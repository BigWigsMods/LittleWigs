-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Meathook", 595, 611)
if not mod then return end
mod:RegisterEnableMob(26529)
mod.engageId = 2002
--mod.respawnTime = 0 -- resets instead of respawning

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		52696, -- Constricting Chains
	}
end

function mod:OnEnable()
	self:Log("SPELL_AURA_APPLIED", "ConstrictingChains", 52696, 58823) -- normal, heroic
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:ConstrictingChains(args)
	self:TargetMessageOld(52696, args.destName, "red")
	self:TargetBar(52696, 5, args.destName)
end
