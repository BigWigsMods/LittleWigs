------------------------------
--      Are you local?      --
------------------------------

local boss = BB["King Dred"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "KingDred",

	raptor = "Raptor Call",
	raptor_desc = "Warn when King Dred calls a Raptor.",
	raptor_message = "Raptor Called",
} end )

L:RegisterTranslations("koKR", function() return {
	raptor = "랩터 부르기",
	raptor_desc = "랩터왕 서슬발톱의 랩터 부르기를 알립니다.",
	raptor_message = "랩터 부르기",
} end )

L:RegisterTranslations("frFR", function() return {
	raptor = "Appel du raptor",
	raptor_desc = "Prévient quand le Roi Dred appelle un raptor.",
	raptor_message = "Raptor appelé",
} end )

L:RegisterTranslations("zhTW", function() return {
	raptor = "呼喚迅猛龍",
	raptor_desc = "當崔德王呼喚迅猛龍時發出警報。",
	raptor_message = "呼喚 迅猛龍！",
} end )

L:RegisterTranslations("deDE", function() return {
	raptor = "Raptorruf",
	raptor_desc = "Warnung wenn K\195\182nig Dred einen Raptor ruft.",
	raptor_message = "Raptor herbeigerufen!",	
} end )

L:RegisterTranslations("zhCN", function() return {
	raptor = "召唤迅猛龙",
	raptor_desc = "当暴龙之王爵德召唤迅猛龙时发出警报。",
	raptor_message = "召唤 迅猛龙！",
} end )

L:RegisterTranslations("ruRU", function() return {
	raptor = "Призыв ящера",
	raptor_desc = "Предупреждать, когда Король Дред призывает ящера.",
	raptor_message = "Призван ящер",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Zul'Drak"
mod.zonename = BZ["Drak'Tharon Keep"]
mod.enabletrigger = boss 
mod.guid = 27483
mod.toggleoptions = {"raptor", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_START", "RaptorCall", 59416)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:RaptorCall(_, spellId)
	if self.db.profile.raptor then
		self:IfMessage(L["raptor_message"], "Attention", spellId)
	end
end
