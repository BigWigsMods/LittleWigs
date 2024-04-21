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

local powerVacuumCount = 0

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
	self:Log("SPELL_CAST_SUCCESS", "EnergyBomb", 374343)
	self:Log("SPELL_AURA_APPLIED", "EnergyBombApplied", 374350)
	self:Log("SPELL_AURA_REMOVED", "EnergyBombRemoved", 374350)
end

function mod:OnEngage()
	powerVacuumCount = 0
	self:CDBar(374352, 15.9) -- Energy Bomb
	self:CDBar(388822, 22.8) -- Power Vacuum
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
		-- aura removed at 3 stacks, spawning an Arcane Rift
		self:StackMessage(args.spellId, "blue", args.destName, args.amount, 2)
		self:PlaySound(args.spellId, "alert")
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
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 29.1)
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 388820 then -- Power Vacuum
		-- using this event instead of SPELL_CAST_START on 388822 allows us to alert 2s earlier
		powerVacuumCount = powerVacuumCount + 1
		self:Message(388822, "red")
		self:PlaySound(388822, "alarm")
		self:CDBar(388822, powerVacuumCount == 1 and 21.9 or 29.1)
	end
end

function mod:EnergyBomb(args)
	self:TargetMessage(374352, "yellow", args.destName)
	self:PlaySound(374352, "alert", nil, args.destName)
	self:CDBar(374352, 14.5)
	if self:Me(args.destGUID) then
		self:Say(374352, nil, nil, "Energy Bomb")
	end
end

function mod:EnergyBombApplied(args)
	if self:Me(args.destGUID) then
		self:SayCountdown(374352, 6)
	end
end

function mod:EnergyBombRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(374352)
	end
end
