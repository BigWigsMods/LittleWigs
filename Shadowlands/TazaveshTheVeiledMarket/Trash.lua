--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Tazavesh Trash", 2441)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	------ Streets of Wonder ------
	178392, -- Gatewarden Zo'mazz
	177816, -- Interrogation Specialist
	179334, -- Portalmancer Zo'honn
	177808, -- Armored Overseer
	179837, -- Tracker Zo'korss
	180091, -- Ancient Core Hound
	180495, -- Enraged Direhorn
	180348, -- Cartel Muscle
	180335, -- Cartel Smuggler
	177817, -- Support Officer
	176396, -- Defective Sorter
	179840, -- Market Peacekeeper
	179841, -- Veteran Sparkcaster
	179842, -- Commerce Enforcer
	179821, -- Commander Zo'far

	------ So'leah's Gambit ------
	178141, -- Murkbrine Scalebinder
	178139, -- Murkbrine Shellcrusher
	178165, -- Coastwalker Goliath
	178171, -- Stormforged Guardian
	180015, -- Burly Deckhand
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
	L.menagerie_warmup_trigger = "Now for the item you have all been awaiting! The allegedly demon-cursed Edge of Oblivion!"
	L.soazmi_warmup_trigger = "Excuse our intrusion, So'leah. I hope we caught you at an inconvenient time."
	L.portal_authority = "Tazavesh Portal Authority"
	L.custom_on_portal_autotalk = "Autotalk"
	L.custom_on_portal_autotalk_desc = "Instantly open portals back to the entrance when talking to Broker NPCs."
	L.custom_on_portal_autotalk_icon = "ui_chat"
	L.trading_game = "Trading Game"
	L.trading_game_desc = "Alerts with the right password during the Trading Game."
	L.custom_on_trading_game_autotalk = "Autotalk"
	L.custom_on_trading_game_autotalk_desc = "Instantly select the right password after the Trading Game has been completed."
	L.custom_on_trading_game_autotalk_icon = "ui_chat"
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
	L.interrogation_specialist = "Interrogation Specialist"
	L.portalmancer_zohonn = "Portalmancer Zo'honn"
	L.armored_overseer_tracker_zokorss = "Armored Overseer / Tracker Zo'korss"
	L.tracker_zokorss = "Tracker Zo'korss"
	L.ancient_core_hound = "Ancient Core Hound"
	L.enraged_direhorn = "Enraged Direhorn"
	L.cartel_muscle = "Cartel Muscle"
	L.cartel_smuggler = "Cartel Smuggler"
	L.support_officer = "Support Officer"
	L.defective_sorter = "Defective Sorter"
	L.market_peacekeeper = "Market Peacekeeper"
	L.veteran_sparkcaster = "Veteran Sparkcaster"
	L.commerce_enforcer = "Commerce Enforcer"
	L.commerce_enforcer_commander_zofar = "Commerce Enforcer / Commander Zo'far"
	L.commander_zofar = "Commander Zo'far"

	------ So'leah's Gambit ------
	L.tazavesh_soleahs_gambit = "Tazavesh: So'leah's Gambit"
	L.murkbrine_scalebinder = "Murkbrine Scalebinder"
	L.murkbrine_shellcrusher = "Murkbrine Shellcrusher"
	L.coastwalker_goliath = "Coastwalker Goliath"
	L.stormforged_guardian = "Stormforged Guardian"
	L.burly_deckhand = "Burly Deckhand"
	L.adorned_starseer = "Adorned Starseer"
	L.focused_ritualist = "Focused Ritualist"
	L.devoted_accomplice = "Devoted Accomplice"
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
		-- Interrogation Specialist
		356031, -- Stasis Beam
		-- Portalmancer Zo'honn
		356324, -- Empowered Glyph of Restraint
		356548, -- Radiant Pulse
		-- Armored Overseer / Tracker Zo'korss
		356001, -- Beam Splicer
		-- Tracker Zo'korss
		356929, -- Chain of Custody
		{356942, "DISPEL"}, -- Lockdown
		-- Ancient Core Hound
		356404, -- Lava Breath
		356407, -- Ancient Dread
		-- Enraged Direhorn
		{357512, "SAY"}, -- Frenzied Charge
		-- Cartel Muscle
		{356967, "TANK_HEALER"}, -- Hyperlight Backhand
		-- Cartel Smuggler
		{357029, "SAY", "SAY_COUNTDOWN"}, -- Hyperlight Bomb
		-- Support Officer
		355980, -- Refraction Shield
		{355934, "DISPEL"}, -- Hard Light Barrier
		-- Defective Sorter
		347721, -- Open Cage
		-- Market Peacekeeper
		355637, -- Quelling Strike
		-- Veteran Sparkcaster
		355642, -- Hyperlight Salvo
		-- Commerce Enforcer
		355782, -- Force Multiplier
		-- Commerce Enforcer / Commander Zo'far
		{355477, "TANK_HEALER"}, -- Power Kick
		-- Commander Zo'far
		355480, -- Lethal Force

		------ So'leah's Gambit ------
		-- General
		358443, -- Blood in the Water
		-- Murkbrine Scalebinder
		{355132, "NAMEPLATEBAR"}, -- Invigorating Fish Stick
		-- Murkbrine Shellcrusher
		355057, -- Cry of Mrrggllrrgg
		-- Coastwalker Goliath
		355429, -- Tidal Stomp
		-- Stormforged Guardian
		355584, -- Charged Pulse
		355577, -- Crackle
		-- Burly Deckhand
		356133, -- Super Saison
		-- Adorned Starseer
		357226, -- Drifting Star
		357238, -- Wandering Pulsar
		-- Focused Ritualist
		357260, -- Unstable Rift
		-- Devoted Accomplice
		357284, -- Reinvigorate
	}, {
		------ Streets of Wonder ------
		["custom_on_portal_autotalk"] = L.portal_authority,
		["trading_game"] = L.trading_game,
		[356031] = L.interrogation_specialist,
		[356324] = L.portalmancer_zohonn,
		[356001] = L.armored_overseer_tracker_zokorss,
		[356929] = L.tracker_zokorss,
		[356404] = L.ancient_core_hound,
		[357512] = L.enraged_direhorn,
		[356967] = L.cartel_muscle,
		[357029] = L.cartel_smuggler,
		[355980] = L.support_officer,
		[347721] = L.defective_sorter,
		[355637] = L.market_peacekeeper,
		[355642] = L.veteran_sparkcaster,
		[355782] = L.commerce_enforcer,
		[355477] = L.commerce_enforcer_commander_zofar,
		[355480] = L.commander_zofar,

		------ So'leah's Gambit ------
		[358443] = L.tazavesh_soleahs_gambit,
		[355132] = L.murkbrine_scalebinder,
		[355057] = L.murkbrine_shellcrusher,
		[355429] = L.coastwalker_goliath,
		[355584] = L.stormforged_guardian,
		[356133] = L.burly_deckhand,
		[357226] = L.adorned_starseer,
		[357260] = L.focused_ritualist,
		[357284] = L.devoted_accomplice,
	}
