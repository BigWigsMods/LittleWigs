--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Striker Ga'dok", 962, 675)
if not mod then return end
mod:RegisterEnableMob(56589)
mod:SetEncounterID(1405)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local nextStrafingWarning = 75

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		106933, -- Prey Time
		{107047, "TANK_HEALER"}, -- Impaling Strike
		-5660, -- Strafing Run
		115458, -- Acid Bomb
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "PreyTime", 106933)
	self:Log("SPELL_CAST_SUCCESS", "ImpalingStrike", 107047)
	self:Log("SPELL_DAMAGE", "GroundEffectDamage", 116297, 115458) -- Strafing Run, Acid Bomb
	self:Log("SPELL_MISSED", "GroundEffectDamage", 116297, 115458)

	self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1")
end

function mod:OnEngage()
	nextStrafingWarning = 75 -- casts it at 70% and 30%
	self:CDBar(107047, 9.4) -- Impaling Strike
	self:CDBar(106933, 15.9) -- Prey Time
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:PreyTime(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	self:PlaySound(args.spellId, "info", nil, args.destName)
	self:CDBar(args.spellId, 15.6)
end

function mod:ImpalingStrike(args) -- has no cast time, short of providing a CDBar there's nothing we can help with
	self:CDBar(args.spellId, 28)
end

do
	local prev = 0
	function mod:GroundEffectDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 3.5 then
				prev = t
				self:PersonalMessage(args.spellId == 115458 and args.spellId or -5660, "underyou") -- SetOption:-5660,115458:::
				self:PlaySound(args.spellId == 115458 and args.spellId or -5660, "alert", nil, args.destName) -- SetOption:-5660,115458:::
			end
		end
	end
end

function mod:UNIT_HEALTH(event, unit)
	local hp = self:GetHealth(unit)
	if hp < nextStrafingWarning then
		nextStrafingWarning = nextStrafingWarning - 40
		self:Message(-5660, "yellow", CL.soon:format(self:SpellName(-5660)), false)
		if nextStrafingWarning < 30 then
			self:UnregisterUnitEvent(event, unit)
		end
	end
end
