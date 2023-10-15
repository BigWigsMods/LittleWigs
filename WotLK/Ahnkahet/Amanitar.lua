--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Amanitar", 619, 583)
if not mod then return end
mod:RegisterEnableMob(30258)
mod:SetEncounterID(1989)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		57055, -- Mini
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Mini", 57055)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Mini(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "info")
end
