
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Vez'okk the Lightless", 2212)
if not mod then return end
mod:RegisterEnableMob(152874)
mod:SetAllowWin(true)
mod.engageId = 2373

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
	self:Log("SPELL_CAST_SUCCESS", "UnleashCorruption", 306656)
end

function mod:OnEngage()
	self:Bar(306726, 3.3) -- Defiled Ground
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DefiledGround(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 11.6)
end

function mod:RingOfChaos(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:UnleashCorruption(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end