end

function mod:OnBossEnable()
	passwordId = nil

	------ Streets of Wonder ------
	self:RegisterEvent("CHAT_MSG_MONSTER_SAY")
	self:RegisterEvent("GOSSIP_SHOW")
	self:Log("SPELL_CAST_START", "StasisBeam", 356031)
	self:Log("SPELL_CAST_START", "EmpoweredGlyphOfRestraint", 356537)
	self:Log("SPELL_CAST_START", "RadiantPulse", 356548)
	self:Death("RadiantPulseCasterDeath", 178392, 179334)
	self:Log("SPELL_CAST_SUCCESS", "BeamSplicer", 356001)
	self:Log("SPELL_AURA_APPLIED", "BeamSplicerApplied", 356011)
	self:Log("SPELL_AURA_APPLIED_DOSE", "BeamSplicerApplied", 356011)
	self:Log("SPELL_CAST_START", "ChainOfCustody", 356929)
	self:Log("SPELL_CAST_START", "Lockdown", 356942)
	self:Log("SPELL_AURA_APPLIED", "LockdownApplied", 356943)
	self:Log("SPELL_CAST_START", "LavaBreath", 356404)
	self:Log("SPELL_CAST_START", "AncientDread", 356407)
	self:Log("SPELL_AURA_APPLIED", "AncientDreadApplied", 356407)
	self:Log("SPELL_CAST_START", "FrenziedCharge", 357512)
	self:Log("SPELL_CAST_START", "HyperlightBackhand", 356967)
	self:Log("SPELL_AURA_APPLIED", "HyperlightBombApplied", 357029)
	self:Log("SPELL_AURA_REMOVED", "HyperlightBombRemoved", 357029)
	self:Log("SPELL_AURA_APPLIED", "RefractionShieldApplied", 355980)
	self:Log("SPELL_CAST_START", "HardLightBarrier", 355934)
	self:Log("SPELL_AURA_APPLIED", "HardLightBarrierApplied", 355934)
	self:Log("SPELL_CAST_START", "OpenCage", 347721)
	self:Log("SPELL_CAST_START", "QuellingStrike", 355637)
	self:Log("SPELL_CAST_START", "HyperlightSalvo", 355642)
	self:Log("SPELL_AURA_APPLIED", "ForceMultiplierApplied", 355782)
	self:Log("SPELL_CAST_START", "PowerKick", 355477)
	self:Log("SPELL_AURA_APPLIED", "LethalForceApplied", 355480)
	self:Log("SPELL_AURA_REMOVED", "LethalForceRemoved", 355480)

	------ So'leah's Gambit ------
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_WHISPER")
	self:RegisterEvent("UNIT_TARGET")
	self:Log("SPELL_CAST_START", "InvigoratingFishStick", 355132)
	self:Log("SPELL_CAST_SUCCESS", "InvigoratingFishStickSpawned", 355132)
	self:Log("SPELL_CAST_START", "CryofMrrggllrrgg", 355057)
	self:Log("SPELL_AURA_APPLIED", "CryofMrrggllrrggApplied", 355057)
	self:Log("SPELL_CAST_START", "TidalStomp", 355429)
	self:Log("SPELL_CAST_START", "ChargedPulse", 355584)
	self:Log("SPELL_CAST_START", "Crackle", 355577)
	self:Log("SPELL_AURA_APPLIED", "CrackleDamage", 355581)
	self:Log("SPELL_PERIODIC_DAMAGE", "CrackleDamage", 355581)
	self:Log("SPELL_PERIODIC_MISSED", "CrackleDamage", 355581)
	self:Log("SPELL_CAST_START", "SuperSaison", 356133)
	self:Log("SPELL_AURA_APPLIED", "SuperSaisonApplied", 356133)
	self:Log("SPELL_CAST_START", "DriftingStar", 357226)
	self:Log("SPELL_CAST_SUCCESS", "WanderingPulsar", 357238)
	self:Log("SPELL_CAST_START", "UnstableRift", 357260)
	self:Log("SPELL_CAST_START", "Reinvigorate", 357284)
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
			self:Message("trading_game", "green", msg, "achievement_dungeon_brokerdungeon")
			self:PlaySound("trading_game", "info")
		end
	elseif msg == L.menagerie_warmup_trigger then
		-- Menagerie 1st boss Warmup
		local menagerieModule = BigWigs:GetBossModule("The Grand Menagerie", true)
		if menagerieModule then
			menagerieModule:Enable()
			menagerieModule:Warmup()
		end
	elseif msg == L.soazmi_warmup_trigger then
		-- So'azmi Warmup
		local soazmiModule = BigWigs:GetBossModule("So'azmi", true)
		if soazmiModule then
			soazmiModule:Enable()
			soazmiModule:Warmup()
		end
	end
