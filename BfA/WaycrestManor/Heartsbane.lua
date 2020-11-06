
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Heartsbane Triad", 1862, 2125)
if not mod then return end
mod:RegisterEnableMob(131825, 131823, 131824) -- Sister Briar, Sister Malady, Sister Solena
mod.engageId = 2113
mod.respawnTime = 20

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
		-- General
		{260805, "ICON"}, -- Focusing Iris
		260773, -- Dire Ritual
		-- Sister Solena
		{260907, "ICON"}, -- Soul Manipulation
		-- Sister Malady
		{260703, "SAY", "SAY_COUNTDOWN", "FLASH", "PROXIMITY"}, -- Unstable Runic Mark
		268086, -- Aura of Dread
		-- Sister Briar
		260741, -- Jagged Nettles
	}, {
		[260805] = "general",
		[260907] = -17740, -- Sister Solena
		[260703] = -17739, -- Sister Malady
		[260741] = -17738, -- Sister Briar
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "ClaimTheIris", 260852)
	self:Log("SPELL_AURA_APPLIED", "FocusingIris", 260805)
	self:Log("SPELL_CAST_START", "DireRitual", 260773)
	self:Log("SPELL_CAST_START", "SoulManipulation", 260907)
	self:Log("SPELL_AURA_APPLIED", "SoulManipulationApplied", 260926)
	self:Log("SPELL_AURA_REMOVED", "SoulManipulationRemovedFromBoss", 260923)
	self:Log("SPELL_AURA_APPLIED_DOSE", "AuraOfDread", 268086)
	self:Log("SPELL_CAST_SUCCESS", "UnstableRunicMark", 260703)
	self:Log("SPELL_AURA_APPLIED", "UnstableRunicMarkApplied", 260703)
	self:Log("SPELL_AURA_REMOVED", "UnstableRunicMarkRemoved", 260703)
	self:Log("SPELL_CAST_START", "JaggedNettles", 260741)
end

function mod:OnEngage()
	playersWithRunicMark = 0
	bossWithIris = nil
	isMCApplied = false
	self:Bar(260907, 8.5) -- Soul Manipulation
end

--------------------------------------------------------------------------------
-- Event Handlers
--

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
		self:Bar(260741, 8.5)  -- Jagged Nettles
	elseif mobId == 131823 then -- Sister Malady
		self:Bar(260703, 9) -- Unstable Runic Mark
	elseif mobId == 131824 then -- Sister Solena
		self:Bar(260907, 8.5) -- Soul Manipulation
	end
end

function mod:DireRitual(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
end

function mod:SoulManipulation(args)
	self:Bar(args.spellId, 25.5)
	self:CastBar(args.spellId, 2)
end

function mod:SoulManipulationApplied(args)
	isMCApplied = true
	self:TargetMessage(260907, "orange", args.destName) -- Soul Manipulation
	self:PlaySound(260907, "alarm", nil, args.destName) -- Soul Manipulation
	self:PrimaryIcon(260907, args.destName) -- Soul Manipulation, Move icon from boss to player
end

function mod:SoulManipulationRemovedFromBoss(args)
	isMCApplied = false
	if bossWithIris then -- safety-check for occasional disconnects
		-- Move the icon away from the player and back to the boss
		self:PrimaryIcon(260805, self:GetBossId(bossWithIris)) -- Focusing Iris
	end
end

function mod:AuraOfDread(args)
	if self:Me(args.destGUID) then
		if args.amount % 3 == 0 or args.amount > 6 then
			self:StackMessage(args.spellId, args.destName, args.amount, "blue")
			self:PlaySound(args.spellId, args.amount > 6 and "warning" or "alert")
		end
	end
end

function mod:UnstableRunicMark(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 12)
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

do
	local function printTarget(self, name, guid)
		self:TargetMessage(260741, "orange", name) -- Jagged Nettles
		self:PlaySound(260741, "alarm", nil, name) -- Jagged Nettles
	end

	function mod:JaggedNettles(args)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
		self:Bar(args.spellId, 13.5)
	end
end
