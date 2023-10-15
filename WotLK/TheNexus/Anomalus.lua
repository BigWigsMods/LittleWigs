--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Anomalus", 576, 619)
if not mod then return end
mod:RegisterEnableMob(26763)
mod:SetEncounterID(mod:Classic() and 522 or 2009)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		47743, -- Create Rift
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "CreateRift", 47743)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CreateRift(args)
	self:Message(args.spellId, "yellow")
end
