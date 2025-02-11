local isElevenDotOne = select(4, GetBuildInfo()) >= 110100 -- XXX remove when 11.1 is live
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

local gatlingGunCount = 1 -- XXX remove in 11.1
local homingMissileCount = 1 -- XXX remove in 11.1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		-- Stage One: Big Guns
		260280, -- Gatling Gun
		{260811, "SAY", "ME_ONLY_EMPHASIZE"}, -- Homing Missile
		{276229, "CASTBAR"}, -- Micro Missiles (Mythic)
		-- Stage Two: Drill!
		271456, -- Drill Smash
	}, {
		[260280] = -18916, -- Stage One: Big Guns
		[271456] = -17498, -- Stage Two: Drill!
	}
end

function mod:OnBossEnable()
	-- Stage One: Big Guns
	self:Log("SPELL_CAST_START", "GatlingGun", 260280)
	self:Log("SPELL_CAST_START", "HomingMissile", 260811)
	self:Log("SPELL_AURA_APPLIED", "HomingMissileApplied", 260829)
	self:Log("SPELL_CAST_START", "MicroMissiles", 276229)
	self:Log("SPELL_CAST_SUCCESS", "ConfigurationDrill", 260189)

	-- Stage Two: Drill!
	self:Log("SPELL_CAST_START", "DrillSmash", 271456)
	self:Log("SPELL_CAST_SUCCESS", "ConfigurationCombat", 260190)
	self:Death("MogulRazdunkVehicleDeath", 129232)
end

function mod:OnEngage()
	gatlingGunCount = 1
	homingMissileCount = 1
	self:SetStage(1)
	self:CDBar(260811, 5.0) -- Homing Missile
	self:CDBar(260280, 15.0) -- Gatling Gun
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Stage One: Big Guns

function mod:GatlingGun(args)
	self:Message(args.spellId, "yellow")
	if isElevenDotOne then
		self:CDBar(args.spellId, 30.0)
	else -- XXX remove in 11.1
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
	self:Message(args.spellId, "red", CL.incoming:format(args.spellName))
	if isElevenDotOne then
		self:CDBar(args.spellId, 30.0)
	else -- XXX remove in 11.1
		homingMissileCount = homingMissileCount + 1
		if homingMissileCount % 2 == 0 then
			self:CDBar(args.spellId, 21.0)
		else
			self:CDBar(args.spellId, 24.0)
		end
	end
end

function mod:HomingMissileApplied(args)
	self:TargetMessage(260811, "orange", args.destName)
	if self:Me(args.destGUID) then
		self:Say(260811, nil, nil, "Homing Missile")
		self:PlaySound(260811, "warning", nil, args.destName)
	else
		self:PlaySound(260811, "alarm", nil, args.destName)
	end
end

do
	local prev = 0
	function mod:MicroMissiles(args)
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "red")
			self:CastBar(args.spellId, 5)
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

function mod:ConfigurationDrill(args)
	homingMissileCount = 1
	gatlingGunCount = 1
	self:StopBar(260811) -- Homing Missile
	self:StopBar(260280) -- Gatling Gun
	self:StopBar(CL.cast:format(self:SpellName(276229))) --  Micro Missiles Cast Bar
	self:SetStage(2)
	self:Message("stages", "cyan", args.spellName, args.spellId)
	self:PlaySound("stages", "info")
end

-- Stage Two: Drill!

do
	local function printTarget(self, name, guid)
		self:TargetMessage(271456, "orange", name)
		self:PlaySound(271456, "alert", nil, name)
	end

	function mod:DrillSmash(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
		self:CDBar(args.spellId, 10.9)
	end
end

function mod:ConfigurationCombat(args)
	if self:IsEngaged() then -- cast on respawn
		self:StopBar(271456) -- Drill Smash
		self:SetStage(1)
		self:Message("stages", "cyan", args.spellName, args.spellId)
		self:CDBar(260811, 9.0) -- Homing Missile
		self:CDBar(260280, 17.0) -- Gatling Gun
		self:PlaySound("stages", "info")
	end
end

function mod:MogulRazdunkVehicleDeath()
	self:StopBar(260811) -- Homing Missile
	self:StopBar(260280) -- Gatling Gun
end
