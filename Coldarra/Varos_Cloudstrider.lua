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
	amplifyMagic_message = "%s: %s",

	amplifyMagicBar = "Amplify Magic Bar",
	amplifyMagicBar_desc = "Display a bar for the duration of Amplify Magic.",
} end )

L:RegisterTranslations("koKR", function() return {
	amplifyMagic = "마법 증폭",
	amplifyMagic_desc = "마법 증폭에 걸린 플레이어를 알립니다.",
	amplifyMagic_message = "%s: %s",

	amplifyMagicBar = "마법 증폭 바",
	amplifyMagicBar_desc = "마법 증폭이 지속되는 바를 표시합니다.",
} end )

L:RegisterTranslations("frFR", function() return {
	amplifyMagic = "Amplification de la magie",
	amplifyMagic_desc = "Prévient quand un joueur subit les effets de l'Amplification de la magie.",
	amplifyMagic_message = "%s : %s",

	amplifyMagicBar = "Amplification de la magie - Barre",
	amplifyMagicBar_desc = "Affiche une barre indiquant la durée de l'Amplification de la magie.",
} end )

L:RegisterTranslations("zhTW", function() return {
	amplifyMagic = "魔法增效",
	amplifyMagic_desc = "當玩家中了魔法增效減益時發出警報。",
	amplifyMagic_message = "%s：%s！",

	amplifyMagicBar = "魔法增效計時條",
	amplifyMagicBar_desc = "當魔法增效持續時顯示計時條。",
} end )

L:RegisterTranslations("deDE", function() return {
} end )

L:RegisterTranslations("zhCN", function() return {
	amplifyMagic = "魔法增效",
	amplifyMagic_desc = "当玩家中了魔法增效减益时发出警报。",
	amplifyMagic_message = "%s：%s！",

	amplifyMagicBar = "魔法增效计时条",
	amplifyMagicBar_desc = "当魔法增效持续时显示计时条。",
} end )

L:RegisterTranslations("ruRU", function() return {
	amplifyMagic = "Усиление магии",
	amplifyMagic_desc = "Предупреждать если кто получает дебафф Усиления магии.",
	amplifyMagic_message = "%s: %s",

	amplifyMagicBar = "Полоса Усиление магии",
	amplifyMagicBar_desc = "Отображать полосу продолжительности Усиления магии.",
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
