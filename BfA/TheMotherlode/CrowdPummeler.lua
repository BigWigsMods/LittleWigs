--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Coin-Operated Crowd Pummeler", 1594, 2109)
if not mod then return end
mod:RegisterEnableMob(129214) -- Coin-Operated Crowd Pummeler
mod:SetEncounterID(2105)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.warmup_icon = "achievement_dungeon_kezan"
end

--------------------------------------------------------------------------------
-- Locals
--

local footbombLauncherCount = 1
local shockingClawCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
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
	footbombLauncherCount = 1
	shockingClawCount = 1
	self:StopBar(CL.active)
	self:CDBar(262347, 6.1) -- Static Pulse
	self:CDBar(269493, 19.1) -- Footbomb Launcher
	self:CDBar(1217294, 30.0) -- Shocking Claw
	self:CDBar(271903, 41.0) -- Coin Magnet
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Warmup() -- called from trash module
	-- 17.84 [CLEU] SPELL_CAST_START#Creature-0-3024-1594-15510-144231#Rowdy Reveler##nil#267546#Pony Up
	-- 17.98 [CHAT_MSG_MONSTER_YELL] Hurry! They're comin'!#Rowdy Reveler
	-- 20.79 [CHAT_MSG_MONSTER_YELL] Don't rush me! I'm readin' the license agreement!#Rowdy Reveler
	-- 26.04 [CHAT_MSG_MONSTER_YELL] They're gonna kill us!#Rowdy Reveler
	-- 26.89 [CLEU] SPELL_CAST_START#Creature-0-3024-1594-15510-144231#Rowdy Reveler(100.0%-0.0%)##nil#267546#Pony Up
	-- 29.62 [CHAT_MSG_MONSTER_YELL] Okay, okay! Wait... should I purchase an extended warranty?#Rowdy Reveler
	-- 38.71 [CHAT_MSG_MONSTER_YELL] Moron! NEVER purchase the extended warranty!#Rowdy Reveler
	-- 44.94 [CHAT_MSG_MONSTER_YELL] Venture Company thanks you for your patronage. Please enjoy your purchase of the [basic|elite] pummeling package.#Coin-Operated Crowd Pummeler
	-- 48.38 [NAME_PLATE_UNIT_ADDED] Coin-Operated Crowd Pummeler#Creature-0-3024-1594-15510-129214
	self:Bar("warmup", 30.2, CL.active, L.warmup_icon)
end

function mod:FootbombLauncher(args)
	self:Message(args.spellId, "cyan")
	footbombLauncherCount = footbombLauncherCount + 1
	if footbombLauncherCount == 2 then
		self:CDBar(args.spellId, 46.3)
	else -- 3+
		self:CDBar(args.spellId, 42.5)
	end
	self:PlaySound(args.spellId, "long")
end

function mod:BlazingAzeriteApplied(args)
	local amount = args.amount or 1
	self:Message(args.spellId, "green", CL.stackboss:format(amount, args.spellName))
	self:PlaySound(args.spellId, "info")
end

function mod:CoinMagnet(args)
	self:Message(args.spellId, "purple")
	self:CDBar(args.spellId, 43.7)
	if self:Tank() then
		self:PlaySound(args.spellId, "info")
	end
end

do
	local amount = 0
	local timerStarted = false

	local function warn()
		timerStarted = false
		mod:Message(271867, "purple", CL.stackboss:format(amount, mod:SpellName(271867))) -- Pay to Win
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
	self:CDBar(args.spellId, 43.7)
	self:PlaySound(args.spellId, "alert")
end

function mod:ShockingClaw(args)
	self:Message(args.spellId, "orange")
	shockingClawCount = shockingClawCount + 1
	if shockingClawCount == 2 then
		self:CDBar(args.spellId, 47.5)
	else -- 3+
		self:CDBar(args.spellId, 43.7)
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
