-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Blackheart the Inciter", 555, 545)
if not mod then return end
--mod.otherMenu = "Auchindoun"
mod:RegisterEnableMob(18667)

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		33676, -- Incite Chaos
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Chaos", 33676)

	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
	self:Death("Win", 18667)
end

function mod:OnEngage()
	self:CDBar(33676, 15)
end

-------------------------------------------------------------------------------
--  Event Handlers


function mod:Chaos(args)
	self:Message(args.spellId, "Important")
	self:CastBar(args.spellId, 15)
	self:CDBar(args.spellId, 70)
	self:DelayedMessage(args.spellId, 65, "Attention", CL.soon:format(args.spellName), nil, "Alarm")
end
