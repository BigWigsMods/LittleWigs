--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Gatewatcher Gyro-Kill", 730)
if not mod then return end
mod:RegisterEnableMob(19218)
-- mod.engageId = 1933 -- no boss frames
-- mod.respawnTime = 0 -- resets, doesn't respawn

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.name = "Gatewatcher Gyro-Kill"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		39193, -- Shadow Power
	}
end

function mod:OnRegister()
	self.displayName = L.name -- no journal entry
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ShadowPower", 39193, 35322) -- normal, heroic
	self:Log("SPELL_AURA_APPLIED", "ShadowPowerApplied", 39193, 35322)
	self:Log("SPELL_AURA_REMOVED", "ShadowPowerRemoved", 39193, 35322)
	self:Death("Win", 19218)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ShadowPower(args)
	self:Message(39193, "Important", nil, CL.casting:format(args.spellName))
end

function mod:ShadowPowerApplied(args)
	self:Bar(39193, 15)
end

function mod:ShadowPowerRemoved(args)
	self:StopBar(39193)
end
