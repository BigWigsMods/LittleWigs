--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Vez'okk the Lightless", 2212)
if not mod then return end
mod:RegisterEnableMob(
	152874, -- Vez'okk the Lightless
	234037 -- Vez'okk the Lightless (Revisited)
)
mod:SetEncounterID({2373, 3089}) -- BFA, Revisited
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Locals
--

local unleashCorruptionCount = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.vezokk = "Vez'okk the Lightless"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		306726, -- Defiled Ground
		306617, -- Ring of Chaos
		306656, -- Unleash Corruption
	}
end

function mod:OnRegister()
	self.displayName = L.vezokk
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "DefiledGround", 306726)
	self:Log("SPELL_CAST_START", "RingOfChaos", 306617)
	self:Log("SPELL_CAST_START", "UnleashCorruption", 306656)
end

function mod:OnEngage()
	unleashCorruptionCount = 1
	self:CDBar(306726, 3.0) -- Defiled Ground
	self:CDBar(306617, 8.3) -- Ring of Choas
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DefiledGround(args)
	self:Message(args.spellId, "red")
	self:CDBar(args.spellId, 11.1)
	self:PlaySound(args.spellId, "alarm")
end

function mod:RingOfChaos(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 15.7)
	self:PlaySound(args.spellId, "long")
end

function mod:UnleashCorruption(args)
	if unleashCorruptionCount == 1 then
		self:Message(args.spellId, "cyan", CL.percent:format(80, args.spellName))
	elseif unleashCorruptionCount == 2 then
		self:Message(args.spellId, "cyan", CL.percent:format(50, args.spellName))
	else
		self:Message(args.spellId, "cyan", CL.percent:format(30, args.spellName))
	end
	unleashCorruptionCount = unleashCorruptionCount + 1
	self:PlaySound(args.spellId, "alert")
end
