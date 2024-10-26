--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Avanoxx", 2660, 2583)
if not mod then return end
mod:RegisterEnableMob(213179) -- Avanoxx
mod:SetEncounterID(2926)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local voraciousBiteCount = 1
local alertingShrillCount = 1
local gossamerOnslaughtCount = 1
local nextVoraciousBite = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.warmup_icon = "inv_achievement_dungeon_arak-ara"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		{438471, "TANK_HEALER"}, -- Voracious Bite
		438476, -- Alerting Shrill
		438473, -- Gossamer Onslaught
		-- Mythic
		446794, -- Insatiable
	}, {
		[446794] = CL.mythic,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "VoraciousBite", 438471)
	self:Log("SPELL_CAST_START", "AlertingShrill", 438476)
	self:Log("SPELL_CAST_START", "GossamerOnslaught", 438473)

	-- Mythic
	self:Log("SPELL_AURA_APPLIED", "InsatiableApplied", 446794)
	self:Log("SPELL_AURA_APPLIED_DOSE", "InsatiableApplied", 446794)
end

function mod:OnEngage()
	nextVoraciousBite = GetTime() + 3.0
	voraciousBiteCount = 1
	alertingShrillCount = 1
	gossamerOnslaughtCount = 1
	self:StopBar(CL.active)
	self:CDBar(438471, 3.0, CL.count:format(self:SpellName(438471), voraciousBiteCount)) -- Voracious Bite
	self:CDBar(438476, 10.6, CL.count:format(self:SpellName(438476), alertingShrillCount)) -- Alerting Shrill
	self:CDBar(438473, 30.1, CL.count:format(self:SpellName(438473), gossamerOnslaughtCount)) -- Gossamer Onslaught
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Warmup() -- triggered from trash module on CHAT_MSG_RAID_BOSS_EMOTE
	-- 0.0 [CHAT_MSG_RAID_BOSS_EMOTE] The Attendants have been silenced... something emerges!#Avanoxx
	-- 17.3 [NAME_PLATE_UNIT_ADDED] Avanoxx
	self:Bar("warmup", 17.3, CL.active, L.warmup_icon)
end

function mod:VoraciousBite(args)
	local t = GetTime()
	self:StopBar(CL.count:format(args.spellName, voraciousBiteCount))
	self:Message(args.spellId, "purple", CL.count:format(args.spellName, voraciousBiteCount))
	voraciousBiteCount = voraciousBiteCount + 1
	nextVoraciousBite = t + 13.4
	self:CDBar(args.spellId, 13.4, CL.count:format(args.spellName, voraciousBiteCount))
	self:PlaySound(args.spellId, "alert")
end

function mod:AlertingShrill(args)
	local t = GetTime()
	self:StopBar(CL.count:format(args.spellName, alertingShrillCount))
	self:Message(args.spellId, "yellow", CL.count:format(args.spellName, alertingShrillCount))
	alertingShrillCount = alertingShrillCount + 1
	if alertingShrillCount == 2 then
		self:CDBar(args.spellId, 38.4, CL.count:format(args.spellName, alertingShrillCount))
	else
		-- syncs up with Gossamer Onslaught timer after the second cast
		self:CDBar(args.spellId, 39.2, CL.count:format(args.spellName, alertingShrillCount))
	end
	-- 7.25 minimum to next Voracious Bite
	if nextVoraciousBite - t < 7.25 then
		nextVoraciousBite = t + 7.25
		self:CDBar(438471, {7.25, 13.4}, CL.count:format(self:SpellName(438471), voraciousBiteCount)) -- Voracious Bite
	end
	self:PlaySound(args.spellId, "info")
end

function mod:GossamerOnslaught(args)
	local t = GetTime()
	self:StopBar(CL.count:format(args.spellName, gossamerOnslaughtCount))
	self:Message(args.spellId, "red", CL.count:format(args.spellName, gossamerOnslaughtCount))
	gossamerOnslaughtCount = gossamerOnslaughtCount + 1
	self:CDBar(args.spellId, 39.3, CL.count:format(args.spellName, gossamerOnslaughtCount))
	-- 12.1 minimum to next Voracious Bite
	if nextVoraciousBite - t < 12.1 then
		nextVoraciousBite = t + 12.1
		self:CDBar(438471, {12.1, 13.4}, CL.count:format(self:SpellName(438471), voraciousBiteCount)) -- Voracious Bite
	end
	self:PlaySound(args.spellId, "long")
end

-- Mythic

do
	local prev = 0
	function mod:InsatiableApplied(args)
		local stacks = args.amount or 1
		self:Message(args.spellId, "orange", CL.stack:format(stacks, args.spellName, CL.boss))
		if stacks > 1 then
			self:StopBar(CL.stack:format(stacks - 1, args.spellName, CL.boss))
		end
		self:Bar(args.spellId, 60, CL.stack:format(stacks, args.spellName, CL.boss))
		-- throttle the sound, if your group is failing the boss can eat several at once
		local t = args.time
		if t - prev > 3 then
			prev = t
			self:PlaySound(args.spellId, "warning")
		end
	end
end
