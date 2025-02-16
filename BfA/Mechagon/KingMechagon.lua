local isElevenDotOne = select(4, GetBuildInfo()) >= 110100 -- XXX remove when 11.1 is live
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("King Mechagon", 2097, 2331)
if not mod then return end
mod:RegisterEnableMob(150396, 144249, 150397) -- Aerial Unit R-21/X, Omega Buster, King Mechagon
mod:SetEncounterID(2260)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local megaZapCount = 1
local clickCount = 0
local recalibrateTimer = nil

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.hardmode = 292750 -- H.A.R.D.M.O.D.E.
	L.hardmode_desc = "Warning for when the Annihilo-tron 5000 starts displaying the button order."
	L.hardmode_icon = "inv_misc_bomb_03"

	L.button = "Button"
	L.button_desc = "Show a warning when someone clicks a button."
	L.button_icon = 275549 -- Big Red Button
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		-- Stage One: Aerial Unit R-21/X
		291865, -- Recalibrate
		{291928, "SAY"}, -- Mega-Zap
		291613, -- Take Off!
		{291626, "SAY"}, -- Cutting Beam
		-- Stage Two: Omega Buster
		{283551, "CASTBAR"}, -- Magneto-Arm
		{292264, "SAY"}, -- Mega-Zap
		292290, -- Protocol: Ninety-Nine
		-- H.A.R.D.M.O.D.E.
		{"hardmode", "COUNTDOWN"}, -- H.A.R.D.M.O.D.E.
		"button", -- Button
	}, {
		[291865] = -19874, -- Stage One: Aerial Unit R-21/X
		[283551] = -19875, -- Stage Two: Omega Buster
		["hardmode"] = 292750, -- H.A.R.D.M.O.D.E.
	}
end

function mod:OnBossEnable()
	-- Stage One: Aerial Unit R-21/X
	self:Log("SPELL_CAST_START", "RecalibrateStage1", 291865) -- Stage 1 only
	self:Log("SPELL_CAST_START", "MegaZapStage1", 291928)
	self:Log("SPELL_CAST_START", "TakeOff", 291613)
	if isElevenDotOne then
		self:Log("SPELL_AURA_APPLIED", "CuttingBeamApplied", 1226680)
	else -- XXX remove in 11.1
		self:Log("SPELL_CAST_SUCCESS", "CuttingBeam", 291626)
	end
	self:Death("AerialUnitR21XDeath", 150396)

	-- Stage Two: Omega Buster
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1", "boss2", "boss3") -- Activate Omega Buster
	self:Log("SPELL_CAST_SUCCESS", "Recalibrate", 291856) -- Stage 2 only
	self:Log("SPELL_CAST_START", "MagnetoArm", 283551) -- Boss's cast activating the device
	self:Log("SPELL_CAST_SUCCESS", "MagnetoArmSuccess", 283143) -- Pull in effect start
	self:Log("SPELL_CAST_START", "MegaZapStage2", 292264)
	self:Log("SPELL_CAST_START", "ProtocolNinetyNine", 292290)
	self:Death("OmegaBusterDeath", 144249)

	-- H.A.R.D.M.O.D.E.
	self:Log("SPELL_CAST_SUCCESS", "HARDMODE", 292750)
	self:Log("SPELL_CAST_SUCCESS", "ClickButton", 292785)
end

do
	local function hardModeCheck()
		if mod:GetBossId(151168) then -- Annihilo-tron 5000, only active on hard mode
			mod:Bar("hardmode", 32.1, L.hardmode, L.hardmode_icon) -- H.A.R.D.M.O.D.E.
		end
	end

	function mod:OnEngage()
		self:SetStage(1)
		megaZapCount = 1
		recalibrateTimer = nil
		self:CDBar(291865, 4.5) -- Recalibrate
		if isElevenDotOne then
			self:CDBar(291928, 9.5) -- Mega-Zap
			self:CDBar(291613, 35.0) -- Take Off
		else -- XXX remove in 11.1
			self:CDBar(291928, 8.2) -- Giga-Zap
			self:CDBar(291613, 30.0) -- Take Off
		end
		if self:Mythic() and not self:MythicPlus() then
			clickCount = 0
			self:SimpleTimer(hardModeCheck, 0.1)
		end
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Stage One: Aerial Unit R-21/X

function mod:RecalibrateStage1(args)
	-- this boss cast triggers Recalibrate from the Plasma Orbs, it only logs in stage 1
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 12.1)
	self:PlaySound(args.spellId, "alarm")
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(291928, "red", name)
		if self:Me(guid) then
			self:Say(291928, nil, nil, "Mega-Zap")
		end
		self:PlaySound(291928, "alert", nil, name)
	end

	function mod:MegaZapStage1(args)
		self:GetUnitTarget(printTarget, 0.3, args.sourceGUID)
		megaZapCount = megaZapCount + 1
		self:CDBar(args.spellId, 15.7)
	end
end

function mod:TakeOff(args)
	self:Message(args.spellId, "orange")
	self:CDBar(291928, {12.0, 15.7}) -- Mega-Zap (Stage 1)
	self:CDBar(291865, 17.0) -- Recalibrate
	self:CDBar(args.spellId, 34.0)
	self:PlaySound(args.spellId, "info")
end

