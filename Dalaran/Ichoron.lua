----------------------------------
--      Module Declaration      --
----------------------------------

local boss = BB["Ichoron"]
local mod = BigWigs:New(boss, tonumber(("$Revision$"):sub(12, -3)))
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Dalaran"
mod.zonename = BZ["The Violet Hold"]
mod.enabletrigger = boss 
mod.guid = 29313
mod.toggleOptions = {"bubble", "frenzy", "bosskill"}

----------------------------------
--         Localization         --
----------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

L:RegisterTranslations("enUS", function() return --@localization(locale="enUS", namespace="Dalaran/Ichoron", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("deDE", function() return --@localization(locale="deDE", namespace="Dalaran/Ichoron", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esES", function() return --@localization(locale="esES", namespace="Dalaran/Ichoron", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esMX", function() return --@localization(locale="esMX", namespace="Dalaran/Ichoron", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("frFR", function() return --@localization(locale="frFR", namespace="Dalaran/Ichoron", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("koKR", function() return --@localization(locale="koKR", namespace="Dalaran/Ichoron", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("ruRU", function() return --@localization(locale="ruRU", namespace="Dalaran/Ichoron", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhCN", function() return --@localization(locale="zhCN", namespace="Dalaran/Ichoron", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhTW", function() return --@localization(locale="zhTW", namespace="Dalaran/Ichoron", format="lua_table", handle-unlocalized="ignore")@
end )

----------------------------------
--        Initialization        --
----------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Bubble", 54306)
	self:AddCombatListener("SPELL_AURA_REMOVED", "BubbleRemoved", 54306)
	self:AddCombatListener("SPELL_AURA_APPLIED", "Frenzy", 54312, 59522)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

----------------------------------
--        Event Handlers        --
----------------------------------

function mod:Bubble(_, spellId)
	if self.db.profile.bubble then
		self:IfMessage(L["bubble_message"], "Important", spellId)
	end
end

function mod:BubbleRemoved(_, spellId)
	if self.db.profile.bubble then
		self:IfMessage(L["bubbleEnded_message"], "Positive", spellId)
	end
end

function mod:Frenzy(_, spellId, _, _, spellName)
	if self.db.profile.frenzy then
		self:IfMessage(spellName, "Important", spellId)
	end
end
