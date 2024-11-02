--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Dawnbreaker Trash", 2662)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	223660, -- Arathi Lamplighter
	213892, -- Nightfall Shadowmage
	228540, -- Nightfall Shadowmage (summoned)
	214761, -- Nightfall Ritualist
	214762, -- Nightfall Commander
	225479, -- Sureki Webmage (on ship)
	210966, -- Sureki Webmage (in town)
	224325, -- Arathi Bomb
	211261, -- Ascendant Vis'coxria
	211263, -- Deathscreamer Iken'tak
	211262, -- Ixkreten the Unbreakable
	213932, -- Sureki Militant
	213934, -- Nightfall Tactician
	213893, -- Nightfall Darkcaster
	228539, -- Nightfall Darkcaster (summoned)
	213895, -- Nightfall Shadowalker
	228537, -- Nightfall Shadowalker (summoned)
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
	L.nightfall_darkcaster = "Nightfall Darkcaster"
	L.nightfall_shadowalker = "Nightfall Shadowalker"
	L.manifested_shadow = "Manifested Shadow"
	L.nightfall_dark_architect = "Nightfall Dark Architect"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Arathi Lamplighter
		449042, -- Radiant Light
		-- Nightfall Shadowmage
		{431309, "DISPEL", "NAMEPLATE"}, -- Ensnaring Shadows
		-- Nightfall Ritualist
		{432448, "SAY", "NAMEPLATE"}, -- Stygian Seed
		{431364, "NAMEPLATE"}, -- Tormenting Ray
		-- Nightfall Commander
		{450756, "NAMEPLATE"}, -- Abyssal Howl
		{431491, "TANK", "NAMEPLATE"}, -- Tainted Slash
		-- Sureki Webmage
		{451107, "SAY", "NAMEPLATE"}, -- Bursting Cocoon
		-- Arathi Bomb
		451091, -- Plant Arathi Bomb
		-- Ascendant Vis'coxria
		{451102, "NAMEPLATE"}, -- Shadowy Decay
		{451119, "ME_ONLY", "NAMEPLATE"}, -- Abyssal Blast
		-- Deathscreamer Iken'tak
		{450854, "NAMEPLATE"}, -- Dark Orb
		-- Ixkreten the Unbreakable
		{451117, "NAMEPLATE"}, -- Terrifying Slam
		-- Sureki Militant
		{451098, "NAMEPLATE"}, -- Tacky Nova
		{451097, "NAMEPLATE"}, -- Silken Shell
		-- Nightfall Tactician
		{431494, "NAMEPLATE"}, -- Black Edge
		{451112, "DISPEL", "NAMEPLATE"}, -- Tactician's Rage
		-- Nightfall Darkcaster
		{432520, "NAMEPLATE"}, -- Umbral Barrier
		-- Nightfall Shadowalker
		{431637, "TANK", "NAMEPLATE", "OFF"}, -- Umbral Rush
		-- Manifested Shadow
		{432565, "NAMEPLATE"}, -- Black Hail
		{431304, "NAMEPLATE"}, -- Dark Floes
		-- Nightfall Dark Architect
		{431349, "NAMEPLATE"}, -- Tormenting Eruption
		446615, -- Usher Reinforcements
	}, {
		[449042] = L.arathi_lamplighter,
		[431309] = L.nightfall_shadowmage,
		[432448] = L.nightfall_ritualist,
		[450756] = L.nightfall_commander,
		[451107] = L.sureki_webmage,
		[451091] = L.arathi_bomb,
		[451102] = L.ascendant_viscoxria,
		[450854] = L.deathscreamer_ikentak,
		[451117] = L.ixkreten_the_unbreakable,
		[451098] = L.sureki_militant,
		[431494] = L.nightfall_tactician,
		[432520] = L.nightfall_darkcaster,
		[431637] = L.nightfall_shadowalker,
		[432565] = L.manifested_shadow,
		[431349] = L.nightfall_dark_architect,
	}, {
		[449042] = CL.flying_available, -- Radiant Light (You can fly now)
	}
end

