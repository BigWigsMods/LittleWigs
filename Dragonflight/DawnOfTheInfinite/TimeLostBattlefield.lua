--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Time-Lost Battlefield", 2579, UnitFactionGroup("player") == "Horde" and 2534 or 2533)
if not mod then return end
mod:RegisterEnableMob(
	203679, -- Anduin Lothar
	203678  -- Grommash Hellscream
)
mod:SetEncounterID(2672)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local nextForTheFaction = 0
local nextTankBuster = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.warmup_icon = "factionchange"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		{410235, "SAY"}, -- Bladestorm
		-- Anduin Lothar
		{418059, "TANK_HEALER"}, -- Mortal Strikes
		418054, -- Shockwave (Anduin's)
		418047, -- FOR THE ALLIANCE!
		--418062, -- Battle Cry, repeats every 10 seconds, mostly just spam
		-- Grommash Hellscream
		{410254, "TANK_HEALER"}, -- Decapitate
		408227, -- Shockwave (Grommash's)
		418046, -- FOR THE HORDE!
		--410496, -- War Cry, repeats every 10 seconds, mostly just spam
	}, {
		[418059] = -27260, -- Anduin Lothar
		[410254] = -26525, -- Grommash Hellscream
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Bladestorm", 410235)
	self:Log("SPELL_CAST_START", "MortalStrikes", 418059, 410254) -- Mortal Strikes / Decapitate
	self:Log("SPELL_CAST_SUCCESS", "Shockwave", 418054, 408227) -- Anduin, Grommash
	self:Log("SPELL_CAST_START", "ForTheAlliance", 418047, 418046) -- For the Alliance / For the Horde
end

function mod:OnEngage()
	local t = GetTime()
	nextForTheFaction = t + 19.3
	nextTankBuster = t + 2.4
	self:StopBar(CL.active) -- Warmup
	self:CDBar(410235, 21.8) -- Bladestorm
	if self:GetBossId(203679) then -- Anduin Lothar
		self:CDBar(418059, 6.1) -- Mortal Strikes
		self:CDBar(418054, 9.4) -- Shockwave (Anduin's)
		self:CDBar(418047, 19.3) -- FOR THE ALLIANCE!
	elseif self:GetBossId(203678) then -- Grommash Hellscream
		self:CDBar(410254, 6.1) -- Decapitate
		self:CDBar(408227, 9.4) -- Shockwave (Grommash's)
		self:CDBar(418046, 19.3) -- FOR THE HORDE!
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:WarmupAnduinLothar() -- called from trash module
	-- 0.00 [CLEU] SPELL_CAST_SUCCESS#Creature-0-4218-2579-5855-203679#Anduin Lothar##nil#419609#Battle Senses
	-- 0.18 [CHAT_MSG_MONSTER_YELL] We need reinforcements!#Anduin Lothar
	-- 2.20 [CHAT_MSG_MONSTER_YELL] Rally together!#Anduin Lothar
	-- 6.00 [ENCOUNTER_START] 2672#Time-Lost Battlefield
	self:Bar("warmup", 6.0, CL.active, "ui_alliance_7legionmedal")
end

function mod:WarmupGrommashHellscream() -- called from trash module
	-- 0.00 [CLEU] SPELL_CAST_SUCCESS#Creature-0-4229-2579-2662-203678#Grommash Hellscream##nil#419602#Thirst for Battle
	-- 0.11 [CHAT_MSG_MONSTER_YELL] I need fighters!#Grommash Hellscream
	-- 2.15 [CHAT_MSG_MONSTER_YELL] Warriors! Attack!#Grommash Hellscream
	-- 5.99 [ENCOUNTER_START] 2672#Time-Lost Battlefield
	self:Bar("warmup", 6.0, CL.active, "ui_horde_honorboundmedal")
end

function mod:Bladestorm(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	self:CDBar(args.spellId, 35.2)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Bladestorm")
		self:PlaySound(args.spellId, "warning", nil, args.destName)
	else
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
	end
	-- soonest another ability can be is 8.5 seconds
	local t = GetTime()
	if nextForTheFaction - t < 8.5 then
		nextForTheFaction = t + 8.5
		if self:GetBossId(203679) then -- Anduin Lothar
			self:CDBar(418047, {8.5, 21.3}) -- FOR THE ALLIANCE!
		elseif self:GetBossId(203678) then -- Grommash Hellscream
			self:CDBar(418046, {8.5, 21.3}) -- FOR THE HORDE!
		end
	end
	if nextTankBuster - t < 8.5 then
		nextTankBuster = t + 8.5
		if self:GetBossId(203679) then -- Anduin Lothar
			self:CDBar(418059, {8.5, 19.5}) -- Mortal Strikes
		elseif self:GetBossId(203678) then -- Grommash Hellscream
			self:CDBar(410254, {8.5, 19.5}) -- Decapitate
		end
	end
end

function mod:MortalStrikes(args) -- or Decapitate
	nextTankBuster = GetTime() + 19.5
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 19.5)
end

function mod:Shockwave(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 35.2)
	-- soonest another ability can be is 10.2 seconds
	local t = GetTime()
	if nextForTheFaction - t < 10.2 then
		nextForTheFaction = t + 10.2
		if self:GetBossId(203679) then -- Anduin Lothar
			self:CDBar(418047, {10.2, 21.9}) -- FOR THE ALLIANCE!
		elseif self:GetBossId(203678) then -- Grommash Hellscream
			self:CDBar(418046, {10.2, 21.9}) -- FOR THE HORDE!
		end
	end
	if nextTankBuster - t < 10.2 then
		nextTankBuster = t + 10.2
		if self:GetBossId(203679) then -- Anduin Lothar
			self:CDBar(418059, {10.2, 19.5}) -- Mortal Strikes
		elseif self:GetBossId(203678) then -- Grommash Hellscream
			self:CDBar(410254, {10.2, 19.5}) -- Decapitate
		end
	end
end

function mod:ForTheAlliance(args) -- or ForTheHorde
	nextForTheFaction = GetTime() + 21.3
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 21.3)
end
