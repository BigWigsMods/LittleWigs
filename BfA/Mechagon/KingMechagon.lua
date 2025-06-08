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
local castingMagnetoArm = false

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
	self:Log("SPELL_AURA_APPLIED", "CuttingBeamApplied", 1226680)
	self:Death("AerialUnitR21XDeath", 150396)

	-- Stage Two: Omega Buster
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1", "boss2", "boss3") -- Activate Omega Buster (and Recalibrate)
	self:Log("SPELL_CAST_SUCCESS", "RecalibrateSuccess", 291856)
	self:Log("SPELL_CAST_START", "MagnetoArm", 283551) -- Boss's cast activating the device
	self:Log("SPELL_CAST_SUCCESS", "MagnetoArmSuccess", 283143) -- pull in effect start
	self:Log("SPELL_AURA_REMOVED", "MagnetoArmRemoved", 283143) -- pull in effect end
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
		megaZapCount = 1
		recalibrateTimer = nil
		castingMagnetoArm = false
		self:SetStage(1)
		self:CDBar(291865, 5.8) -- Recalibrate
		self:CDBar(291928, 9.5) -- Mega-Zap
		self:CDBar(291613, 30.0) -- Take Off
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
	self:CDBar(args.spellId, 32.9)
	self:PlaySound(args.spellId, "info")
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
	-- don't :SetStage(2) here because a Recalibrate which started in Stage 1 can finish after this happens
	-- and we don't want to schedule a Stage 2 Recalibrate timer when that happens.
	self:Message("stages", "cyan", CL.stage:format(2), false)
	self:PlaySound("stages", "long")
end

-- Stage Two: Omega Buster

do
	local prev = nil
	function mod:UNIT_SPELLCAST_SUCCEEDED(event, _, castGUID, spellId)
		if spellId == 296323 and castGUID ~= prev then -- Activate Omega Buster
			prev = castGUID
			self:UnregisterUnitEvent(event, "boss1", "boss2", "boss3")
			self:SetStage(2)
			self:CDBar(291865, 6.75) -- Recalibrate
			self:CDBar(292264, 17.7) -- Mega-Zap (Stage 2)
			self:CDBar(283551, 36.9) -- Magneto Arm
			self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED") -- boss frames not guaranteed in time for 302377 which will be cast next
		elseif spellId == 302377 and castGUID ~= prev then -- Recalibrate (first cast only)
			prev = castGUID
			self:UnregisterEvent(event)
			-- the first Recalibrate occurs alongside 302377, after that it's a 8s repeater
			recalibrateTimer = self:ScheduleRepeatingTimer("RecalibrateStage2", 8, self)
			self:Message(291865, "orange") -- Recalibrate
			self:CDBar(291865, 8.0) -- Recalibrate
			self:CDBar(292264, {10.9, 17.7}) -- Mega-Zap (Stage 2)
			self:CDBar(283551, {30.1, 36.9}) -- Magneto Arm
			self:PlaySound(291865, "alarm") -- Recalibrate
		end
	end
end

function mod:MagnetoArm(args)
	if self:GetStage() ~= 2 then -- reload protection
		self:SetStage(2)
	end
	self:Message(args.spellId, "yellow")
	self:CDBar(292264, {14.8, 30.3}) -- Mega-Zap (Stage 2)
	self:CDBar(args.spellId, 61.8)
	self:PlaySound(args.spellId, "long")
end

do
	local prev = 0
	function mod:RecalibrateSuccess(args)
		-- if recalibrateTimer is nil then either we reloaded or the USCS for 302377 was missed.
		-- we can guess when the next Recalibrate will be (though it won't be exact because of variable travel time).
		if not recalibrateTimer and self:GetStage() == 2 and args.time - prev > 4 then
			prev = args.time
			-- 8s timer - 3s cast - ~.2s travel time = approximately 4.8s
			self:ScheduleTimer("RecalibrateStage2", 4.8, self)
		end
	end
end

do
	local prev = 0
	function mod:RecalibrateStage2() -- only called from :ScheduleTimer or :ScheduleRepeatingTimer
		if not recalibrateTimer then
			recalibrateTimer = self:ScheduleRepeatingTimer("RecalibrateStage2", 8, self)
		end
		-- casts during Magneto Arm will be skipped
		if not castingMagnetoArm then
			prev = GetTime()
			self:Message(291865, "orange")
			self:CDBar(291865, 8.0)
			self:PlaySound(291865, "alarm")
		end
	end

	function mod:MagnetoArmSuccess(args)
		castingMagnetoArm = true
		self:CastBar(283551, 9) -- Magneto Arm
		-- Every 8 sec, Recalibrate is attempted.
		-- It does not cast between the start of the magnet's channel and the magnet despawning.
		-- The magnet despawns after 10 sec and the cast time of Recalibrate is 3s
		-- The next Recalibrate will be in more than 10 seconds.
		-- Find the lowest multiple of 8 (Recalibrate timer) that is still greater than 10 after the elapsed time has been subtracted:
		local elapsed = GetTime() - prev
		local multiple = math.ceil((13 + elapsed) / 8) * 8
		self:CDBar(291865, multiple - elapsed) -- Recalibrate
	end
end

function mod:MagnetoArmRemoved()
	-- the cast ends (magnet despawns) 1s after the aura is removed from the boss
	self:SimpleTimer(function() castingMagnetoArm = false end, 1)
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
		if self:GetStage() ~= 2 then -- reload protection
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
	if recalibrateTimer then
		self:CancelTimer(recalibrateTimer)
		recalibrateTimer = nil
	end
	self:StopBar(292264) -- Mega-Zap (Stage 2)
	self:StopBar(283534) -- Magneto Arm
	self:StopBar(291865) -- Recalibrate
	self:SetStage(3)
	self:Message("stages", "cyan", CL.stage:format(3), false)
	self:PlaySound("stages", "long")
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