end

-- Auto-gossip
function mod:GOSSIP_SHOW(event)
	if self:GetOption("custom_on_trading_game_autotalk") and passwordId ~= nil and self:GetGossipID(passwordId) then
		self:SelectGossipID(passwordId)
	elseif self:GetOption("custom_on_portal_autotalk") then
		if self:GetGossipID(53719) then
			-- right after first boss
			self:SelectGossipID(53719)
		elseif self:GetGossipID(53721) then
			-- outside myza's oasis
			self:SelectGossipID(53721)
		elseif self:GetGossipID(53722) then
			-- outside the p.o.s.t.
			self:SelectGossipID(53722)
		elseif self:GetGossipID(53723) then
			-- before so'azmi
			self:SelectGossipID(53723)
		elseif self:GetGossipID(53724) then
			-- on the way to grand menagerie
			self:SelectGossipID(53724)
		end
	end
end

-- Interrogation Specialist
function mod:StasisBeam(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Portalmancer Zo'honn
function mod:EmpoweredGlyphOfRestraint(args)
	self:Message(356324, "red", CL.casting:format(args.spellName))
	self:PlaySound(356324, "warning")
	self:CDBar(356324, 21.9)
end
function mod:RadiantPulse(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	if self:MobId(args.sourceGUID) == 178392 then
		self:CDBar(args.spellId, 18.2) -- Gatewarden Zo'mazz
	else
		self:CDBar(args.spellId, 26.7) -- Portalmancer Zo'honn
	end
end
function mod:RadiantPulseCasterDeath(args)
	if args.mobId == 179334 then -- Portalmancer Zo'honn
		self:StopBar(356324) -- Empowered Glyph Of Restraint
	end
	self:StopBar(356548) -- Radiant Pulse
end

-- Armored Overseer / Tracker Zo'korss
function mod:BeamSplicer(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "orange", CL.near:format(args.spellName))
	else
		self:Message(args.spellId, "orange")
	end
	self:PlaySound(args.spellId, "warning")
end
do
	local prev = 0
	function mod:BeamSplicerApplied(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 1 then
				prev = t
				self:PersonalMessage(356001, "underyou")
				self:PlaySound(356001, "underyou")
			end
		end
	end
end

-- Tracker Zo'korss
function mod:ChainOfCustody(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "info")
end
function mod:Lockdown(args)
	if self:Tank() then
		self:Message(args.spellId, "purple", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alert")
	end
end
function mod:LockdownApplied(args)
	if self:Dispeller("magic", nil, 356942) or self:Dispeller("movement", nil, 356942) then
		self:TargetMessage(356942, "yellow", args.destName)
		self:PlaySound(356942, "alert")
	end
end

-- Ancient Core Hound
function mod:LavaBreath(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
end
function mod:AncientDread(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, self:Interrupter() and "warning" or "alert")
end
do
	local prev = 0
	function mod:AncientDreadApplied(args)
		if self:Dispeller("curse") then
			local t = args.time
			if t - prev > 1 then
				prev = t
				self:Message(args.spellId, "orange", CL.buff_other:format(args.destName, args.spellName))
				self:PlaySound(args.spellId, "warning")
			end
		end
	end
end

-- Enraged Direhorn
do
	local function printTarget(self, name, guid)
		local onMe = self:Me(guid)
		self:TargetMessage(357512, "red", name)
		self:PlaySound(357512, onMe and "warning" or "alert", nil, name)
		if onMe then
			self:Say(357512, nil, nil, "Frenzied Charge")
		end
	end
	function mod:FrenziedCharge(args)
		self:GetUnitTarget(printTarget, 0.2, args.sourceGUID)
	end
end

-- Cartel Muscle
function mod:HyperlightBackhand(args)
	self:Message(args.spellId, "purple", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Cartel Smuggler
do
	local prev = 0
	function mod:HyperlightBombApplied(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:PersonalMessage(args.spellId)
				self:PlaySound(args.spellId, "alarm")
				self:Say(args.spellId, CL.bomb, nil, "Bomb")
				self:SayCountdown(args.spellId, 5)
			end
		end
	end
end
function mod:HyperlightBombRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
end

-- Support Officer
function mod:RefractionShieldApplied(args)
	if not self:Player(args.destFlags) then
		local unit = self:UnitTokenFromGUID(args.sourceGUID)
		if unit and UnitAffectingCombat(unit) then
			self:Message(args.spellId, "yellow", CL.on:format(args.spellName, args.destName))
			self:PlaySound(args.spellId, "warning")
		end
	end
end
function mod:HardLightBarrier(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end
function mod:HardLightBarrierApplied(args)
	if self:Dispeller("magic", true) and not self:Player(args.destFlags) then
		self:Message(args.spellId, "red", CL.buff_other:format(args.destName, args.spellName))
		self:PlaySound(args.spellId, "warning")
	end
end

-- Defective Sorter
function mod:OpenCage(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "warning")
end

-- Market Peacekeeper
do
	local function printTarget(self, name, guid)
		local isOnMe = self:Me(guid)
		self:TargetMessage(355637, "yellow", name)
		self:PlaySound(355637, isOnMe and "warning" or "info", nil, name)
	end

	function mod:QuellingStrike(args)
		self:GetUnitTarget(printTarget, 0.1, args.sourceGUID)
	end
end

-- Veteran Sparkcaster
function mod:HyperlightSalvo(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

-- Commerce Enforcer
function mod:ForceMultiplierApplied(args)
	self:Message(args.spellId, "red", CL.buff_other:format(args.destName, args.spellName))
	self:PlaySound(args.spellId, "warning")
end

-- Commerce Enforcer / Commander Zo'far
function mod:PowerKick(args)
	self:Message(args.spellId, "purple", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Commander Zo'far
do
	local playerList = {}
	local onMe = false
	-- This debuff applies to two players at once, who will be pulled towards each other.
	-- If they touch they take a lot of damage.
	function mod:LethalForceApplied(args)
		local count = #playerList+1
		playerList[count] = args.destName
		if self:Me(args.destGUID) then
			if #playerList > 1 then
				local partner = playerList[1]
				self:PersonalMessage(args.spellId, false, CL.link_with:format(self:ColorName(partner)))
				self:PlaySound(args.spellId, "warning")
			else
				onMe = true
			end
		else
			if onMe then
				local partner = args.destName
				self:PersonalMessage(args.spellId, false, CL.link_with:format(self:ColorName(partner)))
				self:PlaySound(args.spellId, "warning")
			elseif #playerList > 1 then
				self:Message(args.spellId, "red", CL.link_both:format(playerList[1], playerList[2]))
				self:PlaySound(args.spellId, "alert")
			end
		end
	end

	function mod:LethalForceRemoved()
		playerList = {}
		onMe = false
	end
end

------ So'leah's Gambit ------

-- Blood in the Water
function mod:CHAT_MSG_RAID_BOSS_WHISPER(event, msg)
	-- the debuff for Blood in the Water (358443) is a hidden aura that does not fire the SPELL_AURA events
	if msg:find("INV_Pet_BabyShark", nil, true) then
		self:Bar(358443, 5.25) -- Blood in the Water
	end
end

-- Murkbrine Scalebinder
do
	local registeredMobs = {}

	function mod:UNIT_TARGET(event, unit)
		local sourceGUID = self:UnitGUID(unit)
		local mobId = self:MobId(sourceGUID)
		-- we only want to show the initial CD bar if it's the first time the mob has ever targeted anything.
		-- we're using UNIT_TARGET as a proxy for the Scalebinder entering combat.
		if mobId == 178141 and not registeredMobs[sourceGUID] then -- Murkbrine Scalebinder
			registeredMobs[sourceGUID] = true
			self:NameplateCDBar(355132, 7.2, sourceGUID) -- Invigorating Fish Stick
		end
	end
	function mod:InvigoratingFishStick(args)
		self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alert")

		-- if for some reason this mob isn't registered already, register it so this bar won't be overwritten
		registeredMobs[args.sourceGUID] = true
		self:NameplateCDBar(args.spellId, 27.9, args.sourceGUID)
	end
end
function mod:InvigoratingFishStickSpawned(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
end

-- Murkbrine Shellcrusher
function mod:CryofMrrggllrrgg(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end
do
	local prev = 0
	function mod:CryofMrrggllrrggApplied(args)
		if self:Tank() or self:Healer() or self:Dispeller("enrage", true) then
			local t = args.time
			if t - prev > 1 then
				prev = t
				self:Message(args.spellId, "red", CL.buff_other:format(args.destName, args.spellName))
				self:PlaySound(args.spellId, "warning")
			end
		end
	end
end

-- Coastwalker Goliath
function mod:TidalStomp(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
	self:CDBar(args.spellId, 17)
end

-- Stormforged Guardian
function mod:ChargedPulse(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end
function mod:Crackle(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end
do
	local prev = 0
	function mod:CrackleDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:PersonalMessage(355577, "underyou")
				self:PlaySound(355577, "underyou")
			end
		end
	end
end

-- Burly Deckhand
function mod:SuperSaison(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end
function mod:SuperSaisonApplied(args)
	if self:Tank() or self:Healer() or self:Dispeller("enrage", true) then
		self:Message(args.spellId, "red", CL.buff_other:format(args.destName, args.spellName))
		self:PlaySound(args.spellId, "warning")
	end
end

-- Adorned Starseer
do
	local prev = 0
	function mod:DriftingStar(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alarm")
		end
	end
end
function mod:WanderingPulsar(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "warning")
end

-- Focused Ritualist
function mod:UnstableRift(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

-- Devoted Accomplice
function mod:Reinvigorate(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end
