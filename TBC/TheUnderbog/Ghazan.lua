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

	if self:Classic() then
		self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
		self:RegisterEvent("UNIT_HEALTH")
	else
		self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
		self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1")
	end
	self:Death("Win", 18105)
end

function mod:OnEngage()
	if self:Classic() then
		self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
	end
end

-------------------------------------------------------------------------------
--  Event Handlers
--

do
	local playerList = mod:NewTargetList()

	function mod:AcidBreath(args)
		if self:Me(args.destGUID) and not self:Healer() then
			self:TargetMessageOld(args.spellId, args.destName, "blue", not self:Tank() and "warning")
			self:TargetBar(args.spellId, 20, args.destName) -- this will have 100% uptime on the tank, can't be dispelled, no reason to show this to anyone not affected
		elseif self:Healer() then
			playerList[#playerList+1] = args.destName
			if #playerList == 1 then
				self:ScheduleTimer("TargetMessageOld", 0.3, args.spellId, playerList, "red")
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
			local t = args.time
			if t - prev > 1.5 then
				prev = t
				self:MessageOld(38737, "blue", "alert", CL.you:format(args.spellName))
			end
		end
	end
end

function mod:Enrage(args)
	self:MessageOld(args.spellId, "orange", "long", CL.percent:format(20, args.spellName))
end

function mod:UNIT_HEALTH(event, unit)
	if self:MobId(self:UnitGUID(unit)) == 18105 then
		local hp = self:GetHealth(unit)
		if hp < 25 then
			if self:Classic() then
				self:UnregisterEvent(event)
			else
				self:UnregisterUnitEvent(event, unit)
			end
			self:MessageOld(15716, "green", "info", CL.soon:format(self:SpellName(15716))) -- Enrage
		end
	end
end
