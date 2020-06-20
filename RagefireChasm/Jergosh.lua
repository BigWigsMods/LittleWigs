--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Jergosh the Invoker", 389)
if not mod then return end
mod:RegisterEnableMob(11518)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.bossName = "Jergosh the Invoker"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		18267, -- Curse of Weakness
		20800, -- Immolate
	}
end

function mod:OnRegister()
	self.displayName = L.bossName
end

function mod:OnBossEnable()
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")

	self:Log("SPELL_CAST_SUCCESS", "Curse", 18267)
	self:Log("SPELL_CAST_SUCCESS", "Immolate", 20800)
	self:Log("SPELL_AURA_APPLIED", "CurseDebuff", 18267)
	self:Log("SPELL_AURA_APPLIED", "ImmolateDebuff", 20800)

	self:Death("Win", 11518)
end

function mod:OnEngage()
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")

	self:CDBar(18267, 10) -- Curse of Weakness
	self:CDBar(20800, 8) -- Immolate
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Curse()
	self:CDBar(18267, 10) -- 6~16
end

function mod:CurseDebuff()
	self:Message2(18267, "yellow")
end

function mod:Immolate()
	self:CDBar(20800, 8) -- 5~12
end

function mod:ImmolateDebuff()
	self:Message2(20800, "yellow")
end
