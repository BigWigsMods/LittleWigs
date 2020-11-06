
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Council o' Captains", 1754, 2093)
if not mod then return end
mod:RegisterEnableMob(126847, 126848, 126845) -- Captain Raoul, Captain Eudora, Captain Jolly
mod.engageId = 2094
mod.respawnTime = 17.5

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
		-- Captain Raoul
		258338, -- Blackout Barrel
		256589, -- Barrel Smash
		-- Captain Eudora
		258381, -- Grape Shot
		256979, -- Powder Shot
		272902, -- Chain Shot
		-- Captain Jolly
		267533, -- Whirlpool of Blades
		267522, -- Cutting Surge
		--[[ Tending Bar ]]--
		265088, -- Confidence-Boosting Brew (Crit)
		264608, -- Invigorating Brew (Haste)
		265168, -- Caustic Brew
	},{
		[258338] = -17023, -- Captain Raoul
		[258381] = -17024, -- Captain Eudora
		[267533] = -17025, -- Captain Jolly
		[265088] = -18476, -- Rummy Mancomb
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "BlackoutBarrel", 258338)
	self:Log("SPELL_CAST_START", "BarrelSmash", 256589)
	self:Log("SPELL_CAST_SUCCESS", "GrapeShot", 258381)
	self:Log("SPELL_CAST_START", "PowderShot", 256979)
	self:Log("SPELL_CAST_START", "ChainShot", 272902)
	self:Log("SPELL_AURA_APPLIED", "ChainShotApplied", 272905)
	self:Log("SPELL_CAST_START", "WhirlpoolofBlades", 267533)
	self:Log("SPELL_CAST_START", "CuttingSurge", 267522)

	self:Log("SPELL_CAST_SUCCESS", "CritBrew", 265088)
	self:Log("SPELL_AURA_APPLIED", "CritBrewApplied", 265085)
	self:Log("SPELL_CAST_SUCCESS", "HasteBrew", 264608)
	self:Log("SPELL_AURA_APPLIED", "HasteBrewApplied", 265056)
	self:Log("SPELL_CAST_SUCCESS", "CausticBrew", 265168)
	self:Log("SPELL_AURA_APPLIED", "CausticBrewApplied", 278467)

	self:Death("Deaths", 126847, 126848, 126845)
end

function mod:OnEngage()
	engageTime = GetTime()
	initialTimersStarted = false
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
end

do
	local function startTimers(elapsed)
		if UnitCanAttack("player", mod:GetBossId(126847)) then -- Captain Raoul
			mod:Bar(256589, 6.9 - elapsed) -- Barrel Smash, 6.9 sec
			mod:Bar(258338, 19 - elapsed) -- Blackout Barrel, 19 sec
		end
		if UnitCanAttack("player", mod:GetBossId(126848)) then -- Captain Eudora
			mod:Bar(258381, 8.5 - elapsed) -- Grape Shot, 8.5 sec
		else
			mod:Bar(272902, 4.7 - elapsed) -- Chain Shot, 4.7 sec
		end
		if UnitCanAttack("player", mod:GetBossId(126845)) then -- Captain Jolly
			mod:Bar(267533, 13 - elapsed) -- Whirlpool of Blades, 13 sec
			mod:Bar(267522, 5.7 - elapsed) -- Cutting Surge, 5.7 sec
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

function mod:Deaths(args)
	if args.mobId == 126847 then -- Captain Raoul
		self:StopBar(258338) -- Blackout Barrel
		self:StopBar(256589) -- Barrel Smash
	elseif args.mobId == 126848 then -- Captain Eudora
		self:StopBar(258381) -- Grape Shot
	elseif args.mobId == 126845 then -- Captain Jolly
		self:StopBar(267533) -- Whirlpool of Blades
		self:StopBar(267522) -- Cutting Surge
	end
end

function mod:BlackoutBarrel(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert", "killadd")
	self:CDBar(args.spellId, 47)
end

function mod:BarrelSmash(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "long", "watchaoe")
	self:CastBar(args.spellId, 7) -- 3s Cast, 4s Channel
	self:CDBar(args.spellId, 23)
end

function mod:GrapeShot(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning", "watchstep")
	self:CDBar(args.spellId, 30.4)
end

do
	local function printTarget(self, name, guid)
		if self:Me(guid) or self:Healer() then
			self:TargetMessage(256979, "red", name) -- Powder Shot
			self:PlaySound(256979, "alert", nil, name) -- Powder Shot
		end
	end

	function mod:PowderShot(args)
		self:GetBossTarget(printTarget, 1, args.sourceGUID)
	end
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(272902, "green", name)
		self:PlaySound(272902, "info")
	end

	function mod:ChainShot(args)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
		self:Bar(args.spellId, 15.8)
	end
end

function mod:ChainShotApplied(args)
	self:TargetBar(272902, 6, args.destName)
end

function mod:WhirlpoolofBlades(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 20)
end

function mod:CuttingSurge(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 23)
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
		elseif self:Tank() and t-prev > 2 then -- Announce boss crit buff to tanks
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
		elseif self:Tank() and t-prev > 2 then -- Announce boss haste buff to tanks
			local bossId = self:GetBossId(args.destGUID)
			if bossId and UnitCanAttack("player", bossId) then
				prev = t
				self:Message(264608, "purple", CL.onboss:format(L.haste_brew))
				self:PlaySound(264608, "alarm")
			end
		end
	end
end

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
			self:PlaySound(265168, "alarm")
		elseif self:Tank() and t-prev > 2 then -- Announce DoT on boss to tanks
			local bossId = self:GetBossId(args.destGUID)
			if bossId and UnitCanAttack("player", bossId) then
				prev = t
				self:Message(265168, "green", CL.onboss:format(L.bad_brew))
				self:PlaySound(265168, "info")
			end
		end
	end
end
