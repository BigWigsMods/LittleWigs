
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
		{271784, "TANK"}, -- Throw Coins
		271867, -- Pay to Win
	}, {
		[269493] = "general",
		[271784] = "heroic",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "FootbombLauncher", 269493)
	self:Log("SPELL_AURA_APPLIED", "BlazingAzerite", 256493)
	self:Log("SPELL_AURA_APPLIED_DOSE", "BlazingAzerite", 256493)
	self:Log("SPELL_CAST_START", "StaticPulse", 262347)
	self:Log("SPELL_CAST_START", "ShockingClaw", 257337)
	self:Log("SPELL_CAST_SUCCESS", "ThrowCoins", 271784)
	self:Log("SPELL_AURA_APPLIED", "PayToWin", 271867)
	self:Log("SPELL_AURA_APPLIED_DOSE", "PayToWin", 271867)
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
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "long")
	self:Bar(args.spellId, 34)
end

do
	local prev = ""
	function mod:BlazingAzerite(args)
		if self:Me(args.destGUID) then
			self:PlaySound(args.spellId, "alarm")
			self:StackMessageOld(args.spellId, args.destName, args.amount, "blue")
		elseif self:UnitGUID("boss1") == args.destGUID then
			self:PlaySound(args.spellId, "info")
			self:StackMessageOld(args.spellId, args.destName, args.amount, "green")
			self:StopBar(prev, args.destName)
			prev = CL.count:format(args.spellName, args.amount or 1)
			self:TargetBar(args.spellId, 15, args.destName, prev)
		end
	end
end

function mod:StaticPulse(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert", "knockback")
	self:Bar(args.spellId, 23)
end

function mod:ShockingClaw(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm", "watchfront")
	self:CDBar(args.spellId, 33)
end

do
	local prev = 0
	function mod:ThrowCoins(args)
		local t = args.time
		if t-prev > 5 then
			prev = t
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

do
	local stacks = 0
	local timerStarted = false

	local function warn()
		timerStarted = false
		mod:StackMessageOld(271867, mod.displayName, stacks, "red") -- Coin Magnet
		mod:PlaySound(271867, "alarm") -- Coin Magnet
	end

	function mod:PayToWin(args)
		stacks = args.amount
		if not timerStarted then
			timerStarted = true
			self:SimpleTimer(warn, 0.3)
		end
	end
end
