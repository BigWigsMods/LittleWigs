
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Mueh'zala", 2291, 2410)
if not mod then return end
mod:RegisterEnableMob(166608)
mod.engageId = 2396
--mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Locals
--

local soulcrusherCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{327646, "TANK_HEALER"}, -- Soulcrusher
		{325725, "SAY_COUNTDOWN"}, -- Cosmic Artifice
		325258, -- Master of Death
		{326171, "EMPHASIZE"}, -- Shatter Reality
		334970, -- Coalescing
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Soulcrusher", 327646)
	self:Log("SPELL_AURA_APPLIED", "CosmicArtificeApplied", 325725)
	self:Log("SPELL_AURA_REMOVED", "CosmicArtificeRemoved", 325725)
	self:Log("SPELL_CAST_START", "MasterOfDeath", 325258)
	self:Log("SPELL_CAST_START", "ShatterReality", 326171)
	self:Log("SPELL_CAST_SUCCESS", "CoalescingStart", 334970)
end

function mod:OnEngage()
	soulcrusherCount = 1
	self:CDBar(327646, 6) -- Soulcrusher
	self:CDBar(325258, 9) -- Master of Death
	self:CDBar(326171, 60) -- Shatter Reality
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Soulcrusher(args)
	self:Message(args.spellId, "yellow")
	soulcrusherCount = soulcrusherCount + 1
	self:CDBar(args.spellId, soulcrusherCount % 2 == 0 and 20 or 10) -- pull:6.4, 19.7, 10.6, 22.4
	self:PlaySound(args.spellId, "alert")
end

function mod:CosmicArtificeApplied(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId)
		self:PlaySound(args.spellId, "alarm")
		self:SayCountdown(args.spellId, 6)
	end
end

function mod:CosmicArtificeRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
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

function mod:CoalescingStart(args)
	self:Message(args.spellId, "cyan", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "info")
	self:CastBar(args.spellId, 25)
end
