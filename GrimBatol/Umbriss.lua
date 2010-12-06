-- XXX Ulic: Other suggestions?

-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("General Umbriss", "Grim Batol")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(39625)
mod.toggleOptions = {
	47670,
	47853,
	91937,
	"bosskill",
}

-------------------------------------------------------------------------------
--  Localization

local L = mod:NewLocale("enUS", true)
if L then
--@do-not-package@
L["frenzy_trigger"] = "%s goes into a frenzy!"--@localization(locale="enUS", namespace="GrimBatol/Umbriss", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = mod:GetLocale()

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")

	self:Log("SPELL_AURA_APPIED", "Wound", 74846)
	self:Log("SPELL_AURA_REMOVED", "WoundRemoved", 74846)
	
	self:Death("Win", 39625)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg, _, _, _, player)
	if msg == L["frenzy_trigger"] then
		self:Message(47853, msg:format(self.displayName), "Attention", 47853)
	else
		self:TargetMessage(47670, GetSpellInfo(47670), player, "Urgent", 47670, "Alert")
	end
end

function mod:Wound(player, spellId, _, _, spellName)
	self:Message(91937, spellName..": "..player, "Urgent", spellId)
	self:Bar(91937, player..": "..spellName, 15, spellId)
end

function mod:WoundRemoved(player, _, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, player..": "..spellName)
end