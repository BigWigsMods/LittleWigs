--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Thorngrin the Tender", 553, 560)
if not mod then return end
--mod.otherMenu = "Tempest Keep"
mod:RegisterEnableMob(17978)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		34661, -- Sacrifice
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Sacrifice", 34661)
	self:Death("Win", 17978)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Sacrifice(args)
	self:TargetMessage(args.spellId, args.destName, "Attention")
	self:TargetBar(args.spellId, 8, args.destName)
	self:DelayedMessage(args.spellId, 22, "Positive", CL.soon:format(args.spellName))
	self:CDBar(args.spellId, 22)
end
