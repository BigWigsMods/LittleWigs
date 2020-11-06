
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
		276229, -- Micro Missiles
		271456, -- Drill Smash
	}, {
		[260280] = -18916, -- Stage One: Big Guns
		[271456] = -17498, -- Stage Two: Drill!
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "GatlingGun", 260280)
	self:Log("SPELL_AURA_APPLIED", "HomingMissile", 260829)
	self:Log("SPELL_AURA_REMOVED", "HomingMissileRemoved", 260829)
	self:Log("SPELL_CAST_SUCCESS", "ConfigurationDrill", 260189)
	self:Log("SPELL_CAST_START", "DrillSmash", 271456)
	self:Log("SPELL_CAST_START", "MicroMissiles", 276229)
	self:Log("SPELL_CAST_SUCCESS", "ConfigurationCombat", 260190)

end

function mod:OnEngage()
	self:Bar(260829, 5) -- Homing Missile
	self:Bar(260280, 15) -- Gatling Gun
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
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
	end
	self:TargetMessage(args.spellId, "red", args.destName)
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
	self:Message("stages", "cyan", args.spellName, args.spellId)
	self:PlaySound("stages", "info")
	self:StopBar(260829) -- Homing Missile
	self:StopBar(260280) -- Gatling Gun
	self:StopBar(CL.cast:format(self:SpellName(276229))) --  Micro Missiles Cast Bar
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(271456, "orange", name)
		self:PlaySound(271456, "alert", "watchstep", name)
	end

	function mod:DrillSmash(args)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
		self:Bar(args.spellId, 8.5)
	end
end

do
	local prev = 0
	function mod:MicroMissiles(args)
		local t = args.time
		if t-prev > 2 then
			prev = t
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "alarm")
			self:CastBar(args.spellId, 5)
		end
	end
end

function mod:ConfigurationCombat(args)
	self:Message("stages", "cyan", args.spellName, args.spellId)
	self:PlaySound("stages", "info")
	self:CDBar(260829, 9) -- Homing Missile
	self:Bar(260280, 17) -- Gatling Gun
end
