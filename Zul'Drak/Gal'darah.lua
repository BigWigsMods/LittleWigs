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
	forms = "Formes",
	forms_desc = "Prévient avant que Gal'darah ne change de forme.",
	form_troll = "Forme de troll imminente",
	form_rhino = "Forme de rhinocéros imminente",
} end )

L:RegisterTranslations("zhTW", function() return {
	forms = "形態",
	forms_desc = "當蓋爾達拉改變形態之前發出警報。",
	form_troll = "即將 食人妖形態！",
	form_rhino = "即將 犀牛形態！",
} end )

L:RegisterTranslations("deDE", function() return {
} end )

L:RegisterTranslations("zhCN", function() return {
	forms = "形态",
	forms_desc = "当迦尔达拉改变形态之前发出警报。",
	form_troll = "即将 巨魔形态！",
	form_rhino = "即将 犀牛形态！",
} end )

L:RegisterTranslations("ruRU", function() return {
	forms = "Формы",
	forms_desc = "Предупреждать, перед сменой форм Гал'дара.",
	form_troll = "Скоро форма троля",
	form_rhino = "Скоро форма люторога",
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
	if not formannounced and (mod:between(percentHealth, 75, 78) or mod:between(percentHealth, 25, 28)) then
		self:IfMessage(L["form_rhino"], "Attention")
		formannounced = true
	elseif not formannounced and between(percentHealth, 50, 53) then
		self:IfMessage(L["form_troll"], "Attention")
		formannounced = true
	elseif formannounced and (mod:between(percentHealth, 54, 74) or mod:between(percentHealth, 29, 49)) then
		formannounced = false
	end
end

function mod:between(value, low, high)
	if (value >= low) and (value <= high) then
		return true
	end
end
