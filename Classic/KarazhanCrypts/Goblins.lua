--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Goblins", 2875)
if not mod then return end
mod:RegisterEnableMob(
	238420, -- Weeshald Rustboot
	238417, -- Beengis
	238416, -- Geenkle
	238418, -- Jank
	238419 -- Gold Rustboot
)
mod:SetEncounterID(3169) -- Opera of Malediction
--mod:SetRespawnTime(30)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.goblins = "Goblins"
	--L.weeshald_rustboot = "Weeshald Rustboot"
	--L.beengis = "Beengis"
	L.geenkle = "Geenkle"
	L.jank = "Jank"
	L.gold_rustboot = "Gold Rustboot"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.goblins
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
