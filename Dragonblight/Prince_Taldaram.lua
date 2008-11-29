------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Prince Taldaram"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Taldaram",

	embraceGain = "Embrace of the Vampyr Gained",
	embraceGain_desc = "Announce when Prince Taldaram gains Embrace of the Vampyr.",
	embraceGain_message = "Embrace of the Vampyr Gained",

	embraceFade = "Embrace of the Vampyr Fades",
	embraceFade_desc = "Announce when Embrace of the Vampyr fades from Prince Taldaram.",
	embraceFade_message = "Embrace of the Vampyr Fades",

	embraceBar = "Embrace of the Vampyr Bar",
	embraceBar_desc = "Display a bar for the duration of Embrace of the Vampyr.",

	sphere = "Conjure Flame Sphere",
	sphere_desc = "Warn when Prince Taldaram begins conjuring a Flame Sphere.",
	sphere_message = "Conjuring Flame Sphere",
} end)

L:RegisterTranslations("deDE", function() return {
	embraceGain = "Umarmung des Vampyrs Bekommen",
	embraceGain_desc = "Meldet wenn Prinz Taldaram Umarmung des Vampyrs bekommt.",
	embraceGain_message = "Umarmung des Vampyrs bekommen",

	embraceFade = "Umarmung des Vampyrs Abgelaufen",
	embraceFade_desc = "Meldet wenn Umarmung des Vampyrs von Prinz Taldaram schwindet.",
	embraceFade_message = "Umarmung des Vampyrs Schwindet",

	embraceBar = "Umarmung des Vampyrs Bar",
	embraceBar_desc = "Zeigt eine Bar für die Dauer von Umarmung des Vampyrs.",

	sphere = "Flammensphäre beschwören",
	sphere_desc = "Warnt wenn Prinz Taldaram eine Flammensphäre beschwört.",
	sphere_message = "Beschwört Flammensphäre",
} end)

L:RegisterTranslations("frFR", function() return {
	embraceGain = "Etreinte du vampire - Gain",
	embraceGain_desc = "Prévient quand le Prince Taldaram gagne l'Etreinte du vampire.",
	embraceGain_message = "Etreinte du vampire lancée",

	embraceFade = "Etreinte du vampire - Fin",
	embraceFade_desc = "Prévient quand Etreinte du vamprie disparait du Prince Taldaram.",
	embraceFade_message = "Etreinte du vampire terminée",

	embraceBar = "Etreinte du vampire - Barre",
	embraceBar_desc = "Affiche une barre indiquant la durée de l'Etreinte du vampire.",

	sphere = "Invocation d'une sphère de flammes",
	sphere_desc = "Prévient quand le Prince Taldaram commence à invoquer une sphère de flammes.",
	sphere_message = "Invocation d'une sphère de flammes en cours",
} end)

L:RegisterTranslations("koKR", function() return {
	embraceGain = "흡혈의 은총 획득",
	embraceGain_desc = "공작 탈다람의 흡혈의 은총 획득을 알립니다.",
	embraceGain_message = "흡혈의 은총 획득!",

	embraceFade = "흡혈의 은총 사라짐",
	embraceFade_desc = "공작 탈다람에게서 흡혈의 은총이 사라짐을 알립니다.",
	embraceFade_message = "흡혈의 은총 사라짐",

	embraceBar = "흡혈의 은총 바",
	embraceBar_desc = "흡혈의 은총의 지속 시간바를 표시합니다.",

	sphere = "화염 구슬 소환",
	sphere_desc = "공작 탈다람의 화염 구슬 소환 시전을 알립니다.",
	sphere_message = "화염 구슬 소환!",
} end)

L:RegisterTranslations("zhCN", function() return {
	embraceGain = "获得吸血鬼的拥抱",
	embraceGain_desc = "当塔达拉姆王子获得吸血鬼的拥抱时发出警报。",
	embraceGain_message = "已获得 吸血鬼的拥抱！",

	embraceFade = "吸血鬼的拥抱消失",
	embraceFade_desc = "当吸血鬼的拥抱从塔达拉姆王子消失时发出警报。",
	embraceFade_message = "已消失 吸血鬼的拥抱！",

	embraceBar = "吸血鬼的拥抱计时条",
	embraceBar_desc = "当吸血鬼的拥抱持续时显示计时条。",

	sphere = "制造烈焰之球",
	sphere_desc = "当塔达拉姆王子开始制造烈焰之球时发出警报。",
	sphere_message = "制造烈焰之球！",
} end)

L:RegisterTranslations("zhTW", function() return {
	embraceGain = "吸血鬼之擁",
	embraceGain_desc = "當泰爾達朗王子獲得吸血鬼之擁時發出警報。",
	embraceGain_message = "已獲得 吸血鬼之擁！",

	embraceFade = "吸血鬼之擁消失",
	embraceFade_desc = "當吸血鬼之擁從泰爾達朗王子消失時發出警報。",
	embraceFade_message = "已消失 吸血鬼之擁！",

	embraceBar = "吸血鬼之擁計時條",
	embraceBar_desc = "當吸血鬼之擁持續時顯示計時條。",

	sphere = "製造裂焰之球",
	sphere_desc = "當泰爾達朗王子開始製造裂焰之球時發出警報。",
	sphere_message = "製造裂焰之球！",
} end)

L:RegisterTranslations("esES", function() return {
} end)

L:RegisterTranslations("ruRU", function() return {
	embraceGain = "Получение Объятия вампира",
	embraceGain_desc = "Сообщать когда Принц Талдарам получает Объятие вампира.",
	embraceGain_message = "Получено Объятие вампира",

	embraceFade = "Рассеивание Объятия вампира",
	embraceFade_desc = "Сообщать когда Объятие вампира спадает с Принца Талдарам.",
	embraceFade_message = "Объятие вампира рассеелось",

	embraceBar = "Полоса Объятия вампира",
	embraceBar_desc = "Отображать полосу продолжительности Объятия вампира.",

	sphere = "Создание сферы огня",
	sphere_desc = "Предупреждать когда Принц Талдарам начинает Создание сферы огня.",
	sphere_message = "Создание сферы огня",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partycontent = true
mod.otherMenu = "Dragonblight"
mod.zonename = BZ["Ahn'kahet: The Old Kingdom"]
mod.enabletrigger = boss
mod.guid = 29308
mod.toggleoptions = {"embraceGain","embraceFade","embraceBar",-1,"sphere","bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Embrace", 55959, 59513)
	self:AddCombatListener("SPELL_AURA_REMOVED", "EmbraceRemoved", 55959, 59513)
	self:AddCombatListener("SPELL_CAST_START", "Sphere", 55931)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Embrace(_, spellId, _, _, spellName)
	if self.db.profile.embraceGain then
		self:IfMessage(L["embraceGain_message"], "Important", spellId)
	end
	if self.db.profile.embraceBar then
		self:Bar(spellName, 20, spellId)
	end
end

function mod:EmbraceRemoved(_, spellId, _, _, spellName)
	if self.db.profile.embraceFade then
		self:IfMessage(L["embraceFade_message"], "Positive", spellId)
	end
	if self.db.profile.embraceBar then
		self:TriggerEvent("BigWigs_StopBar", self, spellName)
	end
end

function mod:Sphere(_, spellId)
	if self.db.profile.sphere then
		self:IfMessage(L["sphere_message"], "Important", spellId)
	end
end
