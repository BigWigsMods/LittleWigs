if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Grim Batol Trash", 670)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	224219, -- Twilight Earthcaller
	224609, -- Twilight Destroyer
	40167, -- Twilight Beguiler
	224240, -- Twilight Decapitator
	224249, -- Twilight Lavabender
	39392 -- Faceless Corruptor
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.twilight_earthcaller = "Twilight Earthcaller"
	L.twilight_destroyer = "Twilight Destroyer"
	L.twilight_beguiler = "Twilight Beguiler"
	L.twilight_decapitator = "Twilight Decapitator"
	L.twilight_lavabender = "Twilight Lavabender"
	L.faceless_corruptor = "Faceless Corruptor"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Twilight Earthcaller
		451871, -- Mass Tremor
		-- Twilight Destroyer
		{451613, "SAY"}, -- Twilight Flame
		451939, -- Umbral Wind
		-- Twilight Beguiler
		76711, -- Sear Mind
		-- Twilight Decapitator
		451067, -- Decapitate
		-- Twilight Lavabender
		456711, -- Shadowlava Blast
		456713, -- Dark Eruption
		451387, -- Ascension
		-- Faceless Corruptor
		451391, -- Mind Piercer
	}, {
		[451871] = L.twilight_earthcaller,
		[451613] = L.twilight_destroyer,
		[76711] = L.twilight_beguiler,
		[451067] = L.twilight_decapitator,
		[456711] = L.twilight_lavabender,
		[451391] = L.faceless_corruptor,
	}
end

function mod:OnBossEnable()
	-- Twilight Earthcaller
	self:Log("SPELL_CAST_START", "MassTremor", 451871)

	-- Twilight Destroyer
	self:Log("SPELL_AURA_APPLIED", "TwilightFlameApplied", 451613)
	self:Log("SPELL_CAST_START", "UmbralWind", 451939)

	-- Twilight Beguiler
	self:Log("SPELL_CAST_START", "SearMind", 76711)

	-- Twilight Warlock
	-- TODO Enveloping Shadowflame

	-- Twilight Decapitator
	self:Log("SPELL_CAST_START", "Decapitate", 451067)

	-- Twilight Lavabender
	self:Log("SPELL_CAST_START", "ShadowlavaBlast", 456711)
	self:Log("SPELL_CAST_START", "DarkEruption", 456713)
	self:Log("SPELL_CAST_START", "Ascension", 451387)

	-- Faceless Corruptor
	self:Log("SPELL_CAST_START", "MindPiercer", 451391)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Twilight Earthcaller

function mod:MassTremor(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Twilight Destroyer

function mod:TwilightFlameApplied(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Twilight Flame")
	end
end

function mod:UmbralWind(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Twilight Beguiler

function mod:SearMind(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Twilight Decapitator

function mod:Decapitate(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
end

-- Twilight Lavabender

function mod:ShadowlavaBlast(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

function mod:DarkEruption(args)
	-- TODO targetscan?
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:Ascension(args)
	self:Message(args.spellId, "cyan", CL.percent:format(50, args.spellName))
	self:PlaySound(args.spellId, "info")
end

-- Faceless Corruptor

do
	local prev = 0
	function mod:MindPiercer(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end
