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
-- Initialization
--

function mod:GetOptions()
	return {
		439401, -- Shifting Anomalies
		439341, -- Splice
		437700, -- Tremor Slam
		438860, -- Umbral Weave
		439646, -- Process of Elimination
	}
end

function mod:OnBossEnable()
	-- TODO needs warmup triggered from trash module
	self:Log("SPELL_CAST_START", "ShiftingAnomalies", 439401)
	self:Log("SPELL_CAST_START", "Splice", 439341)
	self:Log("SPELL_CAST_START", "TremorSlam", 437700)
	self:Log("SPELL_CAST_START", "UmbralWeave", 438860)
	self:Log("SPELL_CAST_START", "ProcessOfElimination", 439646)
end

function mod:OnEngage()
	self:CDBar(439401, 4.0) -- Shifting Anomalies
	self:CDBar(439341, 10.0) -- Splice
	self:CDBar(438860, 16.0) -- Umbral Weave
	self:CDBar(437700, 36.0) -- Tremor Slam
	self:CDBar(439646, 50.0) -- Process of Elimination
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ShiftingAnomalies(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 55.0)
end

function mod:Splice(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 20.0) -- TODO 20, 35 alternating?
end

function mod:TremorSlam(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 35.0) -- TODO 35, 20 alternating?
end

function mod:UmbralWeave(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 55.0) -- TODO 55?
end

function mod:ProcessOfElimination(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 55.0) -- TODO 55?
end
