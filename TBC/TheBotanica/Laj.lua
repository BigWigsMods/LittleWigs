--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Laj", 553, 561)
if not mod then return end
--mod.otherMenu = "Tempest Keep"
mod:RegisterEnableMob(17980)

--------------------------------------------------------------------------------
-- Initialization
--


function mod:GetOptions()
	return {
		34697, -- Allergic Reaction
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "AllergicReaction", 34697)
	self:Death("Win", 17980)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:AllergicReaction(args)
	self:TargetMessage(args.spellId, args.destName, "Important")
end
