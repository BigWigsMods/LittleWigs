-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Constructor & Controller", "Utgarde Keep")
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Howling Fjord"
mod:RegisterEnableMob(24200, 24201)
mod.toggleOptions = {
	43650, -- Debilitate
	"bosskill",
}

-------------------------------------------------------------------------------
--  Locals

local deaths = 0

-------------------------------------------------------------------------------
--  Localization

local L = mod:NewLocale("enUS", true)
if L then
--@do-not-package@
L["dies"] = "#%d Killed"--@end-do-not-package@
--@localization(locale="enUS", namespace="Howling_Fjord/Controller_and_Constructor", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = mod:GetLocale()

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Debilitate", 43650)
	self:Death("Deaths", 24200, 24201)

	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
end

function mod:OnEngage()
	deaths = 0
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Deaths()
	deaths = deaths + 1
	if deaths < 2 then
		self:Message("bosskill", L["dies"]:format(deaths), "Positive")
	else
		self:Win()
	end
end

function mod:Debilitate(player, spellId, _, _, spellName)
	self:Message(43650, spellName..": "..player, "Attention", spellId)
	self:Bar(43650, player..": "..spellName, 8, spellId)
end
