--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Echo of Doragosa", 2526, 2514)
if not mod then return end
mod:RegisterEnableMob(190609) -- Echo of Doragosa
mod:SetEncounterID(2565)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local nextAstralBreath = 0
local nextPowerVacuum = 0
local nextEnergyBomb = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		439488, -- Unleash Energy
		389011, -- Overwhelming Power
		388901, -- Arcane Rift
		374361, -- Astral Breath
		388822, -- Power Vacuum
		{374352, "SAY", "SAY_COUNTDOWN"}, -- Energy Bomb
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "UnleashEnergy", 439488)
	self:Log("SPELL_AURA_APPLIED", "OverwhelmingPowerApplied", 389011)
	self:Log("SPELL_AURA_APPLIED_DOSE", "OverwhelmingPowerApplied", 389011)
	self:Log("SPELL_PERIODIC_DAMAGE", "WildEnergyDamage", 389007) -- no alert on APPLIED, doesn't damage right away
	self:Log("SPELL_PERIODIC_MISSED", "WildEnergyDamage", 389007)
	self:Log("SPELL_CAST_START", "AstralBreath", 374361)
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1") -- Power Vacuum
	self:Log("SPELL_CAST_START", "EnergyBombStart", 374343)
	self:Log("SPELL_CAST_SUCCESS", "EnergyBomb", 374343)
	self:Log("SPELL_AURA_APPLIED", "EnergyBombApplied", 374350)
	self:Log("SPELL_AURA_REMOVED", "EnergyBombRemoved", 374350)
end

function mod:OnEngage()
	local t = GetTime()
	nextEnergyBomb = t + 14.4
	self:CDBar(374352, 14.4) -- Energy Bomb
	nextPowerVacuum = t + 22.8
	self:CDBar(388822, 22.8) -- Power Vacuum
	nextAstralBreath = t + 28.8
	self:CDBar(374361, 28.8) -- Astral Breath
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UnleashEnergy(args)
	-- Mythic-only ability, cast just once on pull
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
end

function mod:OverwhelmingPowerApplied(args)
	if self:Me(args.destGUID) then
		-- aura removed at 4 stacks, spawning an Arcane Rift. don't emphasize until max stack count is reached.
		self:StackMessage(args.spellId, "blue", args.destName, args.amount, 3)
		self:PlaySound(args.spellId, "info")
	end
end

do
	local prev = 0
	function mod:WildEnergyDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 1.5 then
				prev = t
				self:PersonalMessage(388901, "underyou") -- Arcane Rift
				self:PlaySound(388901, "underyou") -- Arcane Rift
			end
		end
	end
end

function mod:AstralBreath(args)
	local t = GetTime()
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	nextAstralBreath = t + 27.9
	self:CDBar(args.spellId, 27.9)
	-- 4.84s minimum to Power Vacuum or Energy Bomb
	if nextPowerVacuum - t < 4.84 then
		nextPowerVacuum = t + 4.84
		self:CDBar(388822, {4.84, 21.1}) -- Power Vacuum
	end
	if nextEnergyBomb - t < 4.84 then
		nextEnergyBomb = t + 4.84
		self:CDBar(374352, {4.84, 14.5}) -- Energy Bomb
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 388820 then -- Power Vacuum
		local t = GetTime()
		-- using this event (the actual pull in) instead of SPELL_CAST_START on 388822 allows us to alert 2s earlier
		self:Message(388822, "red")
		self:PlaySound(388822, "alarm")
		nextPowerVacuum = t + 21.1
		self:CDBar(388822, 21.1)
		-- 6.07s minimum to Astral Breath or Energy Bomb
		if nextAstralBreath - t < 6.07 then
			nextAstralBreath = t + 6.07
			self:CDBar(374361, {6.07, 27.9}) -- Astral Breath
		end
		if nextEnergyBomb - t < 6.07 then
			nextEnergyBomb = t + 6.07
			self:CDBar(374352, {6.07, 14.5}) -- Energy Bomb
		end
	end
end

function mod:EnergyBombStart()
	local t = GetTime()
	nextEnergyBomb = t + 14.5
	self:CDBar(374352, 14.5)
	-- 8.49s minimum to Astral Breath or Power Vacuum
	if nextAstralBreath - t < 8.49 then
		nextAstralBreath = t + 8.49
		self:CDBar(374361, {8.49, 27.9}) -- Astral Breath
	end
	if nextPowerVacuum - t < 8.49 then
		nextPowerVacuum = t + 8.49
		self:CDBar(388822, {8.49, 21.1}) -- Power Vacuum
	end
end

function mod:EnergyBomb(args)
	self:TargetMessage(374352, "yellow", args.destName)
	self:PlaySound(374352, "alert", nil, args.destName)
end

function mod:EnergyBombApplied(args)
	if self:Me(args.destGUID) then
		self:Say(374352, nil, nil, "Energy Bomb")
		self:SayCountdown(374352, 6)
	end
end

function mod:EnergyBombRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(374352)
	end
end
