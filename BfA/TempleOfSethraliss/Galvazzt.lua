if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Galvazzt", 1877, 2144)
if not mod then return end
mod:RegisterEnableMob(133389) -- Galvazzt
mod.engageId = 2126

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{266923, "ME_ONLY"}, -- Electroshock
		266512, -- Consume Charge
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Electroshock", 266923)
	self:Log("SPELL_CAST_START", "ConsumeCharge", 266512)
end

function mod:OnEngage()
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Electroshock(args)
	self:TargetMessage(args.spellId, destName, "cyan", "Info", nil, nil, true)
end

function mod:ConsumeCharge(args)
	self:Message(args.spellId, "red", "Warning")
end
