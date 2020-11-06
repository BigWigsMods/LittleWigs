
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Anomalus", 576, 619)
if not mod then return end
mod:RegisterEnableMob(26763)

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

	self:Death("Win", 26763)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CreateRift(args)
	self:MessageOld(args.spellId, "yellow")
end

