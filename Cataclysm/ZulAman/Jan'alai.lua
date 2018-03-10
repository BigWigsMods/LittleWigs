-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Jan'alai", 781, 188)
if not mod then return end
mod:RegisterEnableMob(23578)

-------------------------------------------------------------------------------
--  Localization

local L = mod:GetLocale()
if L then
	L.adds = "Amani'shi Hatchers"
	L.adds_desc = "Warn for incoming Amani'shi Hatchers."
	L.adds_all = "All remaining Amani'shi Hatchers soon!"

	L.bomb = "Fire Bombs"
	L.bomb_desc = "Show timers for Fire Bombs."
	L.bomb_trigger = "I burn ya now!"
end

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		{97497, "ICON"}, -- Flame Breath (this is the aura debuff spellid)
		"adds",
		"bomb",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "Bomb")

	self:Log("SPELL_CAST_START", "FlameBreath", 43140) -- This is the actual cast spellid

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Death("Win", 23578)
end

function mod:OnEngage()
	self:CDBar("adds", 12, L.adds, 89259)
	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "boss1")
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
end

-------------------------------------------------------------------------------
--  Event Handlers

do
	local function printTarget(self, player)
		self:TargetMessage(97497, player, "Important", "Alert")
		self:PrimaryIcon(97497, player)
	end
	function mod:FlameBreath(args)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, _, spellId)
	if spellId == 43962 then
		self:Message("adds", "Attention", "Long", CL.incoming:format(L.adds), 89259)
		self:CDBar("adds", 92, L.adds, 89259)
	end
end

function mod:Bomb(_, msg)
	if msg == L.bomb_trigger then
		self:Message("bomb", "Urgent", "Info", CL.incoming:format(L.bomb), 42630)
		self:Bar("bomb", 12, L.bomb, 42630)
	end
end

function mod:UNIT_HEALTH_FREQUENT(unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < 37 then
		self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", unit)
		self:Message("adds", "Attention", nil, L.adds_all)
	end
end
