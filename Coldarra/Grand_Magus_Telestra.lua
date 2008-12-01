------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Grand Magus Telestra"]

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

local splitannounced = nil

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Telestra",

	split = "Split",
	split_desc = "Warn when Grand Magus Telestra is about to split.",
	split_message = "Grand Magus Telestra has split",
	split_soon_message = "Spliting Soon",
	split_trigger1 = "There's plenty of me to go around.",
	split_trigger2 = "I'll give you more than you can handle.",

	merge_trigger = "Now to finish the job!",
	merge_message = "Merged",
} end )

L:RegisterTranslations("koKR", function() return {
	split = "분리",
	split_desc = "대마법사 텔레스트라의 분리를 알립니다.",
	split_message = "대마법사 텔레스트라가 분리합니다!",
	split_soon_message = "잠시 후 분리",
	split_trigger1 = "여기엔 내가 참 많지.",
	split_trigger2 = "과연 나를 감당할 수 있겠느냐!",

	merge_trigger = "이제 슬슬 끝내 주마!",
	merge_message = "본체 등장!",
} end )

L:RegisterTranslations("frFR", function() return {
	split = "Division",
	split_desc = "Prévient quand la Grand magus Telestra est sur le point de se diviser.",
	split_message = "Grand magus Telestra s'est divisée",
	split_soon_message = "Division imminente",
	split_trigger1 = "Il y en aura assez pour tout le monde.",
	split_trigger2 = "Vous allez être trop bien servis !",

	merge_trigger = "Et maintenant finissons le travail !",
	merge_message = "Fusion",
} end )

L:RegisterTranslations("zhTW", function() return {
	split = "分裂",
	split_desc = "當大魔導師特雷斯翠施放分裂時發出警報。",
	split_message = "大魔導師特雷斯翠 - 分裂！",
	split_soon_message = "即將 分裂！",
	split_trigger1 = "There's plenty of me to go around.", -- not yet
	split_trigger2 = "I'll give you more than you can handle.", -- not yet

	merge_trigger = "Now to finish the job!", -- not yet
	merge_message = "合體！",
} end )

L:RegisterTranslations("deDE", function() return {
	split = "Teilung",
	split_desc = "Warnt wenn Großmagistrix Telestra sich teilen wird.",
	split_message = "Großmagistrix Telestra hat sich geteilt",
	split_soon_message = "Teilung Bald",
	split_trigger1 = "Ihr wisst ja, was nach Hochmut kommt...",
	split_trigger2 = "Ich teile mehr aus, als ihr verkraften könnt!",

	merge_trigger = "Nun bringen wir's zu Ende",
	merge_message = "Merged",
} end )

L:RegisterTranslations("zhCN", function() return {
	split = "分裂",
	split_desc = "当大魔导师泰蕾丝塔施放分裂时发出警报。",
	split_message = "大魔导师泰蕾丝塔 - 分裂！",
	split_soon_message = "即将 分裂！",
	split_trigger1 = "There's plenty of me to go around.", -- not yet
	split_trigger2 = "I'll give you more than you can handle.", -- not yet

	merge_trigger = "Now to finish the job!", -- not yet
	merge_message = "合体！",
} end )

L:RegisterTranslations("ruRU", function() return {
	split = "Разделение",
	split_desc = "Предупреждать о разделении Великой ведуньи Телестры.",
	split_message = "Великая ведунья Телестра разделилась",
	split_soon_message = "Скоро разделение",
	split_trigger1 = "Меня на вас хватит!",  --need check
	split_trigger2 = "Вы получите больше, чем заслуживаете!",  --need check

	merge_trigger = "Ну а теперь, покончи с этим!",  --need check
	merge_message = "Слилась",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Coldarra"
mod.zonename = BZ["The Nexus"]
mod.enabletrigger = {boss} 
mod.guid = 26731
mod.toggleoptions = {"split", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("UNIT_DIED", "BossDeath")
	
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	self:RegisterEvent("UNIT_HEALTH")

	splitannounced = nil
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:UNIT_HEALTH(arg1)
	if not self.db.profile.split then return end
	if UnitName(arg1) == boss then
		local currentHealth = UnitHealth(arg1)
		local maxHealth = UnitHealthMax(arg1)
		local percentHealth = (currentHealth/maxHealth)*100
		if percentHealth > 51 and percentHealth <= 54 and not splitannounced then
			self:Message(L["split_soon_message"], "Attention")
			splitannounced = true
		elseif percentHealth > 60 and spliteannounced then
			splitannounced = false
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if (msg == L["split_trigger1"] or msg == L["split_trigger2"]) then
		if self.db.profile.split then
			self:IfMessage(L["split_message"], "Important", 19569)
		end
	elseif msg == L["merge_trigger"] then
		if self.db.profile.split then
			self:Message(L["merge_message"], "Important")
		end
	end
end

