if not IsTestBuild() then return end

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("King Mechagon", 2097, 2331)
if not mod then return end
mod:RegisterEnableMob(154817)
mod.engageId = 2260

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		291865, -- Recalibrate
		{291928, "SAY", "FLASH"}, -- Giga-Zap
		291613, -- Take Off!
		291914, -- Cutting Beam
		283534, -- Magneto-Arm
		292290, -- Protocol: Ninety-Nine
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Recalibrate", 291865)
	self:Log("SPELL_CAST_START", "GigaZap", 291928)
	self:Log("SPELL_CAST_START", "TakeOff", 291613)
	self:Log("SPELL_CAST_SUCCESS", "CuttingBeam", 291914)
	self:Log("SPELL_CAST_SUCCESS", "MagnetoArm", 283534)
	self:Log("SPELL_CAST_START", "ProtocolNinetyNine", 292290)
end

function mod:OnEngage()

end

--------------------------------------------------------------------------------
-- Event Handlers
--

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
	end
end

function mod:TakeOff(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "info")
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
end

function mod:ProtocolNinetyNine(args)
	self:Message2(args.spellId, "yellow")
	self:PlaySound(args.spellId, "warning")
end
