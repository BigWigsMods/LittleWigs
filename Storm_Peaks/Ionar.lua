----------------------------------
--      Module Declaration      --
----------------------------------

local boss = BB["Ionar"]
local mod = BigWigs:New(boss, tonumber(("$Revision$"):sub(12, -3)))
if not mod then return end
mod.partycontent = true
mod.otherMenu = "The Storm Peaks"
mod.zonename = BZ["Halls of Lightning"]
mod.enabletrigger = boss
mod.guid = 28546
mod.toggleoptions = {"overload","overloadWhisper","overloadBar","bosskill"}

--------------------------------
--       Are you local?       --
--------------------------------

local pName = UnitName("player")

--------------------------------
--        Localization        --
--------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

L:RegisterTranslations("enUS", function() return --@localization(locale="enUS", namespace="Ulduar/Ionar", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("deDE", function() return --@localization(locale="deDE", namespace="Ulduar/Ionar", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esES", function() return --@localization(locale="esES", namespace="Ulduar/Ionar", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esMX", function() return --@localization(locale="esMX", namespace="Ulduar/Ionar", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("frFR", function() return --@localization(locale="frFR", namespace="Ulduar/Ionar", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("koKR", function() return --@localization(locale="koKR", namespace="Ulduar/Ionar", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("ruRU", function() return --@localization(locale="ruRU", namespace="Ulduar/Ionar", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhCN", function() return --@localization(locale="zhCN", namespace="Ulduar/Ionar", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhTW", function() return --@localization(locale="zhTW", namespace="Ulduar/Ionar", format="lua_table", handle-unlocalized="ignore")@
end )

----------------------------------
--        Initialization        --
----------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Overload", 52658, 59795)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

----------------------------------
--        Event Handlers        --
----------------------------------

function mod:Overload(player, spellId)
	if self.db.profile.overload then
		self:IfMessage(L["overload_message"]:format(player), "Urgent", spellId)
	end
	if self.db.profile.overloadWhisper and (pName ~= player) then
		self:Whisper(player, L["overloadWhisper_message"])
	end	
	if self.db.profile.overloadBar then
		self:Bar(L["overload_message"]:format(player), 10, spellId)
	end
end
