------------------------------
--      Are you local?      --
------------------------------

local boss = AceLibrary("Babble-Boss-2.2")["Mechano-Lord Capacitus"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)
local aura = nil

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Capacitus",

	trigger1 = "gains Reflective Magic Shield.$",
	trigger2 = "gains Reflective Damage Shield.$",
	trigger3 = "^Reflective Magic Shield fades",
	trigger4 = "^Reflective Damage Shield fades",

	warn1 = "Magic Reflection up!",
	warn2 = "Damage Reflection up!",
	warn3 = "Magic Reflection down!",
	warn4 = "Damage Reflection down!",

	magic = "Magic Reflection",
	magic_desc = "Warn for Magic Reflection",

	dmg = "Damage Shields",
	dmg_desc = "Warn for Damage Shields",

	polarity = "Polarity Shift(Heroic)",
	polarity_desc = "Warn when Polarity Shift is cast",
	polarity_trigger = "begins to cast Polarity Shift",
	polarity_warn = "Polarity Shift in 3 seconds!",
	polarity_bar = "Polarity Shift",
} end )

L:RegisterTranslations("koKR", function() return {
	trigger1 = "마법 반사 보호막 효과를 얻었습니다.$",
	trigger2 = "피해 반사 보호막 효과를 얻었습니다.$",
	trigger3 = "마법 반사 효과가 사라졌습니다.", -- check
	trigger4 = "피해 반사 보호막 효과가 사라졌습니다.", -- check

	warn1 = "마법 반사!",
	warn2 = "피해 반사 보호막!",
	warn3 = "마법 반사 사라짐!",
	warn4 = "피해 반사 보호막 사라짐!",

	magic = "마법 반사",
	magic_desc = "마법 반사에 대한 경고",

	dmg = "피해 반사 보호막",
	dmg_desc = "피해 반사 보호막에 대한 경고",

	polarity = "극성 변환(영웅)",
	polarity_desc = "극성 변환 시전 시 경고",
	polarity_trigger = "기계군주 캐퍼시투스|1이;가; 극성 변환 시전을 시작합니다.", -- check
	polarity_warn = "3초 이내 극성 변환!",
	polarity_bar = "극성 변환",
} end )

L:RegisterTranslations("zhTW", function() return {
	trigger1 = "獲得了反射魔法護盾的效果。",
	trigger2 = "獲得了反射傷害護盾的效果。",
	trigger3 = "反射魔法護盾效果從",
	trigger4 = "反射傷害護盾效果從",

	warn1 = "魔法護盾 開啟！ 法系停火！",
	warn2 = "傷害護盾 開啟！ 近戰停火！",
	warn3 = "魔法護盾 關閉！ 法系開火！",
	warn4 = "傷害護盾 關閉！ 近戰開火！",

	magic = "反射魔法護盾",
	magic_desc = "反射魔法護盾警報",

	dmg = "反射傷害護盾",
	dmg_desc = "反射傷害護盾警報",

	polarity = "極性轉換（英雄模式）",
	polarity_desc = "當極性轉換時警報（僅英雄模式）",
	polarity_trigger = "開始施放兩極移形。",
	polarity_warn = "3 秒後極性轉換，注意跑位！",
	polarity_bar = "極性轉換",
} end )

L:RegisterTranslations("frFR", function() return {
	trigger1 = "gagne Bouclier réflecteur de magie.$",
	trigger2 = "gagne Bouclier réflecteur de dégâts.$",
	trigger3 = "Bouclier réflecteur de magie sur Mécano-seigneur Capacitus vient de se dissiper.",
	trigger4 = "Bouclier réflecteur de dégâts sur Mécano-seigneur Capacitus vient de se dissiper.",

	warn1 = "Réflection de la magie en place !",
	warn2 = "Réflection des dégâts en place !",
	warn3 = "Réflection de la magie terminée !",
	warn4 = "Réflection des dégâts terminée !",

	magic = "Réflection de la magie",
	magic_desc = "Préviens quand Capacitus est protégé par un Bouclier réflecteur de magie.",

	dmg = "Réflection des dégâts",
	dmg_desc = "Préviens quand Capacitus est protégé par un Bouclier réflecteur de dégâts.",

	polarity = "Changement de polarité (Héroïque)",
	polarity_desc = "Préviens quand le Changement de polarité est incanté.",
	polarity_trigger = "commence à lancer Changement de polarité",
	polarity_warn = "Changement de polarité dans 3 sec. !",
	polarity_bar = "Changement de polarité",
} end )

