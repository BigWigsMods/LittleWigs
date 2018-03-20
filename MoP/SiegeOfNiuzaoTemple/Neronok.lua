
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Wing Leader Ner'onok", 1011, 727)
if not mod then return end
mod:RegisterEnableMob(62205)
mod.engageId = 1464
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Locals
--

local nextWindsWarning = 75

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		121443, -- Caustic Pitch
		-6205, -- Quick-Dry Resin (EJ entry mentions Invigorated)
		121284, -- Gusting Winds
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "CausticPitch", 121443)
 	self:Log("SPELL_PERIODIC_DAMAGE", "CausticPitch", 121443)
 	self:Log("SPELL_PERIODIC_MISSED", "CausticPitch", 121443)

	self:Log("SPELL_AURA_APPLIED", "QuickDryResin", 121447)
	self:Log("SPELL_AURA_APPLIED", "Invigorated", 121449)

	self:Log("SPELL_AURA_APPLIED", "GustingWinds", 121282, 121284)
	self:Log("SPELL_INTERRUPT", "GustingWindsInterrupted", "*")

	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "boss1")
end

function mod:OnEngage()
	nextWindsWarning = 75 -- casts it at 70% and 40%
end

--------------------------------------------------------------------------------
-- Event Handlers
--
do
	local prev = 0
	function mod:CausticPitch(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 1.5 then
				prev = t
				self:Message(args.spellId, "Personal", "Alert", CL.underyou:format(args.spellName))
			end
		end
	end
end

function mod:QuickDryResin(args)
	if self:Me(args.destGUID) then
		self:Message(-6205, "Personal", "Alarm", CL.you:format(args.spellName))
	end
end

function mod:Invigorated(args)
	if self:Me(args.destGUID) then
		self:Message(-6205, "Positive", "Info", CL.you:format(args.spellName), args.spellId)
	end
end

do
	local scheduledCooldownTimer = nil
	function mod:GustingWinds(args)
		self:Message(121284, "Urgent", self:Interrupter() and "Warning" or "Long", CL.casting:format(args.spellName))
		self:CastBar(121284, 4)
		scheduledCooldownTimer = self:ScheduleTimer("CDBar", 4.1, 121284, 3.2) -- 7.3s CD
	end

	function mod:GustingWindsInterrupted(args)
		if args.extraSpellId == 121282 or args.extraSpellId == 121284 then -- Gusting Winds
			self:Message(121284, "Positive", nil, CL.interrupted_by:format(args.extraSpellName, self:ColorName(args.sourceName)))
			self:StopBar(CL.cast:format(args.extraSpellName))
			if scheduledCooldownTimer then
				self:CancelTimer(scheduledCooldownTimer)
				scheduledCooldownTimer = nil
			end
		end
	end
end

function mod:UNIT_HEALTH_FREQUENT(unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < nextWindsWarning then
		self:Message("stages", "Attention", nil, CL.soon:format(self:SpellName(-6297)), false) -- -6297 = Treacherous Winds
		nextWindsWarning = nextWindsWarning - 30
		if nextWindsWarning < 40 then
			self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", unit)
		end
	end
end
