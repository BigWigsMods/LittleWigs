if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ring of Booty", nil, 2094, 1754)
if not mod then return end
mod:RegisterEnableMob(126969) -- Trothak
mod.engageId = 2095

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		256405, -- Sharknado
		256358, -- Shark Toss
		256489, -- Rearm
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Sharknado", 256405)
	self:Log("SPELL_CAST_SUCCESS", "SharkToss", 256358)
	self:Log("SPELL_CAST_START", "Rearm", 256489)
end

function mod:OnEngage()
	self:CDBar(256358, 17) -- Shark Toss
	self:CDBar(256405, 23) -- Sharknado
	self:CDBar(256489, 46) -- Rearm
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Sharknado(args)
	self:Message(args.spellId, "red", "Warning")
	self:Bar(args.spellId, 40)
end

function mod:SharkToss(args)
	self:Message(args.spellId, "yellow", "Alert")
	self:CDBar(args.spellId, 29)
end

function mod:Rearm(args)
	self:Message(args.spellId, "cyan", "Info")
	self:Bar(args.spellId, 40)
end
