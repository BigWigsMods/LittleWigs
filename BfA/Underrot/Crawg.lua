if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Infested Crawg", 1841, 2131)
if not mod then return end
mod:RegisterEnableMob(131817)
mod.engageId = 2118

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		260292, -- Charge
		260333, -- Tantrum
		260793, -- Indigestion
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Charge", 260292)
	self:Log("SPELL_CAST_SUCCESS", "Tantrum", 260333)
	self:Log("SPELL_CAST_START", "Indigestion", 260793)
end

function mod:OnEngage()
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Charge(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert", "watchstep")
end

function mod:Tantrum(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "long", "stompstart")
end

function mod:Indigestion(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning", "mobsoon")
end
