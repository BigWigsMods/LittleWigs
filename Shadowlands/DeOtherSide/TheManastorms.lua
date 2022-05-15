
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Manastorms", 2291, 2409)
if not mod then return end
mod:RegisterEnableMob(164556, 164555) -- Millhouse Manastorm, Millificent Manastorm
mod.engageId = 2394
--mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Locals
--

local shadowfuryCount = 0
local millhouseDefeated = false
local millificentDefeated = false

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		320787, -- Summon Power Crystal
		{323877, "SAY"}, -- Echo Finger Laser X-treme
		320141, -- Diabolical Dooooooom!
		320823, -- Experimental Squirrel Bomb
		{320132, "SAY", "SAY_COUNTDOWN"}, -- Shadowfury
		321061, -- Aerial Rocket Chicken Barrage
	}, {
		[320787] = CL.stage:format(1),
		[320823] = CL.stage:format(2),
	}
end

function mod:OnBossEnable()
	-- Stage 1
	self:Log("SPELL_CAST_SUCCESS", "SummonPowerCrystal", 320787)
	self:Log("SPELL_AURA_APPLIED", "EchoFingerLaserXtreme", 323877)
	self:Log("SPELL_CAST_START", "DiabolicalDooooooom", 320141)
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "MillificentCastSucceeded", "boss2")
	self:RegisterUnitEvent("UNIT_TARGETABLE_CHANGED", "MillhouseDefeated", "boss1")

	-- Stage 2
	self:Log("SPELL_CAST_SUCCESS", "ExperimentalSquirrelBomb", 320823)
	self:Log("SPELL_CAST_START", "Shadowfury", 320132)
	self:Log("SPELL_CAST_START", "AerialRocketChickenBarrage", 321061)
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "MillhouseCastSucceeded", "boss1")
	self:RegisterUnitEvent("UNIT_TARGETABLE_CHANGED", "MillificentDefeated", "boss2")
end

function mod:OnEngage()
	millhouseDefeated = false
	millificentDefeated = false
	shadowfuryCount = 0
	self:CDBar(320787, 9) -- Summon Power Crystal
	if self:Mythic() then
		self:CDBar(323877, 17) -- Echo Finger Laser X-treme
		self:Bar(320141, 45.6) -- Diabolical Dooooooom!
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Stage 1

function mod:SummonPowerCrystal(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 9) -- pull:9.0, 8.0, 16.0
end

do
	local playerList = mod:NewTargetList()
	function mod:EchoFingerLaserXtreme(args)
		local laser = self:SpellName(143444)
		playerList[#playerList+1] = args.destName
		self:Bar(args.spellId, 15)
		self:TargetsMessage(args.spellId, "red", playerList, 2, laser)
		if self:Me(args.destGUID) then
			self:PlaySound(args.spellId, "warning")
			self:Say(args.spellId, laser)
			self:TargetBar(args.spellId, 5, args.destName, laser)
		end
	end
end

function mod:DiabolicalDooooooom(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
end

function mod:MillificentCastSucceeded(_, _, _, spellId)
	if spellId == 326804 then -- Rocket Jump (Stage 2 start)
		-- stop stage 1
		self:StopBar(320787) -- Summon Power Crystal
		if self:Mythic() then
			self:StopBar(323877) -- Echo Finger Laser X-treme
			self:StopBar(320141) -- Diabolical Dooooooom!
		end

		-- stage
		self:Message("stages", "cyan", CL.stage:format(2), false)
		self:PlaySound("stages", "long", "stage2")

		-- set up stage 2
		self:Bar(320823, 8.5) -- Experimental Squirrel Bomb
		if self:Mythic() then
			shadowfuryCount = 1
			if not millhouseDefeated then
				self:Bar(320132, 18) -- Shadowfury
			end
			self:Bar(321061, 45.6) -- Aerial Rocket Chicken Barrage
		end
	end
end

function mod:MillhouseDefeated(_, unit)
	if not UnitExists("boss1") then
		millhouseDefeated = true
		if self:Mythic() then
			self:StopBar(320132) -- Shadowfury
		end
	end
end

-- Stage 2

function mod:ExperimentalSquirrelBomb(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "info")
	self:Bar(args.spellId, 8)
end

do
	local function printTarget(self, name, guid)
		local onMe = self:Me(guid)
		self:TargetMessage(320132, "red", name)
		self:PlaySound(320132, onMe and "warning" or "alert", nil, name)
		if onMe then
			self:Say(320132)
			self:SayCountdown(320132, 4.9)
		end
	end
	function mod:Shadowfury(args)
		self:GetUnitTarget(printTarget, 0.1, args.sourceGUID)
		if shadowfuryCount == 1 then
			self:Bar(args.spellId, 15)
		elseif shadowfuryCount == 2 then
			self:Bar(args.spellId, 11)
		end
		shadowfuryCount = shadowfuryCount + 1
	end
end

function mod:AerialRocketChickenBarrage(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
end

function mod:MillhouseCastSucceeded(_, _, _, spellId)
	if spellId == 326920 then -- Teleport (Stage 1 start)
		-- stop stage 2
		self:StopBar(320823) -- Experimental Squirrel Bomb
		if self:Mythic() then
			self:StopBar(320132) -- Shadowfury
			self:StopBar(321061) -- Aerial Rocket Chicken Barrage
		end

		-- stage
		self:Message("stages", "cyan", CL.stage:format(1), false)
		self:PlaySound("stages", "long", "stage1")

		-- set up stage 1
		self:Bar(320787, 10.3) -- Summon Power Crystal
		if self:Mythic() then
			if not millificentDefeated then
				self:Bar(323877, 17) -- Echo Finger Laser X-treme
			end
			self:Bar(320141, 45.6) -- Diabolical Dooooooom!
		end
	end
end

function mod:MillificentDefeated(_, unit)
	if not UnitExists("boss2") then
		millificentDefeated = true
		if self:Mythic() then
			self:StopBar(323877) -- Echo Finger Laser X-treme
		end
	end
end
