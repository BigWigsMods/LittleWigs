
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Oakheart", 1067, 1655)
if not mod then return end
mod:RegisterEnableMob(103344)
mod.engageId = 1837

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		204646, -- Crushing Grip
		204574, -- Strangling Roots
		204667, -- Nightmare Breath
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "CrushingGrip", 204646)
	self:Log("SPELL_CAST_START", "StranglingRoots", 204574)
	self:Log("SPELL_CAST_START", "NightmareBreath", 204667)
end

function mod:OnEngage()
	self:Bar(204646, 33) -- Crushing Grip
	self:Bar(204574, 13) -- Strangling Roots
	self:Bar(204667, 22) -- Nightmare Breath
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CrushingGrip(args)
	self:Message(args.spellId, "Important", "Warning")
	self:Bar(args.spellId, 32)
end

function mod:StranglingRoots(args)
	self:Message(args.spellId, "Attention")
	self:CDBar(args.spellId, 26) -- 26-31
end

function mod:NightmareBreath(args)
	self:Message(args.spellId, "Important", "Info")
	self:CDBar(args.spellId, 32)
end

