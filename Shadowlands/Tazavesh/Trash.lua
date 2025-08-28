--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Tazavesh Trash", 2441)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	------ Streets of Wonder ------
	179799, -- Portal Authority Tunnelmancer
	178392, -- Gatewarden Zo'mazz
	177807, -- Customs Security
	177816, -- Interrogation Specialist
	177808, -- Armored Overseer
	177817, -- Support Officer
	179334, -- Portalmancer Zo'honn
	179837, -- Tracker Zo'korss
	180091, -- Ancient Core Hound
	180567, -- Frenzied Nightclaw
	180495, -- Enraged Direhorn
	179893, -- Cartel Skulker
	180336, -- Cartel Wiseguy
	180348, -- Cartel Muscle
	180335, -- Cartel Smuggler
	176396, -- Defective Sorter
	176395, -- Overloaded Mailemental
	176394, -- P.O.S.T. Worker
	246285, -- Bazaar Overseer
	179840, -- Market Peacekeeper
	179841, -- Veteran Sparkcaster
	179842, -- Commerce Enforcer
	179821, -- Commander Zo'far
	------ So'leah's Gambit ------
	178163, -- Murkbrine Shorerunner
	178141, -- Murkbrine Scalebinder
	178142, -- Murkbrine Fishmancer
	178139, -- Murkbrine Shellcrusher
	178165, -- Coastwalker Goliath
	178171, -- Stormforged Guardian
	180015, -- Burly Deckhand
	179388, -- Hourglass Tidesage
	179386, -- Corsair Officer
	180429, -- Adorned Starseer
	180431, -- Focused Ritualist
	180432 -- Devoted Accomplice
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	------ Streets of Wonder ------
	L.zophex_warmup_trigger = "Surrender... all... contraband..."
	L.menagerie_warmup_trigger = "Now for the item you have all been awaiting! The allegedly demon-cursed Edge of Oblivion!"
	L.soazmi_warmup_trigger = "Excuse our intrusion, So'leah. I hope we caught you at an inconvenient time."
	L.portal_authority = "Tazavesh Portal Authority"
	L.custom_on_portal_autotalk = CL.autotalk
	L.custom_on_portal_autotalk_desc = "Instantly open portals back to the entrance when talking to Broker NPCs."
	L.custom_on_portal_autotalk_icon = mod:GetMenuIcon("SAY")
	L.trading_game = "Trading Game"
	L.trading_game_desc = "Alerts with the right password during the Trading Game."
	L.trading_game_icon = "achievement_dungeon_brokerdungeon"
	L.custom_on_trading_game_autotalk = CL.autotalk
	L.custom_on_trading_game_autotalk_desc = "Instantly select the right password after the Trading Game has been completed."
	L.custom_on_trading_game_autotalk_icon = mod:GetMenuIcon("SAY")
	L.password_triggers = {
		["Ivory Shell"] = 53259,
		["Sapphire Oasis"] = 53260,
		["Jade Palm"] = 53261,
		["Golden Sands"] = 53262,
		["Amber Sunset"] = 53263,
		["Emerald Ocean"] = 53264,
		["Ruby Gem"] = 53265,
		["Pewter Stone"] = 53266,
		["Pale Flower"] = 53267,
		["Crimson Knife"] = 53268
	}
	L.gatewarden_zomazz = "Gatewarden Zo'mazz"
	L.customs_security = "Customs Security"
	L.interrogation_specialist = "Interrogation Specialist"
	L.portalmancer_zohonn = "Portalmancer Zo'honn"
	L.armored_overseer = "Armored Overseer"
	L.support_officer = "Support Officer"
	L.tracker_zokorss = "Tracker Zo'korss"
	L.ancient_core_hound = "Ancient Core Hound"
	L.enraged_direhorn = "Enraged Direhorn"
	L.cartel_skulker = "Cartel Skulker"
	L.cartel_wiseguy = "Cartel Wiseguy"
	L.cartel_muscle = "Cartel Muscle"
	L.cartel_smuggler = "Cartel Smuggler"
	L.defective_sorter = "Defective Sorter"
	L.overloaded_mailemental = "Overloaded Mailemental"
	L.post_worker = "P.O.S.T. Worker"
	L.bazaar_overseer = "Bazaar Overseer"
	L.market_peacekeeper = "Market Peacekeeper"
	L.veteran_sparkcaster = "Veteran Sparkcaster"
	L.commerce_enforcer = "Commerce Enforcer"
	L.commander_zofar = "Commander Zo'far"

	------ So'leah's Gambit ------
	L.tazavesh_soleahs_gambit = "Tazavesh: So'leah's Gambit"
	L.hylbrande_warmup_trigger = "See how your wisdom fares against the might of the titans."
	L.portal_open = "Portal opens"
	L.portal_open_desc = "Show a bar indicating when the portal to the next area will open."
	L.portal_open_icon = "spell_arcane_portalironforge"
	L.murkbrine_scalebinder = "Murkbrine Scalebinder"
	L.murkbrine_fishmancer = "Murkbrine Fishmancer"
	L.murkbrine_shellcrusher = "Murkbrine Shellcrusher"
	L.coastwalker_goliath = "Coastwalker Goliath"
	L.stormforged_guardian = "Stormforged Guardian"
	L.burly_deckhand = "Burly Deckhand"
	L.hourglass_tidesage = "Hourglass Tidesage"
	L.corsair_officer = "Corsair Officer"
	L.adorned_starseer = "Adorned Starseer"
	L.focused_ritualist = "Focused Ritualist"
	L.devoted_accomplice = "Devoted Accomplice"

	L["1244650_icon"] = 356260 -- Tidal Burst has no icon
	L["1244650_desc"] = 356260 -- Tidal Burst has no description
end

--------------------------------------------------------------------------------
-- Locals
--

