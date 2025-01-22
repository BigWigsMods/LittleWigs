local isElevenDotOne = select(4, GetBuildInfo()) >= 110100 -- XXX remove when 11.1 is live
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

if isElevenDotOne then
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
else -- XXX remove in 11.1
	function mod:GetOptions()
		return {
			269493, -- Footbomb Launcher
			256493, -- Blazing Azerite
			271903, -- Coin Magnet
			271867, -- Pay to Win
			262347, -- Static Pulse
			257337, -- Shocking Claw
			271784, -- Throw Coins
		}
	end
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "FootbombLauncher", 269493)
	self:Log("SPELL_AURA_APPLIED", "BlazingAzeriteApplied", 256493)
	self:Log("SPELL_AURA_APPLIED_DOSE", "BlazingAzeriteApplied", 256493)
	self:Log("SPELL_CAST_START", "CoinMagnet", 271903)
	self:Log("SPELL_AURA_APPLIED", "PayToWinApplied", 271867)
	self:Log("SPELL_AURA_APPLIED_DOSE", "PayToWinApplied", 271867)
	self:Log("SPELL_CAST_START", "StaticPulse", 262347)
	if isElevenDotOne then
		self:Log("SPELL_CAST_START", "ShockingClaw", 1217294)
	else -- XXX remove in 11.1
		self:Log("SPELL_CAST_START", "ShockingClaw", 257337)
	end
	self:Log("SPELL_CAST_SUCCESS", "ThrowCoins", 271784)
end

function mod:OnEngage()
	if isElevenDotOne then
		self:CDBar(262347, 6.1) -- Static Pulse
		self:CDBar(269493, 19.1) -- Footbomb Launcher
		self:CDBar(1217294, 30.0) -- Shocking Claw
		self:CDBar(271903, 41.0) -- Coin Magnet
	else -- XXX remove when 11.1 is live
		self:CDBar(262347, 6.1) -- Static Pulse
		self:CDBar(269493, 9.7) -- Footbomb Launcher
		self:CDBar(257337, 14.2) -- Shocking Claw
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:FootbombLauncher(args)
	self:Message(args.spellId, "cyan")
	if isElevenDotOne then
		self:CDBar(args.spellId, 47.4)
	else -- XXX remove in 11.1
		self:CDBar(args.spellId, 34)
	end
	self:PlaySound(args.spellId, "long")
end

function mod:BlazingAzeriteApplied(args)
	if self:Me(args.destGUID) then -- XXX this no longer seems possible
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
	if isElevenDotOne then -- XXX remove check in 11.1
		self:CDBar(args.spellId, 43.8)
	end
	if self:Tank() then
		self:PlaySound(args.spellId, "info")
	end
end

do
	local amount = 0
	local timerStarted = false

	local function warn()
		timerStarted = false
		mod:Message(271867, "red", CL.stack:format(amount, mod:SpellName(271867), CL.boss)) -- Pay to Win
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
	self:Message(args.spellId, "yellow")
	if isElevenDotOne then
		self:CDBar(args.spellId, 43.8)
	else -- XXX remove in 11.1
		self:CDBar(args.spellId, 23)
	end
	self:PlaySound(args.spellId, "alert")
end

function mod:ShockingClaw(args)
	self:Message(args.spellId, "orange")
	if isElevenDotOne then
		self:CDBar(args.spellId, 48.6)
	else -- XXX remove in 11.1
		self:CDBar(args.spellId, 33)
	end
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
