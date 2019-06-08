if not IsTestBuild() then return end

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
		292290, -- Protocol: Ninety-Nine XXX check spell id. only cast when tank is out of range.
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")

	self:Log("SPELL_CAST_START", "Recalibrate", 291865)
	self:Log("SPELL_CAST_START", "GigaZap", 291928, 292264) -- Stage 1, stage 2
	self:Log("SPELL_CAST_START", "TakeOff", 291613)
	self:Log("SPELL_CAST_SUCCESS", "CuttingBeam", 291626)
	self:Log("SPELL_CAST_SUCCESS", "MagnetoArm", 283551)
	self:Log("SPELL_CAST_START", "ProtocolNinetyNine", 292290)

	self:Death("AerialUnitDeath", 150396)
	self:Death("OmegaBusterDeath", 144249)
end

function mod:OnEngage()
	stage = 1
	gigaZapCount = 0
	self:Bar(291865, 5.9) -- Recalibrate
	self:Bar(291928, 8.4) -- Giga-Zap
	self:Bar(291613, 31.4) -- Take Off
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 296323 then -- Activate Omega buster
		self:Bar(291928, 16) -- Giga-Zap
		self:Bar(283551, 40.3) -- Magneto Arm
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
	self:CDBar(args.spellId, 37)
end

function mod:CuttingBeam(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CastBar(args.spellId, 6)
end

function mod:MagnetoArm(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CastBar(args.spellId, 9)
	self:Bar(args.spellId, 62)
end

function mod:ProtocolNinetyNine(args)
	self:Message2(args.spellId, "yellow")
	self:PlaySound(args.spellId, "warning")
end