local passwordId = nil

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		------ Streets of Wonder ------
		"custom_on_portal_autotalk",
		"trading_game",
		"custom_on_trading_game_autotalk",
		-- Gatewarden Zo'mazz
		{352796, "TANK", "NAMEPLATE"}, -- Proxy Strike
		{356548, "NAMEPLATE"}, -- Radiant Pulse
		-- Customs Security
		{355900, "NAMEPLATE"}, -- Disruption Grenade
		{355888, "DISPEL", "NAMEPLATE"}, -- Hard Light Baton
		{355891, "NAMEPLATE", "OFF"}, -- Teleport
		-- Interrogation Specialist
		{355915, "DISPEL", "NAMEPLATE"}, -- Glyph of Restraint
		-- Armored Overseer
		{356001, "NAMEPLATE"}, -- Beam Splicer
		-- Support Officer
		{355934, "DISPEL", "NAMEPLATE"}, -- Hard Light Barrier
		{355980, "DISPEL"}, -- Refraction Shield
		-- Portalmancer Zo'honn
		{356537, "NAMEPLATE"}, -- Empowered Glyph of Restraint
		-- Tracker Zo'korss
		356929, -- Chain of Custody
		{356942, "DISPEL", "NAMEPLATE"}, -- Lockdown
		-- Ancient Core Hound
		{356404, "NAMEPLATE"}, -- Lava Breath
		{356407, "NAMEPLATE"}, -- Ancient Dread
		-- Enraged Direhorn
		{357512, "SAY", "NAMEPLATE"}, -- Frenzied Charge
		{357508, "NAMEPLATE"}, -- Wild Thrash
		-- Cartel Skulker
		{355830, "NAMEPLATE"}, -- Quickblade
		-- Cartel Wiseguy
		{357197, "NAMEPLATE"}, -- Lightshard Retreat
		-- Cartel Muscle
		{356967, "TANK_HEALER", "NAMEPLATE"}, -- Hyperlight Backhand
		{357229, "TANK", "NAMEPLATE", "OFF"}, -- Chronolight Enhancer
		-- Cartel Smuggler
		{357029, "SAY", "SAY_COUNTDOWN", "NAMEPLATE"}, -- Hyperlight Bomb
		-- Defective Sorter
		347721, -- Open Cage
		-- Overloaded Mailemental
		{347775, "NAMEPLATE"}, -- Spam Filter
		-- P.O.S.T. Worker
		{347716, "TANK", "NAMEPLATE"}, -- Letter Opener
		-- Bazaar Overseer
		{1240821, "NAMEPLATE"}, -- Energized Slam
		{1240912, "NAMEPLATE"}, -- Pierce
		-- Market Peacekeeper
		{355640, "NAMEPLATE"}, -- Phalanx Field
		{355637, "ME_ONLY", "NAMEPLATE", "OFF"}, -- Quelling Strike
		-- Veteran Sparkcaster
		{355642, "NAMEPLATE"}, -- Hyperlight Salvo
		-- Commerce Enforcer
		{1244443, "NAMEPLATE", "OFF"}, -- Force Multiplier
		{355477, "TANK_HEALER", "NAMEPLATE"}, -- Power Kick
		-- Commander Zo'far
		{355479, "NAMEPLATE"}, -- Lethal Force
		{355473, "NAMEPLATE"}, -- Shock Mines
		------ So'leah's Gambit ------
		-- General
		"portal_open",
		358443, -- Blood in the Water
		-- Murkbrine Scalebinder
		{355132, "NAMEPLATE"}, -- Invigorating Fish Stick
		-- Murkbrine Fishmancer
		{355234, "NAMEPLATE"}, -- Volatile Pufferfish
		-- Murkbrine Shellcrusher
		{355057, "DISPEL", "NAMEPLATE"}, -- Cry of Mrrggllrrgg
		{355048, "TANK", "NAMEPLATE"}, -- Shellcracker
		-- Coastwalker Goliath
		{355429, "NAMEPLATE"}, -- Tidal Stomp
		{355464, "NAMEPLATE"}, -- Boulder Throw
		-- Stormforged Guardian
		{355584, "NAMEPLATE"}, -- Charged Pulse
		{355577, "NAMEPLATE"}, -- Crackle
		-- Burly Deckhand
		{356133, "DISPEL", "NAMEPLATE"}, -- Super Saison
		-- Hourglass Tidesage
		{1244650, "NAMEPLATE"}, -- Tidal Burst
		-- Corsair Officer
		{368661, "NAMEPLATE", "OFF"}, -- Sword Toss
		-- Adorned Starseer
		{357226, "NAMEPLATE"}, -- Drifting Star
		{357238, "NAMEPLATE"}, -- Wandering Pulsar
		-- Focused Ritualist
		{357260, "NAMEPLATE"}, -- Unstable Rift
	}, {
		------ Streets of Wonder ------
		["custom_on_portal_autotalk"] = L.portal_authority,
		["trading_game"] = L.trading_game,
		[352796] = L.gatewarden_zomazz,
		[355900] = L.customs_security,
		[355915] = L.interrogation_specialist,
		[356537] = L.portalmancer_zohonn,
		[356001] = L.armored_overseer,
		[355934] = L.support_officer,
		[356929] = L.tracker_zokorss,
		[356404] = L.ancient_core_hound,
		[357512] = L.enraged_direhorn,
		[355830] = L.cartel_skulker,
		[357197] = L.cartel_wiseguy,
		[356967] = L.cartel_muscle,
		[357029] = L.cartel_smuggler,
		[347721] = L.defective_sorter,
		[347775] = L.overloaded_mailemental,
		[347716] = L.post_worker,
		[1240821] = L.bazaar_overseer,
		[355640] = L.market_peacekeeper,
		[355642] = L.veteran_sparkcaster,
		[1244443] = L.commerce_enforcer,
		[355479] = L.commander_zofar,
		------ So'leah's Gambit ------
		["portal_open"] = L.tazavesh_soleahs_gambit,
		[355132] = L.murkbrine_scalebinder,
		[355234] = L.murkbrine_fishmancer,
		[355057] = L.murkbrine_shellcrusher,
		[355429] = L.coastwalker_goliath,
		[355584] = L.stormforged_guardian,
		[356133] = L.burly_deckhand,
		[1244650] = L.hourglass_tidesage,
		[368661] = L.corsair_officer,
		[357226] = L.adorned_starseer,
		[357260] = L.focused_ritualist,
	}
end