function mod:CuttingBeam(args) -- XXX remove in 11.1
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:CuttingBeamApplied(args)
	self:TargetMessage(291626, "red", args.destName)
	if self:Me(args.destGUID) then
		self:Say(291626, nil, nil, "Cutting Beam")
	end
	if self:Me(args.destGUID) then
		self:PlaySound(291626, "warning", nil, args.destName)
	else
		self:PlaySound(291626, "alarm", nil, args.destName)
	end
end

function mod:AerialUnitR21XDeath(args)
	megaZapCount = 1 -- Mega-Zap sequence is different in Stage 2
	self:StopBar(291865) -- Recalibrate
	self:StopBar(291928) -- Mega-Zap (Stage 1)
	self:StopBar(291613) -- Take Off
	self:SetStage(2)
	self:Message("stages", "cyan", CL.stage:format(2), false)
	self:PlaySound("stages", "long")
end

-- Stage Two: Omega Buster

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 296323 then -- Activate Omega Buster
		if isElevenDotOne then
			self:CDBar(291865, 7.0) -- Recalibrate
			recalibrateTimer = self:ScheduleTimer("RecalibrateStage2", 7.0)
			self:CDBar(292264, 19.2) -- Mega-Zap (Stage 2)
			self:CDBar(283551, 30.8) -- Magneto Arm
		else -- XXX remove in 11.1
			self:CDBar(291865, 7.0) -- Recalibrate
			recalibrateTimer = self:ScheduleTimer("RecalibrateStage2", 7.0)
			self:CDBar(292264, 14.8) -- Mega-Zap (Stage 2)
			self:CDBar(283551, 36.9) -- Magneto Arm
		end
	end
end

function mod:MagnetoArm(args)
	if self:GetStage() ~= 2 then
		self:SetStage(2)
	end
	self:Message(args.spellId, "yellow")
	self:CDBar(292264, {14.8, 30.3}) -- Mega-Zap (Stage 2)
	self:CDBar(args.spellId, 61.8)
	self:PlaySound(args.spellId, "long")
end

function mod:RecalibrateStage2() -- only called from :ScheduleTimer
	self:Message(291865, "orange")
	self:CDBar(291865, 8.0)
	self:PlaySound(291865, "alarm")
end

do
	local prev = 0

	function mod:Recalibrate(args)
		-- throttle because each of the 4 Plasma Orbs cast this simultaneously
		if self:GetStage() == 2 and args.time - prev > 2 then
			prev = args.time
			mod:CDBar(291865, {5.5, 8.0})
			recalibrateTimer = self:ScheduleTimer("RecalibrateStage2", 5.5)
		end
	end

	function mod:MagnetoArmSuccess(args)
		if recalibrateTimer then
			self:CancelTimer(recalibrateTimer)
		end
		self:CastBar(283551, 9) -- Magneto Arm
		-- Every 8 sec, Recalibrate is attempted.
		-- It does not cast between the start of the magnet's channel and the magnet despawning.
		-- The magnet despawns after 10 sec and the cast time of Recalibrate is 2.5sec
		-- The next Recalibrate will be in more than 10 seconds.
		-- Find the lowest multiple of 8 (Recalibrate timer) that is still greater than 10 after the following have been subtracted:
		-- - 2.5 sec (for the cast time)
		-- - The already elapsed time
		local elapsed = args.time - prev
		local multiple = math.ceil((12.5 + elapsed) / 8) * 8
		local nextCast = multiple - 2.5 - elapsed
		self:CDBar(291865, nextCast) -- Recalibrate
		recalibrateTimer = self:ScheduleTimer("RecalibrateStage2", nextCast)
	end
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(292264, "red", name, CL.count_amount:format(self:SpellName(292264), (megaZapCount - 2) % 3 + 1, 3))
		if self:Me(guid) then
			self:Say(292264, nil, nil, "Mega-Zap")
		end
		self:PlaySound(292264, "alert", nil, name)
	end

	function mod:MegaZapStage2(args)
		if self:GetStage() ~= 2 then
			self:SetStage(2)
		end
		if megaZapCount % 3 == 1 then -- timer for the 1st cast in the 3-cast sequence
			self:CDBar(args.spellId, 30.3)
		end
		megaZapCount = megaZapCount + 1
		self:GetUnitTarget(printTarget, 0.3, args.sourceGUID)
	end
end

function mod:ProtocolNinetyNine(args)
	-- only cast if no one in melee range
	self:Message(args.spellId, "purple")
	if self:Tank() then
		self:PlaySound(args.spellId, "warning")
	end
end

function mod:OmegaBusterDeath(args)
	self:StopBar(292264) -- Mega-Zap (Stage 2)
	self:StopBar(283534) -- Magneto Arm
	self:StopBar(291865) -- Recalibrate
	self:SetStage(3)
	self:Message("stages", "cyan", CL.stage:format(3), false)
	if recalibrateTimer then
		self:CancelTimer(recalibrateTimer)
	end
end

-- H.A.R.D.M.O.D.E.

function mod:HARDMODE(args)
	clickCount = 0
	self:Message("hardmode", "yellow", L.hardmode, L.hardmode_icon)
	self:Bar("hardmode", 43.7, L.hardmode, L.hardmode_icon)
	self:PlaySound("hardmode", "long")
end

function mod:ClickButton(args)
	clickCount = clickCount + 1
	self:TargetMessage("button", "cyan", args.sourceName, CL.count:format(L.button, clickCount), L.button_icon)
	self:PlaySound("button", "warning")
end
