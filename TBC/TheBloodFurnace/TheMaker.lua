-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("The Maker", 542, 555)
if not mod then return end
--mod.otherMenu = "Hellfire Citadel"
mod:RegisterEnableMob(17381)

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		30923, -- Domination
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Domination", 30923)
	self:Death("Win", 17381)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Domination(args)
	self:TargetMessage(args.spellId, args.destName, "Important")
	self:TargetBar(args.spellId, 10, args.destName)
end