function mod:OnBossEnable()
	------ Streets of Wonder ------

	-- Trading Game, warmups
	self:RegisterEvent("CHAT_MSG_MONSTER_SAY")
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")

	-- Auto-gossip
	self:RegisterEvent("GOSSIP_SHOW")

	-- Gatewarden Zo'mazz
	self:RegisterEngageMob("GatewardenZomazzEngaged", 178392)
	self:Log("SPELL_CAST_START", "ProxyStrike", 352796)
	self:Log("SPELL_CAST_START", "RadiantPulse", 356548)
	self:Death("GatewardenZomazzDeath", 178392)

	-- Customs Security
	self:RegisterEngageMob("CustomsSecurityEngaged", 177807)
	self:Log("SPELL_CAST_SUCCESS", "DisruptionGrenade", 355900)
	self:Log("SPELL_CAST_SUCCESS", "HardLightBaton", 355888)
	self:Log("SPELL_CAST_SUCCESS", "Teleport", 355891)
	self:Death("CustomsSecurityDeath", 177807)

	-- Interrogation Specialist
	self:RegisterEngageMob("InterrogationSpecialistEngaged", 177816)
	self:Log("SPELL_CAST_SUCCESS", "GlyphOfRestraint", 355915)
	self:Log("SPELL_AURA_APPLIED", "GlyphOfRestraintApplied", 355915)
	self:Death("InterrogationSpecialistDeath", 177816)

	-- Armored Overseer
	self:RegisterEngageMob("ArmoredOverseerEngaged", 177808)
	self:Log("SPELL_CAST_SUCCESS", "BeamSplicer", 356001)
	self:Log("SPELL_AURA_APPLIED", "BeamSplicerApplied", 356011)
	self:Log("SPELL_AURA_APPLIED_DOSE", "BeamSplicerApplied", 356011)
	self:Death("ArmoredOverseerDeath", 177808) -- Armored Overseer

	-- Support Officer
	self:RegisterEngageMob("SupportOfficerEngaged", 177817)
	self:Log("SPELL_CAST_START", "HardLightBarrier", 355934)
	self:Log("SPELL_INTERRUPT", "HardLightBarrierInterrupt", 355934)
	self:Log("SPELL_CAST_SUCCESS", "HardLightBarrierSuccess", 355934)
	self:Log("SPELL_AURA_APPLIED", "HardLightBarrierApplied", 355934)
	self:Log("SPELL_AURA_APPLIED", "RefractionShieldApplied", 355980)
	self:Death("SupportOfficerDeath", 177817)

	-- Portalmancer Zo'honn
	self:RegisterEngageMob("PortalmancerZohonnEngaged", 179334)
	self:Log("SPELL_CAST_START", "EmpoweredGlyphOfRestraint", 356537)
	self:Death("PortalmancerZohonnDeath", 179334)

	-- Tracker Zo'korss
	self:RegisterEngageMob("TrackerZokorssEngaged", 179837)
	self:Log("SPELL_CAST_START", "ChainOfCustody", 356929)
	self:Log("SPELL_CAST_START", "Lockdown", 356942)
	self:Log("SPELL_AURA_APPLIED", "LockdownApplied", 356943)
	self:Death("TrackerZokorssDeath", 179837)

	-- Ancient Core Hound
	self:RegisterEngageMob("AncientCoreHoundEngaged", 180091)
	self:Log("SPELL_CAST_START", "LavaBreath", 356404)
	self:Log("SPELL_CAST_START", "AncientDread", 356407)
	self:Log("SPELL_AURA_APPLIED", "AncientDreadApplied", 356407)
	self:Death("AncientCoreHoundDeath", 180091)

	-- Enraged Direhorn
	self:RegisterEngageMob("EnragedDirehornEngaged", 180495)
	self:Log("SPELL_CAST_START", "FrenziedCharge", 357512)
	self:Log("SPELL_CAST_START", "WildThrash", 357508)
	self:Death("EnragedDirehornDeath", 180495)

	-- Cartel Skulker
	self:RegisterEngageMob("CartelSkulkerEngaged", 179893)
	self:Log("SPELL_CAST_START", "Quickblade", 355830)
	self:Death("CartelSkulkerDeath", 179893)

	-- Cartel Wiseguy
	self:RegisterEngageMob("CartelWiseguyEngaged", 180336)
	self:Log("SPELL_CAST_SUCCESS", "LightshardRetreat", 357197)
	self:Death("CartelWiseguyDeath", 180336)

	-- Cartel Muscle
	self:RegisterEngageMob("CartelMuscleEngaged", 180348)
	self:Log("SPELL_CAST_START", "HyperlightBackhand", 356967)
	self:Log("SPELL_CAST_START", "ChronolightEnhancer", 357229)
	self:Death("CartelMuscleDeath", 180348)

	-- Cartel Smuggler
	self:RegisterEngageMob("CartelSmugglerEngaged", 180335)
	self:Log("SPELL_CAST_SUCCESS", "HyperlightBomb", 357029)
	self:Log("SPELL_AURA_APPLIED", "HyperlightBombApplied", 357029)
	self:Log("SPELL_AURA_REMOVED", "HyperlightBombRemoved", 357029)
	self:Death("CartelSmugglerDeath", 180335)

	-- Defective Sorter
	self:Log("SPELL_CAST_START", "OpenCage", 347721)

	-- Overloaded Mailemental
	self:RegisterEngageMob("OverloadedMailementalEngaged", 176395)
	self:Log("SPELL_CAST_START", "SpamFilter", 347775)
	self:Log("SPELL_INTERRUPT", "SpamFilterInterrupt", 347775)
	self:Log("SPELL_CAST_SUCCESS", "SpamFilterSuccess", 347775)
	self:Death("OverloadedMailementalDeath", 176395)

	-- P.O.S.T. Worker
	self:RegisterEngageMob("POSTWorkerEngaged", 176394)
	self:Log("SPELL_CAST_START", "LetterOpener", 347716)
	self:Log("SPELL_CAST_SUCCESS", "LetterOpenerSuccess", 347716)
	self:Death("POSTWorkerDeath", 176394)

	-- Bazaar Overseer
	self:RegisterEngageMob("BazaarOverseerEngaged", 246285)
	self:Log("SPELL_CAST_START", "EnergizedSlam", 1240821)
	self:Log("SPELL_CAST_START", "Pierce", 1240912)
	self:Death("BazaarOverseerDeath", 246285)

	-- Market Peacekeeper
	self:RegisterEngageMob("MarketPeacekeeperEngaged", 179840)
	self:Log("SPELL_CAST_SUCCESS", "PhalanxField", 355640)
	self:Log("SPELL_CAST_SUCCESS", "QuellingStrike", 355637)
	self:Death("MarketPeacekeeperDeath", 179840)

	-- Veteran Sparkcaster
	self:RegisterEngageMob("VeteranSparkcasterEngaged", 179841)
	self:Log("SPELL_CAST_SUCCESS", "HyperlightSalvo", 355642)
	self:Death("VeteranSparkcasterDeath", 179841)

	-- Commerce Enforcer
	self:RegisterEngageMob("CommerceEnforcerEngaged", 179842)
	self:Log("SPELL_CAST_SUCCESS", "ForceMultiplier", 1244443)
	self:Log("SPELL_CAST_START", "PowerKick", 355477)
	self:Death("CommerceEnforcerDeath", 179842)

	-- Commander Zo'far
	self:RegisterEngageMob("CommanderZofarEngaged", 179821)
	self:Log("SPELL_CAST_START", "LethalForce", 355479)
	self:Log("SPELL_AURA_APPLIED", "LethalForceApplied", 355480)
	self:Log("SPELL_CAST_START", "ShockMines", 355473)
	self:Death("CommanderZofarDeath", 179821)

	------ So'leah's Gambit ------

	self:RegisterEvent("CHAT_MSG_RAID_BOSS_WHISPER") -- Blood in the Water

	-- Murkbrine Scalebinder
	self:RegisterEngageMob("MurkbrineScalebinderEngaged", 178141)
	self:Log("SPELL_CAST_SUCCESS", "InvigoratingFishStick", 355132)
	self:Death("MurkbrineScalebinderDeath", 178141)

	-- Murkbrine Fishmancer
	self:RegisterEngageMob("MurkbrineFishmancerEngaged", 178142)
	self:Log("SPELL_CAST_SUCCESS", "VolatilePufferfish", 355234)
	self:Death("MurkbrineFishmancerDeath", 178142)

	-- Murkbrine Shellcrusher
	self:RegisterEngageMob("MurkbrineShellcrusherEngaged", 178139)
	self:Log("SPELL_CAST_START", "CryOfMrrggllrrgg", 355057)
	self:Log("SPELL_INTERRUPT", "CryOfMrrggllrrggInterrupt", 355057)
	self:Log("SPELL_CAST_SUCCESS", "CryOfMrrggllrrggSuccess", 355057)
	self:Log("SPELL_AURA_APPLIED", "CryOfMrrggllrrggApplied", 355057)
	self:Log("SPELL_CAST_START", "Shellcracker", 355048)
	self:Log("SPELL_CAST_SUCCESS", "ShellcrackerSuccess", 355048)
	self:Death("MurkbrineShellcrusherDeath", 178139)

	-- Coastwalker Goliath
	self:RegisterEngageMob("CoastwalkerGoliathEngaged", 178165)
	self:Log("SPELL_CAST_START", "TidalStomp", 355429)
	self:Log("SPELL_CAST_START", "BoulderThrow", 355464)
	self:Death("CoastwalkerGoliathDeath", 178165)

	-- Stormforged Guardian
	self:RegisterEngageMob("StormforgedGuardianEngaged", 178171)
	self:Log("SPELL_CAST_START", "ChargedPulse", 355584)
	self:Log("SPELL_CAST_START", "Crackle", 355577)
	self:Log("SPELL_PERIODIC_DAMAGE", "CrackleDamage", 355581)
	self:Log("SPELL_PERIODIC_MISSED", "CrackleDamage", 355581)
	self:Death("StormforgedGuardianDeath", 178171)

	-- Burly Deckhand
	self:RegisterEngageMob("BurlyDeckhandEngaged", 180015)
	self:Log("SPELL_CAST_START", "SuperSaison", 356133)
	self:Log("SPELL_CAST_SUCCESS", "SuperSaisonSuccess", 356133)
	self:Log("SPELL_AURA_APPLIED", "SuperSaisonApplied", 356133)
	self:Death("BurlyDeckhandDeath", 180015)

	-- Hourglass Tidesage
	self:RegisterEngageMob("HourglassTidesageEngaged", 179388)
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED") -- Tidal Burst
	self:Death("HourglassTidesageDeath", 179388)

	-- Corsair Officer
	self:RegisterEngageMob("CorsairOfficerEngaged", 179386)
	self:Log("SPELL_CAST_SUCCESS", "SwordToss", 368661)
	self:Death("CorsairOfficerDeath", 179386)

	-- Adorned Starseer
	self:RegisterEngageMob("AdornedStarseerEngaged", 180429)
	self:Log("SPELL_CAST_START", "DriftingStar", 357226)
	self:Log("SPELL_CAST_START", "WanderingPulsar", 357238)
	self:Death("AdornedStarseerDeath", 180429)

	-- Focused Ritualist
	self:RegisterEngageMob("FocusedRitualistEngaged", 180431)
	self:Log("SPELL_CAST_START", "UnstableRift", 357260)
	self:Log("SPELL_INTERRUPT", "UnstableRiftInterrupt", 357260)
	self:Log("SPELL_CAST_SUCCESS", "UnstableRiftSuccess", 357260)
	self:Death("FocusedRitualistDeath", 180431)

	-- Devoted Accomplice
	self:RegisterEngageMob("DevotedAccompliceEngaged", 180432)
	self:Death("DevotedAccompliceDeath", 180432)
