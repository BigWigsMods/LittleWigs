
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Nightbane", 1651)
if not mod then return end
mod:RegisterEnableMob(114895)
mod.engageId = 2031
--mod.respawnTime = 0

--------------------------------------------------------------------------------
-- Locals
--

local igniteSoulOnMe = nil
local shardCount = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.name = "Nightbane"
end

--------------------------------------------------------------------------------
-- Initialization
--
function mod:GetOptions()
	return {
		"stages",
		{228790, "TANK_HEALER"}, -- Concentrated Power
		{228792, "HEALER"}, -- Infernal Power
		228785, -- Cinder Breath
		228808, -- Charred Earth
		229307, -- Reverberating Shadows
		228829, -- Burning Bones
		{228796, "SAY", "SAY_COUNTDOWN", "FLASH"}, -- Ignite Soul
		228834, -- Jagged Shards
		228835, -- Absorb Vitality
		228837, -- Bellowing Roar
	},{
		["stages"] = "general",
		[228834] = CL.stage:format(2),
		[228837] = CL.stage:format(3),
	}
end

function mod:OnRegister()
	self.displayName = L.name
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Death("BonecurseDeath", 114903)
	self:Log("SPELL_CAST_START", "Stage2", 228839) -- Rain of Bones
	self:Log("SPELL_CAST_START", "CinderBreath", 228785)
	self:Log("SPELL_CAST_START", "ReverberatingShadows", 229307)
	self:Log("SPELL_AURA_APPLIED", "BurningBones", 228829)
	self:Log("SPELL_AURA_APPLIED", "InfernalPower", 228792)
	self:Log("SPELL_AURA_REMOVED", "InfernalPowerRemoved", 228792)
	self:Log("SPELL_AURA_APPLIED", "IgniteSoul", 228796)
	self:Log("SPELL_AURA_REMOVED", "IgniteSoulRemoved", 228796)
	self:Log("SPELL_AURA_APPLIED", "ConcentratedPower", 228790)
	self:Log("SPELL_AURA_REMOVED", "ConcentratedPowerRemoved", 228790)
	self:Log("SPELL_CAST_SUCCESS", "JaggedShards", 228834)
	self:Log("SPELL_AURA_APPLIED", "AbsorbVitality", 228835)
	self:Log("SPELL_AURA_REMOVED", "AbsorbVitalityRemoved", 228835)
	self:Log("SPELL_CAST_START", "BellowingRoar", 228837)

	self:Log("SPELL_AURA_APPLIED", "CharredEarthDamage", 228808)
	self:Log("SPELL_PERIODIC_DAMAGE", "CharredEarthDamage", 228808)
	self:Log("SPELL_PERIODIC_MISSED", "CharredEarthDamage", 228808)
end

function mod:OnEngage()
	igniteSoulOnMe = nil
	shardCount = 1

	self:Bar(228785, 8) -- Cinder Breath
	self:Bar(228808, 15.5) -- Charred Earth
	self:Bar(229307, 16.5) -- Reverberating Shadows
	self:Bar(228792, 20) -- Infernal Power
	self:Bar(228796, 20) -- Ignite Soul
	self:Bar(228790, 40) -- Concentrated Power
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 228806 then -- Charred Earth
		self:MessageOld(228808, "orange", self:Ranged() and "alert")
		self:CDBar(228808, 20)
	elseif spellId == 228789 then -- Flowing Power (Stage 3)
		self:Bar(228785, 8.5) -- Cinder Breath
		self:Bar(228837, 15.5) -- Bellowing Roar
		self:Bar(228829, 19.5) -- Burning Bones
		self:Bar(228790, 20) -- Concentrated Power
		self:Bar(228796, 20.5) -- Ignite Soul
		self:Bar(228808, 22) -- Charred Earth
		self:Bar(229307, 25.5) -- Reverberating Shadows
		self:Bar(228792, 40) -- Infernal Power
	end
end

