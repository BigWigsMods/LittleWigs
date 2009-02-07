----------------------------------
--      Module Declaration      --
----------------------------------

local boss = BB["Cyanigosa"]
local mod = BigWigs:New(boss, tonumber(("$Revision$"):sub(12, -3)))
if not mod then return end
mod.partyContent = true
mod.otherMenu = "Dalaran"
mod.zonename = BZ["The Violet Hold"]
mod.enabletrigger = boss
mod.guid = 31134
mod.toggleoptions = {"blizzard", -1, "vacuum", "vacuumcooldown", -1, "destruction", "destructionBar", "bosskill"}

----------------------------------
--         Localization         --
----------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

L:RegisterTranslations("enUS", function() return --@localization(locale="enUS", namespace="Dalaran/Cyanigosa", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("deDE", function() return --@localization(locale="deDE", namespace="Dalaran/Cyanigosa", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esES", function() return --@localization(locale="esES", namespace="Dalaran/Cyanigosa", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("esMX", function() return --@localization(locale="esMX", namespace="Dalaran/Cyanigosa", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("frFR", function() return --@localization(locale="frFR", namespace="Dalaran/Cyanigosa", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("koKR", function() return --@localization(locale="koKR", namespace="Dalaran/Cyanigosa", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("ruRU", function() return --@localization(locale="ruRU", namespace="Dalaran/Cyanigosa", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhCN", function() return --@localization(locale="zhCN", namespace="Dalaran/Cyanigosa", format="lua_table", handle-unlocalized="ignore")@
end )

L:RegisterTranslations("zhTW", function() return --@localization(locale="zhTW", namespace="Dalaran/Cyanigosa", format="lua_table", handle-unlocalized="ignore")@
end )

----------------------------------
--        Initialization        --
----------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Vacuum", 58694)
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Blizzard", 58693, 59369)
	self:AddCombatListener("SPELL_AURA_APPLIED", "Destruction", 59374)
	self:AddCombatListener("SPELL_AURA_REMOVED", "DestructionRemoved", 59374)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
	
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:RegisterEvent("BigWigs_RecvSync")
end

----------------------------------
--        Event Handlers        --
----------------------------------

function mod:Vacuum(_, spellId)
	if self.db.profile.vacuum then
		self:IfMessage(L["vacuum_message"], "Important", spellId)
	end
	if self.db.profile.vacuumcooldown then
		self:TriggerEvent("BigWigs_StopBar", self, L["vacuum_cooldown_bar"])
		self:CancelScheduledEvent("VacuumWarn")
		self:Bar(L["vacuum_cooldown_bar"], 30, 58694)
		self:ScheduleEvent("VacuumWarn", "BigWigs_Message", 25, L["vacuum_soon"], "Urgent")
	end
end

function mod:Blizzard(_, spellId)
	if self.db.profile.blizzard then
		self:IfMessage(L["blizzard_message"], "Important", spellId)
	end
end

function mod:Destruction(player, spellId, _, _, spellName)
	if self.db.profile.destruction then
		self:IfMessage(L["destruction_message"]:format(spellName, player), "Important", spellId)
	end
	if self.db.profile.destructionBar then
		self:Bar(L["destruction_message"]:format(spellName, player), 8, spellId)
	end
end

function mod:DestructionRemoved(player, _, _, _, spellName)
	if self.db.profile.destructionBar then
		self:TriggerEvent("BigWigs_StopBar", self, L["destruction_message"]:format(spellName, player))
	end
end

function mod:BigWigs_RecvSync(sync, rest, nick)
	if self:ValidateEngageSync(sync, rest) and not started then
		if self:IsEventRegistered("PLAYER_REGEN_DISABLED") then
			self:UnregisterEvent("PLAYER_REGEN_DISABLED")
		end
		if self.db.profile.vacuumcooldown then
			self:Bar(L["vacuum_cooldown_bar"], 30, 58694)
			self:ScheduleEvent("VacuumWarn", "BigWigs_Message", 25, L["vacuum_soon"], "Urgent")
		end
	end
end
