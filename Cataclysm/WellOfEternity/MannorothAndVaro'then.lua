--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Mannoroth and Varo'then", 816, 292)
if not mod then return end
mod:RegisterEnableMob(54969, 55419) -- Mannoroth, Varo'then
mod.engageId = 1274

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		104820, -- Embedded Blade
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(unit, spellName, _, _, spellId)
	if spellId == 104820 then -- Embedded Blade
		self:Message(spellId, "Positive", "info")
	end
end
