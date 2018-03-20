if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Mogul Razzdunk", 1594, 2116)
if not mod then return end
mod:RegisterEnableMob(132713)
mod.engageId = 2108

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		260279, -- Gatling Gun
		260811, -- Homing Missile
		260202, -- Drill Smash
		270277, -- Big Red Rocket
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "GatlingGun", 260279)
	self:Log("SPELL_CAST_SUCCESS", "HomingMissile", 260811)
	self:Log("SPELL_CAST_START", "DrillSmash", 260202)
	self:Log("SPELL_CAST_START", "BigRedRocket", 270277)
end

function mod:OnEngage()
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:GatlingGun(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

function mod:HomingMissile(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning", "killmob") -- XXX can you attack the Missle?
end

function mod:DrillSmash(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert", "watchstep")
end

function mod:BigRedRocket(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
end
