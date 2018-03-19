if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Sporecaller Zancha", 1841, 2130)
if not mod then return end
mod:RegisterEnableMob(131678)
mod.engageId = 2112

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		259830, -- Boundless Rot
		259732, -- Festering Harvest
		259602, -- Necrotic Bolt
		{259718, "SAY"}, -- Ravenous Shadows
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "BoundlessRot", 259830)
	self:Log("SPELL_CAST_START", "FesteringHarvest", 259732)
	self:Log("SPELL_CAST_START", "NecroticBolt", 259602)
	self:Log("SPELL_AURA_APPLIED", "RavenousShadows", 259718)
	self:Log("SPELL_AURA_REMOVED", "RavenousShadowsRemoved", 259718)
end

function mod:OnEngage()
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:BoundlessRot(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info", "watchstep")
end

function mod:FesteringHarvest(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
end

function mod:NecroticBolt(args)
	self:Message(args.spellId, "orange")
	if self:Interrupter() then
		self:PlaySound(args.spellId, "alert", "interrupt")
	end
end

function mod:RavenousShadows(args)
	self:TargetMessage(args.spellId, args.destName, "yellow")
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "warning", "runout")
		self:Say(args.spellId)
		self:SayCountdown(args.spellId, 6)
		self:Flash(args.spellId)
	end
end

function mod:RavenousShadowsRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
end
