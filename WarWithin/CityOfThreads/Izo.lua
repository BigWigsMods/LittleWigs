if not BigWigsLoader.isBeta then return end
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
	self:Log("SPELL_CAST_START", "Splice", 439341)
	self:Log("SPELL_CAST_START", "TremorSlam", 437700)
	self:Log("SPELL_CAST_START", "UmbralWeave", 438860)
	self:Log("SPELL_CAST_START", "ProcessOfElimination", 439646)
end

function mod:OnEngage()
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
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 60.0)
end

function mod:Splice(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
	spliceCount = spliceCount + 1
	if spliceCount % 2 == 0 then
		self:CDBar(args.spellId, 22.0)
	else
		self:CDBar(args.spellId, 38.0)
	end
end

function mod:TremorSlam(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
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
end

function mod:UmbralWeave(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
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
end

function mod:ProcessOfElimination(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 60.0)
end
