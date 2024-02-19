--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Lost Dwarves", 2451, 2475)
if not mod then return end
mod:RegisterEnableMob(
	184581, -- Baelog
	184582, -- Eric "The Swift"
	184580  -- Olaf
)
mod:SetEncounterID(2555)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local olafDefeated = false
local baelogDefeated = false
local ericDefeated = false
local heavyArrowRemaining = 2
local wildCleaveRemaining = 3
local skullcrackerRemaining = 3
local ricochetingShieldRemaining = 3
local defensiveBulwarkRemaining = 2

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Baelog
		369573, -- Heavy Arrow
		369563, -- Wild Cleave
		-- Eric "The Swift"
		369791, -- Skullcracker
		-- Olaf
		{369677, "SAY"}, -- Ricocheting Shield
		369602, -- Defensive Bulwark
		-- Longboat Raid!
		375924, -- Longboat Raid!
		{375286, "DISPEL"}, -- Searing Cannonfire
	}, {
		[369573] = -24740, -- Baelog
		[369791] = -24781, -- Eric "The Swift"
		[369677] = -24782, -- Olaf
		[375924] = -24783, -- Longboat Raid!
	}
end

function mod:OnBossEnable()
	-- Baelog
	self:Log("SPELL_CAST_START", "HeavyArrow", 369573)
	self:Log("SPELL_CAST_START", "WildCleave", 369563)

	-- Eric "The Swift"
	self:Log("SPELL_CAST_START", "Skullcracker", 369791)

	-- Olaf
	self:Log("SPELL_CAST_START", "RicochetingShield", 369677)
	self:Log("SPELL_AURA_APPLIED", "DefensiveBulwark", 369602)

	-- Longboat Raid!
	self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1", "boss2", "boss3")
	self:Log("SPELL_CAST_START", "LongboatRaid", 375924)
	self:Log("SPELL_AURA_APPLIED", "SearingCannonfireApplied", 375286)
	self:Log("SPELL_AURA_APPLIED_DOSE", "SearingCannonfireApplied", 375286)
end

function mod:OnEngage()
	olafDefeated = false
	baelogDefeated = false
	ericDefeated = false
	heavyArrowRemaining = 1
	wildCleaveRemaining = 1
	skullcrackerRemaining = 1
	ricochetingShieldRemaining = 1
	defensiveBulwarkRemaining = 1
	self:CDBar(369791, 6.1) -- Skullcracker
	self:CDBar(369563, 8.5) -- Wild Cleave
	self:CDBar(369677, 12.1) -- Ricocheting Shield
	self:CDBar(369602, 17.2) -- Defensive Bulwark
	self:CDBar(369573, 20.6) -- Heavy Arrow
	-- cast at 100 energy, starts at 60/100
	-- 24s energy gain + .8s delay
	self:CDBar(375924, 24.8) -- Longboat Raid
end

function mod:VerifyEnable(unit)
	-- each of the three bosses is defeated and becomes friendly at 10% HP remaining
	return UnitCanAttack("player", unit) or self:GetHealth(unit) > 10
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Baelog

