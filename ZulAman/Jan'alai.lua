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

-------------------------------------------------------------------------------
--  Localization

local L = mod:NewLocale("enUS", true)
if L then
--@do-not-package@
L["adds"] = "Adds"
L["adds_desc"] = "Warn for incoming adds."
L["adds_trigger"] = "Where ma hatcha? Get to work on dem eggs!"
L["adds_message"] = "Adds incoming!"
L["adds_all"] = "Remaining adds soon!"

L["bomb"] = "Fire Bombs"
L["bomb_desc"] = "Show timers for Fire Bombs."
L["bomb_trigger"] = "I burn ya now!"
L["bomb_message"] = "Fire Bombs incoming!"
--@localization(locale="enUS", namespace="ZulAman/Jan'alai", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = mod:GetLocale()

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "FlameBreath", 43140)

	self:Yell("Adds", L["adds_trigger"])
	self:Yell("Bomb", L["bomb_trigger"])

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Win", 23578)
end

function mod:OnEngage()
	self:Berserk(600) -- XXX verify
	self:Bar("adds", LW_CL["next"]:format(L["adds"]), 12, 89259)
	self:RegisterEvent("UNIT_HEALTH")
end

-------------------------------------------------------------------------------
--  Event Handlers

do
	local function checkTarget(spellName)
		local player = UnitName("boss1target")
		mod:TargetMessage(43140, spellName, player, "Important", 43140, "Alert")
		mod:PrimaryIcon(43140, player)
	end
	function mod:FlameBreath(_, _, _, _, spellName)
		self:ScheduleTimer(checkTarget, 0.2, spellName)
	end
end

function mod:Adds()
	self:Message("adds", L["adds_message"], "Attention", 89259, "Long")
	self:Bar("adds", LW_CL["next"]:format(L["adds"]), 92, 89259)
end

function mod:Bomb()
	self:Message("bomb", L["bomb_message"], "Urgent", 42630, "Info")
	self:Bar("bomb", L["bomb"], 12, 42630)
end

function mod:UNIT_HEALTH(_, unit)
	if unit == "boss1" and UnitName(unit) == self.displayName then
		local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
		if hp < 37 then
			self:Message("adds", L["adds_all"], "Attention")
			self:UnregisterEvent("UNIT_HEALTH")
		end
	end
end

