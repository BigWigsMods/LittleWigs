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

--------------------------------------------------------------------------------
-- Locals
--

local playersWithRunicMark = 0
local bossWithIris = nil
local isMCApplied = false

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Sister Briar
		260741, -- Jagged Nettles
		-- Sister Malady
		{260703, "SAY", "SAY_COUNTDOWN", "FLASH", "PROXIMITY"}, -- Unstable Runic Mark
		268086, -- Aura of Dread
		-- Sister Solena
		{260907, "ICON", "CASTBAR"}, -- Soul Manipulation
		-- Focusing Iris
		{260805, "ICON"}, -- Focusing Iris
		260773, -- Dire Ritual
	}, {
		[260741] = -17738, -- Sister Briar
		[260703] = -17739, -- Sister Malady
		[260907] = -17740, -- Sister Solena
		[260805] = 260805, -- Focusing Iris
	}
end

function mod:OnBossEnable()
	-- Sister Briar
	self:Log("SPELL_CAST_START", "JaggedNettles", 260741)

	-- Sister Malady
	self:Log("SPELL_CAST_SUCCESS", "UnstableRunicMark", 260703)
	self:Log("SPELL_AURA_APPLIED", "UnstableRunicMarkApplied", 260703)
	self:Log("SPELL_AURA_REMOVED", "UnstableRunicMarkRemoved", 260703)
	self:Log("SPELL_AURA_APPLIED_DOSE", "AuraOfDread", 268086)

	-- Sister Solena
	self:Log("SPELL_CAST_START", "SoulManipulation", 260907)
	self:Log("SPELL_AURA_APPLIED", "SoulManipulationApplied", 260926)
	self:Log("SPELL_AURA_REMOVED", "SoulManipulationRemovedFromBoss", 260923)

	-- Focusing Iris
	self:Log("SPELL_CAST_START", "ClaimTheIris", 260852)
	self:Log("SPELL_AURA_APPLIED", "FocusingIris", 260805)
	self:Log("SPELL_CAST_START", "DireRitual", 260773)
	self:Log("SPELL_CAST_SUCCESS", "DireRitualSuccess", 260773)
end

function mod:OnEngage()
	playersWithRunicMark = 0
	bossWithIris = nil
	isMCApplied = false
	if not self:Solo() then
		-- Sister Solena gets the Focusing Iris first
		self:CDBar(260907, 8.5) -- Soul Manipulation
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Sister Briar

do
	local function printTarget(self, name, guid)
		self:TargetMessage(260741, "orange", name) -- Jagged Nettles
		self:PlaySound(260741, "alert", nil, name) -- Jagged Nettles
	end

	function mod:JaggedNettles(args)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
		self:CDBar(args.spellId, 13.5)
	end
end

-- Sister Malady

function mod:UnstableRunicMark(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 12)
end

function mod:UnstableRunicMarkApplied(args)
	playersWithRunicMark = playersWithRunicMark + 1
	if playersWithRunicMark == 1 then
		self:OpenProximity(args.spellId, 6)
	end
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
		self:SayCountdown(args.spellId, 6)
		self:Flash(args.spellId)
	end
end

function mod:UnstableRunicMarkRemoved(args)
	playersWithRunicMark = playersWithRunicMark - 1
	if playersWithRunicMark == 0 then
		self:CloseProximity(args.spellId)
	end
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
end

function mod:AuraOfDread(args)
	if self:Me(args.destGUID) then
		local amount = args.amount
		if amount % 3 == 0 or amount > 6 then
			self:StackMessage(args.spellId, "blue", args.destName, amount, 6)
			if amount > 6 then
				self:PlaySound(args.spellId, "warning", nil, args.destName)
			else
				self:PlaySound(args.spellId, "alert", nil, args.destName)
			end
		end
	end
end

-- Sister Solena

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
		self:PrimaryIcon(260805, self:GetBossId(bossWithIris)) -- Focusing Iris
	end
end

-- Focusing Iris

function mod:ClaimTheIris(args)
	bossWithIris = args.sourceGUID
	self:Message(260805, "cyan", CL.other:format(self:SpellName(260805), args.sourceName)) -- Focusing Iris
	self:PlaySound(260805, "long") -- Focusing Iris
	if not isMCApplied then
		self:PrimaryIcon(260805, self:GetBossId(bossWithIris)) -- Focusing Iris
	end
	self:StopBar(260741) -- Jagged Nettles
	self:StopBar(260703) -- Unstable Runic Mark
	self:StopBar(260907) -- Soul Manipulation
end

function mod:FocusingIris(args)
	local mobId = self:MobId(args.destGUID)
	if mobId == 131825 then -- Sister Briar
		self:CDBar(260741, 8.5) -- Jagged Nettles
	elseif mobId == 131823 then -- Sister Malady
		self:CDBar(260703, 9) -- Unstable Runic Mark
	elseif mobId == 131824 and not self:Solo() then -- Sister Solena
		self:CDBar(260907, 8.5) -- Soul Manipulation
	end
	-- start Dire Ritual timer based on the energy of the boss with Focusing Iris
	local unit = self:GetBossId(args.destGUID)
	local timeUntilDireRitual = 75 * (1 - UnitPower(unit) / UnitPowerMax(unit))
	if timeUntilDireRitual > 0 then
		self:CDBar(260773, {timeUntilDireRitual, 75}) -- Dire Ritual
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
