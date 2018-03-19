-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Warlord Kalithresh", 545, 575)
if not mod then return end
mod:RegisterEnableMob(17798)
mod.engageId = 1944
-- mod.respawnTime = 0 -- resets, doesn't respawn

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		16172, -- Head Crack
		-6003, -- Spell Reflection
		36453, -- Warlord's Rage
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "HeadCrack", 16172)
	self:Log("SPELL_AURA_REMOVED", "HeadCrackRemoved", 16172)
	self:Log("SPELL_AURA_APPLIED", "SpellReflection", 31534)
	self:Log("SPELL_AURA_APPLIED", "WarlordsRage", 36453)
	self:Log("SPELL_AURA_APPLIED_DOSE", "WarlordsRage", 36453)
	self:Log("SPELL_AURA_APPLIED", "WarlordsRageCast", 37076)
	self:Log("SPELL_AURA_REMOVED", "WarlordsRageCastInterrupted", 37076) -- interrupted by killing a naga distiller
end

function mod:OnEngage()
	self:CDBar(36453, 15) -- Warlord's Rage
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:HeadCrack(args)
	self:TargetMessage(args.spellId, args.destName, "Attention", "Alarm", nil, nil, self:Healer())
	self:TargetBar(args.spellId, 15, args.destName)
end

function mod:HeadCrackRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:SpellReflection()
	self:Message(-6003, "Important", "Warning")
	self:Bar(-6003, 8)
end

function mod:WarlordsRage(args)
	self:StackMessage(args.spellId, args.destName, args.amount, "Urgent")
end

function mod:WarlordsRageCast(args)
	self:Message(36453, "Urgent", "Long", CL.casting:format(args.spellName))
	self:CastBar(36453, 7)
	self:CDBar(36453, 40)
end

function mod:WarlordsRageCastInterrupted(args)
	self:StopBar(args.spellName)
end
