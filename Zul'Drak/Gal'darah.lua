------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Gal'darah"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

local formannounce = false

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Gal'darah",

	forms = "Forms",
	forms_desc = "Warn before Gal'darah changes forms.",
	form_troll = "Troll Form Soon",
	form_rhino = "Rhino Form Soon",
} end )

L:RegisterTranslations("koKR", function() return {
} end )

L:RegisterTranslations("frFR", function() return {
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
mod.zonename = BZ["Gundrak"]
mod.enabletrigger = boss 
mod.guid = 29306
mod.toggleoptions = {"forms", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("UNIT_HEALTH")
	self:AddCombatListener("UNIT_DIED", "BossDeath")

	formannounce = false
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:UNIT_HEALTH(arg1)
	if not self.db.profile.forms then return end
	if UnitName(arg1) ~= boss then return end
	
	local currentHealth = UnitHealth(arg1)
	local maxHealth = UnitHealthMax(arg1)
	local percentHealth = (currentHealth/maxHealth)*100
	if not formannounced and (between(percentHealth, 75, 78) or between(percentHealth, 25, 28)) then
		self:IfMessage(L["form_rhino"], "Attention")
		formannounced = true
	elseif not formannounced and between(percentHealth, 50, 53) then
		self:IfMessage(L["form_troll"], "Attention")
		formannounced = true
	elseif formannounced and (between(percentHealth, 54, 74) or between(percentHealth, 29, 49)) then
		formannounced = false
	end
end

local function between(value, low, high)
	if (value >= low) and (value <= high) then
		return true
	end
end
