if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Dawnbreaker Trash", 2662)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	223660, -- Arathi Lamplighter
	213892, -- Nightfall Shadowmage
	214761, -- Nightfall Ritualist
	214762, -- Nightfall Commander
	225479, -- Sureki Webmage
	224325, -- Arathi Bomb
	211261, -- Ascendant Vis'coxria
	211263, -- Deathscreamer Iken'tak
	211262, -- Ixkreten the Unbreakable
	213932, -- Sureki Militant
	213934, -- Nightfall Tactician
	211341, -- Manifested Shadow
	213885 -- Nightfall Dark Architect
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.arathi_lamplighter = "Arathi Lamplighter"
	L.nightfall_shadowmage = "Nightfall Shadowmage"
	L.nightfall_ritualist = "Nightfall Ritualist"
	L.nightfall_commander = "Nightfall Commander"
	L.sureki_webmage = "Sureki Webmage"
	L.arathi_bomb = "Arathi Bomb"
	L.ascendant_viscoxria = "Ascendant Vis'coxria"
	L.deathscreamer_ikentak = "Deathscreamer Iken'tak"
	L.ixkreten_the_unbreakable = "Ixkreten the Unbreakable"
	L.sureki_militant = "Sureki Militant"
	L.nightfall_tactician = "Nightfall Tactician"
	L.manifested_shadow = "Manifested Shadow"
	L.nightfall_dark_architect = "Nightfall Dark Architect"

	L.flying_available = "You can fly now"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Arathi Lamplighter
		449042, -- Radiant Light
		-- Nightfall Shadowmage
		{431309, "DISPEL"}, -- Ensnaring Shadows
		-- Nightfall Ritualist
		431304, -- Dark Floes
		{432448, "SAY"}, -- Stygian Seed
		-- Nightfall Commander
		450756, -- Abyssal Howl
		-- Sureki Webmage
		{451107, "SAY"}, -- Bursting Cocoon
		-- Arathi Bomb
		451091, -- Plant Arathi Bomb
		-- Ascendant Vis'coxria
		451102, -- Shadowy Decay
		-- Deathscreamer Iken'tak
		450854, -- Dark Orb
		-- Ixkreten the Unbreakable
		451117, -- Terrifying Slam
		-- Sureki Militant
		451098, -- Tacky Nova
		451097, -- Silken Shell
		-- Nightfall Tactician
		431494, -- Black Edge
		-- Manifested Shadow
		432565, -- Dark Floes
		-- Nightfall Dark Architect
		431349, -- Tormenting Eruption
		446615, -- Usher Reinforcements
	}, {
		[449042] = L.arathi_lamplighter,
		[431309] = L.nightfall_shadowmage,
		[431304] = L.nightfall_ritualist,
		[450756] = L.nightfall_commander,
		[451107] = L.sureki_webmage,
		[451091] = L.arathi_bomb,
		[451102] = L.ascendant_viscoxria,
		[450854] = L.deathscreamer_ikentak,
		[451117] = L.ixkreten_the_unbreakable,
		[451098] = L.sureki_militant,
		[431494] = L.nightfall_tactician,
		[432565] = L.manifested_shadow,
		[431349] = L.nightfall_dark_architect,
	}, {
		[449042] = L.flying_available, -- Radiant Light (You can fly now)
	}
end

function mod:OnBossEnable()
	-- Arathi Lamplighter
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_WHISPER") -- Radiant Light

	-- Nightfall Shadowmage
	self:Log("SPELL_CAST_START", "EnsnaringShadows", 431309)
	self:Log("SPELL_AURA_APPLIED", "EnsnaringShadowsApplied", 431309)

	-- Nightfall Ritualist
	self:Log("SPELL_CAST_START", "DarkFloes", 431304)
	self:Log("SPELL_AURA_APPLIED", "StygianSeedApplied", 432448)

	-- Nightfall Commander
	self:Log("SPELL_CAST_START", "AbyssalHowl", 450756)

	-- Sureki Webmage
	self:Log("SPELL_AURA_APPLIED", "BurstingCocoonApplied", 451107)

	-- Arathi Bomb
	self:Log("SPELL_CAST_START", "PlantArathiBomb", 451091)

	-- Ascendant Vis'coxria
	self:Log("SPELL_CAST_START", "ShadowyDecay", 451102)
	self:Death("AscendantViscoxriaDeath", 211261)

	-- Deathscreamer Iken'tak
	self:Log("SPELL_CAST_START", "DarkOrb", 450854)
	self:Death("DeathscreamerIkentakDeath", 211263)

	-- Ixkreten the Unbreakable
	self:Log("SPELL_CAST_START", "TerrifyingSlam", 451117)
	self:Death("IxkretenTheUnbreakableDeath", 211262)

	-- Sureki Militant
	self:Log("SPELL_CAST_START", "TackyNova", 451098)
	self:Log("SPELL_CAST_START", "SilkenShell", 451097)

	-- Nightfall Tactician
	self:Log("SPELL_CAST_START", "BlackEdge", 431494)

	-- Manifested Shadow
	self:Log("SPELL_CAST_SUCCESS", "BlackHail", 432565)

	-- Nightfall Dark Architect
	self:Log("SPELL_CAST_START", "TormentingEruption", 431349)
	self:Log("SPELL_CAST_START", "UsherReinforcements", 446615)
	self:Death("NightfallDarkArchitectDeath", 213885)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Arathi Lamplighter

