
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
		{263371, "SAY", "SAY_COUNTDOWN"}, -- Conduction
		263309, -- Cyclone Strike
		263257, -- Static Shock
		263424, -- Arc Dash
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_POWER_FREQUENT", nil, "boss1", "boss2")
	self:Log("SPELL_AURA_APPLIED", "LightningShield", 263246)
	self:Log("SPELL_AURA_APPLIED", "Conduction", 263371)
	self:Log("SPELL_AURA_REMOVED", "ConductionRemoved", 263371)
	self:Log("SPELL_CAST_START", "CycloneStrike", 263309)
	self:Log("SPELL_CAST_START", "StaticShock", 263257)
	self:Death("BossDeath", 133379, 133944)
end

function mod:OnEngage()
	self:Bar(263309, 8.5) -- Cyclone Strike
	self:Bar(263371, 22.5) -- Conduction
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prevDash = 0
	local prevShieldGUID = nil
	function mod:UNIT_POWER_FREQUENT(event, unit)
		local guid = UnitGUID(unit)
		local t = GetTime()
		if t-prevDash > 2 and self:MobId(guid) == 133379 then -- Adderis
			if UnitPower(unit) == 100 then
				prevDash = t
				self:Message2(263424, "orange") -- Arc Dash
				self:PlaySound(263424, "alert") -- Arc Dash
			end
		end
		if guid ~= prevShieldGUID and UnitPower(unit) == 0 then
			prevShieldGUID = guid
			self:Bar(263246, 4) -- Lightning Shield
		end
	end
end

function mod:LightningShield(args)
	self:Message2(args.spellId, "cyan", CL.other:format(args.spellName, args.destName))
	self:PlaySound(args.spellId, "info")
	if self:MobId(args.destGUID) == 133379 then -- Adderis
		self:Bar(263424, 20) -- Arc Dash
	else -- Aspix
		self:Bar(263257, 20) -- Static Shock
	end
end

function mod:Conduction(args)
	self:TargetMessage2(args.spellId, "orange", args.destName)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "warning")
		self:Say(args.spellId)
		self:SayCountdown(args.spellId, 5)
	end
end

function mod:ConductionRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
end

function mod:CycloneStrike(args)
	self:Message2(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 13.5)
end

function mod:StaticShock(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CastBar(args.spellId, 2)
end

function mod:BossDeath(args)
	self:StopBar(263424) -- Arc Dash
	self:StopBar(263257) -- Static Shock
end
