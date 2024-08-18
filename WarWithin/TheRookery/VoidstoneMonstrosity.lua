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
local nextOblivionWave = 0
local nextStormridersCharge = 0

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
	self:Log("SPELL_AURA_REMOVED", "ElectrocutedRemoved", 423839)
end

function mod:OnEngage()
	local t = GetTime()
	voidShellCount = 1
	-- Void Shell is cast immediately on pull
	nextOblivionWave = t + 5.2
	self:CDBar(445457, 5.2) -- Oblivion Wave
	if self:Mythic() then
		nextUnleashCorruption = t + 17.4
		self:CDBar(429493, 17.4) -- Unleash Corruption
	end
	nextNullUpheaval = t + 30.1
	self:CDBar(423305, 30.1) -- Null Upheaval
	-- TODO sometimes Stormrider's Charge isn't cast for a long time, maybe if Void Shell is removed before Null Upheaval is cast
	nextStormridersCharge = t + 43.1
	self:CDBar(429493, 43.1) -- Stormrider's Charge
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:NullUpheaval(args)
	nextNullUpheaval = GetTime() + 38.1
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 38.1)
	self:PlaySound(args.spellId, "alarm")
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
		nextUnleashCorruption = GetTime() + 32.8
		playerList = {}
		self:CDBar(429493, 32.8)
	end

	function mod:UnleashCorruptionApplied(args)
		playerList[#playerList + 1] = args.destName
		self:TargetsMessage(args.spellId, "red", playerList, 2)
		self:PlaySound(args.spellId, "alert", nil, playerList)
		if self:Me(args.destGUID) then
			self:Say(args.spellId, nil, nil, "Unleash Corruption")
		end
	end
end

function mod:OblivionWave(args)
	nextOblivionWave = GetTime() + 17.0
	self:Message(args.spellId, "purple")
	self:CDBar(args.spellId, 17.0)
	if self:Tank() then
		self:PlaySound(args.spellId, "alert")
	else
		self:PlaySound(args.spellId, "alarm")
	end
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
		nextStormridersCharge = GetTime() + 38.0
		playerList = {}
		-- TODO this usually happens 13s after Null Upheaval, maybe the timer should be based on that
		self:CDBar(458082, 38.0)
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
	self:Message(args.spellId, "green", CL.count_amount:format(args.spellName, voidShellCount - 1, 3))
	self:PlaySound(args.spellId, "info")
	self:Bar(args.spellId, 10, CL.onboss:format(args.spellName))
	-- Electrocuted being applied to the boss adds 9.7s to all other timers,
	-- but since the stun lasts 10s there is a 10s minimum.
	local nullUpheavalTimeLeft = nextNullUpheaval - t
	if nullUpheavalTimeLeft > 0.3 then
		self:CDBar(423305, {nullUpheavalTimeLeft + 9.7, 47.8}) -- Null Upheaval
	else
		self:CDBar(423305, {10, 38.1}) -- Null Upheaval
	end
	if self:Mythic() then
		local unleashCorruptionTimeLeft = nextUnleashCorruption - t
		if unleashCorruptionTimeLeft > 0.3 then
			self:CDBar(429493, {unleashCorruptionTimeLeft + 9.7, 42.1}) -- Unleash Corruption
		else
			self:CDBar(429493, {10, 32.4}) -- Unleash Corruption
		end
	end
	local oblivionWaveTimeLeft = nextOblivionWave - t
	if oblivionWaveTimeLeft > 0.3 then
		self:CDBar(445457, {oblivionWaveTimeLeft + 9.7, 26.7}) -- Oblivion Wave
	else
		self:CDBar(445457, {10, 17.0}) -- Oblivion Wave
	end
end

function mod:ElectrocutedRemoved()
	-- TODO :Electrocuted() is too early to delay this timer, so what about here?
	-- it's definitely delayed by something, but when?
	-- probably it should be delayed in :Electrocuted if Null Upheaval was cast less recently than Stormrider's Charge
	local stormridersChargeTimeLeft = nextStormridersCharge - GetTime()
	if stormridersChargeTimeLeft > 0.3 then
		self:CDBar(458082, {stormridersChargeTimeLeft + 9.7, 48.2}) -- Stormrider's Charge
	else
		self:CDBar(458082, {10, 38.5}) -- Stormrider's Charge
	end
end
