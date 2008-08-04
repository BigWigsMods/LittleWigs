------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Ambassador Hellmaw"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

local started=nil

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Hellmaw",

	fear = "Fear Cooldown",
	fear_desc = "Bar and warning for the cooldown on Ambassador Hellmaw's fear.",
	fear_message = "Fear cooldown!",
	fear_warning = "Fear cooldown expired!",
	fear_bar = "Fear Cooldown",
	
	enrage = "Enrage(Heroic)",
	enrage_desc = "Warnings and bar for when Ambassador Hellmaw will enrage.",
	enrage_message = "Enrage in %s seconds",
	enrage_bar = "Enrage",

	engage_message = "%s has been engaged!",
} end )

L:RegisterTranslations("zhCN", function() return {
	fear = "恐惧冷却",
	fear_desc = "当即将施放恐惧时发出警报。",
	fear_message = "恐惧 冷却！",
	fear_warning = "即将施放 恐惧！",
	fear_bar = "<恐惧 冷却>",
	
	enrage = "激怒（英雄）",
	enrage_desc = "当即将激怒时发出警报。",
	enrage_message = "%s秒后，激怒！",
	enrage_bar = "<激怒>",

	engage_message = "%s 激怒！",
} end )

L:RegisterTranslations("zhTW", function() return {
	fear = "恐懼冷卻",
	fear_desc = "即將施放恐懼時發出警報",
	fear_message = "恐懼冷卻!",
	fear_warning = "即將施放 恐懼!",
	fear_bar = "<恐懼冷卻>",
	
	enrage = "狂暴（英雄）",
	enrage_desc = "即將狂暴時發出警報",
	enrage_message = "%s 秒後狂暴!",
	enrage_bar = "<狂暴>",
} end )

L:RegisterTranslations("koKR", function() return {
	fear = "공포 대기시간",
	fear_desc = "사자 지옥아귀의 공포 재사용 대기시간을 위한 경고와 바입니다.",
	fear_message = "공포 대기시간!",
	fear_warning = "공포 대기시간 종료!",
	fear_bar = "공포 대기시간",
	
	enrage = "격노(영웅)",
	enrage_desc = "사자 지옥아귀의 격노에 대한 바와 경고입니다.",
	enrage_message = "%s초 후 격노",
	enrage_bar = "격노",
	
	engage_message = "%s 전투 시작!",
} end )

L:RegisterTranslations("frFR", function() return {
	fear = "Temps de recharge Peur",
	fear_desc = "Affiche une barre et des avertissements concernant la Peur de l'Ambassadeur Gueule-d'enfer.",
	fear_message = "Peur !",
	fear_warning = "Temps de recharge de Peur expiré !",
	fear_bar = "Cooldown Peur",

	enrage = "Enrager (Héroïque)",
	enrage_desc = "Affiche une barre et des avertissements indiquant quand l'Ambassadeur Gueule-d'enfer deviendra enragé.",
	enrage_message = "Enrager dans %s sec.",
	enrage_bar = "Enrager",

	engage_message = "%s engagé - Peur dans ~15 sec. !",
} end )

L:RegisterTranslations("ruRU", function() return {
	fear = "Перезарядка Страха",
	fear_desc = "Предупреждать ипоказать панель перезарядки Страха Посланника Адскай Глотки.",
	fear_message = "Перезарядка Страха!",
	fear_warning = "Перезарядка Страха закончелась!",
	fear_bar = "Перезарядка Страха",
	
	enrage = "Исступление(героик)",
	enrage_desc = "Предупреждать и паказать панель, до того когда Посланник Адская Глотка войдет в Исступление.",
	enrage_message = "Исступление через %s секунд",
	enrage_bar = "Исступление",

	engage_message = "%s has been engaged!",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Auchindoun"
mod.zonename = BZ["Shadow Labyrinth"]
mod.enabletrigger = boss
mod.guid = 18731
mod.toggleoptions = {"fear", "enrage", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	started = nil
	
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Fear", 33547)
	self:AddCombatListener("UNIT_DIED", "BossDeath")

	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")

	self:RegisterEvent("BigWigs_RecvSync")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Fear()
	if self.db.profile.fear then
		self:IfMessage(L["fear_message"], "Attention", 33547)
		self:Bar(L["fear_bar"], 25, 33547)
		self:DelayedMessage(25, L["fear_warning"], "Attention")
	end
end

function mod:BigWigs_RecvSync(sync, rest, nick)
	if self:ValidateEngageSync(sync, rest) and not started then
		started = true
		if self:IsEventRegistered("PLAYER_REGEN_DISABLED") then
			self:UnregisterEvent("PLAYER_REGEN_DISABLED")
		end
		if self.db.profile.fear then
			self:IfMessage(L["engage_message"]:format(boss), "Attention")
			self:Bar(L["fear_bar"], 15, 33547)
		end
		if self.db.profile.enrage and GetInstanceDifficulty() == 2 then
			self:Bar(L["enrage_bar"], 180, 32964)
			self:DelayedMessage(135, L["enrage_message"]:format("45"), "Important", nil, nil, nil, 32964)
			self:DelayedMessage(165, L["enrage_message"]:format("15"), "Important", nil, nil, nil, 32964)
		end
	end
end
