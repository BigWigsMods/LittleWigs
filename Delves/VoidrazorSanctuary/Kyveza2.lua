if not BigWigsLoader.isNext then return end -- XXX remove in 11.2
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Nexus-Princess Ky'veza (Tier 11)", 2951)
if not mod then return end
--mod:RegisterEnableMob(244752, 244753) -- Nexus-Princess Ky'veza (Tier 11)
--mod:SetEncounterID(3326) XXX 3325 or 3326
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.nexus_princess_kyveza = "Nexus-Princess Ky'veza (Tier 11)"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.nexus_princess_kyveza
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
