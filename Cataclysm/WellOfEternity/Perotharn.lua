--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Peroth'arn", 939, 290)
if not mod then return end
mod:RegisterEnableMob(55085)
-- mod.engageId = 1272 -- doesn't fire ENCOUNTER_END on a wipe

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.eyes, L.eyes_desc = -4092, -4092
	L.eyes_icon = "inv_misc_eye_04"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		105544, -- Fel Decay
		"eyes",
		105442, -- Enfeebled
		105493, -- Easy Prey
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "FelDecay", 105544)
	self:Log("SPELL_AURA_APPLIED", "EasyPrey", 105493)
	self:Log("SPELL_AURA_APPLIED", "Enfeebled", 105442)

	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Death("Win", 55085)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:FelDecay(args)
	self:TargetMessage(args.spellId, args.destName, "Important", "Alert")
	self:TargetBar(args.spellId, 10, args.destName)
end

function mod:EasyPrey(args)
	self:TargetMessage(args.spellId, args.destName, "Attention", "Long", self:SpellName(42203)) -- 42203 = "Discovered", hopefully it translates as such
end

function mod:Enfeebled(args)
	self:TargetMessage(args.spellId, args.destName, "Attention", "Long")
	self:Bar(args.spellId, 15)
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, _, spellId)
	if spellId == 105341 then -- Camouflage
		self:DelayedMessage("eyes", 8, "Positive", L.eyes, L.eyes_icon, "Info")
		self:Bar("eyes", 8, L.eyes, L.eyes_icon)
		self:CDBar(105442, 48) -- Enfeebled
	end
end
