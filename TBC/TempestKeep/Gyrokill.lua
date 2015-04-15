------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Gatewatcher Gyro-Kill"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Gyro-Kill",

	shadow = "Shadow Power Cast",
	shadow_desc = "Warn when Gyro-Kill casts Shadow Power",
	shadow_message = "Shadow Power in 2 seconds!",

	shadowbar = "Shadow Power Bar",
	shadowbar_desc = "Display a bar for Shadow Power on Gyro-Kill",
} end )

L:RegisterTranslations("koKR", function() return {
	shadow = "어둠의 힘 시전",
	shadow_desc = "무쇠주먹의 어둠의 힘 시전에 대해 알립니다.",
	shadow_message = "2초 이내 어둠의 힘!",
	
	shadowbar = "어둠의 힘 바",
	shadowbar_desc = "어둠의 힘을 바로 표시합니다.",
} end )

L:RegisterTranslations("zhTW", function() return {
	shadow = "施放暗影強化",
	shadow_desc = "當看守者蓋洛奇歐施放暗影強化時發出警報",
	shadow_message = "2 秒後施放暗影強化!",
} end )

L:RegisterTranslations("frFR", function() return {
	shadow = "Puissance de l'ombre incanté",
	shadow_desc = "Prévient quand Gyro-Meurtre incante la Puissance de l'ombre.",
	shadow_message = "Puissance de l'ombre dans 2 sec. !",

	shadowbar = "Barre Puissance de l'ombre",
	shadowbar_desc = "Affiche une barre pour la Puissance de l'ombre de Gyro-Meurtre.",
} end )

L:RegisterTranslations("esES", function() return {
	shadow = "Shadow Power",
	shadow_desc = "Avisa cuando Manoyerro lanza Poder de las Sombras",
	shadow_message = "Poder de las Sombras en 2 segundos!",
} end )

L:RegisterTranslations("zhCN", function() return {
	shadow = "施放暗影能量",
	shadow_desc = "当埃隆汉施放暗影能量时发出警报。",
	shadow_message = "2秒后，暗影能量！",

	shadowbar = "暗影能量计时条",
	shadowbar_desc = "当盖罗基尔获得暗影能量时显示计时条。",
} end )

L:RegisterTranslations("deDE", function() return {
	shadow = "Schattenmacht",
	shadow_desc = "Warnen, wenn Gyrotod Schattenmacht bekommt",
	shadow_message = "Schattenmacht in 2 Sekunden!",
} end )

L:RegisterTranslations("ruRU", function() return {
	shadow = "Мощь Тьмы",
	shadow_desc = "Предупреждать когда Смертекрут выполняет Мощь Тьмы",
	shadow_message = "Мощь Тьмы за 2 секунды!",

	shadowbar = "Панель Мощи Тьмы",
	shadowbar_desc = "Отоброжать панель для Мощи Тьмы Смертекрута",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Tempest Keep"
mod.zonename = BZ["The Mechanar"]
mod.enabletrigger = boss 
mod.guid = 19218
mod.toggleOptions = {"shadow", "shadowbar", "bosskill"}
mod.revision = tonumber(("$Revision: 34 $"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_START", "Shadow", 39193, 35322)
	self:AddCombatListener("SPELL_AURA_APPLIED", "ShadowApplied", 39193, 35322)
	self:AddCombatListener("SPELL_AURA_REMOVED", "ShadowRemoved", 39193, 35322)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Shadow(_, spellId)
	if self.db.profile.shadow then
		self:Message(L["shadow_message"], "Important")
	end
end

function mod:ShadowApplied(_, spellId, _, _, spellName)
	if self.db.profile.shadowbar then
		self:Bar(spellName, 15, spellId)
	end
end

function mod:ShadowRemoved(_, spellId, _, _, spellName)
	if self.db.profile.shadowbar then
		self:TriggerEvent("BigWigs_StopBar", self, spellName)
	end
end

// another one
