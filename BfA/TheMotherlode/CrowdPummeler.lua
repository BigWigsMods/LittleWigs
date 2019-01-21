
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Coin-Operated Crowd Pummeler", 1594, 2109)
if not mod then return end
mod:RegisterEnableMob(129214) -- Coin-Operated Crowd Pummeler
mod.engageId = 2105
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		269493, -- Footbomb Launcher
		256493, -- Blazing Azerite
		262347, -- Static Pulse
		257337, -- Shocking Claw
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "FootbombLauncher", 269493)
	self:Log("SPELL_AURA_APPLIED", "BlazingAzerite", 256493)
	self:Log("SPELL_AURA_APPLIED_DOSE", "BlazingAzerite", 256493)
	self:Log("SPELL_CAST_START", "StaticPulse", 262347)
	self:Log("SPELL_CAST_START", "ShockingClaw", 257337)
end

function mod:OnEngage()
	self:Bar(262347, 6) -- Static Pulse
	self:Bar(269493, 9.7) -- Footbomb Launcher
	self:Bar(257337, 14.2) -- Shocking Claw
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:FootbombLauncher(args)
	self:Message2(args.spellId, "cyan")
	self:PlaySound(args.spellId, "long")
	self:Bar(args.spellId, 34)
end

do
	local prev = ""
	function mod:BlazingAzerite(args)
		if self:Me(args.destGUID) then
			self:PlaySound(args.spellId, "alarm")
			self:StackMessage(args.spellId, args.destName, args.amount, "blue")
		elseif UnitGUID("boss1") == args.destGUID then
			self:PlaySound(args.spellId, "info")
			self:StackMessage(args.spellId, args.destName, args.amount, "green")
			self:StopBar(prev, args.destName)
			prev = CL.count:format(args.spellName, args.amount or 1)
			self:TargetBar(args.spellId, 15, args.destName, prev)
		end
	end
end

function mod:StaticPulse(args)
	self:Message2(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert", "knockback")
	self:Bar(args.spellId, 23)
end

function mod:ShockingClaw(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm", "watchfront")
	self:CDBar(args.spellId, 33)
end
