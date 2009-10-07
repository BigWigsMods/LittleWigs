-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Amanitar", "Ahn'kahet: The Old Kingdom")
if not mod then return end
mod.partycontent = true
mod.otherMenu = "Dragonblight"
mod:RegisterEnableMob(30258)
mod.defaultToggles = {"MESSAGE"}
mod.toggleOptions = {
	57055, -- Mini
	"bosskill",
}

-------------------------------------------------------------------------------
--  Locals

local pName = UnitName("player")

-------------------------------------------------------------------------------
--  Localization

local L = LibStub("AceLocale-3.0"):NewLocale("Little Wigs: Amanitar", "enUS", true)
if L then
	--@do-not-package@
	L["mini_message"] = "You are Mini"
	--@end-do-not-package@
	--@localization(locale="enUS", namespace="Dragonblight/Amanitar", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Amanitar")
mod.locale = L

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Mini", 57055)
	self:Death("Win", 30258)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Mini(player, spellId)
	if player == pName then
		self:LocalMessage(57055, L["mini_message"], "Personal", spellId)
	end
end
