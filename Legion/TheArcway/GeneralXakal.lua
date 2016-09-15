
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("General Xakal", 1079, 1499)
if not mod then return end
mod:RegisterEnableMob(98206)
mod.engageId = 1828

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		197776, -- Fel Fissure
		197810, -- Wicked Slam
		212030, -- Shadow Slash
		-- Dread Felbat / Bombardment?
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "FelFissure", 197776)
	self:Log("SPELL_CAST_START", "ShadowSlash", 212030)
	self:Log("SPELL_CAST_START", "WickedSlam", 197810)
end

function mod:OnEngage()
	self:Bar(197776, 6) -- Fel Fissure
	self:Bar(212030, 14) -- Shadow Slash
	self:Bar(197810, 36) -- Wicked Slam
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:FelFissure(args)
	self:Message(args.spellId, "Attention")
	self:CDBar(args.spellId, 23)
end

function mod:ShadowSlash(args)
	self:Message(args.spellId, "Urgent", "Alarm")
	self:CDBar(args.spellId, 25)
end

function mod:WickedSlam(args)
	self:Message(args.spellId, "Urgent", "Alert")
	self:CDBar(args.spellId, 47)
end
