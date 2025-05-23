--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Mogul Razdunk", 1594, 2116)
if not mod then return end
mod:RegisterEnableMob(129232, 132713) -- the vehicle, the actual boss
mod:SetEncounterID(2108)
mod:SetRespawnTime(36.4)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local gatlingGunCount = 1
local homingMissileCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		-- Stage One: Big Guns
		260280, -- Gatling Gun
		{260813, "SAY", "ME_ONLY_EMPHASIZE"}, -- Homing Missile
		{276229, "CASTBAR"}, -- Micro Missiles (Mythic)
		-- Stage Two: Drill!
		{271456, "SAY", "SAY_COUNTDOWN", "ME_ONLY_EMPHASIZE"}, -- Drill Smash
	}, {
		[260280] = -18916, -- Stage One: Big Guns
		[271456] = -17498, -- Stage Two: Drill!
	}
end

function mod:OnBossEnable()
	-- Stage One: Big Guns
	self:Log("SPELL_CAST_START", "GatlingGun", 260280)
	self:Log("SPELL_CAST_START", "HomingMissile", 260813)
	self:Log("SPELL_AURA_APPLIED", "HomingMissileApplied", 260811)
	self:Log("SPELL_CAST_START", "MicroMissiles", 276229)
	self:Log("SPELL_CAST_SUCCESS", "ConfigurationDrill", 260189)

	-- Stage Two: Drill!
	self:Log("SPELL_CAST_START", "DrillSmash", 271456)
	self:Log("SPELL_CAST_SUCCESS", "DrillSmashSuccess", 271456)
	self:Log("SPELL_CAST_SUCCESS", "ConfigurationCombat", 260190)
	self:Death("MogulRazdunkVehicleDeath", 129232)
end

function mod:OnEngage()
	gatlingGunCount = 1
	homingMissileCount = 1
	self:SetStage(1)
	self:CDBar(260813, 5.0) -- Homing Missile
	if self:Mythic() then
		self:CDBar(276229, 8.4) -- Micro Missiles
	end
	self:CDBar(260280, 20.0) -- Gatling Gun
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Stage One: Big Guns

function mod:GatlingGun(args)
	self:Message(args.spellId, "yellow")
	if self:GetStage() == 1 then
		self:CDBar(args.spellId, 30.0)
	else -- Stage 3
		gatlingGunCount = gatlingGunCount + 1
		if gatlingGunCount % 2 == 0 then
			self:CDBar(args.spellId, 20.0)
		else
			self:CDBar(args.spellId, 25.0)
		end
	end
	self:PlaySound(args.spellId, "alert")
end

function mod:HomingMissile(args)
	if self:GetStage() == 1 then
		self:CDBar(args.spellId, 30.0)
	else -- Stage 3
		homingMissileCount = homingMissileCount + 1
		if homingMissileCount % 2 == 0 then
			self:CDBar(args.spellId, 21.0)
		else
			self:CDBar(args.spellId, 24.0)
		end
	end
end

function mod:HomingMissileApplied(args)
	self:TargetMessage(260813, "orange", args.destName)
	if self:Me(args.destGUID) then
		self:Say(260813, nil, nil, "Homing Missile")
		self:PlaySound(260813, "warning", nil, args.destName)
	else
		self:PlaySound(260813, "alarm", nil, args.destName)
	end
end

do
	local prev = 0
	function mod:MicroMissiles(args)
		-- cast simultaneously by two B.O.O.M.B.A.s
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "red")
			self:CastBar(args.spellId, 5)
			if self:GetStage() == 1 then
				self:CDBar(args.spellId, 21.8)
			else -- Stage 3
				self:CDBar(args.spellId, 19.0)
			end
			self:PlaySound(args.spellId, "long")
		end
	end
end

function mod:ConfigurationDrill(args)
	self:StopBar(260813) -- Homing Missile
	self:StopBar(260280) -- Gatling Gun
	if self:Mythic() then
		self:StopBar(276229) -- Micro Missiles
	end
	self:SetStage(2)
	self:Message("stages", "cyan", CL.percent:format(50, args.spellName), args.spellId)
	self:PlaySound("stages", "long")
end

-- Stage Two: Drill!

do
	local function printTarget(self, name, guid, elapsed)
		self:TargetMessage(271456, "orange", name)
		if self:Me(guid) then
			self:Say(271456, nil, nil, "Drill Smash")
			self:SayCountdown(271456, 5 - elapsed)
			self:PlaySound(271456, "warning", nil, name)
		else
			self:PlaySound(271456, "alert", nil, name)
		end
	end

	function mod:DrillSmash(args)
		self:GetUnitTarget(printTarget, 0.2, args.sourceGUID)
		-- time until next depends on the travel time of the previous Drill Smash
		self:CDBar(args.spellId, 8.5)
	end

	function mod:DrillSmashSuccess(args)
		if self:Me(args.destGUID) then
			self:Message(args.spellId, "green", CL.removed:format(args.spellName))
			self:PlaySound(args.spellId, "info")
		end
	end
end

function mod:ConfigurationCombat(args)
	if self:IsEngaged() then -- cast on respawn
		self:StopBar(271456) -- Drill Smash
		self:SetStage(3)
		self:Message("stages", "cyan", args.spellName, args.spellId)
		self:CDBar(260813, 7.1) -- Homing Missile
		if self:Mythic() then
			self:CDBar(276229, 11.8) -- Micro Missiles
		end
		self:CDBar(260280, 17.1) -- Gatling Gun
		self:PlaySound("stages", "info")
	end
end

function mod:MogulRazdunkVehicleDeath()
	self:StopBar(260813) -- Homing Missile
	self:StopBar(260280) -- Gatling Gun
	if self:Mythic() then
		self:StopBar(276229) -- Micro Missiles
	end
end
