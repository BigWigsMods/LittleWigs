-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Anub'arak-AN", "Azjol-Nerub")
if not mod then return end
mod.partycontent = true
mod.otherMenu = "Dragonblight"
mod:RegisterEnableMob(29120)
mod.toggleOptions = {
	53472, -- Pound
	"bosskill"
}

-------------------------------------------------------------------------------
--  Localization

LCL = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Common")
local L = mod:NewLocale("enUS", true)
if L then
--@do-not-package@
L["cmd"] = "Anub'arak"
--@localization(locale="enUS", namespace="Dragonblight/Anub_arak", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = mod:GetLocale()

mod.displayName = L["cmd"]

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Pound", 53472, 59433)
	self:Death("Win", 29120)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Pound(_, spellId, _, _, spellName)
	self:Bar(53472, spellName, 3.2, spellId)
	self:Message(53472, LCL["casting"]:format(spellName), "Attention", spellId)
end
