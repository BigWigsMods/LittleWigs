--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Harbinger of Sin", 2875)
if not mod then return end
mod:RegisterEnableMob(237964) -- Harbinger of Sin
mod:SetEncounterID(3141)
--mod:SetRespawnTime(30)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.harbinger_of_sin = "Harbinger of Sin"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.harbinger_of_sin
end

function mod:GetOptions()
	return {
		1222775, -- Incendiary Crash
		1219387, -- Flame Whirl
		{1219420, "CASTBAR"}, -- Pull of the damned
		1220927, -- Inferno
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "IncendiaryCrash", 1222775)
	self:Log("SPELL_CAST_START", "FlameWhirl", 1219387)
	self:Log("SPELL_CAST_START", "PullOfTheDamned", 1219420)
	self:Log("SPELL_CAST_START", "Inferno", 1220927)
end

function mod:OnEngage()
	self:CDBar(1222775, 8.1) -- Incendiary Crash
	self:CDBar(1219387, 13.0) -- Flame Whirl
	self:CDBar(1219420, 30.4) -- Pull of the damned
	self:CDBar(1220927, 43.4) -- Inferno
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:IncendiaryCrash(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 11.3)
	self:PlaySound(args.spellId, "alarm")
end

function mod:FlameWhirl(args)
	self:Message(args.spellId, "red")
	self:CDBar(args.spellId, 38.8)
	self:PlaySound(args.spellId, "alert")
end

function mod:PullOfTheDamned(args)
	self:Message(args.spellId, "cyan")
	self:CastBar(args.spellId, 13.0)
	self:CDBar(1220927, {13.01, 43.7}) -- Inferno
	self:CDBar(1219387, {19.4, 38.8}) -- Flame Whirl
	self:CDBar(1222775, 25.9) -- Incendiary Crash
	self:CDBar(args.spellId, 43.7)
	self:PlaySound(args.spellId, "long")
end

function mod:Inferno(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 43.7)
	self:PlaySound(args.spellId, "warning")
end
