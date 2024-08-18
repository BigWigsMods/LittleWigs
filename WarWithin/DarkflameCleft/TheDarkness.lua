--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Darkness", 2651, 2561)
if not mod then return end
mod:RegisterEnableMob(208747) -- The Darkness
mod:SetEncounterID(2788)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local risingGloomCount = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.wriggling_darkspawn = "Wriggling Darkspawn"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		426943, -- Rising Gloom
		427157, -- Call Darkspawn
		427025, -- Umbral Slash
		{427015, "ME_ONLY_EMPHASIZE"}, -- Shadowblast
		-- TODO Eternal Darkness (Mythic)
		-- Wriggling Darkspawn
		427176, -- Drain Light
	}, {
		[427176] = L.wriggling_darkspawn, -- Wriggling Darkspawn
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "RisingGloom", 426943)
	self:Log("SPELL_CAST_SUCCESS", "CallDarkspawn", 427157)
	self:Log("SPELL_CAST_START", "UmbralSlash", 427025)
	self:Log("SPELL_AURA_APPLIED", "Shadowblast", 427015)

	-- Wriggling Darkspawn
	self:Log("SPELL_CAST_START", "DrainLight", 427176)
end

function mod:OnEngage()
	risingGloomCount = 1
	self:CDBar(427015, 10.9) -- Shadowblast
	self:CDBar(427025, 20.4) -- Umbral Slash
	self:CDBar(427157, 30.0) -- Call Darkspawn
end

function mod:VerifyEnable(unit)
	-- encounter ends at 45%
	return self:GetHealth(unit) > 45
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:RisingGloom(args)
	-- this happens when your Candlelight hits 0%
	self:Message(args.spellId, "yellow", CL.count:format(args.spellName, risingGloomCount))
	self:PlaySound(args.spellId, "warning")
	risingGloomCount = risingGloomCount + 1
end

function mod:CallDarkspawn(args)
	self:Message(args.spellId, "cyan", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 46.1)
end

function mod:UmbralSlash(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 30.3)
end

function mod:Shadowblast(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
	self:CDBar(args.spellId, 30.3)
end

-- Wriggling Darkspawn

function mod:DrainLight(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end
