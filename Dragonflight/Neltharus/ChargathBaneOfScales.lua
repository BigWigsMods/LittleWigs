--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Chargath, Bane of Scales", 2519, 2490)
if not mod then return end
mod:RegisterEnableMob(189340) -- Chargath, Bane of Scales
mod:SetEncounterID(2613)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local recalculateFieryFocus = false
local bossStunned = false
local magmaWaveRemaining = 2
local fieryFocusCount = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.slow = "Slow"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		373424, -- Grounding Spear
		388523, -- Fetter
		{375056, "CASTBAR"}, -- Fiery Focus
		373733, -- Dragon Strike
		373742, -- Magma Wave
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_POWER_UPDATE", nil, "boss1")
	self:Log("SPELL_CAST_START", "GroundingSpear", 373424)
	-- 2 different Fetter debuffs: 388523=12s stun, 374655=12s slow in mythic, 2s stun otherwise
	self:Log("SPELL_AURA_APPLIED", "FetterApplied", 388523, 374655)
	self:Log("SPELL_AURA_APPLIED_DOSE", "FetterApplied", 374655)
	self:Log("SPELL_AURA_REMOVED", "FetterRemoved", 388523, 374655)
	self:Log("SPELL_CAST_START", "FieryFocus", 375056)
	self:Log("SPELL_AURA_APPLIED", "FieryFocusStart", 375055)
	self:Log("SPELL_AURA_REMOVED", "FieryFocusOver", 375055)
	self:Log("SPELL_CAST_START", "DragonStrike", 373733)
	self:Log("SPELL_CAST_START", "MagmaWave", 373742)
end

function mod:OnEngage()
	-- ability pattern: MW, DS, MW, GS, FF (repeat)
	fieryFocusCount = 1
	magmaWaveRemaining = 2
	bossStunned = false
	self:CDBar(373742, 5.0) -- Magma Wave
	self:CDBar(373733, 12.0) -- Dragon Strike
	self:CDBar(373424, 24.2) -- Grounding Spear
	-- 31s energy gain, plus delay
	self:CDBar(375056, 31.1, CL.count:format(self:SpellName(375056), fieryFocusCount)) -- Fiery Focus
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_POWER_UPDATE(_, unit)
	if recalculateFieryFocus then
		recalculateFieryFocus = false
		-- ~31 seconds between Fiery Focus casts, cast at max Energy
		local nextFieryFocus = ceil(30.4 * (1 - UnitPower(unit) / 100))
		if nextFieryFocus > 0 then
			self:Bar(375056, {nextFieryFocus + .2, 30.6}, CL.count:format(self:SpellName(375056), fieryFocusCount)) -- Fiery Focus, ~.2s delay at max energy
		else
			recalculateFieryFocus = true
		end
	end
end

function mod:GroundingSpear(args)
	self:StopBar(args.spellId)
	-- targets all players in Mythic, but just one player in Normal/Heroic
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

