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
local magmaWaveRemaining = 3

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.slow = "Slow"
	L.boss = "BOSS"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		373424, -- Grounding Spear
		388523, -- Fetter
		375056, -- Fiery Focus
		373733, -- Dragon Strike
		373742, -- Magma Wave
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_POWER_UPDATE", nil, "boss1")
	self:Log("SPELL_CAST_START", "GroundingSpear", 373424)
	-- 3 different Fetter debuffs: 388523=long, 374655=short, 374638=player
	self:Log("SPELL_AURA_APPLIED", "FetterApplied", 388523, 374655)
	self:Log("SPELL_AURA_APPLIED_DOSE", "FetterApplied", 374655)
	self:Log("SPELL_AURA_REMOVED", "FetterRemoved", 388523, 374655)
	self:Log("SPELL_CAST_START", "FieryFocus", 375056)
	self:Log("SPELL_AURA_REMOVED", "FieryFocusOver", 375055)
	self:Log("SPELL_CAST_START", "DragonStrike", 373733)
	self:Log("SPELL_CAST_START", "MagmaWave", 373742)
end

function mod:OnEngage()
	-- two ability patterns:
	-- probably intended: MW, DS, MW, GS, FF
	-- or very, very bad: MW, MW, DS, MW, FF (no GS, have fun)
	-- timers can be improved if blizzard fixes the fight so only the intended combo can happen
	magmaWaveRemaining = 3
	bossStunned = false
	self:CDBar(373742, 5.0) -- Magma Wave
	self:CDBar(373733, 12.1) -- Dragon Strike
	self:CDBar(373424, 24.2) -- Grounding Spear
	-- 31s energy gain, plus delay
	self:CDBar(375056, 31.1) -- Fiery Focus
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
			self:Bar(375056, {nextFieryFocus + .2, 30.6}) -- Fiery Focus, ~.2s delay at max energy
		else
			recalculateFieryFocus = true
		end
	end
end

function mod:GroundingSpear(args)
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
				bossStunned = true
				self:Message(388523, "green", CL.onboss:format(args.spellName))
				self:PlaySound(388523, "info")
				self:Bar(388523, 12, CL.onboss:format(args.spellName))
			else -- 374655, Short Fetter on boss (8s slow)
				-- this is for 1 or 2 stacks
				local stacks = args.amount or 1
				if stacks < 3 then -- 3rd stack briefly applies before long stun, ignore it
					self:Message(388523, "green", CL.stack:format(stacks, L.slow, L.boss))
					self:PlaySound(388523, "info")
				end
			end
		else
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
				self:PauseBar(375056) -- Fiery Focus, Chargath doesn't gain energy during the stun
			end
		end
	end
end

function mod:FetterRemoved(args)
	if args.spellId == 388523 then -- Long Fetter
		bossStunned = false
		recalculateFieryFocus = true
		magmaWaveRemaining = 3
		self:CDBar(373742, 9.0) -- Magma Wave
		self:CDBar(373733, 15.1) -- Dragon Strike
		self:CDBar(373424, 27.2) -- Grounding Spear
		-- 31s energy gain, .1s delay
		self:CDBar(375056, 31.1) -- Fiery Focus
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
	self:StopBar(args.spellId)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
end

function mod:FieryFocusOver(args)
	-- these are the timers used if Fiery Focus is not interrupted and completes its channel
	-- only do anything here if the boss was not interrupted by Fetter
	if not bossStunned then
		recalculateFieryFocus = true
		magmaWaveRemaining = 3
		self:Message(375056, "green", CL.over:format(args.spellName))
		self:PlaySound(375056, "info")
		self:CDBar(373742, 6.5) -- Magma Wave
		self:CDBar(373733, 12.5) -- Dragon Strike
		self:CDBar(373424, 24.7) -- Grounding Spear
		-- 31s energy gain, .1s delay
		self:CDBar(375056, 31.1) -- Fiery Focus
	end
end

function mod:DragonStrike(args)
	-- boss targets players too slowly to use GetBossTarget
	self:StopBar(args.spellId)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	-- only ever 1 Magma Wave after the Dragon Strike
	if magmaWaveRemaining == 2 then
		magmaWaveRemaining = 1
		self:CDBar(373742, {6.1, 12.1}) -- Magma Wave
	end
end

function mod:MagmaWave(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	magmaWaveRemaining = magmaWaveRemaining - 1
	if magmaWaveRemaining == 2 then
		-- 8.1s is rare, usually it's ~12.1s
		self:CDBar(args.spellId, 8.1)
	elseif magmaWaveRemaining > 0 then
		-- this is just for the MW MW DS MW pattern
		self:CDBar(args.spellId, 12.1)
		-- fix Dragon Strike timer
		self:CDBar(373733, {6.1, 12.5}) -- Dragon Strike
	else
		self:StopBar(args.spellId)
	end
end
