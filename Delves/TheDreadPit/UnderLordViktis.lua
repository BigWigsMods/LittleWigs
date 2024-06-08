if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Under-Lord Vik'tis", 2684)
if not mod then return end
mod:RegisterEnableMob(220158) -- Under-Lord Vik'tis
mod:SetEncounterID(2989)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.under_lord_viktis = "Under-Lord Vik'tis"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.under_lord_viktis
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
