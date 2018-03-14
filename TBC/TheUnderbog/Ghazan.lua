-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ghaz'an", 546, 577)
if not mod then return end
mod:RegisterEnableMob(18105)
-- mod.engageId = 1945 -- sometimes doesn't fire ENCOUNTER_END on a wipe
-- mod.respawnTime = 0 -- resets, doesn't respawn

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		34268, -- Acid Breath
		38737, -- Tail Sweep
		15716, -- Enrage
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "AcidBreath", 34268)
	self:Log("SPELL_AURA_APPLIED_DOSE", "AcidBreath", 34268)
	self:Log("SPELL_AURA_REMOVED", "AcidBreathRemoved", 34268)

	self:Log("SPELL_DAMAGE", "TailSweep", 34267, 38737) -- normal, heroic
	self:Log("SPELL_MISSED", "TailSweep", 34267, 38737)

	self:Log("SPELL_AURA_APPLIED", "Enrage", 15716)
	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "boss1")

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Death("Win", 18105)
end

-------------------------------------------------------------------------------
--  Event Handlers
--

do
	local playerList = mod:NewTargetList()

	function mod:AcidBreath(args)
		if self:Me(args.destGUID) and not self:Healer() then
			self:TargetMessage(args.spellId, args.destName, "Personal", not self:Tank() and "Warning")
			self:TargetBar(args.spellId, 20, args.destName) -- this will have 100% uptime on the tank, can't be dispelled, no reason to show this to anyone not affected
		elseif self:Healer() then
			playerList[#playerList+1] = args.destName
			if #playerList == 1 then
				self:ScheduleTimer("TargetMessage", 0.3, args.spellId, playerList, "Important")
			end
		end
	end

	function mod:AcidBreathRemoved(args)
		self:StopBar(args.spellName, args.destName)
	end
end

do
	local prev = 0
	function mod:TailSweep(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t - prev > 1.5 then
				prev = t
				self:Message(38737, "Personal", "Alert", CL.you:format(args.spellName))
			end
		end
	end
end

function mod:Enrage(args)
	self:Message(args.spellId, "Urgent", "Long", CL.percent:format(20, args.spellName))
end

function mod:UNIT_HEALTH_FREQUENT(unit)
	local hp = UnitHealth(unit) / UnitHealth(unit) * 100
	if hp < 25 then
		self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", unit)
		self:Message(15716, "Positive", "Info", CL.soon:format(self:SpellName(15716))) -- Enrage
	end
end
