-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Beauty", 645, 108)
if not mod then return end
mod:RegisterEnableMob(39700)

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		{76031, "ICON"}, -- Magma Spit
		76028, -- Terrifying Roar
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "MagmaSpit", 76031)
	self:Log("SPELL_AURA_REMOVED", "MagmaSpitRemoved", 76031)
	self:Log("SPELL_CAST_SUCCESS", "TerrifyingRoar", 76028, 93586)
	self:Death("Win", 39700)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:MagmaSpit(args)
	self:TargetMessage(args.spellId, args.destName, "Urgent")
	self:TargetBar(args.spellId, 9, args.destName)
	self:PrimaryIcon(args.spellId, args.destName)
end

function mod:MagmaSpitRemoved(args)
	self:StopBar(args.spellId, args.destName)
	self:PrimaryIcon(76031)
end

function mod:TerrifyingRoar(args)
	self:CDBar(76028, 30)
	self:Message(76028, "Attention")
end

