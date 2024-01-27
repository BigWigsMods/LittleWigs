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
local dulhuDefeated = false
local revitalizeCount = 1
local toxicBloomCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Life Warden Gola
		{168082, "DISPEL"}, -- Revitalize
		{427498, "OFF"}, -- Torrential Fury
		-- Earthshaper Telu
		427459, -- Toxic Bloom
		{427509, "OFF"}, -- Terrestrial Fury
		-- Dulhu
		{427510, "CASTBAR", "CASTBAR_COUNTDOWN"}, -- Noxious Charge
		427513, -- Noxious Discharge
	}, {
		[168082] = -10409, -- Life Warden Gola
		[427459] = -10413, -- Earthshaper Telu
		[427510] = -10417, -- Dulhu
	}
end

function mod:OnBossEnable()
	-- Life Warden Gola
	self:Log("SPELL_CAST_START", "Revitalize", 168082)
	self:Log("SPELL_AURA_APPLIED", "RevitalizeApplied", 168082)
	self:Log("SPELL_CAST_START", "TorrentialFury", 427498)
	self:Death("LifeWardenGolaDeath", 83892)

	-- Earthshaper Telu
	self:Log("SPELL_CAST_START", "ToxicBloom", 427459)
	self:Log("SPELL_CAST_START", "TerrestrialFury", 427509)
	self:Death("EarthshaperTeluDeath", 83893)

	-- Dulhu
	self:Log("SPELL_AURA_APPLIED", "NoxiousCharge", 427510)
	self:Log("SPELL_PERIODIC_DAMAGE", "NoxiousDischargeDamage", 427513) -- no alert on APPLIED, doesn't damage right away
	self:Log("SPELL_PERIODIC_MISSED", "NoxiousDischargeDamage", 427513)
	self:Death("DulhuDeath", 83894)
end

function mod:OnEngage()
	lifeWardenGolaDefeated = false
	earthshaperTeluDefeated = false
	dulhuDefeated = false
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
		-- will be delayed by Torrential Fury
		self:CDBar(args.spellId, 31.6)
	end
end

function mod:RevitalizeApplied(args)
	if self:Dispeller("magic", true, args.spellId) then
		self:Message(args.spellId, "yellow", CL.on:format(args.spellName, args.destName))
		self:PlaySound(args.spellId, "warning")
	end
end

function mod:TorrentialFury(args)
	revitalizeCount = 1
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "long")
	if not earthshaperTeluDefeated then
		-- this will not be cast again if Earthshaper Telu has been defeated
		self:CDBar(args.spellId, 52.1)
	end
	if not earthshaperTeluDefeated and not dulhuDefeated then
		-- this will not be cast as usual if either of the other two bosses have been defeated
		self:CDBar(168082, {30.4, 31.6}) -- Revitalize
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
		-- will be delayed by Terrestrial Fury
		self:CDBar(args.spellId, 31.6)
	end
end

function mod:TerrestrialFury(args)
	toxicBloomCount = 1
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "long")
	if not lifeWardenGolaDefeated then
		-- this will not be cast again if Life Warden Gola has been defeated
		self:CDBar(args.spellId, 52.1)
	end
	self:CDBar(427459, {30.4, 31.6}) -- Toxic Bloom
end

function mod:EarthshaperTeluDeath(args)
	earthshaperTeluDefeated = true
	self:StopBar(427459) -- Toxic Bloom
	self:StopBar(427509) -- Terrestrial Fury
	-- Earthshaper Telu dying stops Life Warden Gola from casting Torrential Fury and Revitalize
	self:StopBar(427498) -- Torrential Fury
	self:StopBar(168082) -- Revitalize
end

-- Dulhu

function mod:NoxiousCharge(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	self:CastBar(args.spellId, 4)
	self:CDBar(args.spellId, 17.0)
end

do
	local prev = 0
	function mod:NoxiousDischargeDamage(args)
		local t = args.time
		-- don't alert for tanks, this spawns instantly under them after Noxious Charge,
		-- while other roles have the projectile's travel time to move away.
		if t - prev > 1.5 and not self:Tank() and self:Me(args.destGUID) then
			prev = t
			self:PersonalMessage(args.spellId, "underyou")
			self:PlaySound(args.spellId, "underyou", nil, args.destName)
		end
	end
end

function mod:DulhuDeath(args)
	dulhuDefeated = true
	self:StopBar(CL.cast:format(self:SpellName(427510))) -- Noxious Charge
	self:StopBar(427510) -- Noxious Charge
	-- Dulhu dying stops Life Warden Gola from casting Revitalize
	self:StopBar(168082) -- Revitalize
end
