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

	shadowaura = "Shadow Power Gained",
	shadowaura_desc = "Warn when Gyro-Kill gains Shadow Power",
	shadowaura_message ="Gyro-Kill gains Shadow Power",
} end )

L:RegisterTranslations("koKR", function() return {
	shadow = "어둠의 힘 시전",
	shadow_desc = "무쇠주먹의 어둠의 힘 시전에 대해 알립니다.",
	shadow_message = "2초 이내 어둠의 힘!",
		
	shadowaura = "어둠의 힘 획득",
	shadowaura_desc = "회전톱날의 어둠의 힘 회득에 대해 알립니다.",
	shadowaura_message ="회전톱날 어둠의 힘 획득",
} end )

L:RegisterTranslations("zhTW", function() return {
	shadow = "施放暗影強化",
	shadow_desc = "當看守者蓋洛奇歐施放暗影強化時發出警報",
	shadow_message = "2 秒後施放暗影強化!",

	shadowaura = "獲得暗影強化",
	shadowaura_desc = "當看守者蓋洛奇歐獲得暗影強化時發出警報",
	shadowaura_message ="看守者蓋洛奇歐獲得暗影強化!",
} end )

L:RegisterTranslations("frFR", function() return {
	shadow = "Puissance de l'ombre incanté",
	shadow_desc = "Prévient quand Gyro-Meurtre incante la Puissance de l'ombre.",
	shadow_message = "Puissance de l'ombre dans 2 sec. !",

	shadowaura = "Puissance de l'ombre gagné",
	shadowaura_desc = "Prévient quand Main-en-fer gagne la Puissance de l'ombre.",
	shadowaura_message ="Gyro-Meurtre gagne Puissance de l'ombre !",
} end )

L:RegisterTranslations("esES", function() return {
	shadow = "Shadow Power",
	shadow_desc = "Avisa cuando Manoyerro lanza Poder de las Sombras",
	shadow_message = "Poder de las Sombras en 2 segundos!",
	shadow_bar = "Poder de las Sombras",
} end )

L:RegisterTranslations("zhCN", function() return {
	shadow = "施放暗影能量",
	shadow_desc = "当埃隆汉施放暗影能量时发出警报。",
	shadow_message = "2秒后，暗影能量！",

	shadowaura = "获得暗影能量",
	shadowaura_desc = "当盖罗基尔获得暗影能量时发出警报。",
	shadowaura_message ="盖罗基尔 - 暗影能量！",
} end )

L:RegisterTranslations("deDE", function() return {
	shadow = "Schattenmacht",
	shadow_desc = "Warnen, wenn Gyrotod Schattenmacht bekommt",
	shadow_message = "Schattenmacht in 2 Sekunden!",

	shadowaura = "Schattenmacht bekommen",
	shadowaura_desc = "Warnen wenn Gyrotod Schattenmacht bekommt",
	shadowaura_message ="Gyrotod bekommt Schattenmacht",	
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Tempest Keep"
mod.zonename = BZ["The Mechanar"]
mod.enabletrigger = boss 
mod.toggleoptions = {"shadow", "shadowaura", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_START", "Shadow", 39193)
	self:AddCombatListener("SPELL_AURA_APPLIED", "ShadowApplied", 39193)
	self:AddCombatListener("SPELL_AURA_REMOVED", "ShadowRemoved", 39193)
	self:AddCombatListener("UNIT_DIED", "GenericBossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if self.db.profile.hammer and msg:find(L["hammer_trigger"]) then
		self:Message(L["hammer_message"], "Important")
		self:Bar(L["hammer"], 3, "INV_Hammer_07")
	end
end

function mod:Shadow()
	if self.db.profile.shadow then
		self:Message(L["shadow_message"], "Important")
	end
end

function mod:ShadowApplied(_, spellId, _, _, spellName)
	if self.db.profile.shadowaura then
		self:IfMessage(L["shadowaura_message"], "Important", spellId)
		self:Bar(spellName, 15, spellId)
	end
end

function mod:ShadowRemoved(_, spellId, _, _, spellName)
	if self.db.profile.shadowaura then
		self:TriggerEvent("BigWigs_StopBar", self, spellName)
	end
end
