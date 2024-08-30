--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Stonevault Trash", 2652)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	210109, -- Earth Infused Golem
	222923, -- Repurposed Loaderbot
	212453, -- Ghastly Voidsoul
	212389, -- Cursedheart Invader
	212403, -- Cursedheart Invader
	212765, -- Void Bound Despoiler
	221979, -- Void Bound Howler
	214350, -- Turned Speaker
	212400, -- Void Touched Elemental
	213338, -- Forgebound Mender
	213343, -- Forge Loader
	214264, -- Cursedforge Honor Guard
	214066, -- Cursedforge Stoneshaper
	224962, -- Cursedforge Mender
	213954 -- Rock Smasher
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.earth_infused_golem = "Earth Infused Golem"
	L.repurposed_loaderbot = "Repurposed Loaderbot"
	L.ghastly_voidsoul = "Ghastly Voidsoul"
	L.cursedheart_invader = "Cursedheart Invader"
	L.void_bound_despoiler = "Void Bound Despoiler"
	L.void_bound_howler = "Void Bound Howler"
	L.turned_speaker = "Turned Speaker"
	L.void_touched_elemental = "Void Touched Elemental"
	L.forgebound_mender = "Forgebound Mender"
	L.forge_loader = "Forge Loader"
	L.cursedforge_honor_guard = "Cursedforge Honor Guard"
	L.cursedforge_stoneshaper = "Cursedforge Stoneshaper"
	L.rock_smasher = "Rock Smasher"

	L.edna_warmup_trigger = "What's this? Is that golem fused with something else?"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Earth Infused Golem
		{425027, "NAMEPLATE"}, -- Seismic Wave
		-- Repurposed Loaderbot
		{447141, "NAMEPLATE"}, -- Pulverizing Pounce
		-- Ghastly Voidsoul
		{449455, "NAMEPLATE"}, -- Howling Fear
		-- Cursedheart Invader
		{426308, "DISPEL", "NAMEPLATE"}, -- Void Infection
		-- Void Bound Despoiler
		{426771, "HEALER", "NAMEPLATE"}, -- Void Outburst
		-- Void Bound Howler
		{445207, "NAMEPLATE"}, -- Piercing Wail
		-- Turned Speaker
		{429545, "NAMEPLATE"}, -- Censoring Gear
		-- Void Touched Elemental
		{426345, "NAMEPLATE"}, -- Crystal Salvo
		-- Forgebound Mender / Cursedforge Mender
		{429109, "NAMEPLATE"}, -- Restoring Metals
		-- Forge Loader
		{449130, "NAMEPLATE"}, -- Lava Cannon
		{449154, "HEALER", "NAMEPLATE"}, -- Molten Mortar
		-- Cursedforge Honor Guard
		{448640, "NAMEPLATE"}, -- Shield Stampede
		-- Cursedforge Stoneshaper
		{429427, "NAMEPLATE"}, -- Earth Burst Totem
		-- Rock Smasher
		{428879, "NAMEPLATE"}, -- Smash Rock
		{428703, "NAMEPLATE"}, -- Granite Eruption
	}, {
		[425027] = L.earth_infused_golem,
		[447141] = L.repurposed_loaderbot,
		[449455] = L.ghastly_voidsoul,
		[426308] = L.cursedheart_invader,
		[426771] = L.void_bound_despoiler,
		[445207] = L.void_bound_howler,
		[429545] = L.turned_speaker,
		[426345] = L.void_touched_elemental,
		[429109] = L.forgebound_mender,
		[449130] = L.forge_loader,
		[448640] = L.cursedforge_honor_guard,
		[429427] = L.cursedforge_stoneshaper,
		[428879] = L.rock_smasher,
	}
end

