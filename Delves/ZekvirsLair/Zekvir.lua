--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Zekvir", 2682)
if not mod then return end
mod:RegisterEnableMob(225204) -- Zekvir
mod:SetEncounterID(2987)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Locals
--

local callWebTerrorCount = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.zekvir = "Zekvir"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.zekvir
end

function mod:GetOptions()
	return {
		450451, -- Claw Smash
		450505, -- Enfeebling Spittle
		450492, -- Horrendous Roar
		450568, -- Call Web Terror
		450519, -- Angler's Web
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ClawSmash", 450451)
	self:Log("SPELL_CAST_START", "EnfeeblingSpittle", 450505)
	self:Log("SPELL_INTERRUPT", "EnfeeblingSpittleInterrupt", 450505)
	self:Log("SPELL_CAST_SUCCESS", "EnfeeblingSpittleSuccess", 450505)
	self:Log("SPELL_CAST_START", "HorrendousRoar", 450492)
	self:Log("SPELL_CAST_START", "CallWebTerror", 450568)
	self:Log("SPELL_CAST_START", "AnglersWeb", 450519)
end

function mod:OnEngage()
	callWebTerrorCount = 1
	self:CDBar(450451, 5.1) -- Claw Smash
	self:CDBar(450505, 8.4) -- Enfeebling Spittle
	self:CDBar(450492, 10.0) -- Horrendous Roar
	self:CDBar(450568, 18.5, CL.count:format(self:SpellName(450568), callWebTerrorCount)) -- Call Web Terror
	self:CDBar(450519, 20.9) -- Angler's Web
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ClawSmash(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 20.7)
	self:PlaySound(args.spellId, "alarm")
end

function mod:EnfeeblingSpittle(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:EnfeeblingSpittleInterrupt()
	self:CDBar(450505, 15.3)
end

function mod:EnfeeblingSpittleSuccess(args)
	self:CDBar(args.spellId, 15.3)
end

function mod:HorrendousRoar(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 20.6)
	self:PlaySound(args.spellId, "alarm")
end

function mod:CallWebTerror(args)
	self:StopBar(CL.count:format(args.spellName, callWebTerrorCount))
	self:Message(args.spellId, "cyan", CL.count:format(args.spellName, callWebTerrorCount))
	callWebTerrorCount = callWebTerrorCount + 1
	self:CDBar(args.spellId, 41.3, CL.count:format(args.spellName, callWebTerrorCount))
	self:PlaySound(args.spellId, "long")
end

function mod:AnglersWeb(args)
	self:Message(args.spellId, "red")
	self:CDBar(args.spellId, 26.7) -- TODO might be a pattern
	self:PlaySound(args.spellId, "alarm")
end
