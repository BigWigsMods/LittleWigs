------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Mechano-Lord Capacitus"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

local aura = nil
local charge = GetSpellInfo(39090)
local positive = nil

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Capacitus",

	warn1 = "Magic Reflection up!",
	warn2 = "Damage Reflection up!",
	warn3 = "Magic Reflection down!",
	warn4 = "Damage Reflection down!",

	shields = "Reflective Shields",
	shields_desc = "Warnings for damage & spell reflecting shields",
	shields_message = "%s up!",
	shieldsremoved_message = "%s down!",

	shieldbar = "Shield Bar",
	shieldbar_desc = "Display a bar for the duration of Magic & Damage Shields",

	polarity = "Polarity Shift(Heroic)",
	polarity_desc = "Warn when Polarity Shift is cast",
	polarity_message = "Polarity Shift in 3 seconds!",
	polarity_bar = "Polarity Shift",

	enrage = "Enrage(Heroic)",
	enrage_desc = "Warn at 15 and 45 seconds before Enrage",
	enrage_trigger = "^You should split while you can.$",
	enrage_message = "%ss until enraged!",
	enrage_bar = "<Enrage>",
} end )

L:RegisterTranslations("koKR", function() return {
	warn1 = "마법 반사 보호막!",
	warn2 = "피해 반사 보호막!",
	warn3 = "마법 반사 보호막 사라짐!",
	warn4 = "피해 반사 보호막 사라짐!",
	
	shields = "반사 보호막",
	shields_desc = "피해 & 마법 반사 보호막에 대해 알립니다.",
	shields_message = "%s !",
	shieldsremoved_message = "%s 사라짐!",

	shieldbar = "보호막 바",
	shieldbar_desc = "피해 & 마법 반사 보호막 지속에 대한 바를 표시합니다.",

	polarity = "극성 변환(영웅)",
	polarity_desc = "극성 변환 시전시 알립니다.",
	polarity_message = "3초 이내 극성 변환!",
	polarity_bar = "극성 변환",
	
	enrage = "격노(영웅)",
	enrage_desc = "격노까지 15 와 45 초 남았을 경우 알립니다.",
	enrage_trigger = "^You should split while you can.$",	--need to translation.
	enrage_message = "%ss초 후 격노!",
	enrage_bar = "<격노>",
} end )

L:RegisterTranslations("zhTW", function() return {
	warn1 = "魔法護盾 開啟! 法系停火!",
	warn2 = "傷害護盾 開啟! 近戰停火!",
	warn3 = "魔法護盾 關閉! 法系開火!",
	warn4 = "傷害護盾 關閉! 近戰開火!",

	shields = "反射護盾",
	shields_desc = "發動傷害&魔法護盾時發出警報",
	shields_message = "%s 啟動!",			--need to check
	shieldsremoved_message = "%s 關閉!",		--need to check

	shieldbar = "護盾計時條",
	shieldbar_desc = "顯示護盾計時條",

	polarity = "極性轉換（英雄模式）",
	polarity_desc = "當極性轉換時警報（僅英雄模式）",
	polarity_message = "3 秒後極性轉換，注意跑位!",
	polarity_bar = "<極性轉換>",

	enrage = "狂暴（英雄模式）",
	enrage_desc = "狂暴前 15 及 45 秒發出警報",
	enrage_trigger = "^You should split while you can.$",		--need to translation.
	enrage_message = "%s 秒後狂暴!",
	enrage_bar = "<狂暴>",

} end )

