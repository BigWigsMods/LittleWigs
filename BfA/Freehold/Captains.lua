--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Council o' Captains", 1754, 2093)
if not mod then return end
mod:RegisterEnableMob(
	126848, -- Captain Eudora
	126847, -- Captain Raoul
	126845  -- Captain Jolly
)
mod:SetEncounterID(2094)
mod:SetRespawnTime(17.5)

--------------------------------------------------------------------------------
-- Locals
--

local engageTime = 0
local initialTimersStarted = false

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.crit_brew = "Crit Brew"
	L.haste_brew = "Haste Brew"
	L.bad_brew = "Bad Brew"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Captain Eudora
		256979, -- Powder Shot
		258381, -- Grapeshot
		272902, -- Chain Shot
		-- Captain Raoul
		{258338, "SAY", "DISPEL"}, -- Blackout Barrel
		256589, -- Barrel Smash
		-- Captain Jolly
		267522, -- Cutting Surge
		267533, -- Whirlpool of Blades
		-- Rummy Mancomb
		265088, -- Confidence-Boosting Brew (Crit)
		264608, -- Invigorating Brew (Haste)
		265168, -- Caustic Brew
	}, {
		[256979] = -17024, -- Captain Eudora
		[258338] = -17023, -- Captain Raoul
		[267522] = -17025, -- Captain Jolly
		[265088] = -18476, -- Rummy Mancomb
	}
end

function mod:OnBossEnable()
	-- Captain Eudora
	self:Log("SPELL_CAST_START", "PowderShot", 256979)
	self:Log("SPELL_CAST_SUCCESS", "Grapeshot", 258381)
	self:Log("SPELL_CAST_START", "ChainShot", 272902)
	self:Log("SPELL_AURA_APPLIED", "ChainShotApplied", 272905)
	self:Death("CaptainEudoraDeath", 126848)

	-- Captain Raoul
	self:Log("SPELL_CAST_START", "BlackoutBarrel", 258338)
	self:Log("SPELL_AURA_APPLIED", "BlackoutBarrelApplied", 258875)
	self:Log("SPELL_CAST_START", "BarrelSmash", 256589)
	self:Death("CaptainRaoulDeath", 126847)

	-- Captain Jolly
	self:Log("SPELL_CAST_START", "CuttingSurge", 267522)
	self:Log("SPELL_CAST_START", "WhirlpoolOfBlades", 267533)
	self:Death("CaptainJollyDeath", 126845)

	-- Rummy Mancomb
	self:Log("SPELL_CAST_SUCCESS", "CritBrew", 265088)
	self:Log("SPELL_AURA_APPLIED", "CritBrewApplied", 265085)
	self:Log("SPELL_CAST_SUCCESS", "HasteBrew", 264608)
	self:Log("SPELL_AURA_APPLIED", "HasteBrewApplied", 265056)
	self:Log("SPELL_CAST_SUCCESS", "CausticBrew", 265168)
	self:Log("SPELL_AURA_APPLIED", "CausticBrewApplied", 278467)
end

function mod:OnEngage()
	engageTime = GetTime()
	initialTimersStarted = false
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
end

do
	local function startTimers(elapsed)
		if UnitCanAttack("player", mod:GetBossId(126847)) then -- Captain Raoul
			mod:Bar(256589, 6.1 - elapsed) -- Barrel Smash
			mod:Bar(258338, 18.0 - elapsed) -- Blackout Barrel
		end
		if UnitCanAttack("player", mod:GetBossId(126848)) then -- Captain Eudora
			mod:Bar(258381, 8.3 - elapsed) -- Grapeshot
		else
			mod:Bar(272902, 4.7 - elapsed) -- Chain Shot
		end
		if UnitCanAttack("player", mod:GetBossId(126845)) then -- Captain Jolly
			mod:Bar(267533, 13 - elapsed) -- Whirlpool of Blades
			mod:Bar(267522, 5.7 - elapsed) -- Cutting Surge
		end
	end

	function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
		if not initialTimersStarted and UnitExists("boss3") then -- All bosses active
			startTimers(engageTime - GetTime())
			initialTimersStarted = true
		end
	end
end

function mod:VerifyEnable(unit)
	return UnitCanAttack("player", unit) -- one of the captains should be friendly
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Captain Eudora

