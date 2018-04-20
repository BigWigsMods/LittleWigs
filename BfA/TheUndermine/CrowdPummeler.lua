if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Coin-Operated Crowd Pummeler", 1594, 2109)
if not mod then return end
mod:RegisterEnableMob(129214) -- Coin-Operated Crowd Pummeler
mod.engageId = 2105

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		269493, -- Footbomb Launcher
		256493, -- Blazing Azerite
		262347, -- Static Pulse
		257337, -- Chocking Claw
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "FootbombLauncher", 269493)
	self:Log("SPELL_AURA_APPLIED", "BlazingAzerite", 256493)
	self:Log("SPELL_AURA_APPLIED_DOSE", "BlazingAzerite", 256493)
	self:Log("SPELL_CAST_START", "StaticPulse", 262347)
	self:Log("SPELL_CAST_START", "ChockingClaw", 257337)
end

function mod:OnEngage()
	self:Bar(262347, 9) -- Static Pulse
	self:Bar(269493, 14.5) -- Footbomb Launcher
	self:Bar(257337, 25.5) -- Chocking Claw
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:FootbombLauncher(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "long")
	self:Bar(args.spellId, 33)
end

function mod:BlazingAzerite(args)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "alarm")
		self:StackMessage(args.spellId, args.destName, args.amount, "blue")
	elseif UnitGUID("boss1") == args.destGUID then
		self:PlaySound(args.spellId, "info")
		self:StackMessage(args.spellId, args.destName, args.amount, "green")
		self:TargetBar(args.spellId, 15, args.destName) -- XXX Stacks on bar?
	end
end

function mod:StaticPulse(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert", "knockback")
	self:Bar(args.spellId, 33)
end

function mod:ChockingClaw(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm", "watchfront")
	self:Bar(args.spellId, 33)
end
