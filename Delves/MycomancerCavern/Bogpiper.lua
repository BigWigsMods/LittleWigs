if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Bogpiper", 2679)
if not mod then return end
mod:RegisterEnableMob(220314) -- Bogpiper
mod:SetEncounterID(2960)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.bogpiper = "Bogpiper"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.bogpiper
end

function mod:GetOptions()
	return {
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("ENCOUNTER_START")
end

function mod:OnEngage()
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- XXX no boss frames
function mod:ENCOUNTER_START(_, id)
	if id == self.engageId then
		self:Engage()
	end
end
