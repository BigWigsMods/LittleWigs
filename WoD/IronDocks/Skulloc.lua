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
		168348, -- Rapid Fire
	}, {
		[168227] = -10747, -- Skulloc
		--[168227] = -10425, -- Koramar
		[168348] = -10429, -- Zoggosh
	}
end

function mod:OnBossEnable()
	-- Skulloc
	self:Log("SPELL_CAST_START", "GronnSmash", 168227)
	self:Log("SPELL_CAST_START", "CannonBarrage", 168929)
	self:Death("SkullocDeath", 83612)

	-- Koramar
	-- TODO bladestorm? shattering blade? berserker leap?

	-- Zoggosh
	self:Log("SPELL_AURA_APPLIED", "RapidFire", 168398)
end

function mod:OnEngage()
	self:CDBar(168227, 30) -- Gronn Smash
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Skulloc

function mod:GronnSmash(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 60)
end

function mod:CannonBarrage(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:Flash(args.spellId)
end

function mod:SkullocDeath()
	self:StopBar(168227) -- Gronn Smash
end

-- Zoggosh

function mod:RapidFire(args)
	local isOnMe = self:Me(args.destGUID)
	self:TargetMessage(168348, "red", args.destName)
	self:PlaySound(168348, isOnMe and "warning" or "alert")
end
