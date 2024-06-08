if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Overseer Kaskel", 2688)
if not mod then return end
mod:RegisterEnableMob(220437) -- Overseer Kaskel
mod:SetEncounterID(2990)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.overseer_kaskel = "Overseer Kaskel"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.overseer_kaskel
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
