if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Harlan Sweete", 1754, 2095)
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
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Log("SPELL_CAST_START", "LoadedDice", 257402, 257458) -- All Hands!, Man-O-War
	self:Log("SPELL_CAST_SUCCESS", "SwiftwindSaber", 257278)
	self:Log("SPELL_AURA_APPLIED", "CannonBarrage", 257305)
	self:Log("SPELL_CAST_SUCCESS", "Avastye", 257316)
	self:Log("SPELL_AURA_APPLIED", "BlackPowderBomb", 257314)
end

function mod:OnEngage()
	self:CDBar(257278, 11) -- Swiftwind Saber
	self:CDBar(257305, 20) -- Cannon Barrage
	self:CDBar(257316, 32) -- Avast, ye!
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, spellId)
	if spellId == 257454 then -- Swiftwind Saber with Loaded Dice: All Hands!
		self:Message(257278, "yellow")
		self:PlaySound(257278, "alert", "watchstep")
		self:CDBar(257278, 15)
	end
end

function mod:LoadedDice(args)
	self:Message("stages", "cyan", "Info", args.spellName, args.spellId)
	self:PlaySound("stages", "info", "stage")
	self:CDBar(257316, 29) -- Avast, ye!
end

function mod:SwiftwindSaber(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert", "watchstep")
	self:CDBar(args.spellId, 15)
end

do
	local onMe, scheduled = nil, nil
	local function warn(self) -- It's either on 1 person or on everyone in the later stage, targetlist warnings are not not needed
		if onMe then
			self:Message(257305, "blue", nil, CL.you:format(self:SpellName(257305)), 257305) -- Cannon Barrage
			self:PlaySound(257305, "warning", "moveout")
		else
			self:Message(257305, "orange") -- Cannon Barrage
			self:PlaySound(257305, "alarm", "watchstep")
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
			self:CDBar(args.spellId, 18.2)
		end
	end
end

function mod:Avastye(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long", "addincoming")
	self:CDBar(args.spellId, 18.2)
end

function mod:BlackPowderBomb(args)
	self:TargetMessage(args.spellId, args.destName, "yellow", nil, self:SpellName(244657), args.spellId) -- Fixate
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "warning", "fixate")
		self:Say(args.spellId, self:SpellName(244657)) -- Fixate
		self:Flash(args.spellId)
	end
end
