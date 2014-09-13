
--------------------------------------------------------------------------------
-- Module Declaration
--

if not BigWigs.isWOD then return end -- XXX compat
local mod, CL = BigWigs:NewBoss("Grimrail Enforcers", 987, 1236)
if not mod then return end
mod:RegisterEnableMob(80805, 80808, 80816) -- Makogg Emberblade, Neesa Nox, Ahri'ok Dugru

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"bosskill",
	}
end

function mod:OnBossEnable()
	--self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	--self:Death("Win", -1)
end

function mod:OnEngage()

end

--------------------------------------------------------------------------------
-- Event Handlers
--