L:RegisterTranslations("frFR", function() return {
	warn1 = "Réflection de la magie actif !",
	warn2 = "Réflection des dégâts actif !",
	warn3 = "Réflection de la magie terminée !",
	warn4 = "Réflection des dégâts terminée !",

	shields = "Boucliers réflecteurs",
	shields_desc = "Prévient de l'arrivée des boucliers réflecteurs de magie & de dégâts.",
	shields_message = "%s actif !",
	shieldsremoved_message = "%s terminé !",

	shieldbar = "Barre du bouclier",
	shieldbar_desc = "Affiche une barre indiquant la durée des boucliers réflecteurs.",

	polarity = "Changement de polarité (Héroïque)",
	polarity_desc = "Prévient quand le Changement de polarité est incanté.",
	polarity_message = "Changement de polarité dans 3 sec. !",
	polarity_bar = "Changement de polarité",

	enrage = "Enrager (Héroïque)",
	enrage_desc = "Prévient 15 et 45 secondes avant l'Enrager.",
	enrage_trigger = "^Dégagez tant que vous le pouvez.$", -- à vérifier
	enrage_message = "Enrager dans %s sec. !",
	enrage_bar = "<Enrager>",
} end )

L:RegisterTranslations("esES", function() return {
	warn1 = "Iniciado Reflejo de Magia",
	warn2 = "Iniciado Reflejo de Da\195\177o",
	warn3 = "Reflejo de Magia Finalizado",
	warn4 = "Reflejo de Da\195\177o Finalizado",

	polarity = "Cambio de polaridad (Heroico)",
	polarity_desc = "Avisa cuando Capacitus lanza cambio de polaridad",
	polarity_message = "Cambio de polaridad en 3 segundos!",
	polarity_bar = "Cambio de polaridad",
} end )

L:RegisterTranslations("zhCN", function() return {
	warn1 = "魔法护盾打启！ 法系停止攻击！",
	warn2 = "物理护盾打启！ 近战停止攻击！",
	warn3 = "魔法护盾消失！ 法系攻击！",
	warn4 = "物理护盾消失！ 近战攻击！",

	shields = "反射护盾",
	shields_desc = "当启动伤害/魔法护盾时发出警报。",
	shields_message = "%s 开启！",
	shieldsremoved_message = "%s 关闭！",

	shieldbar = "护盾计时条",
	shieldbar_desc = "显示伤害/魔法护盾计时条。",

	polarity = "极性转换（英雄模式）",
	polarity_desc = "当极性转换时发出警报。",
	polarity_message = "3秒后，极性转换！",
	polarity_bar = "<极性转换>",

	enrage = "激怒（英雄模式）",
	enrage_desc = "在激怒前的15和45秒发出警报。",
	enrage_trigger = "",--Need Combatlog
	enrage_message = "%s秒后，激怒！",
	enrage_bar = "<激怒>",
} end )

L:RegisterTranslations("deDE", function() return {
	warn1 = "Magiereflektion!",
	warn2 = "Schadensreflektion!",
	warn3 = "Magiereflektion beendet!",
	warn4 = "Schadensreflektion beendet!",

	polarity = "Polarit\195\164tsver\195\164nderung (Heroisch)",
	polarity_desc = "Warnen, wenn Polarit\195\164tsver\195\164nderung gewirkt wird",
	polarity_message = "Polarit\195\164tsver\195\164nderung in 3 Sekunden!",
	polarity_bar = "Polarit\195\164tsver\195\164nderung",

	enrage = "Enrage(Heroisch)",
	enrage_desc = "15 und 45 Sekunden bevor Enrage warnen",
	enrage_trigger = "^Verzieht Euch, solange Ihr noch k\195\182nnt.$",
	enrage_message = "%ss bis Enrage!",
	enrage_bar = "<Enrage>",
} end )

