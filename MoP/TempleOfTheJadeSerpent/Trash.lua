--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Temple of the Jade Serpent Trash", 960)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	59873,  -- Corrupt Living Water
	200126, -- Fallen Waterspeaker
	59555,  -- Haunting Sha
	59546,  -- The Talking Fish
	59553,  -- The Songbird Queen
	59552,  -- The Crybaby Hozen
	59544,  -- The Nodding Tiger
	59545,  -- The Golden Beetle
	200131, -- Sha-Touched Guardian
	200137, -- Depraved Mistweaver
	200387  -- Shambling Infester
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.corrupt_living_water = "Corrupt Living Water"
	L.fallen_waterspeaker = "Fallen Waterspeaker"
	L.haunting_sha = "Haunting Sha"
	L.the_talking_fish = "The Talking Fish"
	L.the_songbird_queen = "The Songbird Queen"
	L.the_crybaby_hozen = "The Crybaby Hozen"
	L.the_nodding_tiger = "The Nodding Tiger"
	L.the_golden_beetle = "The Golden Beetle"
	L.sha_touched_guardian = "Sha-Touched Guardian"
	L.depraved_mistweaver = "Depraved Mistweaver"
	L.shambling_infester = "Shambling Infester"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Corrupt Living Water
		397881, -- Surging Deluge
		-- Fallen Waterspeaker
		397889, -- Tidal Burst
		-- Haunting Sha
		395859, -- Haunting Scream
		-- The Talking Fish
		{395872, "DISPEL"}, -- Sleepy Soliloquy
		-- The Songbird Queen
		396001, -- Territorial Display
		-- The Crybaby Hozen
		{396018, "DISPEL"}, -- Fit of Rage
		-- The Nodding Tiger
		396073, -- Cat Nap
		-- The Golden Beetle
		{396020, "DISPEL"}, -- Golden Barrier
		-- Sha-Touched Guardian
		397899, -- Leg Sweep
		-- Depraved Mistweaver
		397914, -- Defiling Mist
		-- Shambling Infester
		398300, -- Flames of Doubt
	}, {
		[397881] = L.corrupt_living_water,
		[397889] = L.fallen_waterspeaker,
		[395859] = L.haunting_sha,
		[395872] = L.the_talking_fish,
		[396001] = L.the_songbird_queen,
		[396018] = L.the_crybaby_hozen,
		[396073] = L.the_nodding_tiger,
		[396020] = L.the_golden_beetle,
		[397899] = L.sha_touched_guardian,
		[397914] = L.depraved_mistweaver,
		[398300] = L.shambling_infester,
	}
end

function mod:OnBossEnable()
	-- Corrupt Living Water
	self:Log("SPELL_CAST_START", "SurgingDeluge", 397881)

	-- Fallen Waterspeaker
	self:Log("SPELL_CAST_START", "TidalBurst", 397889)

	-- Haunting Sha
	self:Log("SPELL_CAST_START", "HauntingScream", 395859)

	-- The Talking Fish
	self:Log("SPELL_CAST_START", "SleepySoliloquy", 395872)
	self:Log("SPELL_AURA_APPLIED", "SleepySoliloquyApplied", 395872)

	-- The Songbird Queen
	self:Log("SPELL_CAST_START", "TerritorialDisplay", 396001)

	-- The Crybaby Hozen
	self:Log("SPELL_CAST_START", "FitOfRage", 396018)
	self:Log("SPELL_AURA_APPLIED", "FitOfRageApplied", 396018)

	-- The Nodding Tiger
	self:Log("SPELL_CAST_START", "CatNap", 396073)

	-- The Golden Beetle
	self:Log("SPELL_AURA_APPLIED", "GoldenBarrierApplied", 396020)

	-- Sha-Touched Guardian
	self:Log("SPELL_CAST_START", "LegSweep", 397899)

	-- Depraved Mistweaver
	self:Log("SPELL_CAST_START", "DefilingMist", 397914)

	-- Shambling Infester
	self:Log("SPELL_CAST_START", "FlamesOfDoubt", 398300)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Corrupt Living Water

function mod:SurgingDeluge(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Fallen Waterspeaker

function mod:TidalBurst(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Haunting Sha

function mod:HauntingScream(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

-- The Talking Fish

function mod:SleepySoliloquy(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:SleepySoliloquyApplied(args)
	if self:Dispeller("magic", nil, args.spellId) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "warning")
	end
end

-- The Songbird Queen

function mod:TerritorialDisplay(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- The Crybaby Hozen

function mod:FitOfRage(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:FitOfRageApplied(args)
	if self:Dispeller("enrage", true, args.spellId) then
		self:Message(args.spellId, "yellow", CL.buff_other:format(args.destName, args.spellName))
		self:PlaySound(args.spellId, "warning")
	end
end

-- The Nodding Tiger

function mod:CatNap(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

-- The Golden Beetle

function mod:GoldenBarrierApplied(args)
	if self:Dispeller("magic", true, args.spellId) and not self:Player(args.destFlags) then
		self:Message(args.spellId, "yellow", CL.buff_other:format(args.destName, args.spellName))
		self:PlaySound(args.spellId, "alert")
	end
end

-- Sha-Touched Guardian

function mod:LegSweep(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
end

-- Depraved Mistweaver

function mod:DefilingMist(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Shambling Infester

function mod:FlamesOfDoubt(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end
