-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Keristrasza", "The Nexus")
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Coldarra"
mod:RegisterEnableMob(26723)
mod.toggleOptions = {
	8599, -- Enrage
	50997, -- Chains
	"bosskill",
}

-------------------------------------------------------------------------------
--  Localization

local L = LibStub("AceLocale-3.0"):NewLocale("Little Wigs: Keristrasza", "enUS", true)
if L then
	--@do-not-package@
	L["enrage_message"] = "Keristrasza is Enraged!"
	--@end-do-not-package@
	--@localization(locale="enUS", namespace="Coldarra/Keristrasza", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Keristrasza")
mod.locale = L

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Enrage", 8599)
	self:Log("SPELL_AURA_APPLIED", "Chains", 50997)
	self:Log("SPELL_AURA_REMOVED", "ChainsRemoved", 50997)
	self:Death("Win", 26723)
end

-------------------------------------------------------------------------------
--  Event Handlers


function mod:Chains(player, spellId, _, _, spellName)
	self:Message(50997, spellName..": "..player, "Attention", spellId)
	self:Bar(50997, player..": "..spellName, 10, spellId)
end

function mod:ChainsRemoved(player, _, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, player..": "..spellName)
end

function mod:Enrage(_, spellId)
	self:Message(8599, L["enrage_message"], "Important", spellId)
end