function mod:HeavyArrow(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
	heavyArrowRemaining = heavyArrowRemaining - 1
	if heavyArrowRemaining > 0 then
		self:Bar(args.spellId, 20.6)
	else
		self:StopBar(args.spellId)
	end
end

function mod:WildCleave(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	wildCleaveRemaining = wildCleaveRemaining - 1
	if wildCleaveRemaining > 0 then
		self:CDBar(args.spellId, 17.0)
	else
		self:StopBar(args.spellId)
	end
end

-- Eric "The Swift"

function mod:Skullcracker(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	skullcrackerRemaining = skullcrackerRemaining - 1
	if skullcrackerRemaining > 0 then
		self:CDBar(args.spellId, 26.6)
	else
		self:StopBar(args.spellId)
	end
end

-- Olaf

do
	local function printTarget(self, name, guid)
		self:TargetMessage(369677, "yellow", name)
		self:PlaySound(369677, "alert", nil, name)
		if self:Me(guid) then
			self:Say(369677, nil, nil, "Ricocheting Shield")
		end
	end

	function mod:RicochetingShield(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
		ricochetingShieldRemaining = ricochetingShieldRemaining - 1
		if ricochetingShieldRemaining > 0 then
			self:Bar(args.spellId, 17.0)
		else
			self:StopBar(args.spellId)
		end
	end
end

function mod:DefensiveBulwark(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "warning")
	defensiveBulwarkRemaining = defensiveBulwarkRemaining - 1
	if defensiveBulwarkRemaining > 0 then
		self:Bar(args.spellId, 33.9)
	else
		self:StopBar(args.spellId)
	end
end

-- Longboat Raid!

function mod:UNIT_HEALTH(event, unit)
	-- when a boss hits 10% health it just does Longboat Raid! for the rest of the fight
	if self:GetHealth(unit) <= 10 then
		self:UnregisterUnitEvent(event, unit)
		local mobId = self:MobId(self:UnitGUID(unit))
		if mobId == 184581 then -- Baelog
			baelogDefeated = true
			self:StopBar(369573) -- Heavy Arrow
			self:StopBar(369563) -- Wild Cleave
		elseif mobId == 184582 then -- Eric "The Swift"
			ericDefeated = true
			self:StopBar(369791) -- Skullcracker
		elseif mobId == 184580 then -- Olaf
			olafDefeated = true
			self:StopBar(369677) -- Ricocheting Shield
			self:StopBar(369602) -- Defensive Bulwark
		end
	end
end

do
	local prev = 0
	function mod:LongboatRaid(args)
		if baelogDefeated and ericDefeated and olafDefeated then
			-- ignore this if all 3 bosses are defeated
			return
		end
		local castingBossDefeated = false
		local mobId = self:MobId(args.sourceGUID)
		if mobId == 184581 then -- Baelog
			castingBossDefeated = baelogDefeated
			if not baelogDefeated then
				heavyArrowRemaining = 2
				wildCleaveRemaining = 3
				self:CDBar(369563, 24.9) -- Wild Cleave
				self:Bar(369573, 35.8) -- Heavy Arrow
			end
		elseif mobId == 184582 then -- Eric "The Swift"
			castingBossDefeated = ericDefeated
			if not ericDefeated then
				skullcrackerRemaining = 3
				self:CDBar(369791, 24.9) -- Skullcracker
			end
		elseif mobId == 184580 then -- Olaf
			castingBossDefeated = olafDefeated
			if not olafDefeated then
				ricochetingShieldRemaining = 3
				defensiveBulwarkRemaining = 2
				self:Bar(369677, 29.8) -- Ricocheting Shield
				self:Bar(369602, 34.7) -- Defensive Bulwark
			end
		end
		if castingBossDefeated then
			-- don't restart the Longboat Raid timer if the casting boss has been defeated
			self:Message(args.spellId, "orange", CL.percent:format(10, args.spellName))
			self:PlaySound(args.spellId, "long")
		else
			-- throttle because all 3 bosses cast this, usually around the same time
			local t = args.time
			if t - prev > 6 then
				prev = t
				-- cast at 100 energy: 60s energy gain + 2s cast + 1.8s delay + 15s duration
				self:Message(args.spellId, "orange")
				self:PlaySound(args.spellId, "long")
				self:CDBar(args.spellId, 78.8)
			end
		end
	end
end

function mod:SearingCannonfireApplied(args)
	if self:Me(args.destGUID) then
		self:StackMessage(args.spellId, "blue", args.destName, args.amount, 1)
		self:PlaySound(args.spellId, "underyou")
	elseif self:Dispeller("magic", nil, args.spellId) then
		self:StackMessage(args.spellId, "red", args.destName, args.amount, 1)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end
