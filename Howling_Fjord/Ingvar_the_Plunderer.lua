----------------------------------
--      Module Declaration      --
----------------------------------

local boss = BB["Ingvar the Plunderer"]
local mod = BigWigs:New(boss, tonumber(("$Revision$"):sub(12, -3)))
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Howling Fjord"
mod.zonename = BZ["Utgarde Keep"]
mod.enabletrigger = boss 
mod.guid = 23954
mod.toggleoptions = {"smash", "smashBar", -1, "woe", "woeBar", -1, "roar", "bosskill"}

--------------------------------
--       Are you local?       --
--------------------------------

local deaths = 0

--------------------------------
--        Localization        --
--------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

L:RegisterTranslations("enUS", function() return --@localization(locale="enUS", namespace="Howling_Fjord/Ingvar_the_Plunderer", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("deDE", function() return --@localization(locale="deDE", namespace="Howling_Fjord/Ingvar_the_Plunderer", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esES", function() return --@localization(locale="esES", namespace="Howling_Fjord/Ingvar_the_Plunderer", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esMX", function() return --@localization(locale="esMX", namespace="Howling_Fjord/Ingvar_the_Plunderer", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("frFR", function() return --@localization(locale="frFR", namespace="Howling_Fjord/Ingvar_the_Plunderer", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("koKR", function() return --@localization(locale="koKR", namespace="Howling_Fjord/Ingvar_the_Plunderer", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("ruRU", function() return --@localization(locale="ruRU", namespace="Howling_Fjord/Ingvar_the_Plunderer", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhCN", function() return --@localization(locale="zhCN", namespace="Howling_Fjord/Ingvar_the_Plunderer", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhTW", function() return --@localization(locale="zhTW", namespace="Howling_Fjord/Ingvar_the_Plunderer", format="lua_table", handle-unlocalized="ignore")@
end )

----------------------------------
--        Initialization        --
----------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_START", "Smash", 42723, 42669, 59706)
	self:AddCombatListener("SPELL_CAST_START", "Roar", 42708, 42729, 59708, 59734)
	self:AddCombatListener("SPELL_AURA_APPLIED", "Woe", 42730, 59735)
	self:AddCombatListener("UNIT_DIED", "Deaths")

	deaths = 0
end

----------------------------------
--        Event Handlers        --
----------------------------------

function mod:Smash(_, spellID, _, _, spellName)
	if self.db.profile.smash then
		self:IfMessage(L["smash_message"]:format(spellName), "Urgent", spellID)
	end
	if self.db.profile.smashBar then
		self:Bar(L["smash_message"]:format(spellName), 3, spellID)
	end
end

function mod:Roar(_, spellID, _, _, spellName)
	if self.db.profile.roar then
		self:IfMessage(L["roar_message"]:format(spellName), "Urgent", spellID)
	end
end

function mod:Deaths(_, guid)
	if not self.db.profile.bosskill then return end
	guid = tonumber((guid):sub(-12,-7),16)
	if guid == self.guid then
		deaths = deaths + 1
	end
	if deaths == 2 then
		self:BossDeath(_, guid)
	end
end

function mod:Woe(player, spellId)
	if self.db.profile.woe then
		self:IfMessage(L["woe_message"]:format(player), "Urgent", spellId)
	end
	if self.db.profile.woeBar then
		self:Bar(L["woeBar_message"]:format(player), 10, spellId)
	end
end
