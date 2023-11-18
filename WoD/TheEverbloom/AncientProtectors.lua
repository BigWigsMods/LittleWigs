--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ancient Protectors", 1279, 1207)
if not mod then return end
mod:RegisterEnableMob(
	83892, -- Life Warden Gola
	83893, -- Earthshaper Telu
	83894  -- Dulhu
)
mod:SetEncounterID(1757)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local lifeWardenGolaDefeated = false
local earthshaperTeluDefeated = false
local revitalizeCount = 1
local toxicBloomCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Life Warden Gola
		168082, -- Revitalize
		{427498, "OFF"}, -- Torrential Fury
		-- Earthshaper Telu
		427459, -- Toxic Bloom
		{427509, "OFF"}, -- Terrestrial Fury
		-- Dulhu
		{427510, "CASTBAR", "CASTBAR_COUNTDOWN"}, -- Noxious Charge
	}, {
		[168082] = -10409, -- Life Warden Gola
		[427459] = -10413, -- Earthshaper Telu
		[427510] = -10417, -- Dulhu
	}
end

function mod:OnBossEnable()
	-- Life Warden Gola
	self:Log("SPELL_CAST_START", "Revitalize", 168082)
	self:Log("SPELL_CAST_START", "TorrentialFury", 427498)
	self:Death("LifeWardenGolaDeath", 83892)

	-- Earthshaper Telu
	self:Log("SPELL_CAST_START", "ToxicBloom", 427459)
	self:Log("SPELL_CAST_START", "TerrestrialFury", 427509)
	self:Death("EarthshaperTeluDeath", 83893)

	-- Dulhu
	self:Log("SPELL_AURA_APPLIED", "NoxiousCharge", 427510)
	self:Death("DulhuDeath", 83894)
end

function mod:OnEngage()
	lifeWardenGolaDefeated = false
	earthshaperTeluDefeated = false
	revitalizeCount = 1
	toxicBloomCount = 1
	self:CDBar(427498, 1.0) -- Torrential Fury
	self:CDBar(427459, 7.1) -- Toxic Bloom
	self:CDBar(427510, 12.1) -- Noxious Charge
	self:CDBar(427509, 26.5) -- Terrestrial Fury
	self:CDBar(168082, 31.5) -- Revitalize
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Life Warden Gola

function mod:Revitalize(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
	revitalizeCount = revitalizeCount + 1
	if earthshaperTeluDefeated or revitalizeCount % 2 == 0 then
		self:CDBar(args.spellId, 17.0)
	else
		self:CDBar(args.spellId, 31.6)
	end
end

function mod:TorrentialFury(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "long")
	if not earthshaperTeluDefeated then
		-- this will not be cast again if Earthshaper Telu has been defeated
		self:CDBar(args.spellId, 52.1)
	end
end

function mod:LifeWardenGolaDeath(args)
	lifeWardenGolaDefeated = true
	self:StopBar(168082) -- Revitalize
	self:StopBar(427498) -- Torrential Fury
	-- Life Warden Gola dying stops Earthshaper Telu from casting Terrestrial Fury
	self:StopBar(427509) -- Terrestrial Fury
end

-- Earthshaper Telu

function mod:ToxicBloom(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
	toxicBloomCount = toxicBloomCount + 1
	if lifeWardenGolaDefeated or toxicBloomCount % 2 == 0 then
		self:CDBar(args.spellId, 17.0)
	else
		self:CDBar(args.spellId, 31.6)
	end
end

function mod:TerrestrialFury(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "long")
	if not lifeWardenGolaDefeated then
		-- this will not be cast again if Life Warden Gola has been defeated
		self:CDBar(args.spellId, 52.1)
	end
end

function mod:EarthshaperTeluDeath(args)
	earthshaperTeluDefeated = true
	self:StopBar(427459) -- Toxic Bloom
	self:StopBar(427509) -- Terrestrial Fury
	-- Earthshaper Telu dying stops Life Warden Gola from casting Torrential Fury
	self:StopBar(427498) -- Torrential Fury
end

-- Dulhu

function mod:NoxiousCharge(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	self:CastBar(args.spellId, 4)
	self:CDBar(args.spellId, 17.0)
end

function mod:DulhuDeath(args)
	self:StopBar(CL.cast:format(self:SpellName(427510))) -- Noxious Charge
	self:StopBar(427510) -- Noxious Charge
end
