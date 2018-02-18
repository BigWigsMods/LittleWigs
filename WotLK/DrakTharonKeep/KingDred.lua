-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("King Dred", 534, 590)
if not mod then return end
--mod.otherMenu = "Zul'Drak"
mod:RegisterEnableMob(27483)

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		59416, -- Raptor Call
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "RaptorCall", 59416)
	self:Death("Win", 27483)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:RaptorCall(args)
	self:Message(args.spellId, "Attention")
end
