--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ky'veza Rares", {2664, 2679, 2680, 2681, 2683, 2684, 2685, 2686, 2687, 2688, 2689, 2690, 2803, 2815, 2826}) -- All Delves
if not mod then return end
mod:RegisterEnableMob(
	-- TWW Season 3, Ky'veza rares
	244413, -- Pactsworn Fraycaller
	244415, -- Pactsworn Dustblade
	244410, -- Pactsworn Sandreaver
	244411, -- Pactsworn Arcanist
	244418, -- Pactsworn Wildcaller
	248084, -- Pactsworn Sandreaver (XXX incorrectly named?)
	244448, -- Invasive Phasecrawler
	244453, -- D'rude
	244444, -- Great Devourer
	244755 -- Nexus-Princess Ky'veza (Random Spawn)
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.rares = "Ky'veza Rares"

	L.pactsworn_fraycaller = "Pactsworn Fraycaller"
	L.pactsworn_dustblade = "Pactsworn Dustblade"
	L.pactsworn_sandreaver = "Pactsworn Sandreaver"
	L.pactsworn_arcanist = "Pactsworn Arcanist"
	L.pactsworn_wildcaller = "Pactsworn Wildcaller"
	L.invasive_phasecrawler = "Invasive Phasecrawler"
	L.drude = "D'rude"
	L.great_devourer = "Great Devourer"
	L.nexus_princess_kyveza = "Nexus-Princess Ky'veza (Random Spawn)"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.rares
end

function mod:GetOptions()
	return {
		-- Pactsworn Fraycaller
		{1242752, "NAMEPLATE"}, -- Unworthy Vessel
		-- TODO probably Consume too
		-- Pactsworn Dustblade
		{1243017, "NAMEPLATE"}, -- Sand Crash
		-- Pactsworn Sandreaver
		{1242469, "NAMEPLATE"}, -- Sands of Karesh
		-- Pactsworn Arcanist
		{1244313, "NAMEPLATE"}, -- Torrential Energy
		-- Pactsworn Wildcaller
		{1242521, "NAMEPLATE"}, -- Duneflyer Call
		{1242534, "NAMEPLATE"}, -- Summon Warpstalker
		-- Pactsworn Sandreaver (XXX incorrectly named?)
		{1244108, "NAMEPLATE"}, -- Terrifying Screech
		{1244249, "NAMEPLATE"}, -- Charge Throug
		-- Invasive Phasecrawler
		{1238737, "NAMEPLATE"}, -- Essence Cleave
		{1238713, "NAMEPLATE"}, -- Gravity Shatter
		-- D'rude
		{1237671, "NAMEPLATE"}, -- Sandstorm
		-- Great Devourer
		1237258, -- Decroding Puddle
		-- Nexus-Princess Ky'veza
		{1245156, "EMPHASIZE"}, -- Ky'veza's Grand Entrance
		{1245203, "NAMEPLATE"}, -- Dark Massacre
		{1245240, "NAMEPLATE"}, -- Nexus Daggers
	}, {
		[1242752] = L.pactsworn_fraycaller,
		[1243017] = L.pactsworn_dustblade,
		[1242469] = L.pactsworn_sandreaver,
		[1244313] = L.pactsworn_arcanist,
		[1242521] = L.pactsworn_wildcaller,
		[1244108] = L.pactsworn_sandreaver,
		[1238737] = L.invasive_phasecrawler,
		[1237671] = L.drude,
		[1237258] = L.great_devourer,
		[1245156] = L.nexus_princess_kyveza,
	}
end

function mod:OnBossEnable()
	-- Pactsworn Fraycaller
	self:RegisterEngageMob("PactswornFraycallerEngaged", 244413)
	self:Log("SPELL_CAST_SUCCESS", "UnworthyVessel", 1242752)
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

	-- Nexus-Princess Ky'veza
	self:Log("SPELL_CAST_START", "KyvezasGrandEntrance", 1245156)
	self:Log("SPELL_CAST_SUCCESS", "Reaper", 1245040)
	self:Log("SPELL_CAST_START", "DarkMassacre", 1245203)
	self:Log("SPELL_CAST_START", "NexusDaggers", 1245240)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Pactsworn Fraycaller

function mod:PactswornFraycallerEngaged(guid)
	self:Nameplate(1242752, 10.8, guid) -- Unworthy Vessel
end

do
	local prev = 0
	function mod:UnworthyVessel(args)
		self:Nameplate(args.spellId, 20.6, args.sourceGUID)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "cyan", CL.spawning:format(args.spellName))
			self:PlaySound(args.spellId, "info")
		end
	end
end

function mod:PactswornFraycallerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Pactsworn Dustblade

function mod:PactswornDustbladeEngaged(guid)
	self:Nameplate(1243017, 10.4, guid) -- Sand Crash
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
	self:Nameplate(args.spellId, 44.3, args.sourceGUID)
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

-- Pactsworn Sandreaver (XXX incorrectly named?)

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

-- Invasive Phasecrawler

function mod:InvasivePhasecrawlerEngaged(guid)
	self:Nameplate(1238737, 100, guid) -- Essence Cleave
	self:Nameplate(1238713, 100, guid) -- Gravity Shatter
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

-- Nexus-Princess Ky'veza

do
	local timer

	function mod:KyvezasGrandEntrance(args)
		-- this is cast by some dummy NPC (248134) so can't use the guid for nameplate timers
		self:Message(args.spellId, "cyan")
		self:PlaySound(args.spellId, "warning")
	end

	function mod:Reaper(args)
		self:CDBar(1245203, 14.4) -- Dark Massacre
		self:Nameplate(1245203, 14.4, args.sourceGUID) -- Dark Massacre
		self:CDBar(1245240, 29.0) -- Nexus Daggers
		self:Nameplate(1245240, 29.0, args.sourceGUID) -- Nexus Daggers
		timer = self:ScheduleTimer("KyvezaRetreat", 30, args.sourceGUID)
	end

	function mod:DarkMassacre(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "yellow")
		self:CDBar(args.spellId, 30.2)
		self:Nameplate(args.spellId, 30.2, args.sourceGUID)
		timer = self:ScheduleTimer("KyvezaRetreat", 30, args.sourceGUID)
		self:PlaySound(args.spellId, "info")
	end

	function mod:NexusDaggers(args)
		-- also cast by 2 clones (248193) at 1 and 2 seconds after the main cast
		if self:MobId(args.sourceGUID) == 244755 then -- Nexus-Princess Ky'veza
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
end
