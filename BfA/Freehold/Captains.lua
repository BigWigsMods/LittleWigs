if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

--------------------------------------------------------------------------------
-- TODO:
-- -- Lucky Sevens positive buff message?

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Council o' Captains", 1754, 2093)
if not mod then return end
mod:RegisterEnableMob(126847, 126848, 126845) -- Captain Raoul, Captain Eudora, Captain Jolly
mod.engageId = 2094

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		258338, -- Blackout Barrel
		256589, -- Barrel Smash
		258381, -- Grape Shot
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "BlackoutBarrel", 258338)
	self:Log("SPELL_CAST_START", "BarrelSmash", 256589)
	self:Log("SPELL_CAST_SUCCESS", "GrapeShot", 258381)
end

function mod:OnEngage()
	self:Bar(256589, 6) -- Barrel Smash
	self:Bar(258381, 8.5) -- Grape Shot
	self:Bar(258338, 19.4) -- Blackout Barrel
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:BlackoutBarrel(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert", "killadd")
	self:CDBar(args.spellId, 47)
end

function mod:BarrelSmash(args)
	self:Message(args.spellId, "orange", nil, CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "long", "watchaoe")
	self:CastBar(args.spellId, 7) -- 3s Cast, 4s Channel
	self:CDBar(args.spellId, 23)
end

function mod:GrapeShot(args)
	self:Message(args.spellId, "red", nil, CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning", "watchstep")
	self:CDBar(args.spellId, 30.4)
end
