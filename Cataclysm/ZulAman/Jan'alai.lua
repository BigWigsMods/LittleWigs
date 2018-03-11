-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Jan'alai", 781, 188)
if not mod then return end
mod:RegisterEnableMob(23578)
mod.engageId = 1191
mod.respawnTime = 30

-------------------------------------------------------------------------------
--  Localization
--

local L = mod:GetLocale()
if L then
	L.adds = "Amani'shi Hatchers"
	L.bombs = "Fire Bombs"
end

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		-2625, -- Amani'shi Hatcher
		{97497, "ICON"}, -- Flame Breath (this is the aura debuff spellid)
		-2622, -- Fire Bomb
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "boss1")
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")

	self:Log("SPELL_CAST_START", "FlameBreath", 43140) -- This is the actual cast spellid
	self:Log("SPELL_CAST_SUCCESS", "FlameBreathSuccess", 43140)
end

function mod:OnEngage()
	self:CDBar(-2625, 12, L.adds, 89259)
end

-------------------------------------------------------------------------------
--  Event Handlers
--

do
	local function printTarget(self, player)
		self:TargetMessage(97497, player, "Important", "Alert")
		self:PrimaryIcon(97497, player)
	end
	function mod:FlameBreath(args)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
	end
	function mod:FlameBreathSuccess()
		self:PrimaryIcon(97497)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, _, spellId)
	if spellId == 43962 then -- Summon Amani'shi Hatcher
		self:Message(-2625, "Attention", "Long", CL.incoming:format(L.adds), 89259) -- 89259 provides "achievement_character_troll_male" icon
		self:CDBar(-2625, 92, L.adds, 89259)
	elseif spellId == 43098 then -- Teleport to Center (to cast Fire Bombs)
		self:Message(-2622, "Urgent", "Info", CL.incoming:format(L.bombs), 42630)
		self:Bar(-2622, 12, L.bombs)
	end
end

function mod:UNIT_HEALTH_FREQUENT(unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < 40 then
		self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", unit)
		self:Message(-2625, "Attention", nil, CL.soon:format(self:SpellName(-2628))) -- Hatch All Eggs Soon
	end
end
