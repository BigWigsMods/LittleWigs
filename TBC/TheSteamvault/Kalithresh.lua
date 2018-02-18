-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Warlord Kalithresh", 727, 575)
if not mod then return end
--mod.otherMenu = "Coilfang Reservoir"
mod:RegisterEnableMob(17798)

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		38592, -- Use a different ID that has a better tooltip, Spell Reflection
		31543, -- Warlord's Rage
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "SpellReflection", 31534)
	self:Log("SPELL_CAST_SUCCESS", "WarlordsRage", 31543)

	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
	self:Death("Win", 17798)
end

function mod:OnEngage()
	self:CDBar(31543, 15)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:SpellReflection(args)
	self:Message(38592, "Attention", nil, args.spellId)
	self:Bar(38592, 8)
end

function mod:WarlordsRage(args)
	self:Message(args.spellId, "Urgent", nil, CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 40)
	self:DelayedMessage(args.spellId, 35, "Urgent", CL.soon:format(args.spellName))
end
