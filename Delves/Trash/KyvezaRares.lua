--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ky'veza Rares", {2664, 2679, 2680, 2681, 2683, 2684, 2685, 2686, 2687, 2688, 2689, 2690, 2803, 2815, 2826}) -- All Delves
if not mod then return end
mod:RegisterEnableMob(
	-- TWW Season 3, standard rares
	209721, -- Secret Treasure (spawns Treasure Wraith)
	208728, -- Treasure Wraith
	244448, -- Invasive Phasecrawler
	244453, -- D'rude
	244444, -- Great Devourer
	-- TWW Season 3, Ky'veza rares
	244413, -- Pactsworn Fraycaller
	244415, -- Pactsworn Dustblade
	244410, -- Pactsworn Sandreaver
	244411, -- Pactsworn Arcanist
	244418, -- Pactsworn Wildcaller
	248084, -- Pactsworn Sandreaver (summoned)
	244755, -- Nexus-Princess Ky'veza (Random Spawn)
	245938, -- Flickergate
	248481, -- Ky'veza's Shadow Clone
	247387, -- Zekvir
	247390 -- The Underpin
)

--------------------------------------------------------------------------------
-- Locals
--

local kyvezaEngaged = false

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.rares = "Ky'veza Rares"

	L.treasure_wraith = "Treasure Wraith"
	L.invasive_phasecrawler = "Invasive Phasecrawler"
	L.drude = "D'rude"
	L.great_devourer = "Great Devourer"
	L.pactsworn_fraycaller = "Pactsworn Fraycaller"
	L.pactsworn_dustblade = "Pactsworn Dustblade"
	L.pactsworn_sandreaver = "Pactsworn Sandreaver"
	L.pactsworn_arcanist = "Pactsworn Arcanist"
	L.pactsworn_wildcaller = "Pactsworn Wildcaller"
	L.nexus_princess_kyveza = "Nexus-Princess Ky'veza (Random Spawn)"
	L.zekvir = "Zekvir"
	L.the_underpin = "The Underpin"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.rares
end

function mod:GetOptions()
	return {
		-- Treasure Wraith
		{418295, "NAMEPLATE"}, -- Umbral Slash
		{418297, "NAMEPLATE"}, -- Castigate
		-- Invasive Phasecrawler
		{1238737, "NAMEPLATE"}, -- Essence Cleave
		{1238713, "NAMEPLATE"}, -- Gravity Shatter
		-- D'rude
		{1237671, "NAMEPLATE"}, -- Sandstorm
		-- Great Devourer
		1237258, -- Decroding Puddle
		-- Pactsworn Fraycaller
		{1242752, "NAMEPLATE"}, -- Unworthy Vessel
		-- TODO probably Consume too
		-- Pactsworn Dustblade
		{1243017, "NAMEPLATE"}, -- Sand Crash
		-- Pactsworn Sandreaver
		{1242469, "NAMEPLATE"}, -- Sands of Karesh
		-- Pactsworn Arcanist
		{1244313, "NAMEPLATE"}, -- Torrential Energy
		{1243656, "NAMEPLATE"}, -- Arcane Barrier
		-- Pactsworn Wildcaller
		{1242521, "NAMEPLATE"}, -- Duneflyer Call
		{1242534, "NAMEPLATE"}, -- Summon Warpstalker
		-- Pactsworn Sandreaver (summoned)
		{1244108, "NAMEPLATE"}, -- Terrifying Screech
		{1244249, "NAMEPLATE"}, -- Charge Throug
		-- Nexus-Princess Ky'veza
		{1245156, "EMPHASIZE"}, -- Ky'veza's Grand Entrance
		{1245203, "NAMEPLATE"}, -- Dark Massacre
		{1245240, "NAMEPLATE"}, -- Nexus Daggers
		-- Zekvir
		{450505, "NAMEPLATE"}, -- Enfeebling Spittle
		{450492, "NAMEPLATE"}, -- Horrendous Roar
		{450519, "NAMEPLATE"}, -- Angler's Web
		-- The Underpin
		{1213852, "NAMEPLATE"}, -- Crush
		{1217371, "NAMEPLATE"}, -- Flamethrower
		{1214147, "NAMEPLATE"}, -- Time Bomb Launcher
	},{
		[418295] = L.treasure_wraith,
		[1238737] = L.invasive_phasecrawler,
		[1237671] = L.drude,
		[1237258] = L.great_devourer,
		[1242752] = L.pactsworn_fraycaller,
		[1243017] = L.pactsworn_dustblade,
		[1242469] = L.pactsworn_sandreaver,
		[1244313] = L.pactsworn_arcanist,
		[1242521] = L.pactsworn_wildcaller,
		[1244108] = L.pactsworn_sandreaver,
		[1245156] = L.nexus_princess_kyveza,
		[450505] = L.zekvir,
		[1213852] = L.the_underpin,
	},{
		[450492] = CL.fear, -- Horrendous Roar (Fear)
		[1213852] = CL.leap, -- Crush (Leap)
		[1217371] = CL.frontal_cone, -- Flamethrower (Frontal Cone)
		[1214147] = CL.bombs, -- Time Bomb Launcher (Bombs)
	}
