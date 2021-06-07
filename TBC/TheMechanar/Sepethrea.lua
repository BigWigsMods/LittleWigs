--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Nethermancer Sepethrea", 554, 564)
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
-- Localization
--

local L = mod:GetLocale()
if L then
	L.fixate = CL.fixate
	L.fixate_desc = "Causes the caster to fixate on a random target."
	L.fixate_icon = "ability_fixated_state_red"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		35250, -- Dragon's Breath
		35314, -- Arcane Blast
		{"fixate", "SAY"}, -- Fixate
		-5488, -- Inferno
		35312, -- Raging Flames (the trail of fire the adds leave behind them)
	}, {
		[35250] = "general",
		["fixate"] = 35312, -- Raging Flames
	}
end

function mod:OnBossEnable()
	-- no boss frames, so doing this manually
	self:RegisterEvent("ENCOUNTER_START")
	self:RegisterEvent("ENCOUNTER_END")

	self:Log("SPELL_AURA_APPLIED", "DragonsBreath", 35250)

	self:Log("SPELL_CAST_SUCCESS", "ArcaneBlast", 35314)

	self:Log("SPELL_DAMAGE", "PeriodicDamage", 35312, 35283) -- Raging Flames, Inferno
	self:Log("SPELL_MISSED", "PeriodicDamage", 35312, 35283) -- Raging Flames, Inferno

	self:Log("SPELL_AURA_APPLIED", "Inferno", 35268, 39346) -- normal, heroic

	-- Fixate
	self:RegisterTargetEvents("RagingFlamesFinder")
	self:Log("SWING_DAMAGE", "RagingFlamesSwing", "*") -- just in case the player somehow bodypulls the boss without activating the module (thus missing "NAME_PLATE_UNIT_ADDED" events)
	self:Log("SWING_MISSED", "RagingFlamesSwing", "*")
	self:Log("PARTY_KILL", "RagingFlamesDeath", "*") -- UNIT_DIED (which is what self:Death() is using) doesn't provide a sourceGUID, and both adds fire that event (triggering unregisterGUIDFindingEvents) if you wipe with them alive
	self:Log("SPELL_AURA_REMOVED", "InfernoEnded", 35268, 39346) -- normal, heroic
end

function mod:OnEngage()
	mobsFound = 0
	mobCollector = {}
end

function mod:OnBossDisable()
	mobsFound = 0
	mobCollector = {}
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
	local playerList = mod:NewTargetList()
	function mod:DragonsBreath(args)
		playerList[#playerList + 1] = args.destName
		self:ScheduleTimer("TargetMessageOld", 0.3, args.spellId, playerList, "orange", "alarm", nil, nil, self:Dispeller("magic"))
	end
end

function mod:ArcaneBlast(args)
	self:TargetMessageOld(args.spellId, args.destName, "red", "warning", nil, nil, true)
end

do
	local prev = 0
	function mod:PeriodicDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t - prev > 1.5 then
				prev = t
				self:MessageOld(args.spellId == 35283 and -5488 or args.spellId, "blue", "alert", CL.underyou:format(args.spellName))
			end
		end
	end
end

-- Fixate
do
	local fixatedTargets, isOnMe = mod:NewTargetList(), nil

	local function showFixateMessage(self)
		self:TargetMessageOld("fixate", fixatedTargets, "yellow", "long", L.fixate, L.fixate_icon)
		isOnMe = nil
	end

	local function fixateAnnounce(self, target, guid)
		if self:Me(guid) and not isOnMe then
			isOnMe = true
			self:Say("fixate", L.fixate)
		end

		if #fixatedTargets > 0 and fixatedTargets[#fixatedTargets] == self:ColorName(target) then return end -- don't announce the same player twice
		fixatedTargets[#fixatedTargets + 1] = target

		if #fixatedTargets == 1 then
			self:ScheduleTimer(showFixateMessage, 0.4, self) -- need to reset isOnMe so not calling TargetMessage directly, either this or the possibility of 2-3 :Say() calls
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
			if mobsFound == (self:Normal() and 2 or 3) then
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
	local prev, infernoCasts = 0, 0 -- they can de-sync so I need to track previous cast-time too
	function mod:InfernoEnded(args)
		infernoCasts = infernoCasts - 1
		if infernoCasts == 0 then
			self:StopBar(CL.cast:format(args.spellName))
		end
		self:GetUnitTarget(fixateAnnounce, 0.3, args.destGUID)
	end

	function mod:Inferno(args)
		infernoCasts = infernoCasts + 1
		local t = GetTime()
		if t - prev > 1 then
			prev = t
			self:MessageOld(-5488, "cyan", "info", CL.casting:format(args.spellName))
		end
		self:CastBar(-5488, 8)
	end
end
