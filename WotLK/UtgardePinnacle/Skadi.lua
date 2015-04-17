-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Skadi the Ruthless", 524)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Howling Fjord"
mod:RegisterEnableMob(26693)
mod.toggleOptions = {
	59322, -- Whirlwind
	"bosskill",
}

-------------------------------------------------------------------------------
--  Localization

local L = mod:NewLocale("enUS", true)
if L then
--@do-not-package@
L["whirlwind_cooldown_bar"] = "Whirlwind cooldown"
L["whirlwindcooldown_message"] = "Whirlwind cooldown passed"--@end-do-not-package@
--@localization(locale="enUS", namespace="Howling_Fjord/Skadi_the_Ruthless", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = mod:GetLocale()

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Whirlwind", 59322, 50228)
	self:Death("Win", 26693)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Whirlwind(_, spellId, _, _, spellName)
	self:Message(59322, spellName, "Urgent", spellId)
	self:DelayedMessage(59322, 23, L["whirlwindcooldown_message"], "Attention")
	self:Bar(59322, spellName, 10, spellId)
	self:Bar(59322, L["whirlwind_cooldown_bar"], 23, spellId)
end
