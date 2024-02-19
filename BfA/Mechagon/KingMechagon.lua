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
local clickCount = 0
local recalibrateTimer = nil

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.hardmode = 292750
	L.hardmode_desc = "Warning for when the Annihilo-tron 5000 starts displaying the button order."
	L.hardmode_icon = "inv_misc_bomb_03"

	L.button = "Button"
	L.button_desc = "Show a warning when someone clicks a button."
	L.button_icon = 275549
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		{291865, "CASTBAR"}, -- Recalibrate
		{291928, "SAY", "FLASH"}, -- Giga-Zap
		291613, -- Take Off!
		{291626, "CASTBAR"}, -- Cutting Beam
		{283551, "CASTBAR"}, -- Magneto-Arm
		292290, -- Protocol: Ninety-Nine
		-- Hard Mode
		{"hardmode", "COUNTDOWN"}, -- H.A.R.D.M.O.D.E.
		"button", -- Button
	}, {
		["hardmode"] = 292750,
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1", "boss2", "boss3")
	self:Log("SPELL_CAST_SUCCESS", "ClickButton", 292785)

	self:Log("SPELL_CAST_START", "Recalibrate", 291865) -- Stage 1 only
	self:Log("SPELL_CAST_SUCCESS", "RecalibrateSuccess", 291856)
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
			mod:Bar("hardmode", 32.1, L.hardmode, L.hardmode_icon) -- H.A.R.D.M.O.D.E.
		end
	end

	function mod:OnEngage()
		stage = 1
		gigaZapCount = 0
		clickCount = 0
		recalibrateTimer = nil
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
		clickCount = 0
		self:Message("hardmode", "yellow", L.hardmode, L.hardmode_icon)
		self:PlaySound("hardmode", "long")
		self:CDBar("hardmode", 43.7, L.hardmode, L.hardmode_icon)
	end
end

function mod:ClickButton(args)
	clickCount = clickCount + 1
	self:TargetMessage("button", "cyan", args.sourceName, CL.count:format(L.button, clickCount), L.button_icon)
	self:PlaySound("button", "warning")
end

function mod:AerialUnitDeath(args)
	stage = 2
	gigaZapCount = 0 -- Giga-Zap sequence is different in stage 2
	self:Message("stages", "cyan", CL.stage:format(stage), false)
	self:PlaySound("stages", "long")
	self:StopBar(291865) -- Recalibrate
	self:StopBar(291928) -- Giga-Zap
	self:StopBar(291613) -- Take Off
end

function mod:OmegaBusterDeath(args)
	stage = 3
	self:StopBar(291928) -- Giga-Zap
	self:StopBar(283534) -- Magneto Arm
	self:StopBar(291865) -- Recalibrate
	if recalibrateTimer then
		self:CancelTimer(recalibrateTimer)
	end
end

function mod:Recalibrate(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:CastBar(args.spellId, 2)
end

do
	local function warnRecalibrate()
		mod:Message(291865, "orange")
		mod:PlaySound(291865, "alert")
		mod:CastBar(291865, 2)
	end

	local prev = 0
	function mod:RecalibrateSuccess(args)
		local t = args.time
		if stage == 2 and t-prev > 1.5 then
			prev = t
			self:Bar(291865, 5.5) -- Recalibrate
			recalibrateTimer = self:ScheduleTimer(warnRecalibrate, 5.5)
		end
	end

	function mod:MagnetoArmSuccess(args)
		self:CastBar(283551, 9) -- Magneto Arm
		if recalibrateTimer then
			self:CancelTimer(recalibrateTimer)
		end
		-- Every 8 sec, recalibrate is attempted.
		-- It does not cast between the start of the magnet's channel and the magnet despawning.
		-- The magnet despawns after 10 sec and the cast time of Recalibrate is 2.5sec
		local elapsed = args.time - prev
		-- The next recalibreate will be in greater than 10 seconds.
		-- Find the lowest multiple of 8 (recalibrate timer) that is still greater than 10 after the following have been subtracted
		-- - 2.5 sec (for the cast time)
		-- - The already elapsed time
		local multiple = math.ceil((12.5 + elapsed) / 8) * 8
		local nextCast = multiple - 2.5 - elapsed
		self:Bar(291865, nextCast) -- Recalibrate
		recalibrateTimer = self:ScheduleTimer(warnRecalibrate, nextCast)
	end
end


function mod:MagnetoArm(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 62)
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(291928, "red", name)
		self:PlaySound(291928, "alarm", nil, name)
		if self:Me(guid) then
			self:Say(291928, nil, nil, "Giga-Zap")
			self:Flash(291928)
		end
	end

	function mod:GigaZap(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
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
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 34)
end

function mod:CuttingBeam(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CastBar(args.spellId, 6)
end

function mod:ProtocolNinetyNine(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "warning")
end
