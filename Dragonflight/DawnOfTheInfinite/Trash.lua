--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Dawn of the Infinite Trash", 2579)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	------ Galakrond's Fall ------
	205384, -- Infinite Chronoweaver
	205408, -- Infinite Timeslicer
	205435, -- Epoch Ripper
	206140, -- Coalesced Time
	206065, -- Interval
	206066, -- Timestream Leech
	199749, -- Timestream Anomaly
	206214, -- Infinite Infiltrator
	205804, -- Risen Dragon

	------ Murozond's Rise ------
	201223, -- Infinite Twilight Magus
	205158, -- Spurlok, Timesworn Sentinel
	205152, -- Lerai, Timesworn Maiden
	201222, -- Valow, Timesworn Keeper
	199748, -- Timeline Marauder
	208061, -- Temporal Rift
	208438, -- Infinite Saboteur
	206230, -- Infinite Diversionist
	208698, -- Infinite Riftmage
	205363, -- Time-Lost Waveshaper
	205723, -- Time-Lost Aerobot
	206070, -- Chronaxie
	203861, -- Horde Destroyer
	208208, -- Alliance Destroyer
	204206, -- Horde Farseer
	208193, -- Paladin of the Silver Hand
	207969, -- Horde Raider
	208165, -- Alliance Knight
	205337  -- Infinite Timebender
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	------ Galakrond's Fall ------
	L.infinite_chronoweaver = "Infinite Chronoweaver"
	L.infinite_timeslicer = "Infinite Timeslicer"
	L.epoch_ripper = "Epoch Ripper"
	L.coalesced_time = "Coalesced Time"
	L.interval = "Interval"
	L.timestream_leech = "Timestream Leech"
	L.timestream_anomaly = "Timestream Anomaly"
	L.infinite_infiltrator = "Infinite Infiltrator"
	L.risen_dragon = "Risen Dragon"

	L.iridikron_warmup_trigger = "So the titans' puppets have come to face me."

	------ Murozond's Rise ------
	L.infinite_twilight_magus = "Infinite Twilight Magus"
	L.spurlok = "Spurlok, Timesworn Sentinel"
	L.lerai = "Lerai, Timesworn Maiden"
	L.valow = "Valow, Timesworn Keeper"
	L.timeline_marauder = "Timeline Marauder"
	L.infinite_saboteur = "Infinite Saboteur"
	L.infinite_riftmage = "Infinite Riftmage"
	L.timelost_waveshaper = "Time-Lost Waveshaper"
	L.timelost_aerobot = "Time-Lost Aerobot"
	L.chronaxie = "Chronaxie"
	L.horde_destroyer = "Horde Destroyer"
	L.alliance_destroyer = "Alliance Destroyer"
	L.horde_farseer = "Horde Farseer"
	L.paladin_of_the_silver_hand = "Paladin of the Silver Hand"
	L.horde_raider_alliance_knight = "Horde Raider / Alliance Knight"
	L.infinite_timebender = "Infinite Timebender"

	L.custom_on_rift_autotalk = "Autotalk"
	L.custom_on_rift_autotalk_desc = "Instantly start channeling to open the Temporal Rift."
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- General
		"custom_on_rift_autotalk",

		------ Galakrond's Fall ------
		-- Infinite Chronoweaver
		411994, -- Chronomelt
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
		{413544, "DISPEL"}, -- Bloom
		-- Infinite Infiltrator
		413621, -- Timeless Curse
		413622, -- Infinite Fury
		-- Risen Dragon
		412806, -- Blight Spew

		------ Murozond's Rise ------
		-- Infinite Twilight Magus
		413607, -- Corroding Volley
		-- Spurlok, Timesworn Sentinel
		412215, -- Shrouding Sandstorm
		412922, -- Binding Grasp
		-- Lerai, Timesworn Maiden
		412129, -- Orb of Contemplation
		-- Valow, Timesworn Keeper
		412136, -- Multiversal Fist
		413024, -- Titanic Bulwark
		-- Timeline Marauder
		417481, -- Displace Chronosequence
		-- Infinite Saboteur
		419351, -- Bronze Exhalation
		-- Infinite Riftmage
		418200, -- Infinite Burn
		-- Time-Lost Waveshaper
		411300, -- Fish Bolt Volley
		-- Time-Lost Aerobot
		412156, -- Bombing Run
		412200, -- Electro-Juiced Gigablast
		-- Chronaxie
		419516, -- Chronal Eruption
		419511, -- Temporal Link
		-- Horde Destroyer
		407535, -- Deploy Goblin Sappers
		407205, -- Volatile Mortar
		-- Alliance Destroyer
		418684, -- Deploy Dwarven Bombers
		-- Horde Farseer
		407891, -- Healing Wave
		407906, -- Earthquake
		-- Paladin of the Silver Hand
		417011, -- Holy Light
		417002, -- Consecration
		-- Horde Raider / Alliance Knight
		407124, -- Rallying Shout
		407125, -- Sundering Slam
		-- Infinite Timebender
		412378, -- Dizzying Sands
	}, {
		-- General
		["custom_on_rift_autotalk"] = CL.general,

		------ Galakrond's Fall ------
		[411994] = L.infinite_chronoweaver,
		[412012] = L.infinite_timeslicer,
		[412063] = L.epoch_ripper,
		[415769] = L.coalesced_time,
		[415773] = L.interval,
		[415437] = L.timestream_leech,
		[413529] = L.timestream_anomaly,
		[413621] = L.infinite_infiltrator,
		[412806] = L.risen_dragon,

		------ Murozond's Rise ------
		[413607] = L.infinite_twilight_magus,
		[412215] = L.spurlok,
		[412129] = L.lerai,
		[412136] = L.valow,
		[417481] = L.timeline_marauder,
		[419351] = L.infinite_saboteur,
		[418200] = L.infinite_riftmage,
		[411300] = L.timelost_waveshaper,
		[412156] = L.timelost_aerobot,
		[419516] = L.chronaxie,
		[407535] = L.horde_destroyer,
		[418684] = L.alliance_destroyer,
		[407891] = L.horde_farseer,
		[417011] = L.paladin_of_the_silver_hand,
		[407124] = L.horde_raider_alliance_knight,
		[412378] = L.infinite_timebender,
	}