function mod:OnBossEnable()
	-- Warmups
	self:RegisterEvent("CHAT_MSG_MONSTER_SAY")

	-- TODO gossip with 229507 Imbued Iron Bar (Requires Warrior, Dwarf, or at least 25 skill in Khaz Algar Blacksmithing.)
	-- gives 10% vers buff to party 462500 Imbued Iron Energy
	-- [GOSSIP_SHOW] Creature-0-3779-2652-507-229507-00005116DA#124027:<Sometimes iron is just iron.> \r\n|cFFFF0000[Requires Warrior, Dwarf, or at least 25 skill in Khaz Algar Blacksmithing.]|r",

	-- Earth Infused Golem
	self:Log("SPELL_CAST_START", "SeismicWave", 425027)
	self:Death("EarthInfusedGolemDeath", 210109)

	-- Repurposed Loaderbot
	self:Log("SPELL_CAST_START", "PulverizingPounce", 447141)
	self:Death("RepurposedLoaderbotDeath", 222923)

	-- Ghastly Voidsoul
	self:Log("SPELL_CAST_START", "HowlingFear", 449455)
	self:Log("SPELL_INTERRUPT", "HowlingFearInterrupt", 449455)
	self:Log("SPELL_CAST_SUCCESS", "HowlingFearSuccess", 449455)
	self:Death("GhastlyVoidsoulDeath", 212453)

	-- Cursedheart Invader
	self:Log("SPELL_CAST_SUCCESS", "VoidInfection", 426308)
	self:Log("SPELL_AURA_APPLIED", "VoidInfectionApplied", 426308)
	self:Death("CursedheartInvaderDeath", 212389, 212403)

	-- Void Bound Despoiler
	self:Log("SPELL_CAST_START", "VoidOutburst", 426771)
	self:Death("VoidBoundDespoilerDeath", 212765)

	-- Void Bound Howler
	self:Log("SPELL_CAST_START", "PiercingWail", 445207)
	self:Log("SPELL_INTERRUPT", "PiercingWailInterrupt", 445207)
	self:Log("SPELL_CAST_SUCCESS", "PiercingWailSuccess", 445207)
	self:Death("VoidBoundHowlerDeath", 221979)

	-- Turned Speaker
	self:Log("SPELL_CAST_START", "CensoringGear", 429545)
	self:Log("SPELL_INTERRUPT", "CensoringGearInterrupt", 429545)
	self:Log("SPELL_CAST_SUCCESS", "CensoringGearSuccess", 429545)
	self:Death("TurnedSpeakerDeath", 214350)

	-- Void Touched Elemental
	self:Log("SPELL_CAST_SUCCESS", "CrystalSalvo", 426345)
	self:Death("VoidTouchedElementalDeath", 212400)

	-- Forgebound Mender / Cursedforge Mender
	self:Log("SPELL_CAST_START", "RestoringMetals", 429109)
	self:Log("SPELL_INTERRUPT", "RestoringMetalsInterrupt", 429109)
	self:Log("SPELL_CAST_SUCCESS", "RestoringMetalsSuccess", 429109)
	self:Death("MenderDeath", 213338, 224962) -- Forgebound Mender, Cursedforge Mender

	-- Forge Loader
	self:Log("SPELL_CAST_START", "LavaCannon", 449130)
	self:Log("SPELL_CAST_SUCCESS", "MoltenMortar", 449154)
	self:Death("ForgeLoaderDeath", 213343)

	-- Cursedforge Honor Guard
	self:Log("SPELL_CAST_START", "ShieldStampede", 448640)
	self:Death("CursedforgeHonorGuardDeath", 214264)

	-- Cursedforge Stoneshaper
	self:Log("SPELL_CAST_SUCCESS", "EarthBurstTotem", 429427)
	self:Log("SPELL_SUMMON", "EarthBurstTotemSummon", 429427)
	self:Death("CursedforgeStoneshaperDeath", 214066)

	-- Rock Smasher
	self:Log("SPELL_CAST_START", "SmashRock", 428879)
	self:Log("SPELL_CAST_START", "GraniteEruption", 428703)
	self:Death("RockSmasherDeath", 213954)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Warmups

function mod:CHAT_MSG_MONSTER_SAY(_, msg)
	if msg == L.edna_warmup_trigger then
		-- E.D.N.A. warmup
		local ednaModule = BigWigs:GetBossModule("E.D.N.A.", true)
		if ednaModule then
			ednaModule:Enable()
			ednaModule:Warmup()
		end
	end
end

-- Earth Infused Golem

