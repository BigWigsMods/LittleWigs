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
} end )

L:RegisterTranslations("frFR", function() return {
	raptor = "Appel du raptor",
	raptor_desc = "Prévient quand le Roi Dred appelle un raptor.",
	raptor_message = "Raptor appelé",
} end )

L:RegisterTranslations("zhTW", function() return {
} end )

L:RegisterTranslations("deDE", function() return {
} end )

L:RegisterTranslations("zhCN", function() return {
} end )

L:RegisterTranslations("ruRU", function() return {
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
