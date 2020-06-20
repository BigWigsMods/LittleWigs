--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("General Drakkisath", 229)
if not mod then return end
mod:RegisterEnableMob(10363, 10814) -- Drakkisath, Chromatic Elite Guard

--------------------------------------------------------------------------------
-- Locals
--

local guardsDead = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.bossName = "General Drakkisath"

	L.guard = "Guard Deaths"
	L.guard_desc = "Announces when a Chromatic Elite Guard dies"
	L.guard_msg = "Guards dead: %d/%d"
	L.guard_icon = "inv_misc_head_dragon_red"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{16805, "ICON"}, -- Conflagration
		"guard", -- Chromatic Elite Guard
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
	self:Death("GuardDeath", 10814)
end

function mod:OnEngage()
	guardsDead = 0

	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ConflagrationApply(args)
	self:PrimaryIcon(16805, args.destName)
	self:TargetBar(16805, 10, args.destName, "yellow")
	self:TargetMessage2(16805, "yellow", args.destName)
	self:PlaySound(16805, "Alarm")
end

function mod:ConflagrationRemove(args)
	self:PrimaryIcon(16805)
	self:StopBar(16804, args.destName)
end

function mod:GuardDeath()
	guardsDead = guardsDead + 1
	self:Message2("guard", "green", L.guard_msg:format(guardsDead, 2), L.guard_icon)
end
