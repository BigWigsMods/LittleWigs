--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Harlan Sweete", 0, 0) -- XXX
if not mod then return end
mod:RegisterEnableMob(126983)
mod.engageId = 2096

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages", -- Loaded Dice
		257278, -- Swiftwind Saber
		{257305, "SAY"}, -- Cannon Barrage
		257316, -- Avast, ye!
		{257314, "SAY", "FLASH"}, -- Black Powder Bomb
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "LoadedDice", 257402, 257458) -- All Hands!, Man-O-War
	self:Log("SPELL_CAST_SUCCESS", "SwiftwindSaber", 257278)
	self:Log("SPELL_AURA_APPLIED", "CannonBarrage", 257305)
	self:Log("SPELL_CAST_SUCCESS", "Avastye", 257316)
	self:Log("SPELL_AURA_APPLIED", "BlackPowderBomb", 257314)
end

function mod:OnEngage()
	self:CDBar(257278, 11) -- Swiftwind Saber
	self:CDBar(257316, 32) -- Avast, ye!
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:LoadedDiceAllHands(args)
	self:Message("stages", cyan, "Info", args.spellName, args.spellId)
	self:CDBar(257316, 29) -- Avast, ye!
end

function mod:SwiftwindSaber(args)
	self:Message(args.spellId, yellow, "Alert")
	self:CDBar(args.spellId, 15)
end

do
	local onMe, scheduled = nil, nil
	local function warn(self)
		if onMe then
			self:Message(257305, blue, "Warning", CL.you:format(self:SpellName(257305)), 257305) -- Cannon Barrage
		else
			self:Message(257305, orange, "Alarm") -- Cannon Barrage
		end
		onMe = nil
		scheduled = nil
	end

	function mod:CannonBarrage(args)
		if self:Me(args.destGUID) then
			self:Say(args.spellId)
			onMe = true
		end
		if not scheduled then
			scheduled = self:ScheduleTimer(warn, 0.1, self)
		end
	end
end

function mod:Avastye(args)
	self:Message(args.spellId, red, "Long")
	self:CDBar(args.spellId, 20)
end

function mod:BlackPowderBomb(args)
	if self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, args.destName, "Personal", "Warning", self:SpellName(244657), args.spellId) -- Fixate
		self:Say(args.spellId, self:SpellName(244657)) -- Fixate
		self:Flash(args.spellId)
	end
end
