-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Jan'alai", 568, 188)
if not mod then return end
mod:RegisterEnableMob(23578)
mod.engageId = 1191
mod.respawnTime = 30

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
	self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1")
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")

	self:Log("SPELL_CAST_START", "FlameBreath", 43140) -- This is the actual cast spellid
	self:Log("SPELL_CAST_SUCCESS", "FlameBreathSuccess", 43140)
end

function mod:OnEngage()
	self:CDBar(-2625, 12, nil, "achievement_character_troll_male") -- Amani'shi Hatchers
end

-------------------------------------------------------------------------------
--  Event Handlers
--

do
	local function printTarget(self, player)
		self:TargetMessageOld(97497, player, "red", "alert")
		self:PrimaryIcon(97497, player)
	end
	function mod:FlameBreath(args)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
	end
	function mod:FlameBreathSuccess()
		self:PrimaryIcon(97497)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 43962 then -- Summon Amani'shi Hatcher
		self:MessageOld(-2625, "yellow", "long", CL.incoming:format(self:SpellName(-2625)), "achievement_character_troll_male")
		self:CDBar(-2625, 92, nil, "achievement_character_troll_male")
	elseif spellId == 43098 then -- Teleport to Center (to cast Fire Bombs)
		self:MessageOld(-2622, "orange", "info", CL.incoming:format(self:SpellName(-2622)))
		self:Bar(-2622, 12)
	end
end

function mod:UNIT_HEALTH(event, unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < 40 then
		self:UnregisterUnitEvent(event, unit)
		self:MessageOld(-2625, "yellow", nil, CL.soon:format(self:SpellName(-2628)), false) -- Hatch All Eggs Soon
	end
end
