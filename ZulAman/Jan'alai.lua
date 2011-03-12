-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Jan'alai", "Zul'Aman")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(23578)
mod.toggleOptions = {
	{43140, "ICON"},
	"adds",
	"bomb",
	"bosskill",
}

--------------------------------------------------------------------------------
--  Locals

local flameBreath = GetSpellInfo(43140)

-------------------------------------------------------------------------------
--  Localization

local L = mod:NewLocale("enUS", true)
if L then
--@do-not-package@
L["adds"] = "Adds"
L["adds_desc"] = "Warn for Incoming Adds."
L["adds_trigger"] = "Where ma hatcha? Get to work on dem eggs!"
L["adds_message"] = "Incoming Adds!"
L["adds_all"] = "All egg Hatching soon!"
L["bomb"] = "Fire Bomb"
L["bomb_desc"] = "Show timers for Fire Bomb."
L["bomb_trigger"] = "I burn ya now!"
L["bomb_message"] = "Incoming Fire Bombs!"
--@localization(locale="enUS", namespace="ZulAman/Jan'alai", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = mod:GetLocale()

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "FlameBreath", 43140)
	
	self:Yell("Adds", L["adds_trigger"])
	self:Yell("Bomb", L["bomb_trigger"])
	
	self:RegisterEvent("UNIT_HEALTH")
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	
	self:Death("Win", 23578)
end

function mod:OnEngage()
	self:Berserk(600)
	self:Bar("Adds", LW_CL["next"]:format(adds), 12, 89259)
end

-------------------------------------------------------------------------------
--  Event Handlers

do
	local function checkTarget()
		local player = UnitName("boss1target")
		mod:TargetMessage(43140, flameBreath, player, "Important", 43140, "Alert")
		mod:PrimaryIcon(43140, player)
	end
	function mod:FlameBreath()
		self:ScheduleTimer(checkTarget, 0.2)
	end
end

function mod:Adds()
	self:Message("adds", L["adds_message"], "Attention", 89259, "Alarm")
	self:Bar("adds", LW_CL["next"]:format(adds), 92, 89259)
end

function mod:Bomb()
	self:Message("bomb", L["bomb_message"], "Attention", 42630, "Long")
	self:Bar("bomb", L["bomb"], 12, 42630)
end

function mod:UNIT_HEALTH(_, unit)
	if unit == "boss1" and UnitName(unit) == self.displayName then
		local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
		if hp < 37 then
			self:Message("adds", L["adds_all"], "Attention", 89259, "Info")
			self:UnregisterEvent("UNIT_HEALTH")
		end
	end
end
