--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Heartsbane Triad", 1862, 2125)
if not mod then return end
mod:RegisterEnableMob(
	131825, -- Sister Briar
	131823, -- Sister Malady
	131824  -- Sister Solena
)
mod:SetEncounterID(2113)
mod:SetRespawnTime(19.5)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local bossWithIris = nil
local isMCApplied = false

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Sister Briar
		{260741, "ME_ONLY_EMPHASIZE"}, -- Jagged Nettles
		-- Sister Malady
		{260703, "SAY", "SAY_COUNTDOWN"}, -- Unstable Runic Mark
		268086, -- Aura of Dread
		-- Sister Solena
		{260907, "ICON", "CASTBAR"}, -- Soul Manipulation
		-- Focusing Iris
		{260805, "ICON"}, -- Focusing Iris
		260773, -- Dire Ritual
	},{
		[260741] = -17738, -- Sister Briar
		[260703] = -17739, -- Sister Malady
		[260907] = -17740, -- Sister Solena
		[260805] = 260805, -- Focusing Iris
	},{
		[260703] = CL.mark, -- Unstable Runic Mark (Mark)
	}
end

function mod:OnBossEnable()
	-- Sister Briar (Stage 3)
	self:Log("SPELL_CAST_START", "JaggedNettles", 260741)
	self:Death("SisterBriarDeath", 131825)

	-- Sister Malady (Stage 2)
	self:Log("SPELL_CAST_START", "UnstableRunicMark", 260703)
	self:Log("SPELL_AURA_APPLIED", "UnstableRunicMarkApplied", 260703)
	self:Log("SPELL_AURA_REMOVED", "UnstableRunicMarkRemoved", 260703)
	self:Log("SPELL_AURA_APPLIED_DOSE", "AuraOfDread", 268086)
	self:Death("SisterMaladyDeath", 131823)

	-- Sister Solena (Stage 1)
	self:Log("SPELL_CAST_START", "SoulManipulation", 260907)
	self:Log("SPELL_AURA_APPLIED", "SoulManipulationApplied", 260926)
	self:Log("SPELL_AURA_REMOVED", "SoulManipulationRemovedFromBoss", 260923)
	self:Death("SisterSolenaDeath", 131824)

	-- Focusing Iris
	self:Log("SPELL_CAST_START", "ClaimTheIris", 260852)
	self:Log("SPELL_CAST_START", "DireRitual", 260773)
	self:Log("SPELL_CAST_SUCCESS", "DireRitualSuccess", 260773)
end

function mod:OnEngage()
	self:SetStage(1)
	bossWithIris = nil
	isMCApplied = false
	-- Sister Solena is always first, bars started in :ClaimTheIris
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Sister Briar (Stage 3)

do
	local function printTarget(self, name, guid)
		self:TargetMessage(260741, "orange", name)
		if self:Me(guid) then
			self:PlaySound(260741, "alarm", nil, name)
		else
			self:PlaySound(260741, "alert", nil, name)
		end
	end

	function mod:JaggedNettles(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
		self:CDBar(args.spellId, 14.2)
	end
end

function mod:SisterBriarDeath(args)
	self:StopBar(260741) -- Jagged Nettles
end

-- Sister Malady (Stage 2)

function mod:UnstableRunicMark(args)
	self:Message(args.spellId, "orange", CL.marks)
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 12.1, CL.marks)
end

function mod:UnstableRunicMarkApplied(args)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, CL.mark, nil, "Mark")
		self:SayCountdown(args.spellId, 6)
	end
end

function mod:UnstableRunicMarkRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
end

function mod:AuraOfDread(args)
	if self:Me(args.destGUID) then
		local amount = args.amount
		if amount % 2 == 0 or amount >= 4 then
			self:StackMessage(args.spellId, "blue", args.destName, amount, 4)
			if amount >= 4 then
				self:PlaySound(args.spellId, "warning", nil, args.destName)
			else
				self:PlaySound(args.spellId, "alert", nil, args.destName)
			end
		end
	end
end

function mod:SisterMaladyDeath(args)
	self:StopBar(CL.marks) -- Unstable Runic Mark
end

-- Sister Solena (Stage 1)

function mod:SoulManipulation(args)
	self:CDBar(args.spellId, 25.5)
	self:CastBar(args.spellId, 2)
end

function mod:SoulManipulationApplied(args)
	isMCApplied = true
	self:TargetMessage(260907, "orange", args.destName) -- Soul Manipulation
	self:PlaySound(260907, "alarm", nil, args.destName) -- Soul Manipulation
	self:PrimaryIcon(260907, args.destName) -- Soul Manipulation, move icon from boss to player
end

function mod:SoulManipulationRemovedFromBoss(args)
	isMCApplied = false
	if bossWithIris then -- safety-check for occasional disconnects
		-- Move the icon away from the player and back to the boss
		self:PrimaryIcon(260805, self:UnitTokenFromGUID(bossWithIris)) -- Focusing Iris
	end
end

function mod:SisterSolenaDeath(args)
	self:StopBar(260907) -- Soul Manipulation
end

-- Focusing Iris

function mod:ClaimTheIris(args)
	bossWithIris = args.sourceGUID
	self:Message(260805, "cyan", CL.other:format(self:SpellName(260805), args.sourceName)) -- Focusing Iris
	self:PlaySound(260805, "long") -- Focusing Iris
	if not isMCApplied then
		self:PrimaryIcon(260805, self:UnitTokenFromGUID(bossWithIris)) -- Focusing Iris
	end
	-- stop and start boss ability timers
	local mobId = self:MobId(bossWithIris)
	if mobId == 131825 then -- Sister Briar
		self:StopBar(CL.marks) -- Unstable Runic Mark
		self:StopBar(260907) -- Soul Manipulation
		self:SetStage(3)
		self:CDBar(260741, 7.3) -- Jagged Nettles
	elseif mobId == 131823 then -- Sister Malady
		self:StopBar(260741) -- Jagged Nettles
		self:StopBar(260907) -- Soul Manipulation
		self:SetStage(2)
		self:CDBar(260703, 7.7, CL.marks) -- Unstable Runic Mark
	else -- 131824, Sister Solena
		self:StopBar(260741) -- Jagged Nettles
		self:StopBar(CL.marks) -- Unstable Runic Mark
		self:SetStage(1)
		if not self:Solo() then
			-- won't be cast if solo
			self:CDBar(260907, 9.0) -- Soul Manipulation
		end
	end
	-- start Dire Ritual timer based on the energy of the boss claiming the Focusing Iris
	local unit = self:UnitTokenFromGUID(bossWithIris)
	local timeUntilDireRitual = 75 * (1 - UnitPower(unit) / UnitPowerMax(unit))
	if timeUntilDireRitual > 0 then
		-- add 1.5s Claim the Iris cast time
		self:CDBar(260773, {timeUntilDireRitual + 1.5, 76.5}) -- Dire Ritual
	else
		self:StopBar(260773) -- Dire Ritual
	end
end

function mod:DireRitual(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	self:StopBar(args.spellId)
end

function mod:DireRitualSuccess(args)
	self:CDBar(args.spellId, 75)
end
