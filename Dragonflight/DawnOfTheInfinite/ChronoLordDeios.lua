--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Infinite Dragonflight", 2579, 2538)
if not mod then return end
mod:RegisterEnableMob(199000) -- Chrono-Lord Deios
mod:SetEncounterID(2673)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local summonInfiniteKeeperCount = 1
local infinityOrbCount = 1
local temporalBreathCount = 1
local infiniteCorruptionCount = 1
local infiniteKeeperDeaths = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- General
		"stages",
		-- Stage 1: We Are Infinite
		416152, -- Summon Infinite Keeper
		{412027, "DISPEL"}, -- Chronal Burn
		410904, -- Infinity Orb
		{410908, "OFF"}, -- Infinity Nova
		416139, -- Temporal Breath
		-- Stage 2: Lord of the Infinite
		416264, -- Infinite Corruption
		417413, -- Temporal Scar
	}, {
		["stages"] = CL.general,
		[416152] = -26751, -- Stage 1: We Are Infinite
		[416264] = -26757, -- Stage 2: Lord of the Infinite
	}
end

function mod:OnBossEnable()
	-- Stage 1: We Are Infinite
	self:Log("SPELL_CAST_START", "SummonInfiniteKeeper", 416152)
	self:Death("InfiniteKeeperDeath", 205212)
	self:Log("SPELL_AURA_APPLIED", "ChronalBurnApplied", 412027)
	self:Log("SPELL_CAST_START", "InfinityOrb", 410904)
	self:Log("SPELL_AURA_APPLIED", "InfinityNovaApplied", 410908)
	self:Log("SPELL_AURA_APPLIED_DOSE", "InfinityNovaApplied", 410908)
	self:Log("SPELL_CAST_START", "TemporalBreath", 416139)

	-- Stage 2: Lord of the Infinite
	self:Log("SPELL_CAST_START", "InfiniteCorruption", 416264)
	self:Log("SPELL_PERIODIC_DAMAGE", "TemporalScarDamage", 417413) -- don't alert on APPLIED
end

function mod:OnEngage()
	summonInfiniteKeeperCount = 1
	infinityOrbCount = 1
	temporalBreathCount = 1
	infiniteCorruptionCount = 1
	infiniteKeeperDeaths = 0
	self:SetStage(1)
	self:CDBar(410904, 9.6) -- Infinity Orb
	self:CDBar(416152, 15.7) -- Summon Infinite Keeper
	self:CDBar(416139, 19.4) -- Temporal Breath
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Stage 1: We Are Infinite

function mod:SummonInfiniteKeeper(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "info")
	summonInfiniteKeeperCount = summonInfiniteKeeperCount + 1
	if summonInfiniteKeeperCount <= 3 then
		-- only 4 adds will spawn, 3rd cast is a double spawn, so this is only cast 3 times
		self:CDBar(args.spellId, 24.3)
	else
		self:StopBar(args.spellId)
	end
end

function mod:InfiniteKeeperDeath(args)
	infiniteKeeperDeaths = infiniteKeeperDeaths + 1
	if infiniteKeeperDeaths == 4 then
		self:SetStage(2)
		self:Message("stages", "cyan", -26757, false) -- Stage 2: Lord of the Infinite
		self:PlaySound("stages", "info")
		self:CDBar(416264, 5.1) -- Infinite Corruption
		self:CDBar(416139, 16.9) -- Temporal Breath
	end
end

function mod:ChronalBurnApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("magic", nil, args.spellId) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
		-- each Infinite Keeper casts this on a 13.3s CD
	end
end

function mod:InfinityOrb(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	infinityOrbCount = infinityOrbCount + 1
	if self:GetStage() == 1 then
		-- pull:9.6, 17.0, 17.4, 17.4, 17.4, 24.0, 12.0, 12.0, 12.0...
		if infinityOrbCount == 2 then -- 2
			self:CDBar(args.spellId, 17.0)
		elseif infinityOrbCount < 6 then -- 3, 4, 5
			self:CDBar(args.spellId, 17.4)
		elseif infinityOrbCount == 6 then -- 6
			self:CDBar(args.spellId, 24.0)
		else -- 7, 8, 9...
			self:CDBar(args.spellId, 12.0)
		end
	else -- Stage 2
		self:CDBar(args.spellId, 24.6)
	end
end

function mod:InfinityNovaApplied(args)
	if self:Me(args.destGUID) then
		self:Bar(args.spellId, 4, CL.on_group:format(args.spellName))
	end
end

function mod:TemporalBreath(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	temporalBreathCount = temporalBreathCount + 1
	if self:GetStage() == 1 then
		-- just 4 breaths in stage 1
		if temporalBreathCount <= 4 then
			-- pull:19.4, 17.4, 17.4, 17.4
			self:CDBar(args.spellId, 17.4)
		else
			self:StopBar(args.spellId)
		end
	else -- Stage 2
		self:CDBar(args.spellId, 24.6)
	end
end

-- Stage 2: Lord of the Infinite

function mod:InfiniteCorruption(args)
	if self:GetStage() == 1 then
		-- rarely a UNIT_DIED will not be logged for Infinite Keeper, so the stage will never
		-- be incremented. this check ensures that the stage 2 timers will be used for other
		-- abilities if Infinite Corruption (the first stage 2 ability) is ever cast while
		-- the module is still in stage 1. this can also happen if you push the boss without
		-- giving him time to summon all 4 Infinite Keepers. the actual stage 2 trigger is
		-- probably just boss health.
		self:StopBar(416152) -- Summon Infinite Keeper
		self:SetStage(2)
		self:CDBar(416139, 11.8) -- Temporal Breath
	end
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
	infiniteCorruptionCount = infiniteCorruptionCount + 1
	self:CDBar(args.spellId, 24.6)
	if infiniteCorruptionCount == 2 then
		-- the first Infinite Corruption resets the CD of Infinity Orb
		self:CDBar(410904, 19.2) -- Infinity Orb
	end
end

do
	local prev = 0
	function mod:TemporalScarDamage(args)
		local t = args.time
		if self:Me(args.destGUID) and t - prev > 2.25 then
			prev = t
			self:PersonalMessage(args.spellId, "underyou")
			self:PlaySound(args.spellId, "underyou", nil, args.destName)
		end
	end
end
