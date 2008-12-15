------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Novos the Summoner"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Novos",

	misery = "Wrath of Misery",
	misery_desc = "Warn what party memeber has the Wrath of Misery curse.",
	misery_message = "Wrath of Misery: %s",

	miseryBar = "Wrath of Misery Bar",
	miseryBar_desc = "Show a bar for the duration of the Wrath of Misery curse.",
} end )

L:RegisterTranslations("koKR", function() return {
	misery = "불행의 분노",
	misery_desc = "불행의 분노 저주에 걸린 플레이어를 알립니다.",
	misery_message = "불행의 분노: %s",

	miseryBar = "불행의 분노 바",
	miseryBar_desc = "불행의 분노 디버프가 지속되는 바를 표시합니다.",
} end )

L:RegisterTranslations("frFR", function() return {
	misery = "Courroux de misère",
	misery_desc = "Prévient quand un joueur subit les effets du Courroux de misère.",
	misery_message = "Courroux de misère : %s",

	miseryBar = "Courroux de misère - Barre",
	miseryBar_desc = "Affiche une barre indiquant la durée du Courroux de misère.",
} end )

L:RegisterTranslations("zhTW", function() return {
	misery = "苦難之怒",
	misery_desc = "當玩家中了苦難之怒詛咒時發出警報。",
	misery_message = ">%s<：苦難之怒！",

	miseryBar = "苦難之怒計時條",
	miseryBar_desc = "當苦難之怒持續時顯示計時條。",
} end )

L:RegisterTranslations("deDE", function() return {
	misery = "Zorn des Elends",
	misery_desc = "Warnung welches Gruppenmitglied vom Zorn des Elends-Fluch betroffen ist.",
	misery_message = "Zorn des Elends: %s",

	miseryBar = "Zorn des Elends-Anzeige",
	miseryBar_desc = "Eine Leiste mit der Dauer des Zorn des Elends-Fluchs anzeigen.",
} end)

L:RegisterTranslations("zhCN", function() return {
	misery = "痛苦之怒",
	misery_desc = "当玩家中了痛苦之怒诅咒时发出警报。",
	misery_message = ">%s<：痛苦之怒！",

	miseryBar = "痛苦之怒计时条",
	miseryBar_desc = "当痛苦之怒持续时显示计时条。",
} end )

L:RegisterTranslations("ruRU", function() return {
	misery = "Гнев страдания",
	misery_desc = "Предупреждать когда на участника группы накладывается проклятье Гнева страданий.",
	misery_message = "Гнев страдания: %s",

	miseryBar = "Полоса Гнева страдании",
	miseryBar_desc = "Отображать полосу продолжительности проклятья Гнева страданий.",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Zul'Drak"
mod.zonename = BZ["Drak'Tharon Keep"]
mod.enabletrigger = boss 
mod.guid = 26631
mod.toggleoptions = {"misery", "miseryBar", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Misery", 50089, 59856)
	self:AddCombatListener("SPELL_AURA_REMOVED", "MiseryRemoved", 50089, 59856)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Misery(player, spellId, _, _, spellName)
	if self.db.profile.misery then
		self:IfMessage(L["misery_message"]:format(player), "Urgent", spellId)
	end
	if self.db.profile.miseryBar then
		self:Bar(L["misery_message"]:format(player), 6, spellId)
	end
end

function mod:MiseryRemoved(player)
	if self.db.profile.miseryBar then
		self:TriggerEvent("BigWigs_StopBar", self, L["misery_message"]:format(player))
	end
end
