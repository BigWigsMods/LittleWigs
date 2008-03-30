------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Vexallus"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Vexallus",

	adds = "Pure Energy",
	adds_desc = "Warn when Pure Energy is discharged.",
	adds_message = "Pure Energy discharged!",
	adds_trigger = "discharges pure energy!",

	feedback = "Energy Feedback",
	feedback_desc = "Warn when someone gets the Energy Feedback debuff.",
	feedback_you = "Energy Feedback on YOU!",
	feedback_other = "Energy Feedback on %s!",
} end )

L:RegisterTranslations("koKR", function() return {
	adds = "순수한 마력덩어리",
	adds_desc = "순수한 마력덩어리 방출에 대해 알립니다.",
	adds_message = "순수한 마력덩어리 방출!",
	adds_trigger = "순수한 마력덩어리를 방출합니다!",

	feedback = "에너지 역류",
	feedback_desc = "에너지 역류 디버프가 걸린 플레이어를 알립니다.",
	feedback_you = "당신은 에너지 역류!",
	feedback_other = "에너지 역류: %s!",
} end )

L:RegisterTranslations("frFR", function() return {
	adds = "Energie pure",
	adds_desc = "Préviens quand l'Energie pure est déchargée.",
	adds_message = "Energie pure déchargée !",
	adds_trigger = "envoie une décharge d'énergie pure !",

	feedback = "Réaction énergétique",
	feedback_desc = "Préviens quand un joueur subit les effets de la Réaction énergétique.",
	feedback_you = "Réaction énergétique sur VOUS !",
	feedback_other = "Réaction énergétique sur %s !",
} end )

L:RegisterTranslations("zhCN", function() return {
	adds = "纯净能量",
	adds_desc = "当纯净能力被释放发出警报。",
	adds_message = "纯净能量释放！",
	adds_trigger = "discharges pure energy!",--need check

	feedback = "能量反噬",
	feedback_desc = "当队友受到能量反噬发出警报。",
	feedback_you = "能量反噬：>你<！",
	feedback_other = "能量反噬：>%s<！",
} end )

L:RegisterTranslations("zhTW", function() return {
	adds = "純淨能量",
	adds_desc = "當維克索魯斯釋放純淨能量時發出警報",
	adds_message = "純淨能量釋放!",
	adds_trigger = "無……法……控制。",

	feedback = "能量反噬",
	feedback_desc = "當隊友受到能量反噬時發出警報",
	feedback_you = "能量反噬: >你<",
	feedback_other = "能量反噬: >%s<",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.zonename = BZ["Magisters' Terrace"]
mod.enabletrigger = boss 
mod.toggleoptions = {"adds", "feedback", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE", "AddSpawned")

	self:AddCombatListener("SPELL_AURA_APPLIED", "Feedback", 44335)
	self:AddCombatListener("SPELL_AURA_APPLIED_DOSE", "FeedbackDose", 44335)
	self:AddCombatListener("SPELL_AURA_REMOVED", "FeedbackRemove", 44335)
	self:AddCombatListener("UNIT_DIED", "GenericBossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:AddSpawned(msg)
	if self.db.profile.adds and msg:find(L["adds_trigger"]) then
		self:Message(L["adds_message"], "Important")
	end
end

function mod:Feedback(player, spellID)
	if self.db.profile.feedback then
		local other = fmt(L["feedback_other"], player)
		if UnitIsUnit(player, "player") then
			self:LocalMessage(L["feedback_you"], "Personal", spellID, "Alert")
			self:WideMessage(other)
		else
			self:IfMessage(other, "Attention", spellID)
		end
		self:Bar(other, 30, spellID)
	end
end

function mod:FeedbackDose(player, spellID)
	if self.db.profile.feedback then
		self:Bar(fmt(L["feedback_other"], player), 30, spellID)
	end
end

function mod:FeedbackRemove(player)
	if self.db.profile.feedback then
		self:TriggerEvent("BigWigs_StopBar", self, fmt(L["feedback_other"], player))
	end
end
