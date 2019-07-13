--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("King Mechagon", 2097, 2331)
if not mod then return end
mod:RegisterEnableMob(150396, 150397, 144249) -- Aerial Unit R-21/X, King Mechagon, Omega Buster
mod.engageId = 2260

--------------------------------------------------------------------------------
-- Locals
--

local stage = 1
local gigaZapCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		291865, -- Recalibrate
		{291928, "SAY", "FLASH"}, -- Giga-Zap
		291613, -- Take Off!
		291626, -- Cutting Beam
		283551, -- Magneto-Arm
		292290, -- Protocol: Ninety-Nine
		-- Hard Mode
		292750, -- H.A.R.D.M.O.D.E.
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1", "boss2", "boss3")

	self:Log("SPELL_CAST_START", "Recalibrate", 291865)
	self:Log("SPELL_CAST_START", "GigaZap", 291928, 292264) -- Stage 1, stage 2
	self:Log("SPELL_CAST_START", "TakeOff", 291613)
	self:Log("SPELL_CAST_SUCCESS", "CuttingBeam", 291626)
	self:Log("SPELL_CAST_SUCCESS", "MagnetoArm", 283551) -- Boss's cast activating the device
	self:Log("SPELL_CAST_SUCCESS", "MagnetoArmSuccess", 283143) -- Pull in effect start
	self:Log("SPELL_CAST_START", "ProtocolNinetyNine", 292290)

	self:Death("AerialUnitDeath", 150396)
	self:Death("OmegaBusterDeath", 144249)
end

do
	local function startTimer()
		if mod:GetBossId(151168) then -- Annihilo-tron 5000, only active on hard mode
			mod:Bar(292750, 32.1) -- H.A.R.D.M.O.D.E.
		end
	end

	function mod:OnEngage()
		stage = 1
		gigaZapCount = 0
		self:SimpleTimer(startTimer, 0.1)
		self:Bar(291865, 5.9) -- Recalibrate
		self:Bar(291928, 8.4) -- Giga-Zap
		self:Bar(291613, 30) -- Take Off
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 296323 then -- Activate Omega buster
		self:Bar(291928, 14.8) -- Giga-Zap
		self:Bar(283551, 35.6) -- Magneto Arm
	elseif spellId == 292750 then -- H.A.R.D.M.O.D.E.
		self:Message2(292750, "cyan")
		self:PlaySound(292750, "long")
		self:CDBar(292750, 43.7)
	end
end

function mod:AerialUnitDeath(args)
	stage = 2
	gigaZapCount = 0 -- Giga-Zap sequence is different in stage 2
	self:Message2("stages", "cyan", CL.stage:format(stage), false)
	self:PlaySound("stages", "long")
	self:StopBar(291865) -- Recalibrate
	self:StopBar(291928) -- Giga-Zap
	self:StopBar(291613) -- Take Off
end

function mod:OmegaBusterDeath(args)
	self:StopBar(291928) -- Giga-Zap
	self:StopBar(283534) -- Magneto Arm
end

function mod:Recalibrate(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:CastBar(args.spellId, 2)
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage2(291928, "red", name)
		self:PlaySound(291928, "alarm", nil, name)
		if self:Me(guid) then
			self:Say(291928)
			self:Flash(291928)
		end
	end

	function mod:GigaZap(args)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
		gigaZapCount = gigaZapCount + 1
		if stage == 1 then
			self:CDBar(291928, (gigaZapCount % 2 == 0) and 20.8 or 16) -- Longer timer when Cutting Beam is cast
		else -- Stage 2
			if gigaZapCount % 3 == 0 then
				self:CDBar(291928, 23)
			else
				self:Bar(291928, 3.5)
			end
		end
	end
end

function mod:TakeOff(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 34)
end

function mod:CuttingBeam(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CastBar(args.spellId, 6)
end

function mod:MagnetoArm(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 62)
end

function mod:MagnetoArmSuccess(args)
	self:CastBar(283551, 9)
end

function mod:ProtocolNinetyNine(args)
	self:Message2(args.spellId, "yellow")
	self:PlaySound(args.spellId, "warning")
end
