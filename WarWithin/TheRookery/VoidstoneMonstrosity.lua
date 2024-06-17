if not BigWigsLoader.isBeta then return end
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
local nextNullUpheaval = 0
local nextUnleashCorruption = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Voidstone Monstrosity
		423305, -- Null Upheaval
		445262, -- Void Shell
		{429493, "SAY"}, -- Unleash Corruption
		445457, -- Oblivion Wave
		423393, -- Entropy
		-- Stormrider Vokmar
		{458082, "SAY", "SAY_COUNTDOWN"}, -- Stormrider's Charge
		{424371, "CASTBAR"}, -- Storm's Vengeance
		423839, -- Electrocuted
	}, {
		[458082] = -27791, -- Stormrider Vokmar
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "NullUpheaval", 423305)
	self:Log("SPELL_CAST_SUCCESS", "VoidShell", 445262)
	self:Log("SPELL_AURA_REMOVED", "VoidShellRemoved", 445262)
	self:Log("SPELL_CAST_SUCCESS", "UnleashCorruption", 429487)
	self:Log("SPELL_AURA_APPLIED", "UnleashCorruptionApplied", 429493)
	self:Log("SPELL_CAST_START", "OblivionWave", 445457)
	self:Log("SPELL_CAST_SUCCESS", "Entropy", 423393)

	-- Stormrider Vokmar
	self:Log("SPELL_CAST_START", "StormridersCharge", 458130)
	self:Log("SPELL_AURA_APPLIED", "StormridersChargeApplied", 458082)
	self:Log("SPELL_CAST_SUCCESS", "Electrocuted", 423839)
end

function mod:OnEngage()
	local t = GetTime()
	voidShellCount = 1
	-- Void Shell is cast immediately on pull
	self:CDBar(445457, 5.0) -- Oblivion Wave
	nextUnleashCorruption = t + 12.7
	self:CDBar(429493, 12.7) -- Unleash Corruption
	nextNullUpheaval = t + 20.5
	self:CDBar(423305, 20.5) -- Null Upheaval
	self:CDBar(429493, 33.5) -- Stormrider's Charge
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:NullUpheaval(args)
	nextNullUpheaval = GetTime() + 43.7
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 43.7)
end

function mod:VoidShell(args)
	self:Message(args.spellId, "cyan", CL.count_amount:format(args.spellName, voidShellCount, 3))
	self:PlaySound(args.spellId, "long")
	voidShellCount = voidShellCount + 1
end

function mod:VoidShellRemoved(args)
	-- Storm's Vengeance is a 2s cast but it finishes 4.5s after Void Shell is removed
	self:CastBar(424371, 4.5) -- Storm's Vengeance
end

do
	local playerList = {}

	function mod:UnleashCorruption(args)
		nextUnleashCorruption = GetTime() + 37.7
		playerList = {}
		self:CDBar(429493, 37.7)
	end

	function mod:UnleashCorruptionApplied(args)
		playerList[#playerList + 1] = args.destName
		self:PlaySound(args.spellId, "alert", nil, playerList)
		self:TargetsMessage(args.spellId, "red", playerList, 2)
		if self:Me(args.destGUID) then
			self:Say(args.spellId, nil, nil, "Unleash Corruption")
		end
	end
end

function mod:OblivionWave(args)
	self:Message(args.spellId, "purple")
	if self:Tank() then
		self:PlaySound(args.spellId, "alert")
	else
		self:PlaySound(args.spellId, "alarm")
	end
	self:CDBar(args.spellId, 17.0)
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

	function mod:StormridersCharge()
		playerList = {}
		self:StopBar(458082)
		-- TODO what triggers the timer for the next Stormrider's Charge?
	end

	function mod:StormridersChargeApplied(args)
		playerList[#playerList + 1] = args.destName
		self:PlaySound(args.spellId, "info", nil, playerList)
		self:TargetsMessage(args.spellId, "green", playerList, 2)
		if self:Me(args.destGUID) then
			self:Say(args.spellId, nil, nil, "Stormrider's Charge")
			self:SayCountdown(args.spellId, 6)
		end
	end
end

function mod:Electrocuted(args)
	local t = GetTime()
	self:Message(args.spellId, "green")
	self:PlaySound(args.spellId, "info")
	self:Bar(args.spellId, 10, CL.onboss:format(args.spellName))
	-- Electrocuted being applied to the boss adds 9.7s to Null Upheaval and Unleash Corruption,
	-- but since the stun lasts 10s there is a 10s minimum.
	local nullUpheavalTimeLeft = nextNullUpheaval - t
	if nullUpheavalTimeLeft > 0.3 then
		self:CDBar(423305, {nullUpheavalTimeLeft + 9.7, 53.4}) -- Null Upheaval
	else
		self:CDBar(423305, {10, 53.4}) -- Null Upheaval
	end
	local unleashCorruptionTimeLeft = nextUnleashCorruption - t
	if unleashCorruptionTimeLeft > 0.3 then
		self:CDBar(429493, {unleashCorruptionTimeLeft + 9.7, 43.4}) -- Unleash Corruption
	else
		self:CDBar(429493, {10, 43.4}) -- Unleash Corruption
	end
	-- Electrocuted being applied to the boss resets the cooldown on Oblivion Wave to 10s,
	-- even if there was more than 10s left on the cooldown.
	self:CDBar(445457, 10) -- Oblivion Wave
end
