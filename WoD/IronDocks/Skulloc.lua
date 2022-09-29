--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Skulloc", 1195, 1238)
if not mod then return end
mod:RegisterEnableMob(83612, 83613, 83616) -- Skulloc, Koramar, Zoggosh
mod:SetEncounterID(1754)
mod:SetRespawnTime(33)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		168227, -- Gronn Smash
		{168929, "FLASH"}, -- Cannon Barrage
		168965, -- Berserker Leap
		168348, -- Rapid Fire
	}, {
		[168227] = -10747, -- Skulloc
		[168965] = -10425, -- Koramar
		[168348] = -10429, -- Zoggosh
	}
end

function mod:OnBossEnable()
	-- Skulloc
	self:Log("SPELL_CAST_START", "GronnSmash", 168227)
	self:Log("SPELL_CAST_START", "CannonBarrage", 168929)
	self:Log("SPELL_CAST_SUCCESS", "EncounterEvent", 181089) -- Cannon Barrage ends
	self:Death("SkullocDeath", 83612)

	-- Koramar
	self:Log("SPELL_AURA_APPLIED", "BerserkerLeap", 168965)
	self:Death("KoramarDeath", 83613)

	-- Zoggosh
	self:Log("SPELL_AURA_APPLIED", "RapidFire", 168398)
end

function mod:OnEngage()
	self:Bar(168227, 30) -- Gronn Smash
	self:CDBar(168965, 8.4) -- Berserker Leap
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Skulloc

function mod:GronnSmash(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "long")
	self:StopBar(168965) -- Berserker Leap
	self:StopBar(168348) -- Rapid Fire
end

function mod:CannonBarrage(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:Flash(args.spellId)
end

function mod:EncounterEvent() -- Cannon Barrage ends
	self:Message(168929, "green", CL.over:format(self:SpellName(168929)))
	self:PlaySound(168929, "info")
	self:Bar(168227, 40.7) -- Gronn Smash
end

function mod:SkullocDeath()
	self:StopBar(168227) -- Gronn Smash
end

-- Koramar

function mod:BerserkerLeap(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 19.5)
end

function mod:KoramarDeath()
	self:StopBar(168965) -- Berserker Leap
	self:StopBar(168348) -- Rapid Fire
end

-- Zoggosh

function mod:RapidFire(args)
	local isOnMe = self:Me(args.destGUID)
	self:TargetMessage(168348, "red", args.destName)
	self:PlaySound(168348, isOnMe and "warning" or "alert", nil, args.destName)
	self:Bar(168348, 12.2)
end
