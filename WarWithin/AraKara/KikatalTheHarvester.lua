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
		432117, -- Cosmic Singularity
		{432031, "ME_ONLY"}, -- Grasping Blood
		432227, -- Venom Volley
		432130, -- Erupting Webs
		-- Mythic
		461487, -- Cultivated Poisons
	}, {
		[461487] = CL.mythic,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "CosmicSingularity", 432117)
	self:Log("SPELL_AURA_APPLIED", "GraspingBloodApplied", 432031)
	self:Log("SPELL_CAST_START", "VenomVolley", 432227)
	self:Log("SPELL_CAST_START", "EruptingWebs", 432130)

	-- Mythic
	self:Log("SPELL_CAST_START", "CultivatedPoisons", 461487)
end

function mod:OnEngage()
	self:CDBar(432130, 6.5) -- Erupting Webs
	self:CDBar(432227, 13.0) -- Venom Volley
	if self:Mythic() then
		self:CDBar(461487, 29.5) -- Cultivated Poisons
	end
	self:CDBar(432117, 34.8) -- Cosmic Singularity
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CosmicSingularity(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 43.7)
end

function mod:GraspingBloodApplied(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "info", nil, args.destName)
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

-- Mythic

function mod:CultivatedPoisons(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 23.0)
end
