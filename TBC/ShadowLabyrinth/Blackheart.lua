-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Blackheart the Inciter", 555, 545)
if not mod then return end
mod:RegisterEnableMob(18667)
-- mod.engageId = 1909 -- no boss frames
-- mod.respawnTime = 0 -- resets, doesn't respawn

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		33676, -- Incite Chaos
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Chaos", 33676)

	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:Death("Win", 18667)
end

function mod:OnEngage()
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
	self:CDBar(33676, 15) -- Incite Chaos
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:Chaos(args)
	self:MessageOld(args.spellId, "red")
	self:CastBar(args.spellId, 15)
	self:CDBar(args.spellId, 70)
	self:DelayedMessage(args.spellId, 65, "yellow", CL.soon:format(args.spellName), nil, "alarm")
end
