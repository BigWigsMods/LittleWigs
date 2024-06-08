if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Nerl'athekk the Skulking", 2685)
if not mod then return end
mod:RegisterEnableMob(219676) -- Nerl'athekk the Skulking
mod:SetEncounterID(2946)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.nerlathekk_the_skulking = "Nerl'athekk the Skulking"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.nerlathekk_the_skulking
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
