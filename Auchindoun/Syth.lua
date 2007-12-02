------------------------------
--      Are you local?      --
------------------------------

local boss = AceLibrary("Babble-Boss-2.2")["Darkweaver Syth"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Syth",

	summon = "Elementals Alert",
	summon_desc = "Warn for Summoned Elementals",
	summon_trigger = "casts Summon Syth Arcane Elemental",
	summon_message = "Elementals Summoned!",
} end )

L:RegisterTranslations("koKR", function() return {
	summon = "정령 알림",
	summon_desc = "정령 소환 시 알립니다.",
	summon_trigger = "흑마술사 시스|1이;가; 시스의 비전 정령|1을;를; 시전합니다.", -- check
	summon_message = "정령 소환!",
} end )

L:RegisterTranslations("zhTW", function() return {
	summon = "召喚元素警報",
	summon_desc = "召喚元素生物時發出警報",
	summon_trigger = "施放了召喚希斯秘法元素。",
	summon_message = "希斯元素已被召喚出來!",
} end )

L:RegisterTranslations("frFR", function() return {
	summon = "Élémentaires",
	summon_desc = "Préviens quand Syth invoque ses élémentaires.",
	summon_trigger = "lance Invocation d'élémentaire des arcanes Syth",
	summon_message = "Élémentaires invoqués !",
} end )

L:RegisterTranslations("esES", function() return {
	summon = "Alerta de Elementales",
	summon_desc = "Aviso de Invocaci?n de Elementales",
	summon_trigger = "lanza Invocar elemental Arcano Syth",
	summon_message = "Elementales Invocados!",
} end )

L:RegisterTranslations("zhCN", function() return {
	summon = "元素警报",
	summon_desc = "召唤元素警报",
	summon_trigger = "施放了召唤塞斯奥术元素。",
	summon_message = "元素已被召唤!",
} end )

L:RegisterTranslations("deDE", function() return {
	summon = "Elementare-Warnung",
	summon_desc = "Warnt vor beschworenen Elementaren",
	summon_trigger = "wirkt Syths Arkanelementar beschw\195\182ren",
	summon_message = "Elementare beschworen!",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.zonename = {GetAddOnMetadata("LittleWigs_Auchindoun", "X-BigWigs-LoadInZone")} or AceLibrary("AceLocale-2.2"):new("BigWigs_Auchindoun")["Sethekk Halls"]
mod.otherMenu = GetAddOnMetadata("LittleWigs_Auchindoun", "X-BigWigs-Menu") or AceLibrary("AceLocale-2.2"):new("BigWigs_Auchindoun")["Auchindoun"]
mod.enabletrigger = boss 
mod.toggleoptions = {"summon", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF")
	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH", "GenericBossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF(msg)
	if self.db.profile.summon and msg:find(L["summon_trigger"]) then
		self:Message(L["summon_message"], "Attention")
	end
end

