if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

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
		260811, -- Homing Missile
		271456, -- Drill Smash
		--270277, -- Big Red Rocket XXX Missing from logs, UNIT event?
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "GatlingGun", 260280)
	self:Log("SPELL_CAST_START", "HomingMissile", 260811)
	self:Log("SPELL_CAST_SUCCESS", "ConfigurationDrill", 260189)
	self:Log("SPELL_CAST_START", "DrillSmash", 271456)
	--self:Log("SPELL_CAST_START", "BigRedRocket", 270277)
	self:Log("SPELL_CAST_SUCCESS", "ConfigurationCombat", 260190)

end

function mod:OnEngage()
	self:Bar(260811, 5) -- Homing Missile
	self:Bar(260280, 15) -- Gatling Gun
	self:Bar("stages", 49, self:SpellName(260189), 260189) -- Configuration: Drill
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:GatlingGun(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 20)
end

function mod:HomingMissile(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning", "killmob")
	self:Bar(args.spellId, 21)
end

function mod:ConfigurationDrill(args)
	self:Message("stages", "cyan", nil, args.spellName, args.spellId)
	self:PlaySound("stages", "info")
	self:StopBar(260811) -- Homing Missile
	self:StopBar(260280) -- Gatling Gun
end

function mod:DrillSmash(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert", "watchstep")
	self:Bar(args.spellId, 8.5)
end

-- function mod:BigRedRocket(args)
	-- self:Message(args.spellId, "yellow")
	-- self:Playsound(args.spellId, "long")
-- end

function mod:ConfigurationCombat(args)
	self:Message("stages", "cyan", nil, args.spellName, args.spellId)
	self:PlaySound("stages", "info")
	-- XXX Update timers below
	self:Bar(260811, 5) -- Homing Missile
	self:Bar(260280, 15) -- Gatling Gun
	self:Bar("stages", 49, self:SpellName(260189), 260189) -- Configuration: Drill
end
