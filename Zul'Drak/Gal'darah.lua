----------------------------------
--      Module Declaration      --
----------------------------------

local boss = BB["Gal'darah"]
local mod = BigWigs:New(boss, tonumber(("$Revision$"):sub(12, -3)))
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Zul'Drak"
mod.zonename = BZ["Gundrak"]
mod.enabletrigger = boss 
mod.guid = 29306
mod.toggleOptions = {"forms", "bosskill"}

----------------------------------
--        Are you local?        --
----------------------------------

local formannounce = false

----------------------------------
--         Localization         --
----------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

L:RegisterTranslations("enUS", function() return {
	cmd = "Gal'darah",
	form_rhino = "Rhino Form Soon",
	forms = "Forms",
	forms_desc = "Warn before Gal'darah changes forms.",
	form_troll = "Troll Form Soon",
}

end )

L:RegisterTranslations("deDE", function() return {
	cmd = "Gal'darah",
	form_rhino = "Rhinozeros-Haltung bald!",
	forms = "Haltungen",
	forms_desc = "Warnen bevor Gal'darah seine Haltungen ändert.",
	form_troll = "Troll-Haltung bald!",
}

end )

L:RegisterTranslations("esES", function() return {
}

end )

L:RegisterTranslations("esMX", function() return {
}

end )

L:RegisterTranslations("frFR", function() return {
	cmd = "Gal'darah",
	form_rhino = "Forme de rhinocéros imminente",
	forms = "Formes",
	forms_desc = "Prévient avant que Gal'darah ne change de forme.",
	form_troll = "Forme de troll imminente",
}

end )

L:RegisterTranslations("koKR", function() return {
	cmd = "갈다라",
	form_rhino = "곧 코뿔소 형태",
	forms = "형태",
	forms_desc = "갈다라의 형태를 알립니다.",
	form_troll = "곧 트롤 형태",
}

end )

L:RegisterTranslations("ruRU", function() return {
	form_rhino = "Скоро форма люторога",
	forms = "Формы",
	forms_desc = "Предупреждать, перед сменой форм Гал'дара.",
	form_troll = "Скоро форма троля",
}

end )

L:RegisterTranslations("zhCN", function() return {
	form_rhino = "即将 犀牛形态！",
	forms = "形态",
	forms_desc = "当迦尔达拉改变形态之前发出警报。",
	form_troll = "即将 巨魔形态！",
}

end )

L:RegisterTranslations("zhTW", function() return {
	form_rhino = "即將 犀牛形態！",
	forms = "形態",
	forms_desc = "當蓋爾達拉改變形態之前發出警報。",
	form_troll = "即將 食人妖形態！",
}

end )

----------------------------------
--        Initialization        --
----------------------------------

function mod:OnEnable()
	self:RegisterEvent("UNIT_HEALTH")
	self:AddCombatListener("UNIT_DIED", "BossDeath")

	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")

	formannounce = false
end

----------------------------------
--        Event Handlers        --
----------------------------------

function mod:UNIT_HEALTH(arg1)
	if not self.db.profile.forms then return end
	if UnitName(arg1) ~= boss then return end
	
	local currentHealth = UnitHealth(arg1)
	local maxHealth = UnitHealthMax(arg1)
	local percentHealth = (currentHealth/maxHealth)*100
	if not formannounce and (self:between(percentHealth, 75, 78) or self:between(percentHealth, 25, 28)) then
		self:IfMessage(L["form_rhino"], "Attention")
		formannounce = true
	elseif not formannounce and self:between(percentHealth, 50, 53) then
		self:IfMessage(L["form_troll"], "Attention")
		formannounce = true
	elseif formannounce and (self:between(percentHealth, 54, 74) or self:between(percentHealth, 29, 49)) then
		formannounce = false
	end
end

function mod:between(value, low, high)
	if (value >= low) and (value <= high) then
		return true
	end
end
