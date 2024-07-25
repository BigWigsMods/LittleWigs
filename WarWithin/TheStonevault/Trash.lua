if not BigWigsLoader.isBeta then return end
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
	L.rock_smasher = "Rock Smasher"

	L.edna_warmup_trigger = "What's this? Is that golem fused with something else?"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Earth Infused Golem
		425027, -- Seismic Wave
		-- Repurposed Loaderbot
		447141, -- Pulverizing Pounce
		-- Ghastly Voidsoul
		449455, -- Howling Fear
		-- Cursedheart Invader
		{426308, "DISPEL"}, -- Void Infection
		-- Void Bound Despoiler
		{426771, "HEALER"}, -- Void Storm
		-- Void Bound Howler
		445207, -- Piercing Wail
		-- Turned Speaker
		429545, -- Censoring Gear
		-- Void Touched Elemental
		426345, -- Crystal Salvo
		-- Forgebound Mender
		429109, -- Restoring Metals
		-- Forge Loader
		449130, -- Lava Cannon
		{449154, "DISPEL"}, -- Molten Mortar
		-- Cursedforge Honor Guard
		448640, -- Shield Stampede
		-- Rock Smasher
		428879, -- Smash Rock
		428703, -- Granite Eruption
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
		[428879] = L.rock_smasher,
	}
end

function mod:OnBossEnable()
	-- Warmups
	self:RegisterEvent("CHAT_MSG_MONSTER_SAY")

	-- Earth Infused Golem
	self:Log("SPELL_CAST_START", "SeismicWave", 425027)

	-- Repurposed Loaderbot
	self:Log("SPELL_CAST_START", "PulverizingPounce", 447141)

	-- Ghastly Voidsoul
	self:Log("SPELL_CAST_START", "HowlingFear", 449455)

	-- Cursedheart Invader
	self:Log("SPELL_AURA_APPLIED", "VoidInfectionApplied", 426308)

	-- Void Bound Despoiler
	self:Log("SPELL_CAST_START", "VoidStorm", 426771)

	-- Void Bound Howler
	self:Log("SPELL_CAST_START", "PiercingWail", 445207)

	-- Turned Speaker
	self:Log("SPELL_CAST_START", "CensoringGear", 429545)

	-- Void Touched Elemental
	self:Log("SPELL_CAST_SUCCESS", "CrystalSalvo", 426345)

	-- Forgebound Mender
	self:Log("SPELL_CAST_START", "RestoringMetals", 429109)

	-- Forge Loader
	self:Log("SPELL_CAST_START", "LavaCannon", 449130)
	self:Log("SPELL_CAST_SUCCESS", "MoltenMortar", 449154)

	-- Cursedforge Honor Guard
	self:Log("SPELL_CAST_START", "ShieldStampede", 448640)

	-- Rock Smasher
	self:Log("SPELL_CAST_START", "SmashRock", 428879)
	self:Log("SPELL_CAST_START", "GraniteEruption", 428703)
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
	end
end

-- Ghastly Voidsoul

function mod:HowlingFear(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

-- Cursedheart Invader

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

-- Void Bound Despoiler

function mod:VoidStorm(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

-- Void Bound Howler

do
	local prev = 0
	function mod:PiercingWail(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

-- Turned Speaker

function mod:CensoringGear(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Void Touched Elemental

function mod:CrystalSalvo(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
end

-- Forgebound Mender

do
	local prev = 0
	function mod:RestoringMetals(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "warning")
		end
	end
end

-- Forge Loader

function mod:LavaCannon(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

function mod:MoltenMortar(args)
	-- this applies to 2 targets, can only dispel one
	if self:Dispeller("magic", nil, args.spellId) or self:Healer() then
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "alert")
	end
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
	end
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
	end
end
