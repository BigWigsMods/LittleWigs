if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Web General Ab'enar", 2680)
if not mod then return end
mod:RegisterEnableMob(221896) -- Web General Ab'enar
mod:SetEncounterID(2877)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.web_general_abenar = "Web General Ab'enar"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.web_general_abenar
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
