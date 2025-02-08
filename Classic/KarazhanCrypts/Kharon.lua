--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Kharon", 2875)
if not mod then return end
mod:RegisterEnableMob(237439) -- Kharon
mod:SetEncounterID(3143)
--mod:SetRespawnTime(30)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.kharon = "Kharon"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.kharon
end

function mod:GetOptions()
	return {
		{1217694, "CASTBAR"}, -- The Red Death
		1217952, -- Dreadful Visage
		1218038, -- Inhume
		1218089, -- Illimitable Dominion
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "TheRedDeath", 1217694)
	self:Log("SPELL_CAST_START", "DreadfulVisage", 1217952)
	self:Log("SPELL_CAST_START", "Inhume", 1218038)
	self:Log("SPELL_AURA_APPLIED", "InhumeApplied", 1218038)
	self:Log("SPELL_CAST_START", "IllimitableDominion", 1218089)
	self:Log("SPELL_AURA_APPLIED", "IllimitableDominionApplied", 1218089)
end

function mod:OnEngage()
	self:CDBar(1217694, 20.8) -- The Red Death
	self:CDBar(1217952, 30.6) -- Dreadful Visage
	self:CDBar(1218038, 32.6) -- Inhume
	self:CDBar(1218089, 40.3) -- Illimitable Dominion
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:TheRedDeath(args)
	self:Message(args.spellId, "red")
	self:CastBar(args.spellId, 4.5)
	self:CDBar(args.spellId, 30.7)
	self:PlaySound(args.spellId, "warning")
end

function mod:DreadfulVisage(args)
	self:Message(args.spellId, "cyan")
	self:CDBar(args.spellId, 64.7)
	self:PlaySound(args.spellId, "info")
end

function mod:Inhume(args)
	self:CDBar(args.spellId, 64.7)
end

function mod:InhumeApplied(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "info", nil, args.destName)
	else
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
	end
end

function mod:IllimitableDominion(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 82.5)
end

function mod:IllimitableDominionApplied(args)
	self:TargetMessage(args.spellId, "orange", args.destName)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
end
