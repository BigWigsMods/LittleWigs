if select(4, GetBuildInfo()) < 110100 then return end -- XXX remove when 11.1 is live
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Xel'anegh The Many", 2815)
if not mod then return end
mod:RegisterEnableMob(234435, 234436, 234437, 234438) -- Xel'anegh The Many
mod:SetEncounterID(3099)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.xelanegh_the_many = "Xel'anegh The Many"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.xelanegh_the_many
end

function mod:GetOptions()
	return {
	}
end

function mod:OnBossEnable()
end

function mod:OnEngage()
end

--------------------------------------------------------------------------------
-- Event Handlers
--
