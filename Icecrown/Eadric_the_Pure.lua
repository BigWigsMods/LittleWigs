----------------------------------
--      Module Declaration      --
----------------------------------

local boss = BB["Eadric the Pure"]
local mod = BigWigs:New(boss, tonumber(("$Revision: 550 $"):sub(12, -3)))
if not mod then return end
mod.partycontent = true
mod.otherMenu = "Icecrown"
mod.zonename = BZ["Trial of the Champion"]
mod.enabletrigger = boss
mod.guid = 35119
mod.toggleOptions = {"radiance", "radianceBar", "bosskill"}

--------------------------------
--        Localization        --
--------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

L:RegisterTranslations("enUS", function() return --@localization(locale="enUS", namespace="Icecrown/Eadric_the_Pure", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("deDE", function() return --@localization(locale="deDE", namespace="Icecrown/Eadric_the_Pure", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esES", function() return --@localization(locale="esES", namespace="Icecrown/Eadric_the_Pure", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esMX", function() return --@localization(locale="esMX", namespace="Icecrown/Eadric_the_Pure", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("frFR", function() return --@localization(locale="frFR", namespace="Icecrown/Eadric_the_Pure", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("koKR", function() return --@localization(locale="koKR", namespace="Icecrown/Eadric_the_Pure", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("ruRU", function() return --@localization(locale="ruRU", namespace="Icecrown/Eadric_the_Pure", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhCN", function() return --@localization(locale="zhCN", namespace="Icecrown/Eadric_the_Pure", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhTW", function() return --@localization(locale="zhTW", namespace="Icecrown/Eadric_the_Pure", format="lua_table", handle-unlocalized="ignore")@
end )

----------------------------------
--        Initialization        --
----------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_START", "radiance", 66935, 66862, 67681)
	--self:AddCombatListener("SPELL_AURA_APPLIED", "hammer", 66940)
	--self:AddCombatListener("UNIT_DIED", "BossDeath")
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
end

----------------------------------
--        Event Handlers        --
----------------------------------

function mod:radiance(_, spellId, _, _, spellName)
	if self.db.profile.radiance then
		self:IfMessage(L["radiance_message"], "Urgent", spellId)
	end
	if self.db.profile.radianceBar then
		self:Bar(spellName, 3, spellId)
	end
end

--[[function mod:hammer(player)
	local other = fmt(L["hammer_message_other"], player)
	if player == pName and db.youhammer then

		self:LocalMessage(L["hammer_message_you"], "Personal", 66940)
		self:WideMessage(other)
	elseif db.elsehammer then
		self:IfMessage(other, "Attention", 66940)
		self:Whisper(player, L["hammer_message_you"])
	end

end]]--

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L["defeat_trigger"] then
		self:BossDeath(nil, self.guid)
	end
end
