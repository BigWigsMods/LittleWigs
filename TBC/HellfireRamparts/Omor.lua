-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Omor the Unscarred", 797, 528)
if not mod then return end
--mod.otherMenu = "Hellfire Citadel"
mod:RegisterEnableMob(17308)

-------------------------------------------------------------------------------
--  Initialization


function mod:GetOptions()
	return {
		{30695, "ICON"}, -- Treacherous Aura
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Curse", 30695, 37566, 37567, 39298) -- Treacherous Aura, 3x Bane of Treachery
	self:Log("SPELL_AURA_REMOVED", "CurseRemoved", 30695, 37566, 37567, 39298)
	self:Death("Win", 17308)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Curse(args)
	self:TargetMessage(30695, args.destName, "Urgent", nil, args.spellId)
	self:TargetBar(30695, 15, args.destName, args.spellId)
	self:PrimaryIcon(30695, args.destName)
end

function mod:CurseRemoved(args)
	self:PrimaryIcon(30695)
	self:StopBar(30695, args.destName)
end
