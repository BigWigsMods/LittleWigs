--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Bazzalan", 389)
if not mod then return end
mod:RegisterEnableMob(11519)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.bossName = "Bazzalan"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		744, -- Poison
	}
end

function mod:OnRegister()
	self.displayName = L.bossName
end

function mod:OnBossEnable()
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")

	self:Log("SPELL_CAST_SUCCESS", "Poison", 744)
	self:Log("SPELL_AURA_APPLIED", "PosionDebuff", 744)

	self:Death("Win", 11519)
end

function mod:OnEngage()
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Poison(args)
	self:Message2(744, "yellow")
end

function mod:PosionDebuff()
	self:CDBar(744, 10)
end
