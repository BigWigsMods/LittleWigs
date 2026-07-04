if not BigWigsLoader.isNext then return end -- 12.1
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Azta'rec", 3079)
if not mod then return end
mod:SetEncounterID({3508, 3525}) -- Tier 8, Tier 11
mod:SetAllowWin(true)
--mod:SetRespawnTime(15)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.aztarec = "Azta'rec"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.aztarec
end

function mod:GetOptions()
	return {
	}
end
