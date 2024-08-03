if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Void Speaker Eirich", 2652, 2582)
if not mod then return end
mod:RegisterEnableMob(213119) -- Void Speaker Eirich
mod:SetEncounterID(2883)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		427461, -- Void Corruption
		427852, -- Entropic Reckoning
		427869, -- Unbridled Void
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "VoidCorruption", 427461)
	self:Log("SPELL_AURA_REMOVED", "VoidCorruptionRemoved", 427329)
	self:Log("SPELL_CAST_START", "EntropicReckoning", 427852)
	self:Log("SPELL_CAST_START", "UnbridledVoid", 427869)
end

function mod:OnEngage()
	self:CDBar(427869, 7.6) -- Unbridled Void
	self:CDBar(427461, 16.1) -- Void Corruption
	self:CDBar(427852, 22.2) -- Entropic Reckoning
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:VoidCorruption(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 27.9)
end

function mod:VoidCorruptionRemoved(args)
	if self:Me(args.destGUID) then
		self:Message(427461, "green", CL.removed:format(args.spellName))
		self:PlaySound(427461, "info", nil, args.destName)
	end
end

function mod:EntropicReckoning(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 17.0)
end

function mod:UnbridledVoid(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 20.6)
end
