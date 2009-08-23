----------------------------------
--      Module Declaration      --
----------------------------------

local boss = BB["General Bjarngrim"]
local mod = BigWigs:New(boss, tonumber(("$Revision$"):sub(12, -3)))
if not mod then return end
mod.partycontent = true
mod.otherMenu = "The Storm Peaks"
mod.zonename = BZ["Halls of Lightning"]
mod.enabletrigger = boss
mod.guid = 28586
mod.toggleOptions = {"mortalStrike", "mortalStrikeBar", -1, "berserker", "bosskill"}

--------------------------------
--        Localization        --
--------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

L:RegisterTranslations("enUS", function() return --@localization(locale="enUS", namespace="Ulduar/General_Bjarngrim", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("deDE", function() return --@localization(locale="deDE", namespace="Ulduar/General_Bjarngrim", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esES", function() return --@localization(locale="esES", namespace="Ulduar/General_Bjarngrim", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esMX", function() return --@localization(locale="esMX", namespace="Ulduar/General_Bjarngrim", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("frFR", function() return --@localization(locale="frFR", namespace="Ulduar/General_Bjarngrim", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("koKR", function() return --@localization(locale="koKR", namespace="Ulduar/General_Bjarngrim", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("ruRU", function() return --@localization(locale="ruRU", namespace="Ulduar/General_Bjarngrim", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhCN", function() return --@localization(locale="zhCN", namespace="Ulduar/General_Bjarngrim", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhTW", function() return --@localization(locale="zhTW", namespace="Ulduar/General_Bjarngrim", format="lua_table", handle-unlocalized="ignore")@
end )

----------------------------------
--        Initialization        --
----------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "MortalStrike", 16856)
	self:AddCombatListener("SPELL_AURA_APPLIED", "Berserker", 41107)
	self:AddCombatListener("SPELL_AURA_REMOVED", "BerserkerRemoved", 41107)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

----------------------------------
--        Event Handlers        --
----------------------------------

function mod:MortalStrike(player, spellId)
	if self.db.profile.mortalStrike then
		self:IfMessage(L["mortalStrike_message"]:format(player), "Important", spellId)
	end
	if self.db.profile.mortalStrikeBar then
		self:Bar(L["mortalStrike_message"]:format(player), 5, spellId)
	end
end

function mod:Berserker(target, spellId)
	if self.db.profile.beserker and (target == boss) then
		self:IfMessage(L["berserker_applied"]:format(player), "Urgent", spellId)
	end
end

function mod:BerserkerRemoved(player, spellId)
	if self.db.profile.beserker and (target == boss) then
		self:IfMessage(L["berserker_removed"], "Attention", spellId)
	end
end