end

function mod:OnBossDisable()
	passwordId = nil
end

--------------------------------------------------------------------------------
-- Event Handlers
--

------ Streets of Wonder ------

function mod:CHAT_MSG_MONSTER_SAY(event, msg)
	if L.password_triggers[msg] then
		-- Market Trading Game
		passwordId = L.password_triggers[msg]
		if self:GetOption("trading_game") > 0 then
			self:Message("trading_game", "green", msg, L.trading_game_icon)
			self:PlaySound("trading_game", "info")
		end
	elseif msg == L.menagerie_warmup_trigger then
		-- Menagerie warmup
		local menagerieModule = BigWigs:GetBossModule("The Grand Menagerie", true)
		if menagerieModule then
			menagerieModule:Enable()
			menagerieModule:Warmup()
		end
	elseif msg == L.soazmi_warmup_trigger then
		-- So'azmi warmup
		local soazmiModule = BigWigs:GetBossModule("So'azmi", true)
		if soazmiModule then
			soazmiModule:Enable()
			soazmiModule:Warmup()
		end
	elseif msg == L.hylbrande_warmup_trigger then
		-- Hylbrande warmup
		local hylbrandeModule = BigWigs:GetBossModule("Hylbrande", true)
		if hylbrandeModule then
			hylbrandeModule:Enable()
			hylbrandeModule:Warmup()
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(event, msg)
	if msg == L.zophex_warmup_trigger then
		-- Zo'phex warmup
		local zophexModule = BigWigs:GetBossModule("Zo'phex the Sentinel", true)
		if zophexModule then
			zophexModule:Enable()
			zophexModule:Warmup()
		end
	end
end

-- Auto-gossip

function mod:GOSSIP_SHOW(event)
	if self:GetOption("custom_on_trading_game_autotalk") and passwordId ~= nil and self:GetGossipID(passwordId) then
		self:SelectGossipID(passwordId)
	elseif self:GetOption("custom_on_portal_autotalk") then
		if self:GetGossipID(53719) then
			-- right after Zo'phex the Sentinel
			self:SelectGossipID(53719)
		elseif self:GetGossipID(53721) then
			-- outside Myza's Oasis
			self:SelectGossipID(53721)
		elseif self:GetGossipID(53722) then
			-- outside The P.O.S.T.
			self:SelectGossipID(53722)
		elseif self:GetGossipID(53723) then
			-- before So'azmi
			self:SelectGossipID(53723)
		elseif self:GetGossipID(53724) then
			-- on the way to The Grand Menagerie
			self:SelectGossipID(53724)
		end
	end
end

-- Gatewarden Zo'mazz / Armored Overseer

do
	local prev = 0
	function mod:ProxyStrike(args)
		if self:MobId(args.sourceGUID) == 178392 then -- Gatewarden Zo'mazz
			self:GatewardenZomazzProxyStrike(args.sourceGUID)
		else -- Armored Overseer
			self:Nameplate(args.spellId, 31.5, args.sourceGUID)
		end
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

-- Gatewarden Zo'mazz / Portalmancer Zo'honn

function mod:RadiantPulse(args)
	self:Message(args.spellId, "yellow")
	if self:MobId(args.sourceGUID) == 178392 then -- Gatewarden Zo'mazz
		self:GatewardenZomazzRadiantPulse(args.sourceGUID)
	else -- 179334, Portalmancer Zo'honn
		self:PortalmancerZohonnRadiantPulse(args.sourceGUID)
	end
	self:PlaySound(args.spellId, "info")
end

-- Gatewarden Zo'mazz

do
	local timer

	function mod:GatewardenZomazzEngaged(guid)
		if timer then
			self:CancelTimer(timer)
		end
		self:CDBar(352796, 9.6) -- Proxy Strike
		self:Nameplate(352796, 9.6, guid) -- Proxy Strike
		self:CDBar(356548, 13.2) -- Radiant Pulse
		self:Nameplate(356548, 13.2, guid) -- Radiant Pulse
		timer = self:ScheduleTimer("GatewardenZomazzDeath", 20, nil, guid)
	end

	function mod:GatewardenZomazzProxyStrike(guid)
		if timer then
			self:CancelTimer(timer)
		end
		self:CDBar(352796, 25.5)
		self:Nameplate(352796, 25.5, guid)
		timer = self:ScheduleTimer("GatewardenZomazzDeath", 30, nil, guid)
	end

	function mod:GatewardenZomazzRadiantPulse(guid)
		if timer then
			self:CancelTimer(timer)
		end
		self:CDBar(356548, 24.2)
		self:Nameplate(356548, 24.2, guid)
		timer = self:ScheduleTimer("GatewardenZomazzDeath", 30, nil, guid)
	end

	function mod:GatewardenZomazzDeath(args, guidFromTimer)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(352796) -- Proxy Strike
		self:StopBar(356548) -- Radiant Pulse
		self:ClearNameplate(guidFromTimer or args.destGUID)
	end
