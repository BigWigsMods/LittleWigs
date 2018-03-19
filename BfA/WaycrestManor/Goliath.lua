if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Soulbound Goliath", 1862, 2126)
if not mod then return end
mod:RegisterEnableMob(131667, 132401) -- Soulbound Goliath, Wicker Goliath XXX Check which one is correct
mod.engageId = 2114

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		260512, -- Soul Harvest
		267907, -- Soul Thorns
		{260508, "TANK"}, -- Crush
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "SoulHarvest", 260512)
	self:Log("SPELL_AURA_APPLIED", "SoulThorns", 267907)
	self:Log("SPELL_CAST_START", "Crush", 260508)
end

function mod:OnEngage()
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SoulHarvest(args)
	self:Message(args.spellId, "yellow", "Alert")
end

function mod:SoulThorns(args)
	self:TargetMessage(args.spellId, args.destName, "orange", "Alarm", nil, nil, true)
end

function mod:SoulHarvest(args)
	self:Message(args.spellId, "yellow", "Alert")
end
