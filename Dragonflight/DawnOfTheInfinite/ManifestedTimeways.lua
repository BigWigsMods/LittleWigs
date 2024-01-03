--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Manifested Timeways", 2579, 2528)
if not mod then return end
mod:RegisterEnableMob(198996) -- Manifested Timeways
mod:SetEncounterID(2667)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.warmup_icon = "spell_holy_borrowedtime"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		{405696, "SAY"}, -- Chrono-faded
		405431, -- Fragments of Time
		414303, -- Unwind
		414307, -- Radiant
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Chronofaded", 405696)
	self:Log("SPELL_AURA_APPLIED", "ChronofadedApplied", 404141)
	self:Log("SPELL_CAST_START", "FragmentsOfTime", 405431)
	self:Log("SPELL_CAST_START", "Unwind", 414303)
	self:Log("SPELL_CAST_START", "Radiant", 414307)
end

function mod:OnEngage()
	self:StopBar(CL.active) -- Warmup
	-- Unwind is not cast in M+, removed from dungeon journal in all difficulties.
	-- apparently still cast in hardmode in 10.2 - but no way to detect hardmode.
	--self:CDBar(414303, 5.8) -- Unwind
	self:CDBar(405431, 15.5) -- Fragments of Time
	self:CDBar(405696, 30.1) -- Chrono-faded
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Warmup()
	-- triggered from trash module on CHAT_MSG_MONSTER_YELL
	-- 11.22 [CLEU] SPELL_AURA_REMOVED#Creature-198996#Manifested Timeways#413329#Sand Zone
	-- 12.85 [CHAT_MSG_MONSTER_YELL] Even the Aspect of Time cannot be allowed to disrupt the timeways!#Manifested Timeways
	-- 25.01 [UNIT_SPELLCAST_SUCCEEDED] Manifested Timeways -Timeways- [417483]
	-- 26.24 [UNIT_SPELLCAST_SUCCEEDED] Manifested Timeways -Anchor Here- [45313]
	-- 26.24 [UNIT_SPELLCAST_SUCCEEDED] Manifested Timeways -Timeways- [415269]
	-- 26.24 [ENCOUNTER_START] 2667#Manifested Timeways
	if self:MythicPlus() then -- the RP is longer in other difficulties
		self:Bar("warmup", 13.4, CL.active, L.warmup_icon)
	end
end

do
	local playerList = {}

	function mod:Chronofaded(args)
		playerList = {}
		self:CDBar(args.spellId, 30.3)
	end

	function mod:ChronofadedApplied(args)
		playerList[#playerList + 1] = args.destName
		self:TargetsMessage(405696, "orange", playerList, 2)
		self:PlaySound(405696, "alert", nil, playerList)
		if self:Me(args.destGUID) then
			self:Say(405696, nil, nil, "Chronofaded")
			-- ticks 4x as fast when standing in Accelerating Time so can't really do a countdown
		end
	end
end

function mod:FragmentsOfTime(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 30.3)
end

function mod:Unwind(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 30.3)
end

function mod:Radiant(args)
	-- only cast when the tank is not in melee range
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "warning")
end