function mod:BonecurseDeath()
	self:MessageOld("stages", "cyan", "long", CL.stage:format(3), false)
	self:StopBar(CL.count:format(self:SpellName(228834), shardCount)) -- Jagged Shards
	self:StopBar(228835) -- Absorb Vitality
end

function mod:Stage2(args)
	self:MessageOld("stages", "cyan", "long", CL.stage:format(2), false)
	self:StopBar(228785) -- Cinder Breath
	self:StopBar(228808) -- Charred Earth
	self:StopBar(228829) -- Burning Bones
	self:StopBar(229307) -- Reverberating Shadows
	self:StopBar(228792) -- Infernal Power
	self:StopBar(CL.onboss:format(self:SpellName(228792))) -- Infernal Power
	self:StopBar(228796) -- Ignite Soul
	self:StopBar(228790) -- Concentrated Power
	self:StopBar(CL.onboss:format(self:SpellName(228790))) -- Concentrated Power

	self:Bar("stages", 3, CL.add, args.spellId)
	self:Bar(228834, 12, CL.count:format(self:SpellName(228834), shardCount)) -- Jagged Shards
end

function mod:CinderBreath(args)
	self:MessageOld(args.spellId, "red", self:Tank() and "alert")
	self:CDBar(args.spellId, 22.5)
end

function mod:ReverberatingShadows(args)
	self:MessageOld(args.spellId, "yellow", self:Interrupter() and "alarm", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 11)
end

function mod:BurningBones(args)
	self:TargetMessageOld(args.spellId, args.destName, "orange", "info")
	self:CDBar(args.spellId, 18)
end

function mod:InfernalPower(args)
	self:MessageOld(args.spellId, "red", "info")
	self:Bar(args.spellId, 10, CL.onboss:format(args.spellName))
end

function mod:InfernalPowerRemoved(args)
	self:MessageOld(args.spellId, "green", nil, CL.over:format(args.spellName))
	self:Bar(args.spellId, 30)
end

function mod:IgniteSoul(args)
	self:TargetMessageOld(args.spellId, args.destName, "red", "warning")
	self:TargetBar(args.spellId, 9, args.destName)
	if self:Me(args.destGUID) then
		igniteSoulOnMe = true
		self:Say(args.spellId, nil, nil, "Ignite Soul")
		self:Flash(args.spellId)
		self:SayCountdown(args.spellId, 9)
	end
	self:Bar(args.spellId, 25.5)
end

function mod:IgniteSoulRemoved(args)
	if self:Me(args.destGUID) then
		igniteSoulOnMe = nil
		self:CancelSayCountdown(args.spellId)
	end
	self:StopBar(args.spellName, args.destName)
end

function mod:ConcentratedPower(args)
	self:MessageOld(args.spellId, "red", "info")
	self:Bar(args.spellId, 10, CL.onboss:format(args.spellName))
end

function mod:ConcentratedPowerRemoved(args)
	self:MessageOld(args.spellId, "green", nil, CL.over:format(args.spellName))
	self:Bar(args.spellId, 30)
end

function mod:JaggedShards(args)
	self:MessageOld(args.spellId, "red", nil, CL.count:format(args.spellName, shardCount))
	shardCount = shardCount + 1
	self:CDBar(args.spellId, 8, CL.count:format(args.spellName, shardCount))
end

function mod:AbsorbVitality(args)
	self:TargetMessageOld(args.spellId, args.destName, "orange", "alarm", nil, nil, self:Healer())
	self:TargetBar(args.spellId, 18, args.destName)
	self:Bar(args.spellId, 20)
end

function mod:AbsorbVitalityRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:BellowingRoar(args)
	self:MessageOld(args.spellId, "yellow", "warning")
	self:Bar(args.spellId, 3, CL.cast:format(args.spellName))
	self:CDBar(args.spellId, 45)
end

do
	local prev = 0
	function mod:CharredEarthDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 2 then
				prev = t
				self:MessageOld(args.spellId, "blue", not igniteSoulOnMe and "alarm", CL.underyou:format(args.spellName))
			end
		end
	end
end
