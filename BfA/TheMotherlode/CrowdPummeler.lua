--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Coin-Operated Crowd Pummeler", 1594, 2109)
if not mod then return end
mod:RegisterEnableMob(129214) -- Coin-Operated Crowd Pummeler
mod:SetEncounterID(2105)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		269493, -- Footbomb Launcher
		256493, -- Blazing Azerite
		271903, -- Coin Magnet
		271867, -- Pay to Win
		262347, -- Static Pulse
		1217294, -- Shocking Claw
		271784, -- Throw Coins
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "FootbombLauncher", 269493)
	self:Log("SPELL_AURA_APPLIED", "BlazingAzeriteApplied", 256493)
	self:Log("SPELL_AURA_APPLIED_DOSE", "BlazingAzeriteApplied", 256493)
	self:Log("SPELL_CAST_START", "CoinMagnet", 271903)
	self:Log("SPELL_AURA_APPLIED", "PayToWinApplied", 271867)
	self:Log("SPELL_AURA_APPLIED_DOSE", "PayToWinApplied", 271867)
	self:Log("SPELL_CAST_START", "StaticPulse", 262347)
	self:Log("SPELL_CAST_START", "ShockingClaw", 1217294)
	self:Log("SPELL_CAST_SUCCESS", "ThrowCoins", 271784)
end

function mod:OnEngage()
	self:CDBar(262347, 6.1) -- Static Pulse
	self:CDBar(269493, 19.1) -- Footbomb Launcher
	self:CDBar(1217294, 30.0) -- Shocking Claw
	self:CDBar(271903, 41.0) -- Coin Magnet
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:FootbombLauncher(args)
	self:Message(args.spellId, "cyan")
	self:CDBar(args.spellId, 47.4)
	self:PlaySound(args.spellId, "long")
end

function mod:BlazingAzeriteApplied(args)
	if self:Me(args.destGUID) then -- XXX this no longer seems possible
		-- TODO it's 270882 on players, but do we care?
		self:StackMessageOld(args.spellId, args.destName, args.amount, "blue")
		self:PlaySound(args.spellId, "alarm")
	elseif self:UnitGUID("boss1") == args.destGUID then
		local amount = args.amount or 1
		self:Message(args.spellId, "green", CL.stack:format(amount, args.spellName, CL.boss))
		self:PlaySound(args.spellId, "info")
	end
end

function mod:CoinMagnet(args)
	self:Message(args.spellId, "purple")
	self:CDBar(args.spellId, 43.8)
	if self:Tank() then
		self:PlaySound(args.spellId, "info")
	end
end

do
	local amount = 0
	local timerStarted = false

	local function warn()
		timerStarted = false
		mod:Message(271867, "purple", CL.stack:format(amount, mod:SpellName(271867), CL.boss)) -- Pay to Win
		mod:PlaySound(271867, "alarm") -- Pay to Win
	end

	function mod:PayToWinApplied(args)
		amount = args.amount or 1
		if not timerStarted then
			timerStarted = true
			self:SimpleTimer(warn, 0.2)
		end
	end
end

function mod:StaticPulse(args)
	self:Message(args.spellId, "red")
	self:CDBar(args.spellId, 43.8)
	self:PlaySound(args.spellId, "alert")
end

function mod:ShockingClaw(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 48.6)
	self:PlaySound(args.spellId, "alarm")
end

do
	local prev = 0
	function mod:ThrowCoins(args)
		-- 5 to 6 casts over ~7 seconds
		if args.time - prev > 8 then
			prev = args.time
			self:Message(args.spellId, "yellow")
			--self:CDBar(args.spellId, 43.7)
			self:PlaySound(args.spellId, "info")
		end
	end
end
