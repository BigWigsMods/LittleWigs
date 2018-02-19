-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Talon King Ikiss", 556, 543)
if not mod then return end
--mod.otherMenu = "Auchindoun"
mod:RegisterEnableMob(18473)

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		38197, -- Arcane Explosion
		{38245, "ICON"}, -- Polymorph
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "ArcaneExplosion", 38194)
	self:Log("SPELL_AURA_APPLIED", "Polymorph", 38245, 43309)
	self:Log("SPELL_AURA_REMOVED", "PolymorphRemoved", 38245, 43309)
	self:Death("Win", 18473)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:ArcaneExplosion()
	self:Message(38197, "Urgent", nil, CL.casting:format(self:SpellName(38197)))
end

function mod:Polymorph(args)
	self:TargetMessage(38245, args.destName, "Attention")
	self:TargetBar(38245, 6, args.destName)
	self:PrimaryIcon(38245, args.destName)
end

function mod:PolymorphRemoved(args)
	self:StopBar(args.spellId, args.destName)
	self:PrimaryIcon(38245)
end
