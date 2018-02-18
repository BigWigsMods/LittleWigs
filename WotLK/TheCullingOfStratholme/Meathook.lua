-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Meathook", 521, 611)
if not mod then return end
--mod.otherMenu = "Caverns of Time"
mod:RegisterEnableMob(26529)
mod.engageId = 2002

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		52696, -- Constricting Chains
	}
end

function mod:OnEnable()
	self:Log("SPELL_AURA_APPLIED", "ConstrictingChains", 52696, 58823)
	self:Death("Win", 26529)
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:ConstrictingChains(args)
	self:TargetMessage(52696, args.destName, "Important")
	self:TargetBar(52696, 5, args.destName)
end
