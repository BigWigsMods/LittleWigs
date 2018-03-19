if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Adderis and Aspix", 1877, 2142)
if not mod then return end
mod:RegisterEnableMob(133379, 133944) -- Adderis, Aspix
mod.engageId = 2124

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		263246, -- Lightning Shield
		263371, -- Conduction
		263234, -- Arcing Blade XXX in overview but not listed under spells
		263257, -- Static Shock
		263424, -- Arc Dash
		263758, -- Twister
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "LightningShield", 263246)
	self:Log("SPELL_AURA_APPLIED", "Conduction", 263371)
	self:Log("SPELL_CAST_START", "ArcingBlade", 263234)
	self:Log("SPELL_AURA_START", "StaticShock", 263257)
	self:Log("SPELL_AURA_SUCCESS", "ArcDash", 263424)
	self:Log("SPELL_AURA_SUCCESS", "Twister", 263758)

end

function mod:OnEngage()
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:LightningShield(args)
	self:TargetMessage(args.spellId, destName, "cyan", "Info", nil, nil, true)
end

function mod:Conduction(args)
	self:TargetMessage(args.spellId, destName, "red", "Warning")
end

function mod:ArcingBlade(args)
	self:Message(args.spellId, "yellow", "Alert")
end

function mod:StaticShock(args)
	self:Message(args.spellId, "orange", "Long")
end

function mod:ArcDash(args)
	self:Message(args.spellId, "yellow", "Alert")
end

function mod:Twister(args)
	self:Message(args.spellId, "orange", "Alarm")
end
