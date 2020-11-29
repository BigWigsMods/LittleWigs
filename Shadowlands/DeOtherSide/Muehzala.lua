
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Mueh'zala", 2291, 2410)
if not mod then return end
mod:RegisterEnableMob(166608)
mod.engageId = 2396
--mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		325725, -- Cosmic Artifice
		325258, -- Master of Death
		{326171, "EMPHASIZE"}, -- Shatter Reality
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "CosmicArtificeApplied", 325725)
	self:Log("SPELL_CAST_START", "MasterOfDeath", 325258)
	self:Log("SPELL_CAST_START", "ShatterReality", 326171)
end

function mod:OnEngage()
	self:CDBar(325258, 9) -- Master of Death
	self:CDBar(326171, 60) -- Shatter Reality
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CosmicArtificeApplied(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId)
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:MasterOfDeath(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 32) -- pull:9.7, 32.8
	self:PlaySound(args.spellId, "warning")
end

function mod:ShatterReality(args)
	self:Message(args.spellId, "red")
	self:CastBar(args.spellId, 10)
	self:PlaySound(args.spellId, "long")
	self:StopBar(325258) -- Master of Death
end
