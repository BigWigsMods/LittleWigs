----------------------------------
--      Module Declaration      --
----------------------------------

local boss = BB["Svala Sorrowgrave"]
local mod = BigWigs:New(boss, tonumber(("$Revision$"):sub(12, -3)))
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Howling Fjord"
mod.zonename = BZ["Utgarde Pinnacle"]
mod.enabletrigger = boss 
mod.guid = 26668
mod.toggleOptions = {"ritual", "ritualbars", "preparation", "bosskill"}

--------------------------------
--       Are you local?       --
--------------------------------

local started = nil

--------------------------------
--        Localization        --
--------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

L:RegisterTranslations("enUS", function() return --@localization(locale="enUS", namespace="Howling_Fjord/Svala_Sorrowgrave", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("deDE", function() return --@localization(locale="deDE", namespace="Howling_Fjord/Svala_Sorrowgrave", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esES", function() return --@localization(locale="esES", namespace="Howling_Fjord/Svala_Sorrowgrave", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esMX", function() return --@localization(locale="esMX", namespace="Howling_Fjord/Svala_Sorrowgrave", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("frFR", function() return --@localization(locale="frFR", namespace="Howling_Fjord/Svala_Sorrowgrave", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("koKR", function() return --@localization(locale="koKR", namespace="Howling_Fjord/Svala_Sorrowgrave", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("ruRU", function() return --@localization(locale="ruRU", namespace="Howling_Fjord/Svala_Sorrowgrave", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhCN", function() return --@localization(locale="zhCN", namespace="Howling_Fjord/Svala_Sorrowgrave", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhTW", function() return --@localization(locale="zhTW", namespace="Howling_Fjord/Svala_Sorrowgrave", format="lua_table", handle-unlocalized="ignore")@
end )

----------------------------------
--        Initialization        --
----------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_START", "Ritual", 48276)
	self:AddCombatListener("SPELL_AURA_APPLIED", "Preparation", 48267)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
	
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")

	started = nil
end

----------------------------------
--        Event Handlers        --
----------------------------------

function mod:Ritual(_, spellId, _, _, spellName)
	if self.db.profile.ritual then
		self:IfMessage(L["ritual"], "Urgent", spellId)
		self:DelayedMessage(36, L["ritualcooldown_message"], "Attention")
	end
	if self.db.profile.ritualbars then
		self:Bar(spellName, 26, spellId)
		self:Bar(L["ritualcooldown_bar"], 36, spellId)
	end
end

function mod:Preparation(player, spellId, _, _, spellName)
	if self.db.profile.preparation then
		self:IfMessage(L["preparation_message"]:format(spellName, player), "Attention", spellId)
	end
end
