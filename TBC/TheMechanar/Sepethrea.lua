--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Nethermancer Sepethrea", 730, 564)
if not mod then return end
mod:RegisterEnableMob(19221)
-- mod.engageId = 1930 -- no boss frames
-- mod.respawnTime = 0 -- resets, doesn't respawn

--------------------------------------------------------------------------------
-- Locals
--

local mobCollector = {}
local mobsFound = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		35250, -- Dragon's Breath
		{41951, "SAY"}, -- Fixate
	}, {
		[35250] = "general",
		[41951] = -5487, -- Raging Flames
	}
end

function mod:OnBossEnable()
	-- no boss frames, so doing this manually
	self:RegisterEvent("ENCOUNTER_START")
	self:RegisterEvent("ENCOUNTER_END")




	-- Fixate
	self:RegisterTargetEvents("RagingFlamesFinder")
	self:Log("SWING_DAMAGE", "RagingFlamesSwing", "*")
	self:Log("SWING_MISSED", "RagingFlamesSwing", "*")
	self:Log("PARTY_KILL", "RagingFlamesDeath", "*") -- UNIT_DIED (which is what self:Death() is using) doesn't provide a sourceGUID, and both adds fire that event (triggering unregisterGUIDFindingEvents) if you wipe with them alive
	self:Log("SPELL_AURA_REMOVED", "InfernoEnded", 35268)
end

function mod:OnEngage()
	mobsFound = 0
	wipe(mobCollector)
end

function mod:OnBossDisable()
	mobsFound = 0
	wipe(mobCollector)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ENCOUNTER_START(_, engageId)
	if engageId == 1930 then
		self:Engage()
	end
end

function mod:ENCOUNTER_END(_, engageId, _, _, _, status)
	if engageId == 1930 then
		if status == 0 then
			self:Wipe()
		else
			self:Win()
		end
	end
end

do
	local fixatedTargets = mod:NewTargetList()
	local function fixateAnnounce(self, target, guid)
		if self:Me(guid) then
			self:Say(41951)
		end

		if #fixatedTargets == 1 and fixatedTargets[#fixatedTargets] == self:ColorName(target) then return end -- don't announce the same player twice
		fixatedTargets[#fixatedTargets + 1] = target

		if #fixatedTargets == 1 then
			self:ScheduleTimer("TargetMessage", 0.4, 41951, fixatedTargets, "Attention", "Alarm")
		end
	end

	-- Initial fixate
	local function unregisterGUIDFindingEvents(self)
		self:UnregisterTargetEvents()
		self:RemoveLog("SWING_DAMAGE", "*")
		self:RemoveLog("SWING_MISSED", "*")
		self:RemoveLog("PARTY_KILL", "*")
	end

	local function addAMobToCollector(self, guid)
		if self:MobId(guid) == 20481 and not mobCollector[guid] then
			mobsFound = mobsFound + 1
			mobCollector[guid] = true
			if mobsFound == 2 then
				unregisterGUIDFindingEvents(self)
			end
			return true
		end
		return false
	end

	function mod:RagingFlamesFinder(_, unit, guid)
		if UnitIsDead(unit) then return end -- corpse from a previous try
		if addAMobToCollector(self, guid) then
			self:GetUnitTarget(fixateAnnounce, 0.3, guid)
		end
	end

	function mod:RagingFlamesSwing(args)
		if addAMobToCollector(self, args.sourceGUID) then
			self:GetUnitTarget(fixateAnnounce, 0.3, args.sourceGUID)
		end
	end

	function mod:RagingFlamesDeath(args)
		addAMobToCollector(self, args.destGUID)
	end

	-- Refixate after Inferno
	function mod:InfernoEnded(args)
		self:GetUnitTarget(fixateAnnounce, 0.3, args.destGUID)
	end
end
