-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Novos the Summoner", 534, 589)
if not mod then return end
--mod.otherMenu = "Zul'Drak"
mod:RegisterEnableMob(26631)

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		50089, -- Wrath of Misery
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "WrathOfMisery", 50089, 59856)
	self:Log("SPELL_AURA_REMOVED", "WrathOfMiseryRemoved", 50089, 59856)
	self:Death("Win", 26631)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:WrathOfMisery(args)
	self:TargetMessage(50089, args.destName, "Urgent")
	self:TargetBar(50089, 6, args.destName)
end

function mod:WrathOfMiseryRemoved(args)
	self:StopBar(50089, args.destName)
end
