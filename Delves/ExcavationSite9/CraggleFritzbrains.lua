--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Craggle Fritzbrains", 2815)
if not mod then return end
mod:RegisterEnableMob(234291) -- Craggle Fritzbrains
mod:SetEncounterID(3095)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.craggle_fritzbrains = "Craggle Fritzbrains"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.craggle_fritzbrains
end

function mod:GetOptions()
	return {
		1214135, -- Make It Rain!
		{1214504, "DISPEL"}, -- Goblin Ingenuity
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "MakeItRain", 1214135)
	self:Log("SPELL_CAST_START", "GoblinIngenuity", 1214504)
	self:Log("SPELL_AURA_APPLIED", "GoblinIngenuityApplied", 1214504)
end

function mod:OnEngage()
	self:CDBar(1214135, 7.3) -- Make It Rain!
	self:CDBar(1214504, 11.0) -- Goblin Ingenuity
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:MakeItRain(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 15.0)
	self:PlaySound(args.spellId, "long")
end

function mod:GoblinIngenuity(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 17.0)
	self:PlaySound(args.spellId, "alert")
end

function mod:GoblinIngenuityApplied(args)
	if self:Dispeller("enrage", true, args.spellId) then
		self:Message(args.spellId, "orange", CL.onboss:format(args.spellName))
		if self:Dispeller("enrage", true) then
			self:PlaySound(args.spellId, "warning")
		else
			self:PlaySound(args.spellId, "info")
		end
	end
end