-- Normal/Heroic: 1 stack of Fetter always stuns (2s or 12s)
-- Mythic: 1 or 2 hits of Fetter just slows, 3 hits stuns (12s)
do
	local prev = 0
	function mod:FetterApplied(args)
		if self:Mythic() then
			if args.spellId == 388523 then -- Long Fetter on boss (12s stun)
				self:StopBar(CL.stack:format(2, L.slow, CL.boss))
				self:StopBar(CL.cast:format(self:SpellName(375056))) -- Fiery Focus
				bossStunned = true
				self:Message(388523, "green", CL.onboss:format(args.spellName))
				self:PlaySound(388523, "info")
				self:Bar(388523, 12, CL.onboss:format(args.spellName))
			else -- 374655, Short Fetter on boss (12s slow)
				-- this is for 1 or 2 stacks
				local stacks = args.amount or 1
				if stacks < 3 then -- 3rd stack briefly applies before long stun, ignore it
					self:Message(388523, "green", CL.stack:format(stacks, L.slow, CL.boss))
					self:PlaySound(388523, "info")
					if stacks == 2 then
						self:StopBar(CL.stack:format(1, L.slow, CL.boss))
					end
					self:Bar(388523, 12, CL.stack:format(stacks, L.slow, CL.boss))
				end
			end
		else
			self:StopBar(CL.cast:format(self:SpellName(375056))) -- Fiery Focus
			local t = args.time
			if t - prev > 1 then
				prev = t
				self:Message(388523, "green", CL.onboss:format(args.spellName))
				self:PlaySound(388523, "info")
			end
			if args.spellId == 388523 then -- Long Fetter on boss (12s stun)
				bossStunned = true
				self:Bar(388523, 12, CL.onboss:format(args.spellName))
			else -- 374655, Short Fetter on boss (2s stun)
				bossStunned = true
				recalculateFieryFocus = true
				self:PauseBar(375056, CL.count:format(self:SpellName(375056), fieryFocusCount)) -- Fiery Focus, Chargath doesn't gain energy during the stun
			end
		end
	end
end

function mod:FetterRemoved(args)
	if args.spellId == 388523 then -- Long Fetter
		bossStunned = false
		recalculateFieryFocus = true
		magmaWaveRemaining = 2
		self:CDBar(373742, 8.3) -- Magma Wave
		self:CDBar(373733, 14.4) -- Dragon Strike
		self:CDBar(373424, 26.6) -- Grounding Spear
		-- 30s energy gain, .1s delay
		self:CDBar(375056, 30.1, CL.count:format(self:SpellName(375056), fieryFocusCount)) -- Fiery Focus
	elseif not self:Mythic() then
		bossStunned = false
		recalculateFieryFocus = true
	end
end

function mod:FieryFocus(args)
	recalculateFieryFocus = false
	self:StopBar(373742) -- Magma Wave
	self:StopBar(373733) -- Dragon Strike
	self:StopBar(373424) -- Grounding Spear
	self:StopBar(CL.count:format(args.spellName, fieryFocusCount))
	self:CastBar(args.spellId, 3.5)
	self:Message(args.spellId, "red", CL.count:format(args.spellName, fieryFocusCount))
	self:PlaySound(args.spellId, "long")
	fieryFocusCount = fieryFocusCount + 1
end

function mod:FieryFocusStart(args)
	self:CastBar(375056, 25) -- Fiery Focus
end

function mod:FieryFocusOver(args)
	self:StopBar(CL.cast:format(args.spellName))
	-- these are the timers used if Fiery Focus is not interrupted and completes its channel,
	-- only do anything here if the boss was not interrupted by Fetter
	if not bossStunned then
		recalculateFieryFocus = true
		magmaWaveRemaining = 2
		self:Message(375056, "green", CL.over:format(args.spellName))
		self:PlaySound(375056, "info")
		self:CDBar(373742, 6.5) -- Magma Wave
		self:CDBar(373733, 12.5) -- Dragon Strike
		self:CDBar(373424, 24.7) -- Grounding Spear
		-- 30s energy gain, .1s delay
		self:CDBar(375056, 30.1, CL.count:format(args.spellName, fieryFocusCount)) -- Fiery Focus
	end
end

function mod:DragonStrike(args)
	-- boss targets players too slowly to use GetUnitTarget
	self:StopBar(args.spellId)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

function mod:MagmaWave(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	magmaWaveRemaining = magmaWaveRemaining - 1
	if magmaWaveRemaining > 0 then
		self:CDBar(args.spellId, 12.1)
		-- minimum of 6.06s until Dragon Strike
		local dragonStrikeTimeLeft = self:BarTimeLeft(373733)
		if dragonStrikeTimeLeft > 0 and dragonStrikeTimeLeft < 6.06 then
			self:CDBar(373733, {6.06, 12.5}) -- Dragon Strike
		end
	else
		self:StopBar(args.spellId)
	end
end
