
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Armsmaster Harlan", 871, 654)
mod:RegisterEnableMob(58632)

local cleave = GetSpellInfo(845)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.engage_yell = "yell"

	L.cleave = EJ_GetSectionInfo(5377) .. "(".. cleave ..")"
	L.cleave_desc = select(2, EJ_GetSectionInfo(5377))
	L.cleave_icon = 111217

	L.blades, L.blades_desc = EJ_GetSectionInfo(5376)
	L.blades_icon = 111216
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {"cleave", "blades", "bosskill"}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Cleave", 111217)
	self:Log("SPELL_CAST_SUCCESS", "Blades", 111216)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Win", 58632)
end

function mod:OnEngage()

end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Cleave(_, spellId)
	self:Message("cleave", cleave, "Attention", spellId)
	--bar..?
end

function mod:Blades(player, spellId, _, _, spellName)
	self:Message("blades", spellName, "Urgent", spellId, "Alert")
	-- duration bar..?
end