end

function mod:OnBossEnable()
	-- Treasure Wraith
	self:RegisterEngageMob("TreasureWraithEngaged", 208728)
	self:Log("SPELL_CAST_START", "UmbralSlash", 418295)
	self:Log("SPELL_AURA_APPLIED", "Castigate", 418297)
	self:Death("TreasureWraithDeath", 208728)

	-- Invasive Phasecrawler
	self:RegisterEngageMob("InvasivePhasecrawlerEngaged", 244448)
	self:Log("SPELL_CAST_START", "EssenceCleave", 1238737)
	self:Log("SPELL_CAST_START", "GravityShatter", 1238713)
	self:Death("InvasivePhasecrawlerDeath", 244448)

	-- D'rude
	self:RegisterEngageMob("DrudeEngaged", 244453)
	self:Log("SPELL_CAST_START", "Sandstorm", 1237671)
	self:Death("DrudeDeath", 244453)

	-- Great Devourer
	self:Log("SPELL_PERIODIC_DAMAGE", "DecrodingPuddleDamage", 1237258)
	self:Log("SPELL_PERIODIC_MISSED", "DecrodingPuddleDamage", 1237258)

	-- Pactsworn Fraycaller
	self:RegisterEngageMob("PactswornFraycallerEngaged", 244413)
	self:Log("SPELL_CAST_SUCCESS", "UnworthyVessel", 1242752)
	self:Log("SPELL_SUMMON", "UnworthyVesselSummon", 1242752)
	self:Death("PactswornFraycallerDeath", 244413)

	-- Pactsworn Dustblade
	self:RegisterEngageMob("PactswornDustbladeEngaged", 244415)
	self:Log("SPELL_CAST_START", "SandCrash", 1243017)
	self:Log("SPELL_CAST_SUCCESS", "SandCrashSuccess", 1243017)
	self:Death("PactswornFraycallerDeath", 244413)

	-- Pactsworn Sandreaver
	self:RegisterEngageMob("PactswornSandreaverEngaged", 244410)
	self:Log("SPELL_CAST_START", "SandsOfKaresh", 1242469)
	self:Log("SPELL_INTERRUPT", "SandsOfKareshInterrupt", 1242469)
	self:Log("SPELL_CAST_SUCCESS", "SandsOfKareshSuccess", 1242469)
	self:Death("PactswornSandreaverDeath", 244410)

	-- Pactsworn Arcanist
	self:RegisterEngageMob("PactswornArcanistEngaged", 244411)
	self:Log("SPELL_CAST_START", "TorrentialEnergy", 1244313)
	self:Log("SPELL_CAST_SUCCESS", "TorrentialEnergySuccess", 1244313)
	self:Log("SPELL_CAST_START", "ArcaneBarrier", 1243656)
	self:Log("SPELL_INTERRUPT", "ArcaneBarrierInterrupt", 1243656)
	self:Log("SPELL_CAST_SUCCESS", "ArcaneBarrierSuccess", 1243656)
	self:Death("PactswornArcanistDeath", 244411)

	-- Pactsworn Wildcaller
	self:Log("SPELL_CAST_START", "DuneflyerCall", 1242521)
	self:Log("SPELL_CAST_SUCCESS", "DuneflyerCallSuccess", 1242521)
	self:Log("SPELL_CAST_START", "SummonWarpstalker", 1242534)
	self:Log("SPELL_CAST_SUCCESS", "SummonWarpstalkerSuccess", 1242534)
	self:Death("PactswornWildcallerDeath", 244418)

	-- Pactsworn Sandreaver (XXX incorrectly named?)
	self:RegisterEngageMob("PactswornSandreaver2Engaged", 248084)
	self:Log("SPELL_CAST_START", "TerrifyingScreech", 1244108)
	self:Log("SPELL_CAST_SUCCESS", "TerrifyingScreechSuccess", 1244108)
	self:Log("SPELL_CAST_START", "ChargeThrough", 1244249)
	self:Death("PactswornSandreaver2Death", 248084)

	-- Engage Detection
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT") -- for Nexus-Princess Ky'veza
	self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED") -- for Zekvir and The Underpin

	-- Nexus-Princess Ky'veza
	self:Log("SPELL_CAST_START", "KyvezasGrandEntrance", 1245156)
	self:Log("SPELL_CAST_START", "DarkMassacre", 1245203)
	self:Log("SPELL_CAST_SUCCESS", "DarkMassacrePhantom", 1245035)
	self:Log("SPELL_CAST_START", "NexusDaggers", 1245240)

	-- Ky'veza's Shadow Clone
	self:RegisterEngageMob("KyvezasShadowCloneEngaged", 248481)
	self:Death("KyvezasShadowCloneDeath", 248481)

	-- Zekvir
	self:RegisterEngageMob("ZekvirEngaged", 247387)
	self:Log("SPELL_CAST_START", "EnfeeblingSpittle", 450505)
	self:Log("SPELL_INTERRUPT", "EnfeeblingSpittleInterrupt", 450505)
	self:Log("SPELL_CAST_SUCCESS", "EnfeeblingSpittleSuccess", 450505)
	self:Log("SPELL_AURA_APPLIED", "EnfeeblingSpittleApplied", 450505)
	self:Log("SPELL_CAST_START", "HorrendousRoar", 450492)
	self:Log("SPELL_CAST_START", "AnglersWeb", 450519)

	-- The Underpin
	self:RegisterEngageMob("TheUnderpinEngaged", 247390)
	self:Log("SPELL_CAST_START", "Crush", 1213852)
	self:Log("SPELL_CAST_START", "Flamethrower", 1217371)
	self:Log("SPELL_CAST_SUCCESS", "TimeBombLauncher", 1214147)
