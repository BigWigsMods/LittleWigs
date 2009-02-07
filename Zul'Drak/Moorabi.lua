----------------------------------
--      Module Declaration      --
----------------------------------

local boss = BB["Moorabi"]
local mod = BigWigs:New(boss, tonumber(("$Revision$"):sub(12, -3)))
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Zul'Drak"
mod.zonename = BZ["Gundrak"]
mod.enabletrigger = boss 
mod.guid = 29305
mod.toggleoptions = {"transformation", "transformationBar", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

----------------------------------
--        Are you local?        --
----------------------------------

local transSpellName = GetSpellInfo(55098)

----------------------------------
--         Localization         --
----------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

L:RegisterTranslations("enUS", function() return --@localization(locale="enUS", namespace="Zul_Drak/Moorabi", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("deDE", function() return --@localization(locale="deDE", namespace="Zul_Drak/Moorabi", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esES", function() return --@localization(locale="esES", namespace="Zul_Drak/Moorabi", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esMX", function() return --@localization(locale="esMX", namespace="Zul_Drak/Moorabi", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("frFR", function() return --@localization(locale="frFR", namespace="Zul_Drak/Moorabi", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("koKR", function() return --@localization(locale="koKR", namespace="Zul_Drak/Moorabi", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("ruRU", function() return --@localization(locale="ruRU", namespace="Zul_Drak/Moorabi", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhCN", function() return --@localization(locale="zhCN", namespace="Zul_Drak/Moorabi", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhTW", function() return --@localization(locale="zhTW", namespace="Zul_Drak/Moorabi", format="lua_table", handle-unlocalized="ignore")@
end )

----------------------------------
--        Initialization        --
----------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_START", "Transform", 55098)
	self:AddCombatListener("SPELL_INTERRUPT", "Interrupt", 32747) -- spellId of Interrupt
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Transform(_, spellId, _, _, spellName)
	if self.db.profile.transformation then
		self:IfMessage(L["transformation_message"], "Urgent", spellId)
	end
	if self.db.profile.transformationBar then
		self:Bar(transSpellName, 4, spellId)
	end
end

function mod:Interrupt(_, _, source)
	if self.db.profile.transformationBar and source == boss then
		self:TriggerEvent("BigWigs_StopBar", self, transSpellName)
	end
end
