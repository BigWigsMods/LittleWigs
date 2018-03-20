if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Coin-operated Crowd Pummeler", 1594, 2109)
if not mod then return end
mod:RegisterEnableMob(131224, 129214) -- XXX Won't need both
mod.engageId = 2105

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		262347, -- Static Pulse
		257337, -- Chocking Claw
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "StaticPulse", 262347)
	self:Log("SPELL_CAST_START", "ChockingClaw", 257337)
end

function mod:OnEngage()
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:StaticPulse(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert", "knockback")
end

function mod:ChockingClaw(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm", "watchfront")
end