end

function mod:OnBossEnable()
	-- Warmups
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")

	-- Autotalk
	self:RegisterEvent("GOSSIP_SHOW")

	------ Galakrond's Fall ------

	-- Infinite Chronoweaver
	self:Log("SPELL_CAST_SUCCESS", "Chronomelt", 411994)

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

	-- Risen Dragon
	self:Log("SPELL_CAST_START", "BlightSpew", 412806)

	------ Murozond's Rise ------

	-- Infinite Twilight Magus
	self:Log("SPELL_CAST_START", "CorrodingVolley", 413607)

	-- Spurlok, Timesworn Sentinel
	self:Log("SPELL_CAST_START", "ShroudingSandstorm", 412215)
	self:Log("SPELL_CAST_START", "BindingGrasp", 412922)

	-- Lerai, Timesworn Maiden
	self:Log("SPELL_CAST_START", "OrbOfContemplation", 412129)

	-- Valow, Timesworn Keeper
	self:Log("SPELL_CAST_START", "MultiversalFist", 412136)
	self:Log("SPELL_CAST_START", "TitanicBulwark", 413024)

	-- Tyr
	self:Log("SPELL_AURA_REMOVED", "PonderingTheOathstoneRemoved", 413595)

	-- Timeline Marauder
	self:Log("SPELL_CAST_START", "DisplaceChronosequence", 417481)

	-- Infinite Saboteur
	self:Log("SPELL_CAST_START", "BronzeExhalation", 419351)

	-- Infinite Riftmage
	self:Log("SPELL_CAST_START", "InfiniteBurn", 418200)

	-- Time-Lost Waveshaper
	self:Log("SPELL_CAST_START", "FishBoltVolley", 411300)

	-- Time-Lost Aerobot
	self:Log("SPELL_CAST_START", "BombingRun", 412156)
	self:Log("SPELL_CAST_START", "ElectroJuicedGigablast", 412200)

	-- Chronaxie
	self:Log("SPELL_CAST_START", "ChronalEruption", 419516)
	self:Log("SPELL_AURA_APPLIED", "ChronalEruptionApplied", 419517)
	self:Log("SPELL_CAST_START", "TemporalLink", 419511)

	-- Horde Destroyer
	self:Log("SPELL_CAST_START", "DeployGoblinSappers", 407535)
	self:Log("SPELL_CAST_START", "VolatileMortar", 407205)

	-- Alliance Destroyer
	self:Log("SPELL_CAST_START", "DeployDwarvenBombers", 418684)

	-- Horde Farseer
	self:Log("SPELL_CAST_START", "HealingWave", 407891)
	self:Log("SPELL_AURA_APPLIED", "EarthquakeDamage", 407906)
	self:Log("SPELL_PERIODIC_DAMAGE", "EarthquakeDamage", 407906)

	-- Paladin of the Silver Hand
	self:Log("SPELL_CAST_START", "HolyLight", 417011)
	self:Log("SPELL_AURA_APPLIED", "ConsecrationDamage", 417002)
	self:Log("SPELL_PERIODIC_DAMAGE", "ConsecrationDamage", 417002)

	-- Horde Raider / Alliance Knight
	self:Log("SPELL_CAST_START", "RallyingShout", 407124)
	self:Log("SPELL_CAST_START", "SunderingSlam", 407125)

	-- Infinite Timebender
	self:Log("SPELL_CAST_START", "DizzyingSands", 412378)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Warmups