end

-- Customs Security

function mod:CustomsSecurityEngaged(guid)
	if self:Dispeller("magic", true, 355888) then
		self:Nameplate(355888, 2.4, guid) -- Hard Light Baton
	end
	self:Nameplate(355891, 3.6, guid) -- Teleport
	self:Nameplate(355900, 10.7, guid) -- Disruption Grenade
end

do
	local prev = 0
	function mod:DisruptionGrenade(args)
		self:Nameplate(args.spellId, 18.1, args.sourceGUID)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

do
	local prev = 0
	function mod:HardLightBaton(args)
		if self:Dispeller("magic", true, args.spellId) then
			self:Nameplate(args.spellId, 18.1, args.sourceGUID)
			if args.time - prev > 3 then
				prev = args.time
				self:Message(args.spellId, "purple", CL.on:format(args.spellName, args.sourceName))
				self:PlaySound(args.spellId, "alert")
			end
		end
	end
end

do
	local prev = 0
	function mod:Teleport(args)
		self:Nameplate(args.spellId, 10.9, args.sourceGUID)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "cyan")
			self:PlaySound(args.spellId, "info")
		end
	end
end

function mod:CustomsSecurityDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Interrogation Specialist

function mod:InterrogationSpecialistEngaged(guid)
	self:Nameplate(355915, 6.0, guid) -- Glyph of Restraint
end

function mod:GlyphOfRestraint(args)
	self:Nameplate(args.spellId, 16.9, args.sourceGUID)
end

do
	local prev = 0
	function mod:GlyphOfRestraintApplied(args)
		-- can be reflected with Diffuse Magic
		if (self:Me(args.destGUID) or (self:Friendly(args.destFlags) and (self:Dispeller("magic", nil, args.spellId) or self:Dispeller("movement", nil, args.spellId)))) and args.time - prev > 2 then
			prev = args.time
			self:TargetMessage(args.spellId, "yellow", args.destName)
			self:PlaySound(args.spellId, "alert", nil, args.destName)
		end
	end
end

function mod:InterrogationSpecialistDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Armored Overseer

function mod:ArmoredOverseerEngaged(guid)
	self:Nameplate(352796, 12.1, guid) -- Proxy Strike
	self:Nameplate(356001, 7.3, guid) -- Beam Splicer
end

do
	local prev = 0
	function mod:BeamSplicer(args)
		if self:Me(args.destGUID) then
			self:Message(args.spellId, "yellow", CL.near:format(args.spellName))
		else
			self:Message(args.spellId, "yellow")
		end
		if self:MobId(args.sourceGUID) == 179837 then -- Tracker Zo'korss
			self:TrackerZokorssBeamSplicer(args.sourceGUID)
		else -- 177808, Armored Overseer
			self:Nameplate(args.spellId, 23.0, args.sourceGUID)
		end
		if args.time - prev > 2 then
			prev = args.time
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

do
	local prev = 0
	function mod:BeamSplicerApplied(args)
		if self:Me(args.destGUID) and args.time - prev > 1.5 then
			prev = args.time
			self:PersonalMessage(356001, "underyou")
			self:PlaySound(356001, "underyou")
		end
	end
end

function mod:ArmoredOverseerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Support Officer

do
	local prev = 0
	function mod:SupportOfficerEngaged(guid)
		self:Nameplate(355934, 9.4, guid) -- Hard Light Barrier
		local t = GetTime()
		if self:Dispeller("magic", true, 355980) and t - prev > 2 then -- Refraction Shield
			prev = t
			local unit = self:UnitTokenFromGUID(guid)
			if unit and self:UnitBuff(unit, 355980) then -- Refraction Shield
				self:Message(355980, "yellow", CL.magic_buff_other:format(self:UnitName(unit), self:SpellName(355980))) -- Refraction Shield
				self:PlaySound(355980, "info") -- Refraction Shield
			end
		end
	end
end

do
	local prev = 0
	function mod:HardLightBarrier(args)
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:HardLightBarrierInterrupt(args)
	self:Nameplate(355934, 21.4, args.destGUID)
end

function mod:HardLightBarrierSuccess(args)
	self:Nameplate(args.spellId, 21.4, args.sourceGUID)
end

function mod:HardLightBarrierApplied(args)
	if self:Dispeller("magic", true, args.spellId) and not self:Friendly(args.destFlags) then
		self:Message(args.spellId, "red", CL.magic_buff_other:format(args.destName, args.spellName))
		self:PlaySound(args.spellId, "info")
	end
end

function mod:RefractionShieldApplied(args)
	if self:Dispeller("magic", true, args.spellId) and not self:Friendly(args.destFlags) then
		local unit = self:UnitTokenFromGUID(args.sourceGUID)
		if unit and UnitAffectingCombat(unit) then
			self:Message(args.spellId, "yellow", CL.magic_buff_other:format(args.destName, args.spellName))
			self:PlaySound(args.spellId, "warning")
		end
	end
end

function mod:SupportOfficerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Portalmancer Zo'honn