function mod:OnBossEnable()
	-- Arathi Lamplighter
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_WHISPER") -- Radiant Light

	-- Nightfall Shadowmage
	self:RegisterEngageMob("NightfallShadowmageEngaged", 213892, 228540) -- regular trash, Nightfall Dark Architect summon
	self:Log("SPELL_CAST_START", "EnsnaringShadows", 431309)
	self:Log("SPELL_INTERRUPT", "EnsnaringShadowsInterrupt", 431309)
	self:Log("SPELL_CAST_SUCCESS", "EnsnaringShadowsSuccess", 431309)
	self:Log("SPELL_AURA_APPLIED", "EnsnaringShadowsApplied", 431309)
	self:Death("NightfallShadowmageDeath", 213892, 228540) -- regular trash, Nightfall Dark Architect summon

	-- Nightfall Ritualist
	self:RegisterEngageMob("NightfallRitualistEngaged", 214761)
	self:Log("SPELL_CAST_SUCCESS", "StygianSeed", 432448)
	self:Log("SPELL_AURA_APPLIED", "StygianSeedApplied", 432448)
	self:Log("SPELL_CAST_SUCCESS", "TormentingRay", 431364)
	self:Log("SPELL_AURA_APPLIED", "TormentingRayApplied", 431365)
	self:Death("NightfallRitualistDeath", 214761)

	-- Nightfall Commander
	self:RegisterEngageMob("NightfallCommanderEngaged", 214762)
	self:Log("SPELL_CAST_START", "AbyssalHowl", 450756)
	self:Log("SPELL_INTERRUPT", "AbyssalHowlInterrupt", 450756)
	self:Log("SPELL_CAST_SUCCESS", "AbyssalHowlSuccess", 450756)
	self:Log("SPELL_CAST_START", "TaintedSlash", 431491)
	self:Death("NightfallCommanderDeath", 214762)

	-- Sureki Webmage
	self:RegisterEngageMob("SurekiWebmageEngaged", 225479, 210966) -- on ship, in town
	self:Log("SPELL_CAST_SUCCESS", "BurstingCocoon", 451107)
	self:Log("SPELL_AURA_APPLIED", "BurstingCocoonApplied", 451107)
	self:Death("SurekiWebmageDeath", 225479, 210966) -- on ship, in town

	-- Arathi Bomb
	self:Log("SPELL_CAST_START", "PlantArathiBomb", 451091)

	-- Ascendant Vis'coxria / Deathscreamer Iken'tak / Ixkreten the Unbreakable
	self:Log("SPELL_CAST_START", "AbyssalBlast", 451119)

	-- Ascendant Vis'coxria
	self:RegisterEngageMob("AscendantViscoxriaEngaged", 211261)
	self:Log("SPELL_CAST_START", "ShadowyDecay", 451102)
	self:Death("AscendantViscoxriaDeath", 211261)

	-- Deathscreamer Iken'tak
	self:RegisterEngageMob("DeathscreamerIkentakEngaged", 211263)
	self:Log("SPELL_CAST_START", "DarkOrb", 450854)
	self:Death("DeathscreamerIkentakDeath", 211263)

	-- Ixkreten the Unbreakable
	self:RegisterEngageMob("IxkretenTheUnbreakableEngaged", 211262)
	self:Log("SPELL_CAST_START", "TerrifyingSlam", 451117)
	self:Death("IxkretenTheUnbreakableDeath", 211262)

	-- Sureki Militant
	self:RegisterEngageMob("SurekiMilitantEngaged", 213932)
	self:Log("SPELL_CAST_START", "TackyNova", 451098)
	self:Log("SPELL_CAST_START", "SilkenShell", 451097)
	self:Log("SPELL_INTERRUPT", "SilkenShellInterrupt", 451097)
	self:Log("SPELL_CAST_SUCCESS", "SilkenShellSuccess", 451097)
	self:Death("SurekiMilitantDeath", 213932)

	-- Nightfall Tactician
	self:RegisterEngageMob("NightfallTacticianEngaged", 213934)
	self:Log("SPELL_CAST_START", "BlackEdge", 431494)
	self:Log("SPELL_CAST_SUCCESS", "TacticiansRage", 451112)
	self:Log("SPELL_AURA_APPLIED", "TacticiansRageApplied", 451112)
	self:Death("NightfallTacticianDeath", 213934)

	-- Nightfall Darkcaster
	--self:RegisterEngageMob("NightfallDarkcasterEngaged", 213893, 228539) -- regular trash, Nightfall Dark Architect summon
	self:Log("SPELL_CAST_START", "UmbralBarrier", 432520)
	self:Log("SPELL_INTERRUPT", "UmbralBarrierInterrupt", 432520)
	self:Log("SPELL_CAST_SUCCESS", "UmbralBarrierSuccess", 432520)
	self:Death("NightfallDarkcasterDeath", 213893, 228539) -- regular trash, Nightfall Dark Architect summon

	-- Nightfall Shadowalker
	self:RegisterEngageMob("NightfallShadowalkerEngaged", 213895, 228537) -- regular trash, Nightfall Dark Architect summon
	self:Log("SPELL_CAST_START", "UmbralRush", 431637)
	self:Log("SPELL_CAST_SUCCESS", "UmbralRushSuccess", 431637)
	self:Death("NightfallShadowalkerDeath", 213895, 228537) -- regular trash, Nightfall Dark Architect summon

	-- Manifested Shadow
	self:RegisterEngageMob("ManifestedShadowEngaged", 211341)
	self:Log("SPELL_CAST_SUCCESS", "BlackHail", 432565)
	self:Log("SPELL_CAST_START", "DarkFloes", 431304)
	self:Death("ManifestedShadowDeath", 211341)

	-- Nightfall Dark Architect
	self:RegisterEngageMob("NightfallDarkArchitectEngaged", 213885)
	self:Log("SPELL_CAST_SUCCESS", "TormentingEruption", 431349)
	self:Log("SPELL_AURA_APPLIED", "TormentingEruptionApplied", 431350)
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
			self:Message(449042, "green", CL.flying_available, "Ability_DragonRiding_DragonRiding01")
			self:PlaySound(449042, "info")
		end
	end
