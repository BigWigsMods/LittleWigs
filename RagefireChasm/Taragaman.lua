--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Taragaman the Hungerer", 389)
if not mod then return end
mod:RegisterEnableMob(11520)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.bossName = "Taragaman the Hungerer"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{18072, "TANK"}, -- Uppercut
		11970, -- Fire Nova
	}
end

function mod:OnRegister()
	self.displayName = L.bossName
end

function mod:OnBossEnable()
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")

	self:Log("SPELL_CAST_SUCCESS", "Uppercut", 18072)
	self:Log("SPELL_CAST_SUCCESS", "FireNova", 11970)

	self:Death("Win", 11520)
end

function mod:OnEngage()
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")

	self:CDBar(18072, 12) -- Uppercut
	self:CDBar(11970, 16) -- Fire Nova
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Uppercut()
	self:Message2(18072, "orange")
	self:CDBar(18072, 7) -- 7~17
end

function mod:FireNova()
	self:CDBar(11970, 12) -- 12~21
end
