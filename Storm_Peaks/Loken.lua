----------------------------------
--      Module Declaration      --
----------------------------------

local boss = BB["Loken"]
local mod = BigWigs:New(boss, tonumber(("$Revision$"):sub(12, -3)))
if not mod then return end
mod.partycontent = true
mod.otherMenu = "The Storm Peaks"
mod.zonename = BZ["Halls of Lightning"]
mod.enabletrigger = boss
mod.guid = 28586
mod.toggleOptions = {"nova","novaBar","bosskill"}

----------------------------------
--        Are you local?        --
----------------------------------

local casttime
local difficulty

----------------------------------
--         Localization         --
----------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

L:RegisterTranslations("enUS", function() return --@localization(locale="enUS", namespace="Ulduar/Loken", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("deDE", function() return --@localization(locale="deDE", namespace="Ulduar/Loken", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esES", function() return --@localization(locale="esES", namespace="Ulduar/Loken", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esMX", function() return --@localization(locale="esMX", namespace="Ulduar/Loken", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("frFR", function() return --@localization(locale="frFR", namespace="Ulduar/Loken", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("koKR", function() return --@localization(locale="koKR", namespace="Ulduar/Loken", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("ruRU", function() return --@localization(locale="ruRU", namespace="Ulduar/Loken", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhCN", function() return --@localization(locale="zhCN", namespace="Ulduar/Loken", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhTW", function() return --@localization(locale="zhTW", namespace="Ulduar/Loken", format="lua_table", handle-unlocalized="ignore")@
end )

----------------------------------
--        Initialization        --
----------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_START", "Nova", 52960, 59835)
	self:AddCombatListener("UNIT_DIED", "BossDeath")

	difficulty = GetInstanceDifficulty()
end

----------------------------------
--        Event Handlers        --
----------------------------------

function mod:Nova(_, spellId, _, _, spellName)
	if self.db.profile.nova then
		self:IfMessage(L["nova_message"], "Urgent", spellId)
	end
	if self.db.profile.novaBar then
		if difficulty == 1 then casttime = 5 else casttime = 4 end
		self:Bar(spellName, casttime, spellId)
	end
end