end

-- Nightfall Shadowmage

function mod:NightfallShadowmageEngaged(guid)
	self:Nameplate(431309, 6.1, guid) -- Ensnaring Shadows
end

function mod:EnsnaringShadows(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:EnsnaringShadowsInterrupt(args)
	self:Nameplate(431309, 18.1, args.destGUID)
end

function mod:EnsnaringShadowsSuccess(args)
	self:Nameplate(args.spellId, 18.1, args.sourceGUID)
end

function mod:EnsnaringShadowsApplied(args)
	if self:Dispeller("curse", nil, args.spellId) or self:Dispeller("movement", nil, args.spellId) then
		self:TargetMessage(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end

function mod:NightfallShadowmageDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Nightfall Ritualist

function mod:NightfallRitualistEngaged(guid)
	self:Nameplate(431364, 3.6, guid) -- Tormenting Ray
	self:Nameplate(432448, 11.2, guid) -- Stygian Seed
end

function mod:StygianSeed(args)
	self:Nameplate(args.spellId, 21.8, args.sourceGUID)
end

function mod:StygianSeedApplied(args)
	self:TargetMessage(args.spellId, "orange", args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Stygian Seed")
	end
end

do
	local playerList = {}

	function mod:TormentingRay(args)
		playerList = {}
		self:Nameplate(args.spellId, 10.9, args.sourceGUID)
	end

	function mod:TormentingRayApplied(args)
		if self:Healer() or self:Me(args.destGUID) then
			playerList[#playerList + 1] = args.destName
			self:TargetsMessage(431364, "yellow", playerList, 2)
			self:PlaySound(431364, "alert", nil, playerList)
		end
	end
end

function mod:NightfallRitualistDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Nightfall Commander

function mod:NightfallCommanderEngaged(guid)
	self:Nameplate(431491, 1.1, guid) -- Tainted Slash
	self:Nameplate(450756, 7.0, guid) -- Abyssal Howl
end

function mod:AbyssalHowl(args)
	-- only cast if there are nearby injured enemies
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	self:PlaySound(args.spellId, "warning")
end

function mod:AbyssalHowlInterrupt(args)
	self:Nameplate(450756, 25.2, args.destGUID)
end

function mod:AbyssalHowlSuccess(args)
	self:Nameplate(args.spellId, 25.2, args.sourceGUID)
end

function mod:TaintedSlash(args)
	self:Message(args.spellId, "purple")
	self:Nameplate(args.spellId, 8.5, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:NightfallCommanderDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Sureki Webmage

function mod:SurekiWebmageEngaged(guid)
	self:Nameplate(451107, 5.1, guid) -- Bursting Cocoon
end

function mod:BurstingCocoon(args)
	self:Nameplate(args.spellId, 17.0, args.sourceGUID)
end

function mod:BurstingCocoonApplied(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Bursting Cocoon")
	end
end

function mod:SurekiWebmageDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Arathi Bomb

function mod:PlantArathiBomb(args)
	self:Message(args.spellId, "green", CL.other:format(self:ColorName(args.sourceName), args.spellName))
	self:Bar(args.spellId, 15, CL.explosion)
	self:PlaySound(args.spellId, "info")
end

-- Ascendant Vis'coxria / Deathscreamer Iken'tak / Ixkreten the Unbreakable

do
	local function printTarget(self, name, guid)
		self:TargetMessage(451119, "red", name, CL.casting:format(self:SpellName(451119)))
		if self:Me(guid) then
			self:PlaySound(451119, "alarm", nil, name)
		else
			self:PlaySound(451119, "alert", nil, name)
		end
	end

	function mod:AbyssalBlast(args)
		self:GetUnitTarget(printTarget, 0.2, args.sourceGUID)
		self:CDBar(args.spellId, 10.9)
		self:Nameplate(args.spellId, 10.9, args.sourceGUID)
		-- reschedule timer cancellations
		local mobId = self:MobId(args.sourceGUID)
		if mobId == 211261 then -- Ascendant Vis'coxria
			self:AbyssalBlastAscendantViscoxria()
		elseif mobId == 211263 then -- Deathscreamer Iken'tak
			self:AbyssalBlastDeathscreamerIkentak()
		else -- 211262, Ixkreten the Unbreakable
			self:AbyssalBlastIxkretenTheUnbreakable()
		end
	end
end

-- Ascendant Vis'coxria

do
	local timer

	function mod:AscendantViscoxriaEngaged(guid)
		self:CDBar(451102, 4.7) -- Shadowy Decay
		self:Nameplate(451102, 4.7, guid) -- Shadowy Decay
		self:CDBar(451119, 14.4) -- Abyssal Blast
		self:Nameplate(451119, 14.4, guid) -- Abyssal Blast
		timer = self:ScheduleTimer("AscendantViscoxriaDeath", 30)
	end

	function mod:ShadowyDecay(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "yellow")
		self:CDBar(args.spellId, 24.4)
		self:Nameplate(args.spellId, 24.4, args.sourceGUID)
		self:PlaySound(args.spellId, "alert")
		timer = self:ScheduleTimer("AscendantViscoxriaDeath", 30)
	end

	function mod:AbyssalBlastAscendantViscoxria()
		if timer then
			self:CancelTimer(timer)
		end
		timer = self:ScheduleTimer("AscendantViscoxriaDeath", 30)
	end

	function mod:AscendantViscoxriaDeath(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(451119) -- Abyssal Blast
		self:StopBar(451102) -- Shadowy Decay
		if args then
			self:ClearNameplate(args.destGUID)
		end
	end
end

-- Deathscreamer Iken'tak

do
	local timer

	function mod:DeathscreamerIkentakEngaged(guid)
		self:CDBar(451119, 3.6) -- Abyssal Blast
		self:Nameplate(451119, 3.6, guid) -- Abyssal Blast
		self:CDBar(450854, 12.1) -- Dark Orb
		self:Nameplate(450854, 12.1, guid) -- Dark Orb
		timer = self:ScheduleTimer("DeathscreamerIkentakDeath", 30)
	end

	function mod:DarkOrb(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		self:CDBar(args.spellId, 21.9)
		self:Nameplate(args.spellId, 21.9, args.sourceGUID)
		self:PlaySound(args.spellId, "alarm")
		timer = self:ScheduleTimer("DeathscreamerIkentakDeath", 30)
	end

	function mod:AbyssalBlastDeathscreamerIkentak()
		if timer then
			self:CancelTimer(timer)
		end
		timer = self:ScheduleTimer("DeathscreamerIkentakDeath", 30)
	end

	function mod:DeathscreamerIkentakDeath(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(451119) -- Abyssal Blast
		self:StopBar(450854) -- Dark Orb
		if args then
			self:ClearNameplate(args.destGUID)
		end
	end
end

-- Ixkreten the Unbreakable

do
	local timer

	function mod:IxkretenTheUnbreakableEngaged(guid)
		self:CDBar(451119, 3.5) -- Abyssal Blast
		self:Nameplate(451119, 3.5, guid) -- Abyssal Blast
		self:CDBar(451117, 6.4) -- Terrifying Slam
		self:Nameplate(451117, 6.4, guid) -- Terrifying Slam
		timer = self:ScheduleTimer("IxkretenTheUnbreakableDeath", 30)
	end

	function mod:TerrifyingSlam(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "purple")
		self:CDBar(args.spellId, 24.2)
		self:Nameplate(args.spellId, 24.2, args.sourceGUID)
		self:PlaySound(args.spellId, "alarm")
		timer = self:ScheduleTimer("IxkretenTheUnbreakableDeath", 30)
	end

	function mod:AbyssalBlastIxkretenTheUnbreakable()
		if timer then
			self:CancelTimer(timer)
		end
		timer = self:ScheduleTimer("IxkretenTheUnbreakableDeath", 30)
	end

	function mod:IxkretenTheUnbreakableDeath(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(451119) -- Abyssal Blast
		self:StopBar(451117) -- Terrifying Slam
		if args then
			self:ClearNameplate(args.destGUID)
		end
	end
end

-- Sureki Militant

function mod:SurekiMilitantEngaged(guid)
	self:Nameplate(451098, 6.1, guid) -- Tacky Nova
	self:Nameplate(451097, 7.2, guid) -- Silken Shell
end

function mod:TackyNova(args)
	self:Message(args.spellId, "orange")
	self:Nameplate(args.spellId, 29.2, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:SilkenShell(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:SilkenShellInterrupt(args)
	self:Nameplate(451097, 15.2, args.destGUID)
end

function mod:SilkenShellSuccess(args)
	self:Nameplate(args.spellId, 15.2, args.sourceGUID)
end

function mod:SurekiMilitantDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Nightfall Tactician

function mod:NightfallTacticianEngaged(guid)
	self:Nameplate(431494, 3.5, guid) -- Black Edge
	if self:Dispeller("enrage", true, 451112) then
		self:Nameplate(451112, 9.5, guid) -- Tactician's Rage
	end
end

do
	local prev = 0
	function mod:BlackEdge(args)
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "alarm")
		end
		self:Nameplate(args.spellId, 13.3, args.sourceGUID)
	end
end

function mod:TacticiansRage(args)
	if self:Dispeller("enrage", true, args.spellId) then
		self:Nameplate(args.spellId, 18.2, args.sourceGUID)
	end
end

do
	local prev = 0
	function mod:TacticiansRageApplied(args)
		if self:Dispeller("enrage", true, args.spellId) and args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "yellow", CL.on:format(args.spellName, args.destName))
			self:PlaySound(args.spellId, "info")
		end
	end
end

function mod:NightfallTacticianDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Nightfall Darkcaster

--function mod:NightfallDarkcasterEngaged(guid)
	-- seems to be health based for the first cast, so an initial timer is not very useful
	--self:Nameplate(432520, 6.4, guid) -- Umbral Barrier
--end

do
	local prev = 0
	function mod:UmbralBarrier(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
		self:Nameplate(args.spellId, 0, args.sourceGUID)
	end
end

function mod:UmbralBarrierInterrupt(args)
	self:Nameplate(432520, 24.2, args.destGUID)
end

function mod:UmbralBarrierSuccess(args)
	self:Nameplate(args.spellId, 24.2, args.sourceGUID)
end

function mod:NightfallDarkcasterDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Nightfall Shadowalker

function mod:NightfallShadowalkerEngaged(guid)
	self:Nameplate(431637, 0, guid) -- Umbral Rush
end

do
	local prev = 0
	function mod:UmbralRush(args)
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:UmbralRushSuccess(args)
	self:Nameplate(args.spellId, 12.2, args.sourceGUID)
end

function mod:NightfallShadowalkerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Manifested Shadow

function mod:ManifestedShadowEngaged(guid)
	self:Nameplate(432565, 8.9, guid) -- Black Hail
	self:Nameplate(431304, 39.6, guid) -- Dark Floes
end

do
	local prev = 0
	function mod:BlackHail(args)
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "alarm")
		end
		self:Nameplate(args.spellId, 14.5, args.sourceGUID)
	end
end

do
	local prev = 0
	function mod:DarkFloes(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
		self:Nameplate(args.spellId, 35.2, args.sourceGUID)
	end
end

function mod:ManifestedShadowDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Nightfall Dark Architect

do
	local timer

	function mod:NightfallDarkArchitectEngaged(guid)
		self:CDBar(431349, 7.3) -- Tormenting Eruption
		self:Nameplate(431349, 7.3, guid) -- Tormenting Eruption
		timer = self:ScheduleTimer("NightfallDarkArchitectDeath", 30)
	end

	do
		local playerList = {}

		function mod:TormentingEruption(args)
			if timer then
				self:CancelTimer(timer)
			end
			playerList = {}
			self:CDBar(args.spellId, 14.6)
			self:Nameplate(args.spellId, 14.6, args.sourceGUID)
			timer = self:ScheduleTimer("NightfallDarkArchitectDeath", 30)
		end

		function mod:TormentingEruptionApplied(args)
			playerList[#playerList + 1] = args.destName
			self:TargetsMessage(431349, "red", playerList, 2)
			self:PlaySound(431349, "alarm", nil, playerList)
		end
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

	function mod:NightfallDarkArchitectDeath(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(431349) -- Tormenting Eruption
		if args then
			self:ClearNameplate(args.destGUID)
		end
	end
end