do
	local timer

	function mod:PortalmancerZohonnEngaged(guid)
		if timer then
			self:CancelTimer(timer)
		end
		-- Radiant Pulse is cast immediately
		self:CDBar(356537, 10.6) -- Empowered Glyph Of Restraint
		self:Nameplate(356537, 10.6, guid) -- Empowered Glyph Of Restraint
		timer = self:ScheduleTimer("PortalmancerZohonnDeath", 20, nil, guid)
	end

	function mod:EmpoweredGlyphOfRestraint(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		-- cd on cast start
		self:CDBar(args.spellId, 23.0)
		self:Nameplate(args.spellId, 23.0, args.sourceGUID)
		timer = self:ScheduleTimer("PortalmancerZohonnDeath", 30, nil, args.sourceGUID)
		self:PlaySound(args.spellId, "warning")
	end

	function mod:PortalmancerZohonnRadiantPulse(guid)
		if timer then
			self:CancelTimer(timer)
		end
		if not self:IsMobEngaged(guid) then
			-- this cast can beat the engage callback, so trigger it manually
			self:PortalmancerZohonnEngaged(guid)
		else
			timer = self:ScheduleTimer("PortalmancerZohonnDeath", 30, nil, guid)
		end
		self:CDBar(356548, 26.3)
		self:Nameplate(356548, 26.3, guid)
	end

	function mod:PortalmancerZohonnDeath(args, guidFromTimer)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(356548) -- Radiant Pulse
		self:StopBar(356537) -- Empowered Glyph Of Restraint
		self:ClearNameplate(guidFromTimer or args.destGUID)
	end
end

-- Tracker Zo'korss

do
	local timer

	function mod:TrackerZokorssEngaged(guid)
		if timer then
			self:CancelTimer(timer)
		end
		self:CDBar(356001, 9.0) -- Beam Splicer
		self:Nameplate(356001, 9.0, guid) -- Beam Splicer
		self:CDBar(356942, 10.8) -- Lockdown
		self:Nameplate(356942, 10.8, guid) -- Lockdown
		timer = self:ScheduleTimer("TrackerZokorssDeath", 20, nil, guid)
	end

	function mod:ChainOfCustody(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "cyan")
		-- cast once on pull and that's it
		timer = self:ScheduleTimer("TrackerZokorssDeath", 30, nil, args.sourceGUID)
		self:PlaySound(args.spellId, "info")
	end

	function mod:TrackerZokorssBeamSplicer(guid)
		if timer then
			self:CancelTimer(timer)
		end
		self:CDBar(356001, 23.0)
		self:Nameplate(356001, 23.0, guid)
		timer = self:ScheduleTimer("TrackerZokorssDeath", 30, nil, guid)
	end

	function mod:Lockdown(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:CDBar(args.spellId, 16.9)
		self:Nameplate(args.spellId, 16.9, args.sourceGUID)
		timer = self:ScheduleTimer("TrackerZokorssDeath", 30, nil, args.sourceGUID)
		if self:Tank() then
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "alert")
		end
	end

	function mod:LockdownApplied(args)
		if self:Dispeller("magic", nil, 356942) or self:Dispeller("movement", nil, 356942) then
			self:TargetMessage(356942, "yellow", args.destName)
			self:PlaySound(356942, "alert", nil, args.destName)
		end
	end

	function mod:TrackerZokorssDeath(args, guidFromTimer)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(356942) -- Lockdown
		self:StopBar(356001) -- Beam Splicer
		self:ClearNameplate(guidFromTimer or args.destGUID)
	end
end

-- Ancient Core Hound

function mod:AncientCoreHoundEngaged(guid)
	self:Nameplate(356404, 9.3, guid) -- Lava Breath
	self:Nameplate(356407, 14.1, guid) -- Ancient Dread
end

do
	local prev = 0
	function mod:LavaBreath(args)
		self:Nameplate(args.spellId, 19.3, args.sourceGUID)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

function mod:AncientDread(args)
	-- won't be cast if the party already has Ancient Dread
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 31.4, args.sourceGUID)
	if self:Interrupter() then
		self:PlaySound(args.spellId, "warning")
	end
end

do
	local prev = 0
	function mod:AncientDreadApplied(args)
		if self:Dispeller("curse") and args.time - prev > 2 then
			prev = args.time
			-- affects the entire party
			self:Message(args.spellId, "orange", CL.on_group:format(args.spellName))
			self:PlaySound(args.spellId, "warning")
		end
	end
end

function mod:AncientCoreHoundDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Enraged Direhorn

do
	local timer

	function mod:EnragedDirehornEngaged(guid)
		if timer then
			self:CancelTimer(timer)
		end
		self:CDBar(357512, 7.9) -- Frenzied Charge
		self:Nameplate(357512, 7.9, guid) -- Frenzied Charge
		self:CDBar(357508, 13.5) -- Wild Thrash
		self:Nameplate(357508, 13.5, guid) -- Wild Thrash
		timer = self:ScheduleTimer("EnragedDirehornDeath", 20, nil, guid)
	end

	do
		local function printTarget(self, name, guid)
			self:TargetMessage(357512, "red", name)
			if self:Me(guid) then
				self:Say(357512, nil, nil, "Frenzied Charge")
				self:PlaySound(357512, "warning", nil, name)
			else
				self:PlaySound(357512, "alert", nil, name)
			end
		end

		function mod:FrenziedCharge(args)
			if timer then
				self:CancelTimer(timer)
			end
			self:CDBar(args.spellId, 18.1)
			self:Nameplate(args.spellId, 18.1, args.sourceGUID)
			self:GetUnitTarget(printTarget, 0.2, args.sourceGUID)
			timer = self:ScheduleTimer("EnragedDirehornDeath", 30, nil, args.sourceGUID)
		end
	end

	function mod:WildThrash(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "yellow")
		self:CDBar(args.spellId, 26.5)
		self:Nameplate(args.spellId, 26.5, args.sourceGUID)
		timer = self:ScheduleTimer("EnragedDirehornDeath", 30, nil, args.sourceGUID)
		self:PlaySound(args.spellId, "info")
	end

	function mod:EnragedDirehornDeath(args, guidFromTimer)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(357512) -- Frenzied Charge
		self:StopBar(357508) -- Wild Thrash
		self:ClearNameplate(guidFromTimer or args.destGUID)
	end
end

-- Cartel Skulker

function mod:CartelSkulkerEngaged(guid)
	self:Nameplate(355830, 1.8, guid) -- Quickblade
end

do
	local prev = 0
	function mod:Quickblade(args)
		self:Nameplate(args.spellId, 14.5, args.sourceGUID) -- CD on cast start
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "info")
		end
	end
end

function mod:CartelSkulkerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Cartel Wiseguy

function mod:CartelWiseguyEngaged(guid)
	self:Nameplate(357197, 9.1, guid) -- Lightshard Retreat
end

do
	local prev = 0
	function mod:LightshardRetreat(args)
		self:Nameplate(args.spellId, 14.5, args.sourceGUID)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

function mod:CartelWiseguyDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Cartel Muscle

function mod:CartelMuscleEngaged(guid)
	self:Nameplate(357229, 9.1, guid) -- Chronolight Enhancer
	self:Nameplate(356967, 27.7, guid) -- Hyperlight Backhand
end