do
	local prev = 0
	function mod:CHAT_MSG_RAID_BOSS_WHISPER(_, msg)
		local t = GetTime()
		if t - prev > 10 and msg:find("449042", nil, true) then -- Radiant Light
			prev = t
			-- [CHAT_MSG_RAID_BOSS_WHISPER] |TInterface\\ICONS\\INV_Ability_HolyFire_Nova.BLP:20|t You have gained |cFFFF0000|Hspell:449042|h[Radiant Light]|h|r. |TInterface\\ICONS\\Ability_DragonRiding_DragonRiding01.BLP:20|t Take flight!
			self:Message(449042, "green", L.flying_available, "Ability_DragonRiding_DragonRiding01")
			self:PlaySound(449042, "info")
		end
	end
end

-- Nightfall Shadowmage

function mod:EnsnaringShadows(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:EnsnaringShadowsApplied(args)
	if self:Dispeller("curse", nil, args.spellId) or self:Dispeller("movement", nil, args.spellId) then
		self:TargetMessage(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end

-- Nightfall Ritualist

function mod:DarkFloes(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:StygianSeedApplied(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Stygian Seed")
	end
end

-- Nightfall Commander

function mod:AbyssalHowl(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

-- Sureki Webmage

function mod:BurstingCocoonApplied(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Bursting Cocoon")
	end
end

-- Arathi Bomb

function mod:PlantArathiBomb(args)
	self:Message(args.spellId, "green", CL.other:format(self:ColorName(args.sourceName), args.spellName))
	self:PlaySound(args.spellId, "info")
	self:Bar(args.spellId, 15, CL.explosion)
end

-- Ascendant Vis'coxria

do
	local timer

	function mod:ShadowyDecay(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "alert")
		self:CDBar(args.spellId, 17.0)
		timer = self:ScheduleTimer("AscendantViscoxriaDeath", 30)
	end

	function mod:AscendantViscoxriaDeath()
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(451102) -- Shadowy Decay
	end
end

-- Deathscreamer Iken'tak

do
	local timer

	function mod:DarkOrb(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		self:PlaySound(args.spellId, "alarm")
		self:CDBar(args.spellId, 17.0)
		timer = self:ScheduleTimer("DeathscreamerIkentakDeath", 30)
	end

	function mod:DeathscreamerIkentakDeath()
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(450854) -- Dark Orb
	end
end

-- Ixkreten the Unbreakable

do
	local timer

	function mod:TerrifyingSlam(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "purple")
		self:PlaySound(args.spellId, "alarm")
		self:CDBar(args.spellId, 17.0)
		timer = self:ScheduleTimer("IxkretenTheUnbreakableDeath", 30)
	end

	function mod:IxkretenTheUnbreakableDeath()
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(451117) -- Terrifying Slam
	end
end

-- Sureki Militant

function mod:TackyNova(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

function mod:SilkenShell(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Nightfall Tactician

do
	local prev = 0
	function mod:BlackEdge(args)
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Manifested Shadow

do
	local prev = 0
	function mod:BlackHail(args)
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "info")
		end
	end
end

-- Nightfall Dark Architect

do
	local timer

	function mod:TormentingEruption(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red")
		self:PlaySound(args.spellId, "alarm")
		self:CDBar(args.spellId, 14.6)
		timer = self:ScheduleTimer("NightfallDarkArchitectDeath", 30)
	end

	function mod:UsherReinforcements(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "cyan")
		self:PlaySound(args.spellId, "info")
		-- happens at 75%, 50%, 25%
		timer = self:ScheduleTimer("NightfallDarkArchitectDeath", 30)
	end

	function mod:NightfallDarkArchitectDeath()
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(431349) -- Tormenting Eruption
	end
end
