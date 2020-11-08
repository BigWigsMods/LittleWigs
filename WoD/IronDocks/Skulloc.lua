
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Skulloc", 1195, 1238)
if not mod then return end
mod:RegisterEnableMob(83612, 83613, 83616) -- Skulloc, Koramar, Zoggosh
mod.engageId = 1754
mod.respawnTime = 33

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		168227, -- Gronn Smash
		{168929, "FLASH"}, -- Cannon Barrage
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "GronnSmash", 168227)
	self:Log("SPELL_CAST_START", "CannonBarrage", 168929)
	self:Death("SkullocDeath", 83612)
end

function mod:OnEngage()
	self:CDBar(168227, 30) -- Gronn Smash
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:GronnSmash(args)
	self:MessageOld(args.spellId, "orange", "warning")
	self:CDBar(args.spellId, 60)
end

function mod:CannonBarrage(args)
	self:MessageOld(args.spellId, "yellow", "long")
	self:Flash(args.spellId)
end

function mod:SkullocDeath()
	self:StopBar(168227) -- Gronn Smash
end
