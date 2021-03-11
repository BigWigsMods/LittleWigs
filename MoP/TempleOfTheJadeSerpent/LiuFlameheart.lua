
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Liu Flameheart", 960, 658)
if not mod then return end
mod:RegisterEnableMob(56732)
mod.engageId = 1416
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

local stage = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		106823, -- Serpent Strike
		106841, -- Jade Serpent Strike
		118540, -- Jade Serpent Wave
		107110, -- Jade Fire
	}, {
		["stages"] = "general",
		[106823] = CL.stage:format(1),
		[106841] = CL.stage:format(2),
		[107110] = CL.stage:format(3),
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1")
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")

	self:Log("SPELL_AURA_APPLIED", "SerpentStrike", 106823)
	self:Log("SPELL_AURA_APPLIED", "JadeSerpentStrike", 106841)
	self:Log("SPELL_AURA_REMOVED", "SerpentStrikeRemoved", 106823, 106841)

	self:Log("SPELL_AURA_APPLIED", "GroundEffectDamage", 118540) -- Jade Serpent Wave
	self:Log("SPELL_PERIODIC_DAMAGE", "GroundEffectDamage", 118540)
	self:Log("SPELL_PERIODIC_MISSED", "GroundEffectDamage", 118540)
	self:Log("SPELL_DAMAGE", "GroundEffectDamage", 107110) -- Jade Fire
	self:Log("SPELL_MISSED", "GroundEffectDamage", 107110)
end

function mod:OnEngage()
	stage = 1
	self:MessageOld("stages", "yellow", "info", CL.stage:format(1), false)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_HEALTH(event, unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < 35 then
		self:UnregisterUnitEvent(event, unit)
		self:MessageOld("stages", "green", "info", CL.soon:format(CL.stage:format(3)), false)
	elseif hp < 75 and stage == 1 then
		stage = 2
		self:MessageOld("stages", "green", "info", CL.soon:format(CL.stage:format(2)), false)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(event, unit, _, spellId)
	if spellId == 106895 then -- Summon Jade Serpent
		self:UnregisterUnitEvent(event, unit)
		self:MessageOld("stages", "yellow", "info", CL.stage:format(3), false)
	elseif spellId == 106797 then -- Jade Essence
		self:MessageOld("stages", "yellow", "info", CL.stage:format(2), false)
	end
end

function mod:SerpentStrike(args)
	if self:Me(args.destGUID) or self:Dispeller("magic") then
		self:TargetMessageOld(args.spellId, args.destName, "orange", "alarm", nil, nil, true)
		self:TargetBar(args.spellId, 8, args.destName)
	end
end

function mod:JadeSerpentStrike(args)
	if self:Me(args.destGUID) or self:Healer() then
		self:TargetMessageOld(args.spellId, args.destName, "orange", "alarm", nil, nil, true)
		self:TargetBar(args.spellId, 8, args.destName)
	end
end

function mod:SerpentStrikeRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

do
	local prev = 0
	function mod:GroundEffectDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t - prev > 1.5 then
				prev = t
				self:MessageOld(args.spellId, "blue", "alert", CL.underyou:format(args.spellName))
			end
		end
	end
end