function mod:HyperlightBackhand(args)
	self:Message(args.spellId, "purple")
	self:Nameplate(args.spellId, 31.4, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:ChronolightEnhancer(args)
	self:Message(args.spellId, "red")
	self:Nameplate(args.spellId, 31.4, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:CartelMuscleDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Cartel Smuggler

function mod:CartelSmugglerEngaged(guid)
	self:Nameplate(357029, 4.8, guid) -- Hyperlight Bomb
end

function mod:HyperlightBomb(args)
	self:Nameplate(args.spellId, 18.1, args.sourceGUID)
end

do
	local prev = 0
	function mod:HyperlightBombApplied(args)
		self:TargetMessage(args.spellId, "yellow", args.destName)
		if self:Me(args.destGUID) and args.time - prev > 5 then
			prev = args.time
			self:Say(args.spellId, CL.bomb, nil, "Bomb")
			self:SayCountdown(args.spellId, 5)
		end
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:HyperlightBombRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
end

function mod:CartelSmugglerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Defective Sorter

function mod:OpenCage(args)
	-- this will only be cast if the Defective Sorter is close to a cage
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "warning")
end

-- Overloaded Mailemental

function mod:OverloadedMailementalEngaged(guid)
	self:Nameplate(347775, 13.2, guid) -- Spam Filter
end

do
	local prev = 0
	function mod:SpamFilter(args)
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:SpamFilterInterrupt(args)
	self:Nameplate(347775, 22.2, args.destGUID)
end

function mod:SpamFilterSuccess(args)
	self:Nameplate(args.spellId, 22.2, args.sourceGUID)
end

function mod:OverloadedMailementalDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- P.O.S.T. Worker

function mod:POSTWorkerEngaged(guid)
	self:Nameplate(347716, 9.2, guid) -- Letter Opener
end

do
	local prev = 0
	function mod:LetterOpener(args)
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:LetterOpenerSuccess(args)
	self:Nameplate(args.spellId, 25.1, args.sourceGUID)
end

function mod:POSTWorkerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Bazaar Overseer

function mod:BazaarOverseerEngaged(guid)
	self:Nameplate(1240821, 8.4, guid) -- Energized Slam
	self:Nameplate(1240912, 15.3, guid) -- Pierce
end

function mod:EnergizedSlam(args)
	-- target aura 1240820 is hidden
	self:Message(args.spellId, "yellow")
	self:Nameplate(args.spellId, 23.0, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:Pierce(args)
	self:Message(args.spellId, "purple")
	self:Nameplate(args.spellId, 21.8, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:BazaarOverseerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Market Peacekeeper

function mod:MarketPeacekeeperEngaged(guid)
	self:Nameplate(355637, 3.5, guid) -- Quelling Strike
	self:Nameplate(355640, 9.5, guid) -- Phalanx Field
end

do
	local prev = 0
	function mod:PhalanxField(args)
		self:Nameplate(args.spellId, 30.2, args.sourceGUID)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "info")
		end
	end
end

function mod:QuellingStrike(args)
	self:TargetMessage(args.spellId, "orange", args.destName)
	self:Nameplate(args.spellId, 15.7, args.sourceGUID)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
end

function mod:MarketPeacekeeperDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Veteran Sparkcaster

function mod:VeteranSparkcasterEngaged(guid)
	self:Nameplate(355642, 11.8, guid) -- Hyperlight Salvo
end

do
	local prev = 0
	function mod:HyperlightSalvo(args)
		self:Nameplate(args.spellId, 23.0, args.sourceGUID)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:VeteranSparkcasterDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Commerce Enforcer

function mod:CommerceEnforcerEngaged(guid)
	self:Nameplate(355477, 7.1, guid) -- Power Kick
	self:Nameplate(1244443, 17.2, guid) -- Force Multiplier
end

function mod:ForceMultiplier(args)
	self:Message(args.spellId, "yellow")
	self:Nameplate(args.spellId, 29.1, args.sourceGUID)
	self:PlaySound(args.spellId, "info")
end

function mod:PowerKick(args)
	self:Message(args.spellId, "purple")
	if self:MobId(args.sourceGUID) == 179821 then -- Commander Zo'far
		self:CommanderZofarPowerKick(args.sourceGUID)
	else
		self:Nameplate(args.spellId, 14.5, args.sourceGUID)
	end
	self:PlaySound(args.spellId, "alert")
end

function mod:CommerceEnforcerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Commander Zo'far

do
	local timer

	function mod:CommanderZofarEngaged(guid)
		if timer then
			self:CancelTimer(timer)
		end
		self:CDBar(355473, 3.4) -- Shock Mines
		self:Nameplate(355473, 3.4, guid) -- Shock Mines
		if not self:Solo() then
			self:CDBar(355479, 5.8) -- Lethal Force
			self:Nameplate(355479, 5.8, guid) -- Lethal Force
		end
		self:CDBar(355477, 8.0) -- Power Kick
		self:Nameplate(355477, 8.0, guid) -- Power Kick
		timer = self:ScheduleTimer("CommanderZofarDeath", 20, nil, guid)
	end

	function mod:CommanderZofarPowerKick(guid)
		if timer then
			self:CancelTimer(timer)
		end
		self:CDBar(355477, 9.6)
		self:Nameplate(355477, 9.6, guid)
		timer = self:ScheduleTimer("CommanderZofarDeath", 30, nil, guid)
	end

	do
		local playerList = {}
		local onMe = false

		function mod:LethalForce(args)
			if timer then
				self:CancelTimer(timer)
			end
			playerList = {}
			onMe = false
			self:CDBar(args.spellId, 13.3)
			self:Nameplate(args.spellId, 13.3, args.sourceGUID)
			timer = self:ScheduleTimer("CommanderZofarDeath", 30, nil, args.sourceGUID)
		end

		-- This debuff applies to two players at once, who will be pulled towards each other.
		-- If they touch they take a lot of damage.
		function mod:LethalForceApplied(args)
			playerList[#playerList + 1] = args.destName
			if self:Me(args.destGUID) then
				if #playerList > 1 then
					self:PersonalMessage(355479, false, CL.link_with:format(self:ColorName(playerList[1])))
					self:PlaySound(355479, "warning")
				else
					onMe = true
				end
			else
				if onMe then
					self:PersonalMessage(355479, false, CL.link_with:format(self:ColorName(args.destName)))
					self:PlaySound(355479, "warning")
				elseif #playerList > 1 then
					self:Message(355479, "red", CL.link_both:format(self:ColorName(playerList[1]), self:ColorName(playerList[2])))
					self:PlaySound(355479, "alert")
				end
			end
		end
	end

	function mod:ShockMines(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		self:CDBar(args.spellId, 26.5)
		self:Nameplate(args.spellId, 26.5, args.sourceGUID)
		timer = self:ScheduleTimer("CommanderZofarDeath", 30, nil, args.sourceGUID)
		self:PlaySound(args.spellId, "alarm")
	end

	function mod:CommanderZofarDeath(args, guidFromTimer)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(355473) -- Shock Mines
		self:StopBar(355477) -- Power Kick
		self:StopBar(355479) -- Lethal Force
		self:ClearNameplate(guidFromTimer or args.destGUID)
	end
end

------ So'leah's Gambit ------

function mod:HylbrandeDefeated()
	-- 222.90 [ENCOUNTER_END] 2426#Hylbrande
	-- 223.07 [CHAT_MSG_MONSTER_YELL] That artifact... will... end you all...#Hylbrande
	-- 232.52 [CHAT_MSG_MONSTER_SAY] So'leah's arrogance will be her downfall.#Al'dalil
	-- 237.29 [ZONE_CHANGED] Tazavesh, the Veiled Market#Tazavesh, the Veiled Market#Boralus Harbor
	-- 237.43 [CHAT_MSG_MONSTER_EMOTE] The instance updated the respawn location.#Waystone
	self:Bar("portal_open", 15.0, L.portal_open, L.portal_open_icon)
end

function mod:TimecapnHooktailDefeated()
	-- 27.70 [ENCOUNTER_END] 2419#Timecap'n Hooktail#23#5#1
	-- 38.71 [CHAT_MSG_MONSTER_SAY] Let us depart before the Kul Tirans ask questions we lack time to answer.#Al'dalil
	-- 44.01 [ZONE_CHANGED] Tazavesh, the Veiled Market#Tazavesh, the Veiled Market
	self:Bar("portal_open", 15.0, L.portal_open, L.portal_open_icon)
end

-- Blood in the Water

function mod:CHAT_MSG_RAID_BOSS_WHISPER(event, msg)
	-- the debuff for Blood in the Water (358443) is a hidden aura that does not fire the SPELL_AURA events
	if msg:find("INV_Pet_BabyShark", nil, true) then
		self:Bar(358443, 5.25) -- Blood in the Water
	end
end

-- Murkbrine Scalebinder

function mod:MurkbrineScalebinderEngaged(guid)
	self:Nameplate(355132, 8.4, guid) -- Invigorating Fish Stick
end

function mod:InvigoratingFishStick(args)
	self:Message(args.spellId, "cyan", CL.spawned:format(args.spellName))
	self:Nameplate(args.spellId, 27.5, args.sourceGUID)
	self:PlaySound(args.spellId, "info")
end

function mod:MurkbrineScalebinderDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Murkbrine Shellcrusher

function mod:MurkbrineShellcrusherEngaged(guid)
	-- Cry of Mrrggllrrgg is not cast until 50%
	self:Nameplate(355048, 9.6, guid) -- Shellcracker
end

do
	local prev = 0
	function mod:CryOfMrrggllrrgg(args)
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:CryOfMrrggllrrggInterrupt(args)
	self:Nameplate(355057, 30.9, args.destGUID)
end

function mod:CryOfMrrggllrrggSuccess(args)
	self:Nameplate(args.spellId, 30.9, args.sourceGUID)
end

do
	local prev = 0
	function mod:CryOfMrrggllrrggApplied(args)
		if self:Dispeller("enrage", true, args.spellId) and args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "yellow", CL.buff_other:format(args.destName, args.spellName))
			self:PlaySound(args.spellId, "warning")
		end
	end
end

do
	local prev = 0
	function mod:Shellcracker(args)
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:ShellcrackerSuccess(args)
	self:Nameplate(args.spellId, 14.2, args.sourceGUID)
end

function mod:MurkbrineShellcrusherDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Murkbrine Fishmancer

function mod:MurkbrineFishmancerEngaged(guid)
	self:Nameplate(355234, 7.3, guid) -- Volatile Pufferfish
end

do
	local prev = 0
	function mod:VolatilePufferfish(args)
		self:Nameplate(args.spellId, 16.9, args.sourceGUID)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

function mod:MurkbrineFishmancerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Coastwalker Goliath

function mod:CoastwalkerGoliathEngaged(guid)
	self:Nameplate(355464, 9.4, guid) -- Boulder Throw
	self:Nameplate(355429, 15.4, guid) -- Tidal Stomp
end

function mod:TidalStomp(args)
	self:Message(args.spellId, "yellow")
	self:Nameplate(args.spellId, 23.0, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:BoulderThrow(args)
	self:Message(args.spellId, "orange")
	self:Nameplate(args.spellId, 19.3, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:CoastwalkerGoliathDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Stormforged Guardian

function mod:StormforgedGuardianEngaged(guid)
	self:Nameplate(355577, 3.4, guid) -- Crackle
	self:Nameplate(355584, 9.5, guid) -- Charged Pulse
end

do
	local prev = 0
	function mod:ChargedPulse(args)
		self:Nameplate(args.spellId, 20.5, args.sourceGUID)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

do
	local prev = 0
	function mod:Crackle(args)
		self:Nameplate(args.spellId, 8.5, args.sourceGUID)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

do
	local prev = 0
	function mod:CrackleDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 2 then
			prev = args.time
			self:PersonalMessage(355577, "underyou")
			self:PlaySound(355577, "underyou")
		end
	end
end

function mod:StormforgedGuardianDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Burly Deckhand

function mod:BurlyDeckhandEngaged(guid)
	if self:Tank() or self:Dispeller("enrage", true, 356133) then
		self:Nameplate(356133, 7.1, guid) -- Super Saison
	end
end

do
	local prev = 0
	function mod:SuperSaison(args)
		if self:Tank() or self:Dispeller("enrage", true, args.spellId) then
			self:Nameplate(args.spellId, 0, args.sourceGUID)
			if args.time - prev > 2 then
				prev = args.time
				self:Message(args.spellId, "purple")
				self:PlaySound(args.spellId, "alert")
			end
		end
	end
end

function mod:SuperSaisonSuccess(args)
	if self:Tank() or self:Dispeller("enrage", true, args.spellId) then
		self:Nameplate(args.spellId, 30.3, args.sourceGUID)
	end
end

do
	local prev = 0
	function mod:SuperSaisonApplied(args)
		if (self:Tank() or self:Dispeller("enrage", true, args.spellId)) and args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "red", CL.buff_other:format(args.destName, args.spellName))
			self:PlaySound(args.spellId, "warning")
		end
	end
end

function mod:BurlyDeckhandDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Hourglass Tidesage

function mod:HourglassTidesageEngaged(guid)
	self:Nameplate(1244650, 7.1, guid, 132852) -- Tidal Burst, fileID for L["1244650_icon"]
end

do
	local prevCast, prev = nil, 0
	function mod:UNIT_SPELLCAST_SUCCEEDED(_, unit, castGUID, spellId)
		if spellId == 1244650 and castGUID ~= prevCast then -- Tidal Burst
			prevCast = castGUID
			local sourceGUID = self:UnitGUID(unit)
			if sourceGUID then
				self:Nameplate(spellId, 18.2, sourceGUID, 132852) -- fileID for L["1244650_icon"]
			end
			local t = GetTime()
			if t - prev > 2 then
				prev = t
				self:Message(spellId, "orange", nil, L["1244650_icon"])
				self:PlaySound(spellId, "alarm")
			end
		end
	end
end

function mod:HourglassTidesageDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Corsair Officer

function mod:CorsairOfficerEngaged(guid)
	self:Nameplate(368661, 8.3, guid) -- Sword Toss
end

do
	local prev = 0
	function mod:SwordToss(args)
		self:Nameplate(args.spellId, 14.5, args.sourceGUID)
		if args.time - prev > 2 then
			prev = args.time
			self:TargetMessage(args.spellId, "yellow", args.destName)
			self:PlaySound(args.spellId, "alert", nil, args.destName)
		end
	end
end

function mod:CorsairOfficerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Adorned Starseer

function mod:AdornedStarseerEngaged(guid)
	self:Nameplate(357226, 6.8, guid) -- Drifting Star
	self:Nameplate(357238, 12.0, guid) -- Wandering Pulsar
end

do
	local prev = 0
	function mod:DriftingStar(args)
		self:Nameplate(args.spellId, 16.9, args.sourceGUID)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

function mod:WanderingPulsar(args)
	self:Message(args.spellId, "cyan", CL.spawning:format(args.spellName))
	self:Nameplate(args.spellId, 26.6, args.sourceGUID)
	self:PlaySound(args.spellId, "info")
end

function mod:AdornedStarseerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Focused Ritualist

function mod:FocusedRitualistEngaged(guid)
	self:Nameplate(357260, 9.5, guid) -- Unstable Rift
end

do
	local prev = 0
	function mod:UnstableRift(args)
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "warning")
		end
	end
end

function mod:UnstableRiftInterrupt(args)
	self:Nameplate(357260, 21.4, args.destGUID)
end

function mod:UnstableRiftSuccess(args)
	self:Nameplate(args.spellId, 21.4, args.sourceGUID)
end

function mod:FocusedRitualistDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Devoted Accomplice

function mod:DevotedAccompliceEngaged(guid)
	self:Nameplate(355891, 3.4, guid) -- Teleport
end

function mod:DevotedAccompliceDeath(args)
	self:ClearNameplate(args.destGUID)
end
