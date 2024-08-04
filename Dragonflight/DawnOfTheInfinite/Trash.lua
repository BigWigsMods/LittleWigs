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
	205691, -- Iridikron's Creation

	------ Murozond's Rise ------
	201223, -- Infinite Twilight Magus
	201222, -- Valow, Timesworn Keeper
	205158, -- Spurlok, Timesworn Sentinel
	205152, -- Lerai, Timesworn Maiden
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
	L.iridikrons_creation = "Iridikron's Creation"

	L.iridikron_warmup_trigger = "So the titans' puppets have come to face me."

	------ Murozond's Rise ------
	L.infinite_twilight_magus = "Infinite Twilight Magus"
	L.valow = "Valow, Timesworn Keeper"
	L.spurlok = "Spurlok, Timesworn Sentinel"
	L.lerai = "Lerai, Timesworn Maiden"
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
	L.custom_on_rift_autotalk_icon = "ui_chat"
	L.rift_opening = CL.casting:format(mod:SpellName(416882)) -- Open Rift
	L.rift_opened = "Temporal Rift Opened"
	L.rift_stability = "Rift Stability"
	L.rift_stability_desc = "Show an alert when the Temporal Rift has been opened."
	L.rift_stability_icon = 416882

	L.manifested_timeways_warmup_trigger = "Even the Aspect of Time cannot be allowed to disrupt the timeways!"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- General
		"custom_on_rift_autotalk",
		"rift_stability",

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
		{413621, "DISPEL"}, -- Timeless Curse
		413622, -- Infinite Fury
		-- Risen Dragon
		412806, -- Blight Spew
		-- Iridikron's Creation
		411958, -- Stonebolt

		------ Murozond's Rise ------
		-- Infinite Twilight Magus
		413607, -- Corroding Volley
		-- Valow, Timesworn Keeper
		412136, -- Temporal Strike
		413024, -- Titanic Bulwark
		-- Spurlok, Timesworn Sentinel
		412215, -- Shrouding Sandstorm
		412922, -- Binding Grasp
		-- Lerai, Timesworn Maiden
		412129, -- Orb of Contemplation
		-- Timeline Marauder
		417481, -- Displace Chronosequence
		-- Infinite Saboteur
		419351, -- Bronze Exhalation
		-- Infinite Riftmage
		{418200, "DISPEL"}, -- Infinite Burn
		-- Time-Lost Waveshaper
		411300, -- Fish Bolt Volley
		411407, -- Bubbly Barrage
		-- Time-Lost Aerobot
		412156, -- Bombing Run
		412200, -- Electro-Juiced Gigablast
		-- Chronaxie
		419516, -- Chronal Eruption
		419511, -- Temporal Link
		-- Horde Destroyer
		{407205, "SAY"}, -- Volatile Mortar
		407535, -- Deploy Goblin Sappers
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
		411952, -- Millenium Aid
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
		[411958] = L.iridikrons_creation,

		------ Murozond's Rise ------
		[413607] = L.infinite_twilight_magus,
		[412136] = L.valow,
		[412215] = L.spurlok,
		[412129] = L.lerai,
		[417481] = L.timeline_marauder,
		[419351] = L.infinite_saboteur,
		[418200] = L.infinite_riftmage,
		[411300] = L.timelost_waveshaper,
		[412156] = L.timelost_aerobot,
		[419516] = L.chronaxie,
		[407205] = L.horde_destroyer,
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
	self:Log("SPELL_CAST_SUCCESS", "BattleSenses", 419609)
	self:Log("SPELL_CAST_SUCCESS", "ThirstForBlood", 419602)

	-- Autotalk
	self:RegisterEvent("GOSSIP_SHOW")

	-- Rift Stability
	self:RegisterWidgetEvent(5021, "RiftStability", true)

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
	self:Log("SPELL_AURA_APPLIED", "TimelessCurseApplied", 413618)
	self:Log("SPELL_CAST_START", "InfiniteFury", 413622)

	-- Risen Dragon
	self:Log("SPELL_CAST_START", "BlightSpew", 412806)

	-- Iridikron's Creation
	self:Log("SPELL_CAST_START", "Stonebolt", 411958)

	------ Murozond's Rise ------

	-- Infinite Twilight Magus
	self:Log("SPELL_CAST_START", "CorrodingVolley", 413607)

	-- Valow, Timesworn Keeper
	self:Log("SPELL_CAST_START", "TemporalStrike", 412136)
	self:Log("SPELL_CAST_START", "TitanicBulwark", 413024)
	self:Death("ValowDeath", 201222)

	-- Spurlok, Timesworn Sentinel
	self:Log("SPELL_CAST_START", "ShroudingSandstorm", 412215)
	self:Log("SPELL_CAST_START", "BindingGrasp", 412922)
	self:Log("SPELL_AURA_APPLIED", "BindingGraspApplied", 412922)
	self:Death("SpurlokDeath", 205158)

	-- Lerai, Timesworn Maiden
	self:Log("SPELL_CAST_START", "OrbOfContemplation", 412129)
	self:Death("LeraiDeath", 205152)

	-- Tyr
	self:Log("SPELL_AURA_REMOVED", "PonderingTheOathstoneRemoved", 413595)

	-- Timeline Marauder
	self:Log("SPELL_CAST_START", "DisplaceChronosequence", 417481)

	-- Infinite Saboteur
	self:Log("SPELL_CAST_START", "BronzeExhalation", 419351)

	-- Infinite Riftmage
	self:Log("SPELL_CAST_START", "InfiniteBurn", 418200)
	self:Log("SPELL_AURA_APPLIED", "InfiniteBurnApplied", 418200)

	-- Time-Lost Waveshaper
	self:Log("SPELL_CAST_START", "FishBoltVolley", 411300)
	self:Log("SPELL_CAST_START", "BubblyBarrage", 411407)

	-- Time-Lost Aerobot
	self:Log("SPELL_CAST_START", "BombingRun", 412156)
	self:Log("SPELL_CAST_START", "ElectroJuicedGigablast", 412200)

	-- Chronaxie
	self:Log("SPELL_CAST_START", "ChronalEruption", 419516)
	self:Log("SPELL_AURA_APPLIED", "ChronalEruptionApplied", 419517)
	self:Log("SPELL_CAST_START", "TemporalLink", 419511)

	-- Horde Destroyer / Alliance Destroyer
	self:Log("SPELL_CAST_SUCCESS", "VolatileMortar", 407205)
	self:Log("SPELL_AURA_APPLIED", "VolatileMortarApplied", 407205)
	self:Log("SPELL_CAST_START", "DeployGoblinSappers", 407535)
	self:Log("SPELL_CAST_START", "DeployDwarvenBombers", 418684)
	self:Death("HordeDestroyerDeath", 203861)
	self:Death("AllianceDestroyerDeath", 208208)

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
	self:Log("SPELL_CAST_START", "MillenniumAid", 411952)
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
	elseif msg == L.manifested_timeways_warmup_trigger then
		-- Manifested Timeways warmup
		local manifestedTimewaysModule = BigWigs:GetBossModule("Manifested Timeways", true)
		if manifestedTimewaysModule then
			manifestedTimewaysModule:Enable()
			manifestedTimewaysModule:Warmup()
		end
	end
