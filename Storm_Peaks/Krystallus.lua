----------------------------------
--      Module Declaration      --
----------------------------------

local boss = BB["Krystallus"]
local mod = BigWigs:New(boss, tonumber(("$Revision$"):sub(12, -3)))
if not mod then return end
mod.partycontent = true
mod.otherMenu = "The Storm Peaks"
mod.zonename = BZ["Halls of Stone"]
mod.enabletrigger = boss
mod.guid = 27977
mod.toggleoptions = {"shatter", "shatterBar", "bosskill"}

--------------------------------
--        Localization        --
--------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

L:RegisterTranslations("enUS", function() return --@localization(locale="enUS", namespace="Ulduar/Krystallus", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("deDE", function() return --@localization(locale="deDE", namespace="Ulduar/Krystallus", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esES", function() return --@localization(locale="esES", namespace="Ulduar/Krystallus", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esMX", function() return --@localization(locale="esMX", namespace="Ulduar/Krystallus", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("frFR", function() return --@localization(locale="frFR", namespace="Ulduar/Krystallus", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("koKR", function() return --@localization(locale="koKR", namespace="Ulduar/Krystallus", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("ruRU", function() return --@localization(locale="ruRU", namespace="Ulduar/Krystallus", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhCN", function() return --@localization(locale="zhCN", namespace="Ulduar/Krystallus", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhTW", function() return --@localization(locale="zhTW", namespace="Ulduar/Krystallus", format="lua_table", handle-unlocalized="ignore")@
end )

----------------------------------
--        Initialization        --
----------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Slam", 50833)
	self:AddCombatListener("SPELL_CAST_START", "Shatter", 50810, 61546)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

----------------------------------
--        Event Handlers        --
----------------------------------

function mod:Slam(_, spellId, _, _, spellName)
	if self.db.profile.shatter then
		self:IfMessage(L["shatter_warn"], "Urgent", spellId)
	end
	if self.db.profile.shatterBar then
		self:Bar(L["shatterBar_message"], 8, spellId)
	end
end

function mod:Shatter(_, spellId)
	if self.db.profile.shatterBar then
		self:TriggerEvent("BigWigs_StopBar", self, L["shatterBar_message"])
	end
	if self.db.profile.shatter then
		self:IfMessage(L["shatter_message"], "Urgent", spellId)
	end
end
