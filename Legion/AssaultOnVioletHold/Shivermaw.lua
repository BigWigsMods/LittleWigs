--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Shivermaw", 1544, 1694)
if not mod then return end
mod:RegisterEnableMob(101951)
mod:SetEncounterID(1845)

--------------------------------------------------------------------------------
-- Locals
--

local frostBreathCount = 1
local stormCount = 1
local buffetCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		201379, -- Frost Breath
		201672, -- Relentless Storm
		201354, -- Tail Sweep
		201355, -- Wing Buffet
		202062, -- Frigid Winds
		201960, -- Ice Bomb
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Log("SPELL_CAST_SUCCESS", "FrostBreath", 201379)
	self:Log("SPELL_CAST_START", "RelentlessStorm", 201672)
	self:Log("SPELL_CAST_SUCCESS", "TailSweep", 201354)
	self:Log("SPELL_CAST_START", "FrigidWindsCast", 202062)
	self:Log("SPELL_AURA_APPLIED", "FrigidWindsApplied", 202062)
	self:Log("SPELL_AURA_REMOVED", "FrigidWindsRemoved", 202062)
	self:Log("SPELL_CAST_START", "IceBomb", 201960)
end

function mod:OnEngage()
	frostBreathCount = 1
	stormCount = 1
	buffetCount = 1

	self:Bar(201379, 5) -- Frost Breath
	self:Bar(201672, 9) -- Relentless Storm
	self:Bar(201354, 17) -- Tail Sweep
	self:Bar(201355, 20.5) -- Wing Buffet
	self:CDBar(201960, 47) -- Ice Bomb
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 201355 then -- Wing Buffet
		self:MessageOld(spellId, "orange", "alert")
		buffetCount = buffetCount + 1
		self:Bar(spellId, buffetCount % 2 == 0 and 18 or 43)
	end
end

function mod:FrostBreath(args)
	self:MessageOld(args.spellId, "yellow", self:Tank() and "warning")
	frostBreathCount = frostBreathCount + 1
	self:Bar(args.spellId, frostBreathCount % 2 == 0 and 26 or 35)
end

function mod:RelentlessStorm(args)
	self:MessageOld(args.spellId, "red", "long")
	stormCount = stormCount + 1
	self:Bar(args.spellId, stormCount % 2 == 0 and 14 or 47)
end

function mod:TailSweep(args)
	self:MessageOld(args.spellId, "orange", "alarm")
	self:Bar(args.spellId, 61)
end

function mod:FrigidWindsCast(args)
	self:MessageOld(args.spellId, "red", "warning")
	self:Bar(args.spellId, 61)
end

function mod:FrigidWindsApplied(args)
	if self:Me(args.destGUID) then
		self:TargetBar(args.spellId, 18, args.destName)
	end
end

function mod:FrigidWindsRemoved(args)
	if self:Me(args.destGUID) then
		self:StopBar(args.spellId, args.destName)
	end
end

function mod:IceBomb(args)
	self:MessageOld(args.spellId, "cyan", "info")
	self:Bar(args.spellId, 59)
end