L:RegisterTranslations("esES", function() return {
	polarity = "Cambio de polaridad (Heroico)",
	polarity_desc = "Avisa cuando Capacitus lanza cambio de polaridad",
	polarity_trigger = "comienza a lanzar Cambio de polaridad",
	polarity_warn = "Cambio de polaridad en 3 segundos!",
	polarity_bar = "Cambio de polaridad",
} end )

--机械领主卡帕西图斯
L:RegisterTranslations("zhCN", function() return {
	trigger1 = "获得了魔法反射护盾。$",
	trigger2 = "获得了物理反射护盾。.$",
	trigger3 = "^魔法反射护盾从",
	trigger4 = "^物理反射护盾从",

	warn1 = "魔法护盾！打开 法系停止攻击!",
	warn2 = "物理护盾！打开 近战停止攻击!",
	warn3 = "魔法护盾! 消失 法系攻击",
	warn4 = "物理护盾! 消失 近战攻击",

	magic = "魔法反射护盾",
	magic_desc = "魔法反射护盾警报",

	dmg = "物理护盾",
	dmg_desc = "物理反射护盾",

	polarity = "极性转换(英雄模式)",
	polarity_desc = "当极性转换时发出警报",
	polarity_trigger = "开始施放极性转换",
	polarity_warn = "3秒后 极性转换!",
	polarity_bar = "极性转换",
} end )

L:RegisterTranslations("deDE", function() return {
	trigger1 = "bekommt 'Reflektierender Magieschild'.$",
	trigger2 = "bekommt 'Reflektierender Schadenschild'.$",
	trigger3 = "^Reflektierender Magieschild schwindet",
	trigger4 = "^Reflektierender Schadenschild schwindet",

	warn1 = "Magiereflektion!",
	warn2 = "Schadensreflektion!",
	warn3 = "Magiereflektion beendet!",
	warn4 = "Schadensreflektion beendet!",

	magic = "Magiereflektion",
	magic_desc = "Vor Magiereflektion warnen",

	dmg = "Schadensschild",
	dmg_desc = "Vor Schadensreflektion warnen",

	polarity = "Polarit\195\164tsver\195\164nderung (Heroisch)",
	polarity_desc = "Warnen, wenn Polarit\195\164tsver\195\164nderung gewirkt wird",
	polarity_trigger = "beginnt Polarit\195\164tsver\195\164nderung zu wirken",
	polarity_warn = "Polarit\195\164tsver\195\164nderung in 3 Sekunden!",
	polarity_bar = "Polarit\195\164tsver\195\164nderung",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Tempest Keep"
mod.zonename = AceLibrary("Babble-Zone-2.2")["The Mechanar"]
mod.enabletrigger = boss 
mod.toggleoptions = {"magic", "dmg", -1, "polarity", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS")
	self:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE")
	self:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER")
	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH", "GenericBossDeath")
	aura = nil
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS(msg)
	if not aura and self.db.profile.magic and msg:find(L["trigger1"]) then
		mod:NewPowers(1)
	elseif not aura and self.db.profile.dmg and msg:find(L["trigger2"]) then
		mod:NewPowers(2)
	end
end

function mod:CHAT_MSG_SPELL_AURA_GONE_OTHER(msg)
	if aura and (msg:find(L["trigger3"]) or msg:find(L["trigger4"])) then
		self:Message(aura == 1 and L["warn3"] or L["warn4"], "Attention")
		aura = nil
	end
end

function mod:NewPowers(power)
	aura = power
	self:Message(power == 1 and L["warn1"] or L["warn2"], "Important")
end

function mod:CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE(msg)
	if self.db.profile.polarity and msg:find(L["polarity_trigger"]) then
		self:Message(L["polarity_warn"], "Urgent")
		self:Bar(L["polarity_bar"], 3, "Spell_Nature_Lightning")
	end
end
