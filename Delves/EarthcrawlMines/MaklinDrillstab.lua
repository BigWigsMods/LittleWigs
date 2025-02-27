--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Maklin Drillstab", 2680)
if not mod then return end
mod:RegisterEnableMob(216863) -- Maklin Drillstab
mod:SetEncounterID(3005)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.maklin_drillstab = "Maklin Drillstab"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.maklin_drillstab
end

function mod:GetOptions()
	return {
		1217905, -- Call Mole Machine
		1217903, -- Firebolt
		1217913, -- Dark Burn
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "CallMoleMachine", 1217905)
	self:Log("SPELL_CAST_START", "Firebolt", 1217903)
	self:Log("SPELL_CAST_START", "DarkBurn", 1217913)
end

function mod:OnEngage()
	self:CDBar(1217905, 3.6) -- Call Mole Machine
	self:CDBar(1217903, 6.1) -- Firebolt
	self:CDBar(1217913, 18.2) -- Dark Burn
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CallMoleMachine(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 16.2)
	self:PlaySound(args.spellId, "alarm")
end

function mod:Firebolt(args)
	self:Message(args.spellId, "red")
	self:CDBar(args.spellId, 21.8)
	self:PlaySound(args.spellId, "alert")
end

function mod:DarkBurn(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 21.8)
	self:PlaySound(args.spellId, "info")
end
