------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Mekgineer Steamrigger"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

local db = nil

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Steamrigger",

	mech = "Steamrigger Mechanics",
	mech_desc = "Warn for incoming mechanics",
	mech_trigger = "Tune 'em up good, boys!",
	mech_message = "Steamrigger Mechanics coming soon!",
} end )

L:RegisterTranslations("koKR", function() return {
	mech = "스팀리거 정비사",
	mech_desc = "스팀리거 정비사 소환 경고",
	mech_trigger = "얘들아, 쟤네들을 부드럽게 만져줘라!",
	mech_message = "잠시 후 스팀리거 정비사 등장!",
} end )

L:RegisterTranslations("zhTW", function() return {
	mech = "蒸氣操控者技師",
	mech_desc = "呼叫蒸氣操控者技師時發出警報",
	mech_trigger = "好好的修理它們，孩子們!",
	mech_message = "蒸氣操控者技師出現了! 干擾!",
} end )

L:RegisterTranslations("frFR", function() return {
	mech = "Mécaniciens Montevapeur",
	mech_desc = "Prévient quand Montevapeur appelle ses mécaniciens.",
	mech_trigger = "Faites leur une vidange, les gars !",
	mech_message = "Mécaniciens Montevapeur en approche !",
} end )

L:RegisterTranslations("deDE", function() return {
	mech = "Dampfhammers Mechaniker",
	mech_desc = "Warnt vor Mechanikern",
	mech_trigger = "Legt sie tiefer, Jungs!",
	mech_message = "Dampfhammers Mechaniker kommen bald!",
} end )

L:RegisterTranslations("zhCN", function() return {
	mech = "斯蒂里格技师",
	mech_desc = "呼叫斯蒂里格技师时发出警报。",
	mech_trigger = "好好修理他们，伙计们！",
	mech_message = "斯蒂里格技师出现了！速度杀！",
} end )

L:RegisterTranslations("esES", function() return {
	mech = "Mekigeniero Vaporino",
	mech_desc = "Aviso de la llegada de los mec\195\161nicos",
	mech_trigger = "Dadles lo suyo, chicos!",
	mech_message = "Llegan los Mec\195\161nicos Vaporinos",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Coilfang Reservoir"
mod.zonename = BZ["The Steamvault"]
mod.enabletrigger = boss 
mod.guid = 17796
mod.toggleoptions = {"mech", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("UNIT_DIED", "BossDeath")
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")

	db = self.db.profile
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if db.mech and msg == L["mech_trigger"] then
		self:Message(L["mech_message"], "Attention")
	end
end