function mod:SeismicWave(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	self:Nameplate(args.spellId, 18.2, args.sourceGUID)
end

function mod:EarthInfusedGolemDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Repurposed Loaderbot

do
	local prev = 0
	function mod:PulverizingPounce(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
		self:Nameplate(args.spellId, 18.2, args.sourceGUID)
	end
end

function mod:RepurposedLoaderbotDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Ghastly Voidsoul

function mod:HowlingFear(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
	self:Nameplate(args.spellId, 0, args.sourceGUID)
end

function mod:HowlingFearInterrupt(args)
	self:Nameplate(449455, 22.9, args.destGUID)
end

function mod:HowlingFearSuccess(args)
	self:Nameplate(args.spellId, 22.9, args.sourceGUID)
end

function mod:GhastlyVoidsoulDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Cursedheart Invader

function mod:VoidInfection(args)
	self:Nameplate(args.spellId, 18.2, args.sourceGUID)
end

do
	local prev = 0
	function mod:VoidInfectionApplied(args)
		local t = args.time
		if self:Dispeller("curse", nil, args.spellId) and t - prev > 2 then
			prev = t
			self:TargetMessage(args.spellId, "yellow", args.destName)
			self:PlaySound(args.spellId, "alert", nil, args.destName)
		end
	end
end

function mod:CursedheartInvaderDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Void Bound Despoiler

function mod:VoidOutburst(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:Nameplate(args.spellId, 27.9, args.sourceGUID)
end

function mod:VoidBoundDespoilerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Void Bound Howler

do
	local prev = 0
	function mod:PiercingWail(args)
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
			return
		end
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
		self:Nameplate(args.spellId, 0, args.sourceGUID)
	end
end

function mod:PiercingWailInterrupt(args)
	self:Nameplate(445207, 20.0, args.destGUID)
end

function mod:PiercingWailSuccess(args)
	self:Nameplate(args.spellId, 20.0, args.sourceGUID)
end

function mod:VoidBoundHowlerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Turned Speaker

function mod:CensoringGear(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	self:Nameplate(args.spellId, 0, args.sourceGUID)
end

function mod:CensoringGearInterrupt(args)
	self:Nameplate(429545, 15.7, args.destGUID)
end

function mod:CensoringGearSuccess(args)
	self:Nameplate(args.spellId, 15.7, args.sourceGUID)
end

function mod:TurnedSpeakerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Void Touched Elemental

function mod:CrystalSalvo(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	self:Nameplate(args.spellId, 17.0, args.sourceGUID)
end

function mod:VoidTouchedElementalDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Forgebound Mender / Cursedforge Mender

do
	local prev = 0
	function mod:RestoringMetals(args)
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
			return
		end
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "warning")
		end
		self:Nameplate(args.spellId, 0, args.sourceGUID)
	end
end

function mod:RestoringMetalsInterrupt(args)
	self:Nameplate(429109, 16.4, args.destGUID)
end

function mod:RestoringMetalsSuccess(args)
	self:Nameplate(args.spellId, 16.4, args.sourceGUID)
end

function mod:MenderDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Forge Loader

do
	local prev = 0
	function mod:LavaCannon(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
		self:Nameplate(args.spellId, 12.1, args.sourceGUID)
	end
end

do
	local prev = 0
	function mod:MoltenMortar(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "alert")
		end
		self:Nameplate(args.spellId, 24.2, args.sourceGUID)
	end
end

function mod:ForgeLoaderDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Cursedforge Honor Guard

do
	local prev = 0
	function mod:ShieldStampede(args)
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "alarm")
		end
		self:Nameplate(args.spellId, 18.2, args.sourceGUID)
	end
end

function mod:CursedforgeHonorGuardDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Cursedforge Stoneshaper

function mod:EarthBurstTotem(args)
	self:Nameplate(args.spellId, 31.6, args.sourceGUID)
end

do
	local prev = 0
	function mod:EarthBurstTotemSummon(args)
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "cyan", CL.spawned:format(args.spellName))
			self:PlaySound(args.spellId, "info")
		end
	end
end

function mod:CursedforgeStoneshaperDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Rock Smasher

do
	local prev = 0
	function mod:SmashRock(args)
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "alarm")
		end
		self:Nameplate(args.spellId, 23.0, args.sourceGUID)
	end
end

do
	local prev = 0
	function mod:GraniteEruption(args)
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
		self:Nameplate(args.spellId, 24.3, args.sourceGUID)
	end
end

function mod:RockSmasherDeath(args)
	self:ClearNameplate(args.destGUID)
end