do
	local function printTarget(self, name, guid)
		if not self:Tank() and (self:Me(guid) or self:Healer()) then
			self:TargetMessage(256979, "red", name) -- Powder Shot
			self:PlaySound(256979, "alert", nil, name) -- Powder Shot
		end
	end

	function mod:PowderShot(args)
		self:GetUnitTarget(printTarget, 1, args.sourceGUID)
		--self:CDBar(args.spellId, 4.0)
	end
end

function mod:Grapeshot(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning", "watchstep")
	self:Bar(args.spellId, 30.4)
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(272902, "green", name)
		self:PlaySound(272902, "info")
	end

	function mod:ChainShot(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
		self:Bar(args.spellId, 15.8)
	end
end

function mod:ChainShotApplied(args)
	self:TargetBar(272902, 6, args.destName)
end

function mod:CaptainEudoraDeath(args)
	self:StopBar(258381) -- Grapeshot
end

-- Captain Raoul

do
	local function printTarget(self, name, guid)
		self:TargetMessage(258338, "yellow", name, CL.casting:format(self:SpellName(258338)))
		if self:Me(guid) then
			self:Say(258338, nil, nil, "Blackout Barrel")
			self:PlaySound(258338, "alert")
		else
			self:PlaySound(258338, "alert", "killadd", name)
		end
	end

	function mod:BlackoutBarrel(args)
		self:GetUnitTarget(printTarget, 0.3, args.sourceGUID)
		self:CDBar(args.spellId, 46.1)
	end
end

function mod:BlackoutBarrelApplied(args)
	if self:Dispeller("movement", nil, 258338) then
		-- can be dispelled by movement dispellers, so alert on application
		self:TargetMessage(258338, "cyan", args.destName)
		self:PlaySound(258338, "info", nil, args.destName)
	end
end

function mod:BarrelSmash(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "long", "watchaoe")
	self:Bar(args.spellId, 23.1)
end

function mod:CaptainRaoulDeath(args)
	self:StopBar(258338) -- Blackout Barrel
	self:StopBar(256589) -- Barrel Smash
end

-- Captain Jolly

function mod:CuttingSurge(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 23)
end

function mod:WhirlpoolOfBlades(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 20)
end

function mod:CaptainJollyDeath(args)
	self:StopBar(267522) -- Cutting Surge
	self:StopBar(267533) -- Whirlpool of Blades
end

-- Rummy Mancomb

function mod:CausticBrew(args)
	self:Message(args.spellId, "red", L.bad_brew)
	self:PlaySound(args.spellId, "alarm")
end

do
	local prev = 0
	function mod:CausticBrewApplied(args)
		local t = args.time
		if self:Me(args.destGUID) then
			self:PersonalMessage(265168, "underyou", L.bad_brew)
			self:PlaySound(265168, "underyou")
		elseif self:Tank() and t - prev > 2 then -- Announce DoT on boss to tanks
			local bossId = self:GetBossId(args.destGUID)
			if bossId and UnitCanAttack("player", bossId) then
				prev = t
				self:Message(265168, "green", CL.onboss:format(L.bad_brew))
				self:PlaySound(265168, "info")
			end
		end
	end
end

function mod:CritBrew(args)
	self:Message(args.spellId, "green", L.crit_brew)
	self:PlaySound(args.spellId, "info")
end

do
	local prev = 0
	function mod:CritBrewApplied(args)
		local t = args.time
		if self:Me(args.destGUID) then
			self:PersonalMessage(265088, nil, L.crit_brew)
			self:PlaySound(265088, "info")
		elseif self:Tank() and t - prev > 2 then -- Announce boss crit buff to tanks
			local bossId = self:GetBossId(args.destGUID)
			if bossId and UnitCanAttack("player", bossId) then
				prev = t
				self:Message(265088, "purple", CL.onboss:format(L.crit_brew))
				self:PlaySound(265088, "alarm")
			end
		end
	end
end

function mod:HasteBrew(args)
	self:Message(args.spellId, "green", L.haste_brew)
	self:PlaySound(args.spellId, "info")
end

do
	local prev = 0
	function mod:HasteBrewApplied(args)
		local t = args.time
		if self:Me(args.destGUID) then
			self:PersonalMessage(264608, nil, L.haste_brew)
			self:PlaySound(264608, "info")
		elseif self:Tank() and t - prev > 2 then -- Announce boss haste buff to tanks
			local bossId = self:GetBossId(args.destGUID)
			if bossId and UnitCanAttack("player", bossId) then
				prev = t
				self:Message(264608, "purple", CL.onboss:format(L.haste_brew))
				self:PlaySound(264608, "alarm")
			end
		end
	end
end