end

function mod:BattleSenses(args)
	-- Time-Lost Battlefield (Anduin Lothar version) warmup
	local timelostBattlefieldModule = BigWigs:GetBossModule("Time-Lost Battlefield", true)
	if timelostBattlefieldModule then
		timelostBattlefieldModule:Enable()
		timelostBattlefieldModule:WarmupAnduinLothar()
	end
end

function mod:ThirstForBlood(args)
	-- Time-Lost Battlefield (Grommash Hellscream version) warmup
	local timelostBattlefieldModule = BigWigs:GetBossModule("Time-Lost Battlefield", true)
	if timelostBattlefieldModule then
		timelostBattlefieldModule:Enable()
		timelostBattlefieldModule:WarmupGrommashHellscream()
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

-- Rift Stability

do
	local prev = 0
	function mod:RiftStability(_, _, info)
		-- [UPDATE_UI_WIDGET] widgetID:5021, widgetType:2, barValue:100
		local barValue = info.barValue
		-- shownState will only be 1 if you are at the Rift, so don't check it here - we
		-- want to alert even if the player is not at the Rift.
		if barValue == 3 and prev ~= 3 then
			-- first tick of progress will always be 3. throttle because it could become
			-- visible or hide at 3 if the player moves into or out of range.
			prev = barValue
			self:Message("rift_stability", "green", L.rift_opening, L.rift_stability_icon)
			self:PlaySound("rift_stability", "info")
		elseif barValue == 100 and prev ~= 100 then
			-- throttle because the bar will hide at 100 for any player already through.
			prev = barValue
			self:Message("rift_stability", "green", L.rift_opened, L.rift_stability_icon)
			self:PlaySound("rift_stability", "info")
		else
			prev = barValue
		end
	end
