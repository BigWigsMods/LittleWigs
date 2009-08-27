----------------------------------
--      Module Declaration      --
----------------------------------

local boss = BB["The Black Knight"]
local mod = BigWigs:New(boss, tonumber(("$Revision: 550 $"):sub(12, -3)))
if not mod then return end
mod.partycontent = true
mod.otherMenu = "Icecrown"
mod.zonename = BZ["Trial of the Champion"]
mod.enabletrigger = boss
mod.guid = 35451
mod.toggleOptions = {"explode", "explodeBar", "desecration", "bosskill"}

--------------------------------
--       Are you local?       --
--------------------------------

local deaths = 0
local pName = UnitName("player")

--------------------------------
--        Localization        --
--------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

L:RegisterTranslations("enUS", function() return --@localization(locale="enUS", namespace="Icecrown/Black_Knight", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("deDE", function() return --@localization(locale="deDE", namespace="Icecrown/Black_Knight", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esES", function() return --@localization(locale="esES", namespace="Icecrown/Black_Knight", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esMX", function() return --@localization(locale="esMX", namespace="Icecrown/Black_Knight", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("frFR", function() return --@localization(locale="frFR", namespace="Icecrown/Black_Knight", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("koKR", function() return --@localization(locale="koKR", namespace="Icecrown/Black_Knight", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("ruRU", function() return --@localization(locale="ruRU", namespace="Icecrown/Black_Knight", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhCN", function() return --@localization(locale="zhCN", namespace="Icecrown/Black_Knight", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhTW", function() return --@localization(locale="zhTW", namespace="Icecrown/Black_Knight", format="lua_table", handle-unlocalized="ignore")@
end )

----------------------------------
--        Initialization        --
----------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_START", "Explode", 67751)-- other possible ids :  67886, 51874, 47496, 67729,
	self:AddCombatListener("SPELL_AURA_APPLIED", "Desecration", 67781, 67876)
	self:AddCombatListener("UNIT_DIED", "Deaths")

	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")

	deaths = 0
end

----------------------------------
--        Event Handlers        --
----------------------------------

function mod:Explode(_, spellId, _, _, spellName)
	if self.db.profile.explode then
		self:IfMessage(L["explode_message"], "Urgent", spellId)
	end
	if self.db.profile.explodeBar then
		self:Bar(spellName, 4, spellId)
	end
end

function mod:Deaths(_, guid)
	if not self.db.profile.bosskill then return end
	guid = tonumber((guid):sub(-12,-7),16)
	if guid == self.guid then
		deaths = deaths + 1
	end
	if deaths == 3 then
		self:BossDeath(_, guid)
	end
end

function mod:Desecration(player)
	if player == pName and self.db.profile.desecration then
		self:LocalMessage(L["desecration"], "Personal", 67781, "Alarm")
	end
end	
