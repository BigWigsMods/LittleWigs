
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Amanitar", 619, 583)
if not mod then return end
mod:RegisterEnableMob(30258)

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

	self:Death("Win", 30258)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Mini(args)
	self:MessageOld(args.spellId, "yellow", "info", CL.casting:format(args.spellName))
end

