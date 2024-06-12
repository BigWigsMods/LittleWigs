if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ki'katal the Harvester", 2660, 2585)
if not mod then return end
mod:RegisterEnableMob(215407) -- Ki'katal the Harvester
mod:SetEncounterID(2901)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Ki'katal the Harvester
		432117, -- Cosmic Singularity
		432227, -- Venom Volley
		432130, -- Erupting Webs
		-- Bloodworkers
		{432031, "ME_ONLY"}, -- Grasping Blood
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "CosmicSingularity", 432117)
	self:Log("SPELL_CAST_START", "VenomVolley", 432227)
	self:Log("SPELL_CAST_START", "EruptingWebs", 432130)
	self:Log("SPELL_AURA_APPLIED", "GraspingBloodApplied", 432031)
end

function mod:OnEngage()
	self:CDBar(432130, 6.5) -- Erupting Webs
	self:CDBar(432227, 16.2) -- Venom Volley
	self:CDBar(432117, 26.5) -- Cosmic Singularity
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CosmicSingularity(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 46.1)
end

function mod:VenomVolley(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 23.0)
end

function mod:EruptingWebs(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 18.2)
end

function mod:GraspingBloodApplied(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "info", nil, args.destName)
end
