-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Jan'alai", 781)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(23578)
mod.toggleOptions = {
	{97497, "ICON"}, -- Flame Breath (this is the aura debuff spellid)
	"adds",
	"bomb",
	"bosskill",
}

-------------------------------------------------------------------------------
--  Localization

local L = mod:GetLocale()
if L then
	L["adds"] = "Amani'shi Hatchers"
	L["adds_desc"] = "Warn for incoming Amani'shi Hatchers."
	L["adds_message"] = "Amani'shi Hatchers incoming!"
	L["adds_all"] = "All remaining Amani'shi Hatchers soon!"

	L["bomb"] = "Fire Bombs"
	L["bomb_desc"] = "Show timers for Fire Bombs."
	L["bomb_trigger"] = "I burn ya now!"
	L["bomb_message"] = "Fire Bombs incoming!"
end

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "FlameBreath", 97855) -- This is the actual cast spellid

	--self:Yell("Adds", L["adds_trigger"])
	self:Yell("Bomb", L["bomb_trigger"])

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Win", 23578)
end

function mod:OnEngage()
	self:Bar("adds", LW_CL["next"]:format(L["adds"]), 12, 89259)
	self:RegisterEvent("UNIT_HEALTH")
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", "Adds")
end

-------------------------------------------------------------------------------
--  Event Handlers

do
	local function checkTarget(spellName)
		if not UnitIsPlayer("boss1target") then return end
		local player = UnitName("boss1target")
		mod:TargetMessage(97497, spellName, player, "Important", 97497, "Alert")
		mod:PrimaryIcon(97497, player)
	end
	function mod:FlameBreath(_, _, _, _, spellName)
		self:ScheduleTimer(checkTarget, 0.2, spellName)
	end
end

function mod:Adds(_, _, _, _, _, spellId)
	if spellId ~= 43962 then return end
	self:Message("adds", L["adds_message"], "Attention", 89259, "Long")
	self:Bar("adds", LW_CL["next"]:format(L["adds"]), 92, 89259)
end

function mod:Bomb()
	self:Message("bomb", L["bomb_message"], "Urgent", 42630, "Info")
	self:Bar("bomb", L["bomb"], 12, 42630)
end

function mod:UNIT_HEALTH()
	local hp = UnitHealth("boss1") / UnitHealthMax("boss1") * 100
	if hp < 37 then
		self:Message("adds", L["adds_all"], "Attention")
		self:UnregisterEvent("UNIT_HEALTH")
	end
end

