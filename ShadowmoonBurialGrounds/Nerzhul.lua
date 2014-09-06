
--------------------------------------------------------------------------------
-- Module Declaration
--

if not BigWigs.isWOD then return end -- XXX compat
local mod, CL = BigWigs:NewBoss("Ner'zhul", 969, 1160)
mod:RegisterEnableMob(76407)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		154442, -- Malevolence
		154350, -- Omen of Death
		-9680, -- Ritual of Bones
		"bosskill",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_CAST_START", "Malevolence", 154442)
	self:Log("SPELL_SUMMON", "OmenOfDeath", 154350)
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "RitualOfBones", "boss1")

	self:Death("Win", 76407)
end

function mod:OnEngage()
	self:CDBar(-9680, 20.6) -- Ritual of Bones
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Malevolence(args)
	self:Message(args.spellId, "Attention", self:Tank() and "Alarm")
	self:CDBar(args.spellId, 9.6) -- 9.6-10.8
end

function mod:OmenOfDeath(args)
	self:Message(args.spellId, "Important", "Alert")
	self:CDBar(args.spellId, 10.5) -- 10.5-10.9
end

function mod:RitualOfBones(unit, spellName, _, _, spellId)
	if spellId == 154671 then -- Ritual of Bones
		self:Message(-9680, "Urgent", "Warning")
		--self:Bar(-9680, 0)
	end
end

