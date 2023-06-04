if select(4, GetBuildInfo()) < 100105 then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Dawn of the Infinite Trash", 2579)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	205408, -- Infinite Timeslicer
	205435, -- Epoch Ripper
	206140, -- Coalesced Time
	206065, -- Interval
	206066, -- Timestream Leech
	199749, -- Timestream Anomaly
	206214, -- Infinite Infiltrator
	205804  -- Risen Dragon
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.infinite_timeslicer = "Infinite Timeslicer"
	L.epoch_ripper = "Epoch Ripper"
	L.coalesced_time = "Coalesced Time"
	L.interval = "Interval"
	L.timestream_leech = "Timestream Leech"
	L.timestream_anomaly = "Timestream Anomaly"
	L.infinite_infiltrator = "Infinite Infiltrator"
	L.risen_dragon = "Risen Dragon"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Infinite Timeslicer
		{412012, "DISPEL"}, -- Temposlice
		-- Epoch Ripper
		412063, -- Timerip
		-- Coalesced Time
		{415769, "SAY"}, -- Chronoburst
		415770, -- Infinite Bolt Volley
		-- Interval
		415773, -- Temporal Detonation
		-- Timestream Leech
		415437, -- Enervate
		-- Timestream Anomaly
		413529, -- Untwist
		{413544, "TANK_HEALER", "DISPEL"}, -- Bloom
		-- Infinite Infiltrator
		413621, -- Timeless Curse
		413622, -- Infinite Fury
		-- Risen Dragon
		412806, -- Blight Spew
	}, {
		[412012] = L.infinite_timeslicer,
		[412063] = L.epoch_ripper,
		[415769] = L.coalesced_time,
		[415773] = L.interval,
		[415437] = L.timestream_leech,
		[413529] = L.timestream_anomaly,
		[413621] = L.infinite_infiltrator,
		[412806] = L.risen_dragon,
	}
end

function mod:OnBossEnable()
	-- TODO might as well add the one channel in the beginning

	-- Infinite Timeslicer
	self:Log("SPELL_AURA_APPLIED", "Temposlice", 412012)

	-- Epoch Ripper
	self:Log("SPELL_AURA_APPLIED", "Timerip", 412063)

	-- Coalesced Time
	self:Log("SPELL_AURA_APPLIED", "ChronoburstApplied", 415554)
	self:Log("SPELL_CAST_START", "InfiniteBoltVolley", 415770)

	-- Interval
	self:Log("SPELL_CAST_START", "TemporalDetonation", 415773)

	-- Timestream Leech
	self:Log("SPELL_CAST_START", "Enervate", 415437)

	-- Timestream Anomaly
	self:Log("SPELL_CAST_START", "Untwist", 413529)
	self:Log("SPELL_CAST_START", "Bloom", 413544)
	self:Log("SPELL_AURA_APPLIED", "BloomApplied", 413547)

	-- Infinite Infiltrator
	self:Log("SPELL_CAST_SUCCESS", "TimelessCurse", 413621)
	self:Log("SPELL_CAST_START", "InfiniteFury", 413622)
	self:Death("InfiniteInfiltratorDeath", 206214)

	-- Risen Dragon
	self:Log("SPELL_CAST_START", "BlightSpew", 412806)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Infinite Timeslicer

function mod:Temposlice(args)
	if not self:Player(args.destFlags) and (self:Tank() or self:Dispeller("magic", true, args.spellId)) then
		self:Message(args.spellId, "yellow", CL.on:format(args.spellName, args.destName))
		self:PlaySound(args.spellId, "alert")
		--self:NameplateCDBar(args.spellId, 31.5, args.sourceGUID)
	end
end

-- Epoch Ripper

function mod:Timerip(args)
	-- TODO get teleport target somehow? there is no SPELL_CAST_SUCCESS
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	--self:NameplateCDBar(args.spellId, 34.0, args.sourceGUID)
end

-- Coalesced Time

--function mod:Chronoburst(args)
	--self:NameplateCDBar(415769, 15.8, args.sourceGUID)
--end

do
	local playerList = {}
	local prev = 0
	function mod:ChronoburstApplied(args)
		local t = args.time
		if t - prev > .5 then -- throttle alerts to .5s intervals
			prev = t
			playerList = {}
		end
		playerList[#playerList + 1] = args.destName
		-- TODO confirm max 2 targets
		self:TargetsMessage(415769, "yellow", playerList, 2, nil, nil, .5)
		self:PlaySound(415769, "alert", nil, playerList)
		if self:Me(args.destGUID) then
			self:Say(415769)
		end
	end
end

function mod:InfiniteBoltVolley(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	--self:NameplateCDBar(args.spellId, 7.3, args.sourceGUID)
end

-- Interval

do
	local prev = 0
	function mod:TemporalDetonation(args)
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Timestream Leech

function mod:Enervate(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	--self:NameplateCDBar(args.spellId, 15.8, args.sourceGUID)
end

-- Timestream Anomaly

function mod:Untwist(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	--self:NameplateCDBar(args.spellId, 18.2, args.sourceGUID)
end

function mod:Bloom(args)
	if self:Tank() then
		self:Message(args.spellId, "purple")
		self:PlaySound(args.spellId, "alert")
	end
	--self:NameplateCDBar(args.spellId, 15.8, args.sourceGUID)
end

function mod:BloomApplied(args)
	if self:Dispeller("magic", nil, 413544) then
		self:TargetMessage(413544, "purple", args.destName)
		self:PlaySound(413544, "warning", nil, args.destName)
	end
end

-- Infinite Infiltrator

function mod:TimelessCurse(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 20.6)
end

function mod:InfiniteFury(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 20.6)
end

function mod:InfiniteInfiltratorDeath(args)
	self:StopBar(413621) -- Timeless Curse
	self:StopBar(413622) -- Infinite Fury
end

-- Risen Dragon

function mod:BlightSpew(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	--self:NameplateCDBar(args.spellId, 13.3, args.sourceGUID)
end