end

------ Galakrond's Fall ------

-- Infinite Chronoweaver

function mod:Chronomelt(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	--self:Nameplate(args.spellId, 15.8, args.sourceGUID)
end

-- Infinite Timeslicer

function mod:Temposlice(args)
	if not self:Player(args.destFlags) and (self:Tank() or self:Dispeller("magic", true, args.spellId)) then
		self:Message(args.spellId, "yellow", CL.on:format(args.spellName, args.destName))
		self:PlaySound(args.spellId, "alert")
		--self:Nameplate(args.spellId, 31.5, args.sourceGUID)
	end
end

-- Epoch Ripper

function mod:Timerip(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	--self:Nameplate(args.spellId, 34.0, args.sourceGUID)
end

-- Coalesced Time

--function mod:Chronoburst(args)
	--self:Nameplate(415769, 15.8, args.sourceGUID)
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
		self:TargetsMessage(415769, "yellow", playerList, 2, nil, nil, .5)
		self:PlaySound(415769, "alert", nil, playerList)
		if self:Me(args.destGUID) then
			self:Say(415769, nil, nil, "Chronoburst")
		end
	end
end

function mod:InfiniteBoltVolley(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	--self:Nameplate(args.spellId, 7.3, args.sourceGUID)
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
	--self:Nameplate(args.spellId, 15.8, args.sourceGUID)
end

-- Timestream Anomaly

function mod:Untwist(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	--self:Nameplate(args.spellId, 18.2, args.sourceGUID)
end

function mod:Bloom(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	--self:Nameplate(args.spellId, 15.8, args.sourceGUID)
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

do
	local playerList = {}

	function mod:TimelessCurse(args)
		playerList = {}
		self:Message(args.spellId, "orange")
		self:PlaySound(args.spellId, "alarm")
		--self:Nameplate(args.spellId, 20.6, args.sourceGUID)
	end

	function mod:TimelessCurseApplied(args)
		if self:Dispeller("curse", nil, 413621) then
			playerList[#playerList + 1] = args.destName
			self:PlaySound(413621, "info", nil, playerList)
			self:TargetsMessage(413621, "red", playerList, 5)
		end
	end
end

function mod:InfiniteFury(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	--self:Nameplate(args.spellId, 20.6, args.sourceGUID)
end

-- Risen Dragon

function mod:BlightSpew(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	--self:Nameplate(args.spellId, 13.3, args.sourceGUID)
end

-- Iridikron's Creation

do
	local prev = 0
	function mod:Stonebolt(args)
		-- these can be mind controlled but Stonebolt can only be cast on players,
		-- so don't filter the alert
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

------ Murozond's Rise ------

-- Infinite Twilight Magus

function mod:CorrodingVolley(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	--self:Nameplate(args.spellId, 7.3, args.sourceGUID)
end

-- Valow, Timesworn Keeper

do
	-- timer used to clean up bars in case of a wipe
	local timer

	function mod:TemporalStrike(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		self:PlaySound(args.spellId, "alarm")
		self:CDBar(args.spellId, 12.1)
		timer = self:ScheduleTimer("ValowDeath", 30)
	end

	function mod:TitanicBulwark(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "info")
		self:CDBar(args.spellId, 26.7)
		timer = self:ScheduleTimer("ValowDeath", 30)
	end

	function mod:ValowDeath()
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(412136) -- Temporal Strike
		self:StopBar(413024) -- Titanic Bulwark
	end
end

-- Spurlok, Timesworn Sentinel

do
	-- timer used to clean up bars in case of a wipe
	local timer

	function mod:ShroudingSandstorm(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		self:PlaySound(args.spellId, "alarm")
		self:CDBar(args.spellId, 19.4)
		timer = self:ScheduleTimer("SpurlokDeath", 30)
	end

	function mod:BindingGrasp(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "info")
		self:CDBar(args.spellId, 19.4)
		timer = self:ScheduleTimer("SpurlokDeath", 30)
	end

	function mod:BindingGraspApplied(args)
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
	end

	function mod:SpurlokDeath()
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(412215) -- Shrouding Sandstorm
		self:StopBar(412922) -- Binding Grasp
	end
end

-- Lerai, Timesworn Maiden

do
	-- timer used to clean up bars in case of a wipe
	local timer

	function mod:OrbOfContemplation(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		self:PlaySound(args.spellId, "alarm")
		self:CDBar(args.spellId, 13.4)
		timer = self:ScheduleTimer("LeraiDeath", 30)
	end

	function mod:LeraiDeath()
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(412129) -- Orb of Contemplation
	end
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
	--self:Nameplate(args.spellId, 15.8, args.sourceGUID)
end

-- Infinite Saboteur

function mod:BronzeExhalation(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	--self:Nameplate(args.spellId, 18.2, args.sourceGUID)
end

-- Infinite Riftmage

function mod:InfiniteBurn(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	--self:Nameplate(args.spellId, 9.7, args.sourceGUID)
end

do
	local prev = 0
	function mod:InfiniteBurnApplied(args)
		local t = args.time
		if t - prev > 2 and (self:Dispeller("magic", nil, args.spellId) or self:Dispeller("movement", nil, args.spellId)) then
			prev = t
			self:TargetMessage(args.spellId, "yellow", args.destName)
			self:PlaySound(args.spellId, "alert", nil, args.destName)
		end
	end
end

-- Time-Lost Waveshaper

function mod:FishBoltVolley(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	--self:Nameplate(args.spellId, 13.3, args.sourceGUID)
end

function mod:BubblyBarrage(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
	--self:Nameplate(args.spellId, 20.6, args.sourceGUID)
end

-- Time-Lost Aerobot

function mod:BombingRun(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	--self:Nameplate(args.spellId, 23.0, args.sourceGUID)
end

function mod:ElectroJuicedGigablast(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	--self:Nameplate(args.spellId, 25.5, args.sourceGUID)
end

-- Chronaxie

function mod:ChronalEruption(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	--self:Nameplate(args.spellId, 9.7, args.sourceGUID)
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

-- Horde Destroyer / Alliance Destroyer

do
	-- timer used to clean up bars in case of a wipe
	local timer

	function mod:VolatileMortar(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:CDBar(args.spellId, 19.4)
		if self:MobId(args.sourceGUID) == 203861 then -- Horde Destroyer
			timer = self:ScheduleTimer("HordeDestroyerDeath", 30)
		else -- Alliance Destroyer
			timer = self:ScheduleTimer("AllianceDestroyerDeath", 30)
		end
	end

	function mod:VolatileMortarApplied(args)
		self:TargetMessage(args.spellId, "orange", args.destName)
		if self:Me(args.destGUID) then
			self:PlaySound(args.spellId, "warning", nil, args.destName)
			self:Say(args.spellId, nil, nil, "Volatile Mortar")
		else
			self:PlaySound(args.spellId, "alarm", nil, args.destName)
		end
	end

	function mod:DeployGoblinSappers(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "cyan")
		self:PlaySound(args.spellId, "info")
		self:CDBar(args.spellId, 26.3)
		timer = self:ScheduleTimer("HordeDestroyerDeath", 30)
	end

	function mod:DeployDwarvenBombers(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "cyan")
		self:PlaySound(args.spellId, "info")
		self:CDBar(args.spellId, 26.3)
		timer = self:ScheduleTimer("AllianceDestroyerDeath", 30)
	end

	function mod:HordeDestroyerDeath()
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(407535) -- Deploy Goblin Sappers
		self:StopBar(407205) -- Volatile Mortar
	end

	function mod:AllianceDestroyerDeath()
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(418684) -- Deploy Dwarven Bombers
		self:StopBar(407205) -- Volatile Mortar
	end
end

-- Horde Farseer

function mod:HealingWave(args)
	if self:Interrupter() then
		self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "warning")
	end
	--self:Nameplate(args.spellId, 9.7, args.sourceGUID)
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
	if self:Interrupter() then
		self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "warning")
	end
	--self:Nameplate(args.spellId, 9.7, args.sourceGUID)
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
		--self:Nameplate(args.spellId, 10.9, args.sourceGUID)
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
		--self:Nameplate(args.spellId, 14.5, args.sourceGUID)
	end
end

-- Infinite Timebender

function mod:DizzyingSands(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
	--self:Nameplate(args.spellId, 29.1, args.sourceGUID)
end

function mod:MillenniumAid(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end
