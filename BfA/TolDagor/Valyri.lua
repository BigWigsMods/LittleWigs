if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Knight Captain Valyri", 1771, 2099)
if not mod then return end
mod:RegisterEnableMob(127490) -- Knight Captain Valyri
mod.engageId = 2103

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		256970, -- Ignition
		256955, -- Cinderflame
		257028, -- Fuselighter
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Ignition", 256970)
	self:Log("SPELL_CAST_START", "Cinderflame", 256955)
	self:Log("SPELL_CAST_SUCCESS", "Fuselighter", 257028)
	self:Log("SPELL_AURA_APPLIED", "FuselighterApplied", 257028)
end

function mod:OnEngage()
	self:Bar(256970, 10) -- Ignition
	self:Bar(257028, 17.5) -- Fuselighter
	self:Bar(256955, 18) -- Cinderflame
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Ignition(args)
	self:Message(args.spellId, "yellow", "Alert")
	self:Bar(args.spellId, 47.5)
end

function mod:Cinderflame(args)
	self:Message(args.spellId, "red", "Warning", CL.casting:format(args.spellName))
	self:CastBar(args.spellId, 8)
	self:Bar(args.spellId, 25)
end

function mod:Fuselighter(args)
	self:Bar(args.spellId, 33)
end

function mod:FuselighterApplied(args)
	self:TargetMessage(args.spellId, args.destName, "yellow", "Alarm", nil, nil, self:Dispeller("magic"))
end
