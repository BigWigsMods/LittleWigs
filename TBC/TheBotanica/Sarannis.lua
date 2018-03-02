--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Commander Sarannis", 553, 558)
if not mod then return end
--mod.otherMenu = "Tempest Keep"
mod:RegisterEnableMob(17976)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		34794, -- Arcane Resonance
		-5411, -- Summon Reinforcements
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "ArcaneResonance", 34794)
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
	self:Death("Win", 17976)
end

function mod:OnEngage()
	self:DelayedMessage(-5411, 55, "Attention", CL.soon:format(self:SpellName(-5411)))
	self:CDBar(-5411, 60)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ArcaneResonance(args)
	self:TargetMessage(args.spellId, args.spellName, "Important")
end
