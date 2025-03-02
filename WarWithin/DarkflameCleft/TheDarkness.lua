--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Darkness", 2651, 2561)
if not mod then return end
mod:RegisterEnableMob(
	212777, -- Massive Candle
	208747 -- The Darkness
)
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
		{427011, "SAY", "SAY_COUNTDOWN", "ME_ONLY_EMPHASIZE"}, -- Shadowblast
		-- Mythic
		428266, -- Eternal Darkness
		-- Wriggling Darkspawn
		427176, -- Drain Light
	}, {
		[428266] = CL.mythic,
		[427176] = L.wriggling_darkspawn,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "RisingGloom", 426943)
	self:Log("SPELL_CAST_SUCCESS", "CallDarkspawn", 427157)
	self:Log("SPELL_CAST_START", "UmbralSlash", 427025)
	self:Log("SPELL_CAST_START", "Shadowblast", 427011)
	self:Log("SPELL_AURA_APPLIED", "ShadowblastApplied", 427015)

	-- Mythic
	self:Log("SPELL_CAST_START", "EternalDarkness", 428266)

	-- Wriggling Darkspawn
	self:Log("SPELL_CAST_START", "DrainLight", 427176)
end

function mod:OnEngage()
	risingGloomCount = 1
	self:CDBar(427011, 10.9) -- Shadowblast
	self:CDBar(427025, 20.4) -- Umbral Slash
	if self:Mythic() then
		self:CDBar(427157, 26.7) -- Call Darkspawn
		self:CDBar(428266, 31.7) -- Eternal Darkness
	else
		self:CDBar(427157, 30.0) -- Call Darkspawn
	end
end

function mod:VerifyEnable(unit)
	-- encounter ends at 55%
	return self:GetHealth(unit) > 55
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:RisingGloom(args)
	-- this happens when your Candlelight hits 0%
	self:Message(args.spellId, "yellow", CL.count:format(args.spellName, risingGloomCount))
	risingGloomCount = risingGloomCount + 1
	self:PlaySound(args.spellId, "warning")
end

function mod:CallDarkspawn(args)
	self:Message(args.spellId, "cyan", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 46.1)
	self:PlaySound(args.spellId, "alert")
end

function mod:UmbralSlash(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 30.3)
	self:PlaySound(args.spellId, "alarm")
end

function mod:Shadowblast(args)
	self:CDBar(args.spellId, 30.3)
end

function mod:ShadowblastApplied(args)
	self:TargetMessage(427011, "red", args.destName)
	if self:Me(args.destGUID) then
		self:Say(427011, nil, nil, "Shadowblast")
		self:SayCountdown(427011, 6)
	end
	self:PlaySound(427011, "alarm", nil, args.destName)
end

-- Mythic

function mod:EternalDarkness(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 63.1)
	self:PlaySound(args.spellId, "long")
end

-- Wriggling Darkspawn

do
	local prev = 0
	function mod:DrainLight(args)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end
