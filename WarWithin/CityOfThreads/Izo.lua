--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Izo, the Grand Splicer", 2669, 2596)
if not mod then return end
mod:RegisterEnableMob(216658) -- Izo, the Grand Splicer
mod:SetEncounterID(2909)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.warmup_icon = "inv_achievement_dungeon_cityofthreads"
end

--------------------------------------------------------------------------------
-- Locals
--

local shiftingAnomaliesCount = 1
local spliceCount = 1
local transformCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		439401, -- Shifting Anomalies
		{439341, "HEALER"}, -- Splice
		437700, -- Tremor Slam
		438860, -- Umbral Weave
		439646, -- Process of Elimination
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ShiftingAnomalies", 439401)
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1") -- Shifting Anomalies (moving)
	self:Log("SPELL_CAST_START", "Splice", 439341)
	self:Log("SPELL_CAST_START", "TremorSlam", 437700)
	self:Log("SPELL_CAST_START", "UmbralWeave", 438860)
	self:Log("SPELL_CAST_START", "ProcessOfElimination", 439646)
end

function mod:OnEngage()
	shiftingAnomaliesCount = 1
	spliceCount = 1
	transformCount = 1
	self:StopBar(CL.active)
	self:CDBar(439401, 4.0) -- Shifting Anomalies
	self:CDBar(439341, 10.0) -- Splice
	self:CDBar(437700, 16.0) -- Tremor Slam
	self:CDBar(438860, 16.0) -- Umbral Weave
	self:CDBar(439646, 55.0) -- Process of Elimination
end

function mod:VerifyEnable(unit)
	-- boss shows up for some RP just before the 3rd boss
	return UnitCanAttack("player", unit)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Warmup() -- called from trash module
	-- 194.88 [CHAT_MSG_MONSTER_SAY] Enough! You've earned a place in my collection. Let me usher you in.#Izo, the Grand Splicer
	-- 202.94 [NAME_PLATE_UNIT_ADDED] Izo, the Grand Splicer#Creature-0-2085-2669-27702-216658
	self:Bar("warmup", 8.0, CL.active, L.warmup_icon)
end

function mod:ShiftingAnomalies(args)
	shiftingAnomaliesCount = 1
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 9.0) -- time until first move
	self:PlaySound(args.spellId, "info")
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 439501 then -- Shifting Anomalies (moving)
		self:Message(439401, "yellow")
		shiftingAnomaliesCount = shiftingAnomaliesCount + 1
		if shiftingAnomaliesCount == 2 then -- time until 2nd move
			self:CDBar(439401, 13.0)
		elseif shiftingAnomaliesCount == 3 then -- time until 3rd move
			self:CDBar(439401, 10.0)
		elseif shiftingAnomaliesCount == 4 then -- time until 4th move
			self:CDBar(439401, 12.0)
		else -- Shifting Anomalies respawn timer
			self:CDBar(439401, 16.0)
		end
		self:PlaySound(439401, "info")
	end
end

function mod:Splice(args)
	self:Message(args.spellId, "red")
	spliceCount = spliceCount + 1
	if spliceCount % 2 == 0 then
		self:CDBar(args.spellId, 22.0)
	else
		self:CDBar(args.spellId, 38.0)
	end
	self:PlaySound(args.spellId, "alert")
end

function mod:TremorSlam(args)
	self:Message(args.spellId, "orange")
	-- Tremor Slam and Umbral Weave share a 60s cycle, where first one ability is cast and then the other.
	-- the order is random but both will always be cast once each per 22s/38s pair in the cycle.
	transformCount = transformCount + 1
	if transformCount % 2 == 0 then
		self:CDBar(438860, 22.0) -- Umbral Weave
		self:CDBar(args.spellId, 60.0)
	else
		self:CDBar(args.spellId, 38.0)
		self:CDBar(438860, {38.0, 60.0}) -- Umbral Weave
	end
	self:PlaySound(args.spellId, "alarm")
end

function mod:UmbralWeave(args)
	self:Message(args.spellId, "yellow")
	-- Umbral Weave and Tremor Slam share a 60s cycle, where first one ability is cast and then the other.
	-- the order is random but both will always be cast once each per 22s/38s pair in the cycle.
	transformCount = transformCount + 1
	if transformCount % 2 == 0 then
		self:CDBar(437700, 22.0) -- Tremor Slam
		self:CDBar(args.spellId, 60.0)
	else
		self:CDBar(437700, {38.0, 60.0}) -- Tremor Slam
		self:CDBar(args.spellId, 38.0)
	end
	self:PlaySound(args.spellId, "long")
end

function mod:ProcessOfElimination(args)
	self:Message(args.spellId, "purple")
	self:CDBar(args.spellId, 60.0)
	self:PlaySound(args.spellId, "alarm")
end
