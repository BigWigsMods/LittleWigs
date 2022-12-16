--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Echo of Doragosa", 2526, 2514)
if not mod then return end
mod:RegisterEnableMob(190609) -- Echo of Doragosa
mod:SetEncounterID(2565)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		389011, -- Overwhelming Power
		388901, -- Arcane Rift
		374361, -- Astral Breath
		388822, -- Power Vacuum
		{374352, "SAY", "SAY_COUNTDOWN"}, -- Energy Bomb
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "OverwhelmingPowerApplied", 389011)
	self:Log("SPELL_AURA_APPLIED_DOSE", "OverwhelmingPowerApplied", 389011)
	self:Log("SPELL_AURA_APPLIED", "WildEnergyDamage", 389007)
	self:Log("SPELL_PERIODIC_DAMAGE", "WildEnergyDamage", 389007)
	self:Log("SPELL_CAST_START", "AstralBreath", 374361)
	self:Log("SPELL_CAST_START", "PowerVacuum", 388822)
	self:Log("SPELL_AURA_APPLIED", "EnergyBombApplied", 374350)
	self:Log("SPELL_AURA_REMOVED", "EnergyBombRemoved", 374350)
end

function mod:OnEngage()
	self:CDBar(374352, 14.9) -- Energy Bomb
	self:CDBar(388822, 24.2) -- Power Vacuum
	self:CDBar(374361, 28.8) -- Astral Breath
end

--------------------------------------------------------------------------------
-- Event Handlers
--

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
	self:CDBar(args.spellId, 32.8)
end

function mod:PowerVacuum(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 23.1)
end

function mod:EnergyBombApplied(args)
	self:TargetMessage(374352, "yellow", args.destName)
	self:PlaySound(374352, "alert", nil, args.destName)
	self:CDBar(374352, 13.8)
	if self:Me(args.destGUID) then
		self:Say(374352)
		self:SayCountdown(374352, 6)
	end
end

function mod:EnergyBombRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(374352)
	end
end