L:RegisterTranslations("ruRU", function() return {
	warn1 = "Отражение магии активно!",
	warn2 = "Отражение урона активно!",
	warn3 = "Отражение магии спало!",
	warn4 = "Отражение урона спало!",

	shields = "Отражающие щити",
	shields_desc = "Предупреждения о щитах отражающих заклинания и простой урон",
	shields_message = "%s активно!",
	shieldsremoved_message = "%s спало!",

	shieldbar = "Панель щита",
	shieldbar_desc = "Отображать панель продолжительности Шита Магии и Damage Shields",

	polarity = "Сдвиг полярности(Героик)",
	polarity_desc = "Предупреждать о Сдвиге полярности",
	polarity_message = "Сдвиг полярности за 3 секунды!",
	polarity_bar = "Сдвиг полярности",

	enrage = "Исступление(Heroic)",
	enrage_desc = "Предупреждать за 15 и 45 секунд до Исступления",
	enrage_trigger = "^You should split while you can.$",
	enrage_message = "%ss до Исступление!",
	enrage_bar = "<Исступление>",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Tempest Keep"
mod.zonename = BZ["The Mechanar"]
mod.enabletrigger = boss 
mod.guid = 19219
mod.toggleOptions = {"shields", "shieldbar", -1, "polarity", "enrage"}
mod.revision = tonumber(("$Revision: 34 $"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	self:AddCombatListener("SPELL_AURA_APPLIED", "Shield", 35158)
	self:AddCombatListener("SPELL_AURA_APPLIED", "Shield", 35159)
	self:AddCombatListener("SPELL_AURA_REMOVED", "ShieldRemoved", 35158)
	self:AddCombatListener("SPELL_AURA_REMOVED", "ShieldRemoved", 35159)
	self:AddCombatListener("SPELL_CAST_START", "Polarity", 39096)
	--self:AddCombatListener("SPELL_CAST_SUCCESS", "PolarityScan", 39096) --success isn't getting logged right now
	self:AddCombatListener("UNIT_DIED", "BossDeath")

	aura = nil
	positive = nil
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if not self.db.profile.enrage or GetInstanceDifficulty() == 1 then return end
	if msg == L["enrage_trigger"] then
		self:Bar(L["enrage_bar"], 180, "Spell_Shadow_UnholyFrenzy")
		self:DelayedMessage(135, L["enrage_message"]:format("45"), "Important")
		self:DelayedMessage(165, L["enrage_message"]:format("15"), "Important")
	end
end

function mod:Shield(_, spellId, _, _, spellName)
	if self.db.profile.magic and spellId == 35158 then
		self:IfMessage(L["shields_message"]:format(spellName), "Urgent", 35158)
	elseif self.db.profile.dmg and spellId == 35159 then
		self:IfMessage(L["shields_message"]:format(spellName), "Urgent", 35159)
	end
	if self.db.profile.shieldbar then
		self:Bar(spellName, 10, spellId)
	end
end

function mod:ShieldRemoved(_, spellId, _, _, spellName)
	if self.db.profile.magic and spellId == 35158 then
		self:IfMessage(L["shieldsremoved_message"]:format(spellName), "Positive", 35158)
	elseif self.db.profile.dmg and spellId == 35159 then
		self:IfMessage(L["shieldsremoved_message"]:format(spellName), "Positive", 35159)
	end
end

function mod:Polarity()
	if self.db.profile.polarity then
		self:IfMessage(L["polarity_message"], "Urgent", 39096)
		self:Bar(L["polarity_bar"], 3, 39096)
		self:ScheduleEvent("polarityscan", self.PolarityScan, 4, self)
	end
end

local function hasBuff(player, buff)
	local i = 1
	local name = UnitBuff(player, i)
	while name do
		if name == buff then return true end
		i = i + 1
		name = UnitBuff(player, i)
	end
	return false
end

function mod:PolarityScan()
	if positive then
		for k,v in positive do
			self:TriggerEvent("BigWigs_StopBar", self, v)
		end
		positive = nil 
	end
	if hasBuff("player", charge) then table.insert(positive, UnitName("player")) end
	for i=1, 4 do
		if hasBuff("party"..i, charge) then table.insert(positive, UnitName("party"..i)) end
	end
	if positive then
		for k,v in pairs(positive) do
			self:Bar(v, 60, 39090, "red")
		end
	end
end

