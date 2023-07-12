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
local temporalBreathCount = 1
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
		416139, -- Temporal Breath
		-- Stage 2: Lord of the Infinite
		416264, -- Infinite Corruption
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
	-- TODO Infinity Nova duration?
	self:Log("SPELL_CAST_START", "TemporalBreath", 416139)

	-- Stage 2: Lord of the Infinite
	self:Log("SPELL_CAST_START", "InfiniteCorruption", 416264)
end

function mod:OnEngage()
	summonInfiniteKeeperCount = 1
	temporalBreathCount = 1
	infiniteKeeperDeaths = 0
	self:SetStage(1)
	self:CDBar(410904, 10.7) -- Infinity Orb
	self:CDBar(416152, 16.8) -- Summon Infinite Keeper
	self:CDBar(416139, 20.4) -- Temporal Breath
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
		-- TODO low sample size on these timers
		self:CDBar(416264, 5.1) -- Infinite Corruption
		self:CDBar(416139, 16.9) -- Temporal Breath
		self:CDBar(410904, 24.2) -- Infinity Orb
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
	if self:GetStage() == 1 then
		-- pull:10.7, 17.0, 17.4, 17.4, 17.0, 24.0, 12.0
		-- TODO what's with the 24 and 12? is the CD affected by the last set
		-- of adds spawning?
		self:CDBar(args.spellId, 17.0)
	else -- Stage 2
		-- 27.2, 19.9, 17.0, 13.3, 19.9, 17.0, 13.4, 19.8
		-- TODO is the pattern reliable?
		self:CDBar(args.spellId, 13.3)
	end
end

function mod:TemporalBreath(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	temporalBreathCount = temporalBreathCount + 1
	if self:GetStage() == 1 then
		-- just 4 breaths in stage 1
		if temporalBreathCount <= 4 then
			-- pull:20.4, 17.4, 17.4, 17.0
			self:CDBar(args.spellId, 17.0)
		else
			self:StopBar(args.spellId)
		end
	else -- Stage 2
		-- 63.2, 19.9, 13.3, 17.0, 19.8, 13.4, 17.0, 19.9, 13.3
		if temporalBreathCount % 3 == 0 then -- 6, 9, 12...
			self:CDBar(args.spellId, 19.8)
		elseif temporalBreathCount % 3 == 1 then -- 7, 10, 13...
			self:CDBar(args.spellId, 13.3)
		else -- 8, 11, 14...
			self:CDBar(args.spellId, 17.0)
		end
	end
end

-- Stage 2: Lord of the Infinite

function mod:InfiniteCorruption(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 24.3)
end
