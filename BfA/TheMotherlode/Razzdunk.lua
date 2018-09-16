
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Mogul Razzdunk", 1594, 2116)
if not mod then return end
mod:RegisterEnableMob(129232)
mod.engageId = 2108

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		260280, -- Gatling Gun
		{260829, "ICON", "SAY"}, -- Homing Missile
		271456, -- Drill Smash
		--270277, -- Big Red Rocket XXX Missing from logs, UNIT event?
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "GatlingGun", 260280)
	self:Log("SPELL_AURA_APPLIED", "HomingMissile", 260829)
	self:Log("SPELL_AURA_REMOVED", "HomingMissileRemoved", 260829)
	self:Log("SPELL_CAST_SUCCESS", "ConfigurationDrill", 260189)
	self:Log("SPELL_CAST_START", "DrillSmash", 271456)
	--self:Log("SPELL_CAST_START", "BigRedRocket", 270277)
	self:Log("SPELL_CAST_SUCCESS", "ConfigurationCombat", 260190)

end

function mod:OnEngage()
	self:Bar(260829, 5) -- Homing Missile
	self:Bar(260280, 15) -- Gatling Gun
	self:Bar("stages", 49, self:SpellName(260189), 260189) -- Configuration: Drill
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:GatlingGun(args)
	self:Message2(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 20)
end

function mod:HomingMissile(args)
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
	end
	self:TargetMessage2(args.spellId, "red", args.destName)
	self:PlaySound(args.spellId, "warning", nil, args.destName)
	self:TargetBar(args.spellId, 10, args.destName)
	self:PrimaryIcon(args.spellId, args.destName)

	self:CDBar(args.spellId, 21)
end

function mod:HomingMissileRemoved(args)
	self:PrimaryIcon(args.spellId)
	self:StopBar(args.spellName, args.destName)
end

function mod:ConfigurationDrill(args)
	self:Message2("stages", "cyan", args.spellName, args.spellId)
	self:PlaySound("stages", "info")
	self:StopBar(260829) -- Homing Missile
	self:StopBar(260280) -- Gatling Gun
end

function mod:DrillSmash(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert", "watchstep")
	self:Bar(args.spellId, 8.5)
end

-- function mod:BigRedRocket(args)
	-- self:Message2(args.spellId, "yellow")
	-- self:Playsound(args.spellId, "long")
-- end

function mod:ConfigurationCombat(args)
	self:Message2("stages", "cyan", args.spellName, args.spellId)
	self:PlaySound("stages", "info")
	-- XXX Update timers below
	self:CDBar(260829, 5) -- Homing Missile
	self:Bar(260280, 15) -- Gatling Gun
	self:Bar("stages", 49, self:SpellName(260189), 260189) -- Configuration: Drill
end
