--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("General Drakkisath", 229)
if not mod then return end
mod:RegisterEnableMob(10363)

--------------------------------------------------------------------------------
-- Locals
--

--------------------------------------------------------------------------------
-- Localization
--
local L = mod:NewLocale("enUS", true)
if L then
	L.bossName = "General Drakkisath"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{16805, "ICON"}, -- Conflagration
	}
end

function mod:OnRegister()
	self.displayName = L.bossName
end

function mod:OnBossEnable()
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")

	self:Log("SPELL_AURA_APPLIED", "ConflagrationApply", self:SpellName(16805))
	self:Log("SPELL_AURA_REMOVED", "ConflagrationRemove", self:SpellName(16805))

	self:Death("Win", 10363)
end

function mod:OnEngage()

	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ConflagrationApply(args)
	self:PrimaryIcon(16805, args.destName)
	self:TargetBar(16805, 10, args.destName, "yellow")
	self:TargetMessage2(16805, args.destName)
end

function mod:ConflagrationRemove(args)
	self:PrimaryIcon(16805)
	self:StopBar(16804, args.destName)
end
