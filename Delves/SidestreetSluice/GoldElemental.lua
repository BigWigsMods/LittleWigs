if select(4, GetBuildInfo()) < 110100 then return end -- XXX remove when 11.1 is live
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Gold Elemental", 2826)
if not mod then return end
mod:RegisterEnableMob(
	234932, -- Gold Shaman
	234919 -- Gold Elemental
)
mod:SetEncounterID(3104)
--mod:SetRespawnTime(15) resets, doesn't respawn
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.gold_elemental = "Gold Elemental"
	L.gold_shaman = "Gold Shaman"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.gold_elemental
end

function mod:GetOptions()
	return {
	}
end

function mod:OnBossEnable()
end

--------------------------------------------------------------------------------
-- Event Handlers
--
