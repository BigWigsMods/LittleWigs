if not C_ChatInfo then return end -- XXX Don't load outside of 8.0
--------------------------------------------------------------------------------
-- TODO:
-- Revise more spells, didn't really see many from all the ones listed.
--

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
		263573, -- Cyclone Strike
		-- 263257, -- Static Shock
		-- 263424, -- Arc Dash
		-- 263758, -- Twister
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "LightningShield", 263246)
	self:Log("SPELL_AURA_APPLIED", "Conduction", 263371)
	self:Log("SPELL_AURA_REMOVED", "ConductionRemoved", 263371)
	self:Log("SPELL_CAST_START", "CycloneStrike", 263573)
	-- self:Log("SPELL_AURA_START", "StaticShock", 263257)
	-- self:Log("SPELL_AURA_SUCCESS", "ArcDash", 263424)
	-- self:Log("SPELL_AURA_SUCCESS", "Twister", 263758)

end

function mod:OnEngage()
	self:Bar(263573, 8.5) -- Cyclone Strike
	self:Bar(263371, 22.5) -- Conduction
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:LightningShield(args)
	self:TargetMessage2(args.spellId, "cyan", args.destName)
	self:PlaySound(args.spellId, "info")
end

function mod:Conduction(args)
	self:TargetMessage2(args.spellId, "orange", args.destName)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "warning")
		self:Say(args.spellId)
		self:SayCountdown(args.spellId, 5)
		-- self:Bar(args.spellId, 13.5)
	end
end

function mod:ConductionRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
end

function mod:CycloneStrike(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 13.5)
end

-- function mod:StaticShock(args)
	-- self:Message(args.spellId, "orange", "Long")
-- end

-- function mod:ArcDash(args)
	-- self:Message(args.spellId, "yellow", "Alert")
-- end

-- function mod:Twister(args)
	-- self:Message(args.spellId, "orange", "Alarm")
-- end
