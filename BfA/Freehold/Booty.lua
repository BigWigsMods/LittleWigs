
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ring of Booty", 1754, 2094)
if not mod then return end
mod:RegisterEnableMob(
	130086, -- Davey "Two Eyes"
	129350, -- Gurgthock
	130099, -- Lightning
	129699, -- Ludwig Von Tortollan
	126969 -- Trothak
)
mod.engageId = 2095
mod.respawnTime = 25

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.custom_on_autotalk = "Autotalk"
	L.custom_on_autotalk_desc = "Instantly selects the gossip option to start the fight."

	-- Gather 'round and place yer bets! We got a new set of vict-- uh... competitors! Take it away, Gurgthok and Wodin!
	L.lightning_warmup = "new set of vict--"
	-- It's a greased up pig? I'm beginning to think this is not a professional setup. Oh well... grab the pig and you win
	L.lightning_warmup_2 = "not a professional setup"

	L.lightning = "Lightning"
	L.lightning_caught = "Lightning caught after %.1f seconds!"
	L.ludwig = "Ludwig Von Tortollan"
	L.trothak = "Trothak"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"custom_on_autotalk",
		"warmup",
		-- Lightning
		257829, -- Greasy
		-- Ludwig Von Tortollen
		257904, -- Shell Bounce
		-- Trothak
		256405, -- Sharknado
		{256358, "SAY"}, -- Shark Toss
		256489, -- Rearm
	}, {
		[257829] = L.lightning,
		[257904] = L.ludwig,
		[256405] = L.trothak,
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("GOSSIP_SHOW")

	-- Lightning
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "Warmup")
	self:RegisterEvent("CHAT_MSG_MONSTER_SAY", "Warmup")
	self:Log("SPELL_AURA_APPLIED", "GreasyApplied", 257829)
	self:Log("SPELL_AURA_REMOVED_DOSE", "GreasyRemoved", 257829)
	self:Log("SPELL_AURA_REMOVED", "GreasyRemoved", 257829)

	-- Ludwig Von Tortollan
	self:Log("SPELL_CAST_START", "ShellBounce", 257904)
	self:Death("TortollanDeath", 129699)

	-- Trothak
	self:Log("SPELL_CAST_START", "Sharknado", 256405)
	self:Log("SPELL_CAST_SUCCESS", "SharkToss", 256358)
	self:Log("SPELL_CAST_START", "Rearm", 256489)
end

function mod:OnEngage()
	self:UnregisterEvent("CHAT_MSG_MONSTER_YELL")
	self:UnregisterEvent("CHAT_MSG_MONSTER_SAY")

	self:CDBar(256358, 14) -- Shark Toss
	self:CDBar(256405, 23) -- Sharknado
	self:CDBar(256489, 46) -- Rearm
end

function mod:VerifyEnable(_, mobId)
	if mobId == 130086 or mobId == 129350 then -- friendly NPCs
		local _, _, completed = C_Scenario.GetCriteriaInfo(3)
		return not completed
	end
	return true
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:GOSSIP_SHOW()
	if self:GetOption("custom_on_autotalk") and self:MobId(self:UnitGUID("npc")) == 130086 then
		if self:GetGossipOptions() then
			self:SelectGossipOption(1, true) -- auto confirm it
		end
	end
end

-- Lightning
function mod:Warmup(_, msg)
	if msg:find(L.lightning_warmup, nil, true) then
		self:UnregisterEvent("CHAT_MSG_MONSTER_YELL")
		self:UnregisterEvent("CHAT_MSG_MONSTER_SAY")
		self:Bar("warmup", 62, L.lightning, "achievement_dungeon_freehold")
	elseif msg:find(L.lightning_warmup_2, nil, true) then
		self:UnregisterEvent("CHAT_MSG_MONSTER_YELL")
		self:UnregisterEvent("CHAT_MSG_MONSTER_SAY")
		self:Bar("warmup", 9.5, L.lightning, "achievement_dungeon_freehold")
	end
end

do
	local seconds = 0
	function mod:GreasyApplied(args)
		seconds = args.time
	end

	function mod:GreasyRemoved(args)
		if args.amount then -- Slippery when oily
			self:StackMessage(args.spellId, args.destName, args.amount, "cyan")
			self:PlaySound(args.spellId, "info")
		else -- Caught!
			seconds = math.floor((args.time - seconds) * 100)/100
			self:Message(args.spellId, "green", L.lightning_caught:format(seconds))
			self:Bar("warmup", 24, L.ludwig, "achievement_dungeon_freehold")
			self:PlayVictorySound()
		end
	end
end

-- Ludwig Von Tortollan
function mod:ShellBounce(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:TortollanDeath()
	self:Bar("warmup", 35, L.trothak, "achievement_dungeon_freehold")
end

-- Trothak
function mod:Sharknado(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning", "runout")
	self:Bar(args.spellId, 40)
end

do
	local prev = 0
	function mod:SharkToss(args)
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "alert", "watchstep", args.destName)
		if self:Me(args.destGUID) then
			self:Say(args.spellId)
		end
		local t = args.time
		-- Starts with either 20s or 30s timer and then alternates
		self:CDBar(args.spellId, t-prev < 25 and 30 or 20)
		prev = t
	end
end

function mod:Rearm(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
	self:Bar(args.spellId, 40)
end
