--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Tazavesh Trash", 2441)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	------ Streets of Wonder ------
	177816, -- Interrogation Specialist
	177808, -- Armored Overseer
	179837, -- Tracker Zo'korss
	180348, -- Cartel Muscle
	180335, -- Cartel Smuggler
	177817, -- Support Officer
	176396, -- Defective Sorter
	179840, -- Market Peacekeeper
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
	L.interrogation_specialist = "Interrogation Specialist"
	L.armored_overseer_tracker_zokorss = "Armored Overseer / Tracker Zo'korss"
	L.cartel_muscle = "Cartel Muscle"
	L.cartel_smuggler = "Cartel Smuggler"
	L.support_officer = "Support Officer"
	L.defective_sorter = "Defective Sorter"
	L.market_peacekeeper = "Market Peacekeeper"
	L.commerce_enforcer = "Commerce Enforcer"
	L.commerce_enforcer_commander_zofar = "Commerce Enforcer / Commander Zo'far"
	L.commander_zofar = "Commander Zo'far"

	------ So'leah's Gambit ------
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
-- Initialization
--

function mod:GetOptions()
	return {
		------ Streets of Wonder ------
		-- Interrogation Specialist
		356031, -- Stasis Beam
		-- Armored Overseer / Tracker Zo'korss
		356001, -- Beam Splicer
		-- Cartel Muscle
		{356967, "TANK_HEALER"}, -- Hyperlight Backhand
		-- Cartel Smuggler
		{357029, "SAY_COUNTDOWN"}, -- Hyperlight Bomb
		-- Support Officer
		355980, -- Refraction Shield
		{355934, "DISPEL"}, -- Hard Light Barrier
		-- Defective Sorter
		347721, -- Open Cage
		-- Market Peacekeeper
		355637, -- Quelling Strike
		-- Commerce Enforcer
		355782, -- Force Multiplier
		-- Commerce Enforcer / Commander Zo'far
		{355477, "TANK_HEALER"}, -- Power Kick
		-- Commander Zo'far
		355480, -- Lethal Force

		------ So'leah's Gambit ------
		-- Murkbrine Scalebinder
		355132, -- Invigorating Fish Stick
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
		[356031] = L.interrogation_specialist,
		[356001] = L.armored_overseer_tracker_zokorss,
		[356967] = L.cartel_muscle,
		[357029] = L.cartel_smuggler,
		[355980] = L.support_officer,
		[347721] = L.defective_sorter,
		[355637] = L.market_peacekeeper,
		[355782] = L.commerce_enforcer,
		[355477] = L.commerce_enforcer_commander_zofar,
		[355480] = L.commander_zofar,

		------ So'leah's Gambit ------
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
	------ Streets of Wonder ------
	self:Log("SPELL_CAST_START", "StasisBeam", 356031)
	self:Log("SPELL_CAST_SUCCESS", "BeamSplicer", 356001)
	self:Log("SPELL_PERIODIC_DAMAGE", "BeamSplicerDamage", 356011)
	self:Log("SPELL_CAST_START", "HyperlightBackhand", 356967)
	self:Log("SPELL_AURA_APPLIED", "HyperlightBombApplied", 357029)
	self:Log("SPELL_AURA_REMOVED", "HyperlightBombRemoved", 357029)
	self:Log("SPELL_AURA_APPLIED", "RefractionShieldApplied", 355980)
	self:Log("SPELL_CAST_START", "HardLightBarrier", 355934)
	self:Log("SPELL_AURA_APPLIED", "HardLightBarrierApplied", 355934)
	self:Log("SPELL_CAST_START", "OpenCage", 347721)
	self:Log("SPELL_CAST_START", "QuellingStrike", 355637)
	self:Log("SPELL_AURA_APPLIED", "ForceMultiplierApplied", 355782)
	self:Log("SPELL_CAST_START", "PowerKick", 355477)
	self:Log("SPELL_AURA_APPLIED", "LethalForceApplied", 355480)
	self:Log("SPELL_AURA_REMOVED", "LethalForceRemoved", 355480)

	------ So'leah's Gambit ------
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

-- Interrogation Specialist
function mod:StasisBeam(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
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
	function mod:BeamSplicerDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t-prev > 1 then
				prev = t
				self:PersonalMessage(356001, "underyou")
				self:PlaySound(356001, "underyou")
			end
		end
	end
end

-- Cartel Muscle
function mod:HyperlightBackhand(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Cartel Smuggler
function mod:HyperlightBombApplied(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId)
		self:PlaySound(args.spellId, "alarm")
		self:SayCountdown(args.spellId, 5)
	end
end
function mod:HyperlightBombRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
end

-- Support Officer
function mod:RefractionShieldApplied(args)
	self:Message(args.spellId, "yellow", CL.on:format(args.spellName, args.destName))
	self:PlaySound(args.spellId, "warning")
end
function mod:HardLightBarrier(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end
function mod:HardLightBarrierApplied(args)
	if self:Dispeller("magic", true, args.spellId) then
		self:Message(args.spellId, "red", CL.buff_other:format(args.destName, args.spellName))
		self:PlaySound(args.spellId, "warning")
	end
end

-- Defective Sorter
function mod:OpenCage(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

-- Market Peacekeeper
function mod:QuellingStrike(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "red", CL.you:format(args.spellName))
		self:PlaySound(args.spellId, "warning")
	else
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "alert")
	end
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

	function mod:LethalForceRemoved(args)
		wipe(playerList)
		onMe = false
	end
end

------ So'leah's Gambit ------

-- Murkbrine Scalebinder
function mod:InvigoratingFishStick(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
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
			if t-prev > 2 then
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
