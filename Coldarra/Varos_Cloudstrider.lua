------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Varos Cloudstrider"]

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Varos",

	amplifyMagic = "Amplify Magic",
	amplifyMagic_desc = "Warn who has the Amplify Magic debuff.",

	amplifyMagicBar = "Amplify Magic Bar",
	amplifyMagicBar_desc = "Display a bar for the duration of Amplify Magic.",

	amplifyMagic_message = "%s: %s",
} end )

L:RegisterTranslations("koKR", function() return {
} end )

L:RegisterTranslations("frFR", function() return {
} end )

L:RegisterTranslations("zhTW", function() return {
	log = "|cffff0000"..boss.."|r：缺乏數據，請考慮開啟戰斗記錄（/combatlog）或 Transcriptor 記錄并提交戰斗記錄，謝謝！",
} end )

L:RegisterTranslations("deDE", function() return {
} end )

L:RegisterTranslations("zhCN", function() return {
	log = "|cffff0000"..boss.."|r：缺乏数据，请考虑开启战斗记录（/combatlog）或 Transcriptor 记录并提交战斗记录，谢谢！",
} end )

L:RegisterTranslations("ruRU", function() return {
	amplifyMagic = "Усиление магии",
	amplifyMagic_desc = "Предупреждать если кто получает дебафф Усиления магии.",

	amplifyMagicBar = "Полоса Усиление магии",
	amplifyMagicBar_desc = "Отображать полосу продолжительности Усиления магии.",

	amplifyMagic_message = "%s: %s",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Coldarra"
mod.zonename = BZ["The Oculus"]
mod.enabletrigger = {boss} 
mod.guid = 27447
mod.toggleoptions = {"amplifyMagic", "amplifyMagicBar", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "AmplifyMagic", 51054, 59371)
	self:AddCombatListener("SPELL_AURA_REMOVED", "AmplifyMagicRemoved", 51054, 59371)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:AmplifyMagic(player, spellId, _, _, spellName)
	if self.db.profile.amplifyMagic then
		self:IfMessage(L["amplifyMagic_message"]:format(spellName, player), "Important", spellId)
	end
	if self.db.profile.amplifyMagicBar then
		self:Bar(L["amplifyMagic_message"]:format(spellName, player), 30, spellId)
	end
end

function mod:AmplifyMagicRemoved(player, _, _, _, spellName)
	if self.db.profile.amplifyMagicBar then
		self:TriggerEvent("BigWigs_StopBar", self, L["amplifyMagic_message"]:format(spellName, player))
	end
end