function mod:CHAT_MSG_MONSTER_YELL(_, msg)
	if msg:find(L.iridikron_warmup_trigger, nil, true) then
		-- Iridikron warmup
		local iridikronModule = BigWigs:GetBossModule("Iridikron the Stonescaled", true)
		if iridikronModule then
			iridikronModule:Enable()
			iridikronModule:Warmup()
		end
	end
end

-- Autotalk

function mod:GOSSIP_SHOW(event)
	if self:GetOption("custom_on_rift_autotalk") then
		if self:GetGossipID(110513) then
			-- <Attempt to open the rift.>
			self:SelectGossipID(110513)
		end
	end
end

------ Galakrond's Fall ------

-- Infinite Chronoweaver

function mod:Chronomelt(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	--self:NameplateCDBar(args.spellId, 15.8, args.sourceGUID)
end

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
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	--self:NameplateCDBar(args.spellId, 15.8, args.sourceGUID)
end

do
	local playerList = {}
	local prev = 0
	function mod:BloomApplied(args)
		if self:Me(args.destGUID) or self:Dispeller("magic", nil, 413544) then
			local t = args.time
			if t - prev > .7 then -- throttle alerts to .7s intervals
				prev = t
				playerList = {}
			end
			playerList[#playerList + 1] = args.destName
			self:TargetsMessage(413544, "yellow", playerList, 2, nil, nil, .7)
			self:PlaySound(413544, "alert", nil, playerList)
		end
	end
end

-- Infinite Infiltrator

function mod:TimelessCurse(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	--self:NameplateCDBar(args.spellId, 20.6, args.sourceGUID)
end

function mod:InfiniteFury(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	--self:NameplateCDBar(args.spellId, 20.6, args.sourceGUID)
end

-- Risen Dragon

function mod:BlightSpew(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	--self:NameplateCDBar(args.spellId, 13.3, args.sourceGUID)
end

------ Murozond's Rise ------

-- Infinite Twilight Magus

function mod:CorrodingVolley(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	--self:NameplateCDBar(args.spellId, 7.3, args.sourceGUID)
end

-- Spurlok, Timesworn Sentinel

function mod:ShroudingSandstorm(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	--self:NameplateCDBar(args.spellId, 19.4, args.sourceGUID)
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(412922, "yellow", name)
		self:PlaySound(412922, "info", nil, name)
	end

	function mod:BindingGrasp(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
		--self:NameplateCDBar(args.spellId, 19.4, args.sourceGUID)
	end
end

-- Spurlok, Timesworn Sentinel

function mod:OrbOfContemplation(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	--self:NameplateCDBar(args.spellId, 13.4, args.sourceGUID)
end

-- Valow, Timesworn Keeper

function mod:MultiversalFist(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	--self:NameplateCDBar(args.spellId, 15.8, args.sourceGUID)
end

function mod:TitanicBulwark(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
	--self:NameplateCDBar(args.spellId, 26.7, args.sourceGUID)
end

-- Tyr

function mod:PonderingTheOathstoneRemoved(args)
	-- Tyr warmup
	local tyrModule = BigWigs:GetBossModule("Tyr, the Infinite Keeper", true)
	if tyrModule then
		tyrModule:Enable()
		tyrModule:Warmup()
	end
end

-- Timeline Marauder

function mod:DisplaceChronosequence(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	--self:NameplateCDBar(args.spellId, 15.8, args.sourceGUID)
end

-- Infinite Saboteur

function mod:BronzeExhalation(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	--self:NameplateCDBar(args.spellId, 18.2, args.sourceGUID)
end

-- Infinite Riftmage

function mod:InfiniteBurn(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	--self:NameplateCDBar(args.spellId, 9.7, args.sourceGUID)
end

-- Time-Lost Waveshaper

function mod:FishBoltVolley(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	--self:NameplateCDBar(args.spellId, 13.3, args.sourceGUID)
end

-- Time-Lost Aerobot

function mod:BombingRun(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	--self:NameplateCDBar(args.spellId, 23.0, args.sourceGUID)
end

function mod:ElectroJuicedGigablast(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	--self:NameplateCDBar(args.spellId, 25.5, args.sourceGUID)
end

-- Chronaxie

function mod:ChronalEruption(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	--self:NameplateCDBar(args.spellId, 9.7, args.sourceGUID)
end

function mod:ChronalEruptionApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("magic") then
		self:TargetMessage(419516, "yellow", args.destName)
		self:PlaySound(419516, "alert", nil, args.destName)
	end
end

function mod:TemporalLink(args)
	-- TODO interruptible? get target?
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
	-- TODO unknown CD
end

-- Horde Destroyer

function mod:DeployGoblinSappers(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
	--self:NameplateCDBar(args.spellId, 26.7, args.sourceGUID)
end

function mod:VolatileMortar(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	--self:NameplateCDBar(args.spellId, 17.0, args.sourceGUID)
end

-- Alliance Destroyer

function mod:DeployDwarvenBombers(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
	--self:NameplateCDBar(args.spellId, 26.7, args.sourceGUID)
end

-- Horde Farseer

function mod:HealingWave(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
	--self:NameplateCDBar(args.spellId, 9.7, args.sourceGUID)
end

do
	local prev = 0
	function mod:EarthquakeDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:PersonalMessage(args.spellId, "underyou")
				self:PlaySound(args.spellId, "underyou", nil, args.destName)
			end
		end
	end
end

-- Paladin of the Silver Hand

function mod:HolyLight(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
	--self:NameplateCDBar(args.spellId, 9.7, args.sourceGUID)
end

do
	local prev = 0
	function mod:ConsecrationDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:PersonalMessage(args.spellId, "underyou")
				self:PlaySound(args.spellId, "underyou", nil, args.destName)
			end
		end
	end
end

-- Horde Raider / Alliance Knight

do
	local prev = 0
	function mod:RallyingShout(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
		--self:NameplateCDBar(args.spellId, 10.9, args.sourceGUID)
	end
end

do
	local prev = 0
	function mod:SunderingSlam(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
		--self:NameplateCDBar(args.spellId, 14.5, args.sourceGUID)
	end
end

-- Infinite Timebender

function mod:DizzyingSands(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
	--self:NameplateCDBar(args.spellId, 29.1, args.sourceGUID)
end
