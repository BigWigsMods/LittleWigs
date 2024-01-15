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
mod:SetEncounterID(2095)
mod:SetRespawnTime(25)

--------------------------------------------------------------------------------
-- Locals
--

local ripperPunchCount = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.custom_on_autotalk = "Autotalk"
	L.custom_on_autotalk_desc = "Instantly selects the gossip option to start the fight."
	L.custom_on_autotalk_icon = "ui_chat"

	-- Gather 'round and place yer bets! We got a new set of vict-- uh... competitors! Take it away, Gurgthok and Wodin!
	L.lightning_warmup = "new set of vict--"
	-- It's a greased up pig? I'm beginning to think this is not a professional setup. Oh well... grab the pig and you win
	L.lightning_warmup_2 = "not a professional setup"

	L.lightning = "Lightning"
	L.lightning_caught = "Lightning caught after %.1f seconds!"
	L.ludwig = "Ludwig Von Tortollan"
	L.trothak = "Trothak"

	L.left = "%s (Left)"
	L.right = "%s (Right)"
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
		256405, -- Shark Tornado
		{256358, "SAY"}, -- Shark Toss
		256552, -- Flailing Shark
		256489, -- Rearm
		256363, -- Ripper Punch
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
	self:Log("SPELL_CAST_START", "SharkTornado", 256405)
	self:Log("SPELL_CAST_SUCCESS", "SharkToss", 256358, 256477) -- Boss cast, Shark cast
	self:Log("SPELL_DAMAGE", "FlailingSharkDamage", 256552)
	self:Log("SPELL_MISSED", "FlailingSharkDamage", 256552)
	self:Log("SPELL_CAST_START", "Rearm", 256489, 256494) -- Left, Right
	self:Log("SPELL_CAST_SUCCESS", "RipperPunch", 256363)
end

function mod:OnEngage()
	ripperPunchCount = 1
	self:UnregisterEvent("CHAT_MSG_MONSTER_YELL")
	self:UnregisterEvent("CHAT_MSG_MONSTER_SAY")

	self:CDBar(256363, 9.3) -- Ripper Punch
	self:CDBar(256358, 16.9, L.right:format(self:SpellName(256358))) -- Shark Toss (Right)
	self:CDBar(256405, 23.1) -- Shark Tornado
	self:CDBar(256358, 29.5, L.left:format(self:SpellName(256358))) -- Shark Toss (Left)
	self:CDBar(256489, 30.7, L.right:format(self:SpellName(256494))) -- Rearm (Right)
	self:CDBar(256489, 38.0, L.left:format(self:SpellName(256489))) -- Rearm (Left)
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
	if self:GetOption("custom_on_autotalk") and self:GetGossipID(48039) then
		-- A fight? Bring it on!
		self:SelectGossipID(48039, true) -- auto-confirm
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
	local start = 0
	function mod:GreasyApplied(args)
		start = args.time
	end

	function mod:GreasyRemoved(args)
		if args.amount then -- Slippery when oily
			self:StackMessage(args.spellId, "cyan", args.destName, args.amount, 1)
			self:PlaySound(args.spellId, "info")
		else -- Caught!
			self:Message(args.spellId, "green", L.lightning_caught:format(args.time - start))
			self:Bar("warmup", 24, L.ludwig, "achievement_dungeon_freehold")
			self:PlayVictorySound()
		end
	end
end

-- Ludwig Von Tortollan

function mod:ShellBounce(args)
	-- cast at 90%, 70%, 50%, 30% health
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

function mod:TortollanDeath()
	self:Bar("warmup", 35, L.trothak, "achievement_dungeon_freehold")
end

-- Trothak

function mod:SharkTornado(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning", "runout")
	self:Bar(args.spellId, 26.7)
end

do
	local prev = 0
	function mod:SharkToss(args)
		if args.spellId == 256358 then -- Boss ability, only fires for Right Shark though
			self:TargetMessage(256358, "yellow", args.destName)
			local t = args.time
			if t - prev > 1.5 then
				prev = t
				-- throttle sound because both sharks can be tossed at a time
				self:PlaySound(256358, "alarm", "watchstep", args.destName)
			end
			if self:Me(args.destGUID) then
				self:Say(256358, nil, nil, "Shark Toss")
			end
		else -- 256477, Shark ability, used for timers
			if self:MobId(args.sourceGUID) == 129448 then -- Hammer Shark (Left)
				-- Because 256358 only logs for the Right Shark, we have to
				-- alert late (and with no target) here for the Left shark
				self:Message(256358, "yellow")
				local t = args.time
				if t - prev > 1.5 then
					prev = t
					-- throttle sound because both sharks can be tossed at a time
					self:PlaySound(256358, "alarm", "watchstep")
				end
				self:CDBar(256358, 19.5, L.left:format(args.spellName))
			else -- 129359, Sawtooth Shark (Right)
				self:CDBar(256358, 19.5, L.right:format(args.spellName))
			end
		end
	end
end

do
	local prev = 0
	function mod:FlailingSharkDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 1.5 then
				prev = t
				self:PersonalMessage(args.spellId, "near")
				self:PlaySound(args.spellId, "underyou")
			end
		end
	end
end

do
	local prev = 0
	function mod:Rearm(args)
		local t = args.time
		-- throttle message because both Rearms can happen within 1s
		if t - prev > 2 then
			prev = t
			self:Message(256489, "cyan")
			self:PlaySound(256489, "info")
		end
		if args.spellId == 256489 then -- Rearm (Left)
			self:Bar(256489, 26.7, L.left:format(args.spellName))
		else -- 256494, Rearm (Right)
			self:CDBar(256489, 18.6, L.right:format(args.spellName))
		end
	end
end

function mod:RipperPunch(args)
	if self:Me(args.destGUID) or self:Healer() then
		self:TargetMessage(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
	ripperPunchCount = ripperPunchCount + 1
	if ripperPunchCount == 2 then
		self:CDBar(args.spellId, 51.0)
	elseif ripperPunchCount == 3 then
		self:CDBar(args.spellId, 67.7)
	else
		-- pull:9.5, 51.4, 70.1, 46.2
		-- pull:10.0, 51.0, 68.1, 46.2
		-- pull:10.0, 65.5, 67.7, 70.4, 47.8, 48.2, 70.9, 44.9, 66.4
		self:CDBar(args.spellId, 44.9)
	end
end
