--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Voidstone Monstrosity", 2648, 2568)
if not mod then return end
mod:RegisterEnableMob(207207) -- Voidstone Monstrosity
mod:SetEncounterID(2836)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local voidShellCount = 1
local nextUnleashCorruption = 0
local nextOblivionWave = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Voidstone Monstrosity
		423305, -- Null Upheaval
		445262, -- Void Shell
		{429493, "SAY"}, -- Unleash Corruption
		433067, -- Seeping Corruption (Mythic)
		445457, -- Oblivion Wave
		423393, -- Entropy
		-- Stormrider Vokmar
		{458082, "SAY", "SAY_COUNTDOWN"}, -- Stormrider's Charge
		424371, -- Storm's Vengeance
	}, {
		[458082] = -27791, -- Stormrider Vokmar
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "NullUpheaval", 423305)
	self:Log("SPELL_CAST_SUCCESS", "VoidShell", 445262)
	self:Log("SPELL_AURA_REMOVED", "VoidShellRemoved", 445262)
	self:Log("SPELL_CAST_START", "UnleashCorruption", 429487)
	self:Log("SPELL_AURA_APPLIED", "UnleashCorruptionApplied", 429493)
	self:Log("SPELL_PERIODIC_DAMAGE", "SeepingCorruptionDamage", 433067)
	self:Log("SPELL_PERIODIC_MISSED", "SeepingCorruptionDamage", 433067)
	self:Log("SPELL_CAST_START", "OblivionWave", 445457)
	self:Log("SPELL_CAST_SUCCESS", "Entropy", 423393)

	-- Stormrider Vokmar
	self:Log("SPELL_CAST_SUCCESS", "StormridersCharge", 458082)
	self:Log("SPELL_AURA_APPLIED", "StormridersChargeApplied", 458082)
	self:Log("SPELL_CAST_SUCCESS", "StormsVengeance", 423839)
end

function mod:OnEngage()
	local t = GetTime()
	voidShellCount = 1
	-- Void Shell is cast immediately on pull
	nextOblivionWave = t + 5.8
	self:CDBar(445457, 5.8) -- Oblivion Wave
	nextUnleashCorruption = t + 10.6
	self:CDBar(429493, 10.6) -- Unleash Corruption
	self:CDBar(423305, 16.7) -- Null Upheaval
	self:CDBar(458082, 19.7) -- Stormrider's Charge
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:NullUpheaval(args)
	self:Message(args.spellId, "orange")
	-- cast at 100 energy: 30s energy gain, 3s cast - .2s because the first tick of energy can occur early
	self:CDBar(args.spellId, 32.8)
	self:CDBar(458082, {3.0, 32.8}) -- Stormrider's Charge
	self:PlaySound(args.spellId, "alarm")
end

function mod:VoidShell(args)
	self:Message(args.spellId, "cyan", CL.count:format(args.spellName, voidShellCount))
	voidShellCount = voidShellCount + 1
	self:PlaySound(args.spellId, "long")
end

function mod:VoidShellRemoved(args)
	-- energy gain pauses here, ~5.2s before Storm's Vengeance
	self:Message(args.spellId, "green", CL.removed:format(args.spellName))
end

do
	local playerList = {}

	function mod:UnleashCorruption(args)
		nextUnleashCorruption = GetTime() + 17.0
		playerList = {}
		self:CDBar(429493, 17.0)
	end

	function mod:UnleashCorruptionApplied(args)
		playerList[#playerList + 1] = args.destName
		self:TargetsMessage(args.spellId, "red", playerList, 2)
		if self:Me(args.destGUID) then
			self:Say(args.spellId, nil, nil, "Unleash Corruption")
		end
		self:PlaySound(args.spellId, "alert", nil, playerList)
	end
end

do
	local prev = 0
	function mod:SeepingCorruptionDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 1.5 then
			prev = args.time
			self:PersonalMessage(args.spellId, "underyou")
			self:PlaySound(args.spellId, "underyou")
		end
	end
end

function mod:OblivionWave(args)
	nextOblivionWave = GetTime() + 13.3
	self:Message(args.spellId, "purple")
	self:CDBar(args.spellId, 13.3)
	self:PlaySound(args.spellId, "alarm")
end

function mod:Entropy(args)
	-- only cast when no one is in melee range
	self:Message(args.spellId, "purple")
	if self:Tank() then
		self:PlaySound(args.spellId, "warning")
	end
end

-- Stormrider Vokmar

do
	local playerList = {}

	function mod:StormridersCharge(args)
		playerList = {}
		-- this happens 3s after Null Upheaval
		self:CDBar(args.spellId, 32.8)
	end

	function mod:StormridersChargeApplied(args)
		playerList[#playerList + 1] = args.destName
		self:TargetsMessage(args.spellId, "green", playerList, 4)
		if self:Me(args.destGUID) then
			self:Say(args.spellId, nil, nil, "Stormrider's Charge")
			self:SayCountdown(args.spellId, 12)
		end
		self:PlaySound(args.spellId, "info", nil, playerList)
	end
end

function mod:StormsVengeance(args)
	local t = GetTime()
	self:Message(424371, "green", CL.count:format(args.spellName, voidShellCount - 1))
	self:Bar(424371, 20, CL.onboss:format(args.spellName))
	-- Storm's Vengeance being applied to the boss pauses all timers for 20s. there's an additional 0.3s minimum
	-- delay after Storm's Vengeance ends before another ability will be cast.
	local bossUnit = self:GetBossId(207207) -- Voidstone Monstrosity
	local bossPower = UnitPower(bossUnit)
	local bossPowerMax = UnitPowerMax(bossUnit)
	if bossPower < bossPowerMax then
		local nullUpheavalTimeLeft = 30 * (1 - bossPower / bossPowerMax) + 20.0
		-- energy gain is paused for 20s from when Storm's Vengeance is applied (~25.5s from Void Shell removed)
		self:CDBar(423305, {nullUpheavalTimeLeft, 52.8}) -- Null Upheaval
		self:CDBar(458082, {nullUpheavalTimeLeft + 3, 55.8}) -- Stormrider's Charge
	else -- boss at full power
		-- if Null Upheaval was interrupted by Storm's Vengeance, then Null Upheaval will be cast immediately
		-- after Storm's Vengeance ends
		self:CDBar(423305, {20.3, 52.8}) -- Null Upheaval
		self:CDBar(458082, {23.3, 55.8}) -- Stormrider's Charge
	end
	local unleashCorruptionTimeLeft = nextUnleashCorruption - t
	if unleashCorruptionTimeLeft > 0.3 then
		nextUnleashCorruption = nextUnleashCorruption + 20
		self:CDBar(429493, {unleashCorruptionTimeLeft + 20, 37.0}) -- Unleash Corruption
	else
		nextUnleashCorruption = t + 20.3
		self:CDBar(429493, {20.3, 37.0}) -- Unleash Corruption
	end
	local oblivionWaveTimeLeft = nextOblivionWave - t
	if oblivionWaveTimeLeft > 0.3 then
		nextOblivionWave = nextOblivionWave + 20
		self:CDBar(445457, {oblivionWaveTimeLeft + 20, 33.3}) -- Oblivion Wave
	else
		nextOblivionWave = t + 20.3
		self:CDBar(445457, {20.3, 33.3}) -- Oblivion Wave
	end
	self:PlaySound(424371, "info")
end
