----------------------------------
--      Module Declaration      --
----------------------------------

local boss = BB["Argent Confessor Paletress"]
local mod = BigWigs:New(boss, tonumber(("$Revision: 550 $"):sub(12, -3)))
if not mod then return end
mod.partycontent = true
mod.otherMenu = "Icecrown"
mod.zonename = BZ["Trial of the Champion"]
mod.enabletrigger = boss
mod.guid = 34928
mod.toggleOptions = {"shield", "healing", "bosskill"}

--------------------------------
--           Locals           --
--------------------------------

local shielded = false

--------------------------------
--        Localization        --
--------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

L:RegisterTranslations("enUS", function() return --@localization(locale="enUS", namespace="Icecrown/Argent_Confessor_Paletress", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("deDE", function() return --@localization(locale="deDE", namespace="Icecrown/Argent_Confessor_Paletress", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esES", function() return --@localization(locale="esES", namespace="Icecrown/Argent_Confessor_Paletress", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esMX", function() return --@localization(locale="esMX", namespace="Icecrown/Argent_Confessor_Paletress", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("frFR", function() return --@localization(locale="frFR", namespace="Icecrown/Argent_Confessor_Paletress", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("koKR", function() return --@localization(locale="koKR", namespace="Icecrown/Argent_Confessor_Paletress", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("ruRU", function() return --@localization(locale="ruRU", namespace="Icecrown/Argent_Confessor_Paletress", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhCN", function() return --@localization(locale="zhCN", namespace="Icecrown/Argent_Confessor_Paletress", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhTW", function() return --@localization(locale="zhTW", namespace="Icecrown/Argent_Confessor_Paletress", format="lua_table", handle-unlocalized="ignore")@
end )

----------------------------------
--        Initialization        --
----------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "ShieldGain", 66515)
	self:AddCombatListener("SPELL_AURA_REMOVED", "ShieldLost", 66515)
	self:AddCombatListener("SPELL_CAST_START", "Renew", 66537, 67675)
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	--self:AddCombatListener("UNIT_DIED", "BossDeath")
	
	shielded = false
end

----------------------------------
--        Event Handlers        --
----------------------------------

function mod:ShieldGain(_, spellId, _, _, spellName)
	if self.db.profile.shield then
		self:IfMessage(L["shield_gain"], "Urgent", spellId)
	end
	shielded = true
end

function mod:ShieldLost(_, spellId, _, _, spellName)
	if self.db.profile.shield then
		self:IfMessage(L["shield_lost"], "Urgent", spellId)
	end
	shielded = false
end

function mod:Renew(_, spellId, _, _, spellName)
	-- don't bother announcing while she is shielded
	if not shielded and self.db.profile.healing then
		self:IfMessage(L["heal_msg"], "Urgent", spellId)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L["trigger_surrender"] then
		self:BossDeath(nil, self.guid)
	end
end