end

function mod:OnBossDisable()
	kyvezaEngaged = false
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Treasure Wraith

do
	local timer

	function mod:TreasureWraithEngaged(guid)
		if timer then
			self:CancelTimer(timer)
		end
		self:CDBar(418295, 5.2) -- Umbral Slash
		self:Nameplate(418295, 5.2, guid) -- Umbral Slash
		self:CDBar(418297, 6.7) -- Castigate
		self:Nameplate(418297, 6.7, guid) -- Castigate
		timer = self:ScheduleTimer("TreasureWraithDeath", 30, nil, guid)
	end

	function mod:UmbralSlash(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "yellow")
		self:CDBar(args.spellId, 17.6)
		self:Nameplate(args.spellId, 17.6, args.sourceGUID)
		timer = self:ScheduleTimer("TreasureWraithDeath", 30, nil, args.sourceGUID)
		self:PlaySound(args.spellId, "alarm")
	end

	function mod:Castigate(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:CDBar(args.spellId, 17.5)
		self:Nameplate(args.spellId, 17.5, args.sourceGUID)
		timer = self:ScheduleTimer("TreasureWraithDeath", 30, nil, args.sourceGUID)
		self:PlaySound(args.spellId, "alert")
	end

	function mod:TreasureWraithDeath(args, guidFromTimer)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(418295) -- Umbral Slash
		self:StopBar(418297) -- Castigate
		self:ClearNameplate(guidFromTimer or args.destGUID)
	end
end

-- Invasive Phasecrawler

function mod:InvasivePhasecrawlerEngaged(guid)
	self:Nameplate(1238737, 6.2, guid) -- Essence Cleave
	self:Nameplate(1238713, 9.9, guid) -- Gravity Shatter
end

function mod:EssenceCleave(args)
	self:Message(args.spellId, "red")
	self:Nameplate(args.spellId, 14.6, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:GravityShatter(args)
	self:Message(args.spellId, "orange")
	self:Nameplate(args.spellId, 24.3, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:InvasivePhasecrawlerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- D'rude

function mod:DrudeEngaged(guid)
	self:Nameplate(1237671, 17.2, guid) -- Sandstorm
end

function mod:Sandstorm(args)
	self:Message(args.spellId, "yellow")
	-- TODO confirm this is cd on cast start
	self:Nameplate(args.spellId, 18.1, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:DrudeDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Great Devourer

do
	local prev = 0
	function mod:DecrodingPuddleDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 2 then -- 1.5s tick rate
			prev = args.time
			self:PersonalMessage(1237258, "underyou")
			self:PlaySound(1237258, "underyou")
		end
	end
end

-- Pactsworn Fraycaller

function mod:PactswornFraycallerEngaged(guid)
	self:Nameplate(1242752, 10.7, guid) -- Unworthy Vessel
end

function mod:UnworthyVessel(args)
	self:Nameplate(args.spellId, 20.6, args.sourceGUID)
end

do
	local prev = 0
	function mod:UnworthyVesselSummon(args)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "cyan", CL.spawning:format(args.destName)) -- Unbound Remnant spawning
			self:PlaySound(args.spellId, "info")
		end
	end
end

function mod:PactswornFraycallerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Pactsworn Dustblade

function mod:PactswornDustbladeEngaged(guid)
	self:Nameplate(1243017, 8.3, guid) -- Sand Crash
end

do
	local prev = 0
	function mod:SandCrash(args)
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

function mod:SandCrashSuccess(args)
	self:Nameplate(args.spellId, 17.0, args.sourceGUID)
end

function mod:PactswornDustbladeDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Pactsworn Sandreaver

function mod:PactswornSandreaverEngaged(guid)
	self:Nameplate(1242469, 6.0, guid) -- Sands of Karesh
end

function mod:SandsOfKaresh(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:SandsOfKareshInterrupt(args)
	self:Nameplate(1242469, 17.5, args.destGUID)
end

function mod:SandsOfKareshSuccess(args)
	self:Nameplate(args.spellId, 17.5, args.sourceGUID)
end

function mod:PactswornSandreaverDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Pactsworn Arcanist

function mod:PactswornArcanistEngaged(guid)
	self:Nameplate(1243656, 7.0, guid) -- Arcane Barrier
	self:Nameplate(1244313, 9.5, guid) -- Torrential Energy
end

function mod:TorrentialEnergy(args)
	self:Message(args.spellId, "orange")
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:TorrentialEnergySuccess(args)
	self:Nameplate(args.spellId, 10.2, args.sourceGUID)
end

function mod:ArcaneBarrier(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:ArcaneBarrierInterrupt(args)
	self:Nameplate(1243656, 21.9, args.destGUID)
end

function mod:ArcaneBarrierSuccess(args)
	self:Nameplate(args.spellId, 21.9, args.sourceGUID)
end

function mod:PactswornArcanistDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Pactsworn Wildcaller

function mod:DuneflyerCall(args)
	self:Message(args.spellId, "yellow")
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	self:PlaySound(args.spellId, "info")
end

function mod:DuneflyerCallSuccess(args)
	self:Nameplate(args.spellId, 26.5, args.sourceGUID)
end

function mod:SummonWarpstalker(args)
	self:Message(args.spellId, "cyan")
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	self:PlaySound(args.spellId, "info")
end

function mod:SummonWarpstalkerSuccess(args)
	self:Nameplate(args.spellId, 20.4, args.sourceGUID)
end

function mod:PactswornWildcallerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Pactsworn Sandreaver (summoned)

function mod:PactswornSandreaver2Engaged(guid)
	self:Nameplate(1244249, 5.5, guid) -- Charge Through
	self:Nameplate(1244108, 9.1, guid) -- Terrifying Screech
end

function mod:ChargeThrough(args)
	self:Message(args.spellId, "yellow")
	self:Nameplate(args.spellId, 15.7, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:TerrifyingScreech(args)
	self:Message(args.spellId, "orange")
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:TerrifyingScreechSuccess(args)
	self:Nameplate(args.spellId, 20.4, args.sourceGUID)
end

function mod:PactswornSandreaver2Death(args)
	self:ClearNameplate(args.destGUID)
end

-- Engage Detection

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT(event)
	local _, kyvezaGUID = self:GetBossId(244755) -- Nexus-Princess Ky'veza
	if not kyvezaEngaged and kyvezaGUID then
		kyvezaEngaged = true
		self:KyvezaEngaged(kyvezaGUID)
	elseif kyvezaEngaged and not kyvezaGUID then
		kyvezaEngaged = false
		self:KyvezaDisengaged()
	end
end

do
	local prevCast = nil
	function mod:UNIT_SPELLCAST_INTERRUPTED(_, unit, castGUID, spellId)
		if spellId == 1243416 and castGUID ~= prevCast then -- Teleported (Zekvir and The Underpin retreat)
			prevCast = castGUID
			local unitGUID = self:UnitGUID(unit)
			local mobId = self:MobId(unitGUID)
			if mobId == 247387 then -- Zekvir
				self:ZekvirRetreat(unitGUID)
			elseif mobId == 247390 then -- The Underpin
				self:TheUnderpinRetreat(unitGUID)
			end
		end
	end
end

-- Nexus-Princess Ky'veza

do
	local timer

	function mod:KyvezasGrandEntrance(args)
		-- this is cast by some dummy NPC (248134) so can't use the guid for nameplate timers
		self:Message(args.spellId, "cyan")
		self:PlaySound(args.spellId, "warning")
	end

	function mod:KyvezaEngaged(guid)
		if timer then -- guard against edge cases
			self:KyvezaDisengaged()
		end
		self:CDBar(1245203, 15.5) -- Dark Massacre
		self:Nameplate(1245203, 15.5, guid) -- Dark Massacre
		self:CDBar(1245240, 30.2) -- Nexus Daggers
		self:Nameplate(1245240, 30.2, guid) -- Nexus Daggers
		timer = self:ScheduleTimer("KyvezaRetreat", 30, guid)
	end

	function mod:KyvezaDisengaged()
		if timer then
			timer:Invoke()
			self:CancelTimer(timer)
			timer = nil
		end
	end

	do
		local phantomCount = 1
		function mod:DarkMassacre(args)
			phantomCount = 1
			if timer then
				self:CancelTimer(timer)
			end
			self:Message(args.spellId, "yellow", CL.incoming:format(args.spellName))
			self:CDBar(args.spellId, 30.2)
			self:Nameplate(args.spellId, 30.2, args.sourceGUID)
			timer = self:ScheduleTimer("KyvezaRetreat", 30, args.sourceGUID)
			self:PlaySound(args.spellId, "long")
		end

		function mod:DarkMassacrePhantom(args)
			-- this alerts on SPELL_CAST_SUCCESS, denoting when it's safe to turn away from the active Nether Phantom
			self:Message(1245203, "yellow", CL.count_amount:format(args.spellName, phantomCount, 2))
			phantomCount = phantomCount + 1
			if phantomCount <= 2 then
				-- don't play a sound after the last cast
				self:PlaySound(1245203, "alert")
			end
		end
	end

	function mod:NexusDaggers(args)
		-- also cast by 2 Nether Phantoms (248193) at 1 and 2 seconds after the main cast
		local mobId = self:MobId(args.sourceGUID)
		if mobId == 244755 or mobId == 248481 then -- Nexus-Princess Ky'veza, Ky'veza's Shadow Clone
			if timer then
				self:CancelTimer(timer)
			end
			self:Message(args.spellId, "orange")
			self:CDBar(args.spellId, 30.2)
			self:Nameplate(args.spellId, 30.2, args.sourceGUID)
			timer = self:ScheduleTimer("KyvezaRetreat", 30, args.sourceGUID)
			self:PlaySound(args.spellId, "alarm")
		end
	end

	function mod:KyvezaRetreat(guid)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(1245203) -- Dark Massacre
		self:StopBar(1245240) -- Nexus Daggers
		if guid then
			self:ClearNameplate(guid)
		end
	end

	-- Ky'veza's Shadow Clone

	function mod:KyvezasShadowCloneEngaged(guid)
		self:CDBar(1245203, 15.2) -- Dark Massacre
		self:Nameplate(1245203, 15.2, guid) -- Dark Massacre
		self:CDBar(1245240, 31.1) -- Nexus Daggers
		self:Nameplate(1245240, 31.1, guid) -- Nexus Daggers
		timer = self:ScheduleTimer("KyvezaRetreat", 30, guid)
	end

	function mod:KyvezasShadowCloneDeath(args)
		self:KyvezaRetreat(args.destGUID)
	end
end

-- Zekvir

do
	local timer

	function mod:ZekvirEngaged(guid)
		self:CDBar(450505, 4.5) -- Enfeebling Spittle
		self:Nameplate(450505, 4.5, guid) -- Enfeebling Spittle
		self:CDBar(450492, 9.1, CL.fear) -- Horrendous Roar
		self:Nameplate(450492, 9.1, guid) -- Horrendous Roar
		self:CDBar(450519, 20.0) -- Angler's Web
		self:Nameplate(450519, 20.0, guid) -- Angler's Web
		timer = self:ScheduleTimer("ZekvirRetreat", 20, guid)
	end

	function mod:EnfeeblingSpittle(args)
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		self:PlaySound(args.spellId, "alert")
	end

	function mod:EnfeeblingSpittleInterrupt(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:CDBar(450505, 15.3)
		self:Nameplate(450505, 15.3, args.destGUID)
		timer = self:ScheduleTimer("ZekvirRetreat", 20, args.destGUID)
	end

	function mod:EnfeeblingSpittleSuccess(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:CDBar(args.spellId, 15.3)
		self:Nameplate(args.spellId, 15.3, args.sourceGUID)
		timer = self:ScheduleTimer("ZekvirRetreat", 20, args.sourceGUID)
	end

	function mod:EnfeeblingSpittleApplied(args)
		if self:Me(args.destGUID) then
			self:PersonalMessage(args.spellId)
			self:PlaySound(args.spellId, "info", nil, args.destName)
		end
	end

	function mod:HorrendousRoar(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "yellow", CL.fear)
		self:CDBar(args.spellId, 17.9, CL.fear)
		self:Nameplate(args.spellId, 17.9, args.sourceGUID)
		timer = self:ScheduleTimer("ZekvirRetreat", 20, args.sourceGUID)
		self:PlaySound(args.spellId, "alarm")
	end

	function mod:AnglersWeb(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		self:CDBar(args.spellId, 21.5)
		self:Nameplate(args.spellId, 21.5, args.sourceGUID)
		timer = self:ScheduleTimer("ZekvirRetreat", 20, args.sourceGUID)
		self:PlaySound(args.spellId, "alarm")
	end

	function mod:ZekvirRetreat(guid)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(450505) -- Enfeebling Spittle
		self:StopBar(CL.fear) -- Horrendous Roar
		self:StopBar(450519) -- Angler's Web
		if guid then
			self:ClearNameplate(guid)
		end
	end
end

-- The Underpin

do
	local timer

	function mod:TheUnderpinEngaged(guid)
		self:CDBar(1213852, 4.8, CL.leap) -- Crush
		self:Nameplate(1213852, 4.8, guid) -- Crush
		self:CDBar(1217371, 9.6, CL.frontal_cone) -- Flamethrower
		self:Nameplate(1217371, 9.6, guid) -- Flamethrower
		self:CDBar(1214147, 13.3, CL.bombs) -- Time Bomb Launcher
		self:Nameplate(1214147, 13.3, guid) -- Time Bomb Launcher
		timer = self:ScheduleTimer("TheUnderpinRetreat", 20, guid)
	end

	function mod:Crush(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange", CL.leap)
		self:CDBar(args.spellId, 20.1, CL.leap)
		self:Nameplate(args.spellId, 20.1, args.sourceGUID)
		timer = self:ScheduleTimer("TheUnderpinRetreat", 20, args.sourceGUID)
		self:PlaySound(args.spellId, "alarm")
	end

	function mod:Flamethrower(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red", CL.frontal_cone)
		self:CDBar(args.spellId, 20.1, CL.frontal_cone)
		self:Nameplate(args.spellId, 20.1, args.sourceGUID)
		timer = self:ScheduleTimer("TheUnderpinRetreat", 20, args.sourceGUID)
		self:PlaySound(args.spellId, "alarm")
	end

	function mod:TimeBombLauncher(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "yellow", CL.bombs)
		self:CDBar(args.spellId, 25.1, CL.bombs)
		self:Nameplate(args.spellId, 25.1, args.sourceGUID)
		timer = self:ScheduleTimer("TheUnderpinRetreat", 20, args.sourceGUID)
		self:PlaySound(args.spellId, "info")
	end

	function mod:TheUnderpinRetreat(guid)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(CL.leap) -- Crush
		self:StopBar(CL.frontal_cone) -- Flamethrower
		self:StopBar(CL.bombs) -- Time Bomb Launcher
		if guid then
			self:ClearNameplate(guid)
		end
	end
end
