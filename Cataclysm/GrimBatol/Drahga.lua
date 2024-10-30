--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Drahga Shadowburner", 670, 133)
if not mod then return end
if mod:Retail() then
	mod:SetJournalID(2618) -- Journal ID was changed in The War Within
end
mod:RegisterEnableMob(
	40319, -- Drahga Shadowburner
	40320 -- Valiona
)
mod:SetEncounterID(1048)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local shouldAdjustTimers = false
local invocationOfShadowflameCount = 1
local twilightBuffetCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		-- Drahga Shadowburner
		448013, -- Invocation of Shadowflame (Adds)
		{450095, "DISPEL"}, -- Curse of Entropy
		{447966, "OFF"}, -- Shadowflame Bolt
		-- Valiona
		456751, -- Twilight Buffet
		448105, -- Devouring Flame (Mythic)
		-- Invoked Shadowflame Spirit
		{82850, "ME_ONLY_EMPHASIZE", "SAY", "NAMEPLATE"}, -- Flaming Fixate
	}, {
		[448013] = -29546, -- Drahga Shadowburner
		[456751] = -29551, -- Valiona
		[82850] = -29557, -- Invoked Shadowflame Spirit
	}, {
		[448013] = CL.adds, -- Invocation of Shadowflame (Adds)
		[448105] = CL.mythic, -- Devouring Flame (Mythic)
		[82850] = CL.fixate, -- Flaming Fixate (Fixate)
	}
end

function mod:OnBossEnable()
	-- Stages
	self:Log("SPELL_CAST_SUCCESS", "TwilightProtection", 76303)

	-- Drahga Shadowburner
	self:Log("SPELL_CAST_START", "InvocationOfShadowflame", 448013)
	self:Log("SPELL_AURA_APPLIED", "FlamingFixateApplied", 82850)
	self:Log("SPELL_AURA_REMOVED", "FlamingFixateRemoved", 82850)
	self:Log("SPELL_CAST_START", "CurseOfEntropyStart", 450095)
	self:Log("SPELL_CAST_SUCCESS", "CurseOfEntropy", 450095)
	self:Log("SPELL_AURA_APPLIED", "CurseOfEntropyApplied", 450095)
	self:Log("SPELL_CAST_START", "ShadowflameBolt", 447966)

	-- Valiona
	self:Log("SPELL_CAST_START", "TwilightBuffet", 456751)
	self:Log("SPELL_CAST_START", "DevouringFlame", 448105)
end

function mod:OnEngage()
	shouldAdjustTimers = false
	invocationOfShadowflameCount = 1
	twilightBuffetCount = 1
	self:SetStage(1)
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT") -- Staging
	self:CDBar(448013, 8.0, CL.count:format(CL.add, invocationOfShadowflameCount)) -- Invocation of Shadowflame
	self:CDBar(450095, 17.0) -- Curse of Entropy
end

--------------------------------------------------------------------------------
-- Classic Initialization
--

if mod:Classic() then
	function mod:GetOptions()
		return {
			75218, -- Invocation of Flame
			90950, -- Devouring Flames
		}
	end

	function mod:OnBossEnable()
		-- normal
		self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE", "InvocationOfFlame")
		-- heroic
		self:Log("SPELL_CAST_START", "DevouringFlames", 90950)
	end

	function mod:VerifyEnable()
		-- don't enable if the player is still flying around in a drake
		return not UnitInVehicle("player")
	end

	function mod:OnEngage()
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Stages

function mod:TwilightProtection(args)
	-- starting timers here is more accurate than starting in IEEU, but there's still about ~1s of variance
	shouldAdjustTimers = true
	self:StopBar(CL.count:format(CL.add, invocationOfShadowflameCount)) -- Invocation of Shadowflame
	self:CDBar(450095, 21.1) -- Curse of Entropy
	self:CDBar(448013, 21.12, CL.count:format(CL.adds, invocationOfShadowflameCount)) -- Invocation of Shadowflame
	self:CDBar(456751, 32.1, CL.count:format(self:SpellName(456751), twilightBuffetCount)) -- Twilight Buffet
	if self:Mythic() then
		self:CDBar(448105, 42.1) -- Devouring Flame
	end
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT(event)
	if self:GetBossId(40320) then -- Valiona
		self:UnregisterEvent(event)
		self:SetStage(2)
		self:Message("stages", "cyan", CL.stage:format(2), false)
		self:PlaySound("stages", "long")
	end
end

-- Drahga Shadowburner

function mod:InvocationOfShadowflame(args)
	if self:GetStage() == 1 then -- 1 add spawns
		self:StopBar(CL.count:format(CL.add, invocationOfShadowflameCount))
		self:Message(args.spellId, "yellow", CL.count:format(CL.add_spawning, invocationOfShadowflameCount))
		invocationOfShadowflameCount = invocationOfShadowflameCount + 1
		self:CDBar(args.spellId, 18.0, CL.count:format(CL.add, invocationOfShadowflameCount))
		self:PlaySound(args.spellId, "info")
	else -- Stage 2, 2 adds spawn
		self:StopBar(CL.count:format(CL.adds, invocationOfShadowflameCount))
		self:Message(args.spellId, "yellow", CL.count:format(CL.adds_spawning, invocationOfShadowflameCount))
		invocationOfShadowflameCount = invocationOfShadowflameCount + 1
		self:CDBar(args.spellId, 35.0, CL.count:format(CL.adds, invocationOfShadowflameCount))
		self:PlaySound(args.spellId, "info")
	end
end

do
	local prevOnMe = 0
	function mod:FlamingFixateApplied(args)
		self:TargetMessage(args.spellId, "red", args.destName, CL.fixate)
		if self:Me(args.destGUID) then
			self:Nameplate(args.spellId, 60, args.sourceGUID, CL.fixate)
			if args.time - prevOnMe > 2 then
				prevOnMe = args.time
				self:Say(args.spellId, CL.fixate, nil, "Fixate")
				self:PlaySound(args.spellId, "warning", nil, args.destName)
			end
		end
	end
end

function mod:FlamingFixateRemoved(args)
	if self:Me(args.destGUID) then
		self:StopNameplate(args.spellId, args.sourceGUID, CL.fixate)
	end
end

function mod:CurseOfEntropyStart()
	-- this eliminates the ~1s of variance from timers started in :TwilightProtection
	if shouldAdjustTimers then
		shouldAdjustTimers = false
		self:CDBar(450095, {2.0, 21.1}) -- Curse of Entropy
		self:CDBar(448013, {2.02, 21.1}, CL.count:format(CL.adds, invocationOfShadowflameCount)) -- Invocation of Shadowflame
		self:CDBar(456751, {13.0, 32.1}, CL.count:format(self:SpellName(456751), twilightBuffetCount)) -- Twilight Buffet
		if self:Mythic() then
			self:CDBar(448105, {23.0, 42.1}) -- Devouring Flame
		end
	end
end

do
	local playerList = {}

	function mod:CurseOfEntropy(args)
		playerList = {}
		if self:GetStage() == 1 then
			self:CDBar(args.spellId, 18.0)
		else
			self:CDBar(args.spellId, 35.0)
		end
	end

	function mod:CurseOfEntropyApplied(args)
		-- this slows but is not dispelled by movement-dispelling effects
		if self:Dispeller("curse", nil, args.spellId) or self:Healer() or self:Me(args.destGUID) then
			playerList[#playerList + 1] = args.destName
			self:TargetsMessage(args.spellId, "red", playerList, 3)
			self:PlaySound(args.spellId, "alert", nil, playerList)
		end
	end
end

function mod:ShadowflameBolt(args)
	local _, interruptReady = self:Interrupter()
	if interruptReady then
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alert")
	end
end

-- Valiona

function mod:TwilightBuffet(args)
	self:StopBar(CL.count:format(args.spellName, twilightBuffetCount))
	self:Message(args.spellId, "orange", CL.count:format(args.spellName, twilightBuffetCount))
	twilightBuffetCount = twilightBuffetCount + 1
	self:CDBar(args.spellId, 35.0, CL.count:format(args.spellName, twilightBuffetCount))
	self:PlaySound(args.spellId, "alarm")
end

function mod:DevouringFlame(args)
	self:Message(args.spellId, "red")
	self:CDBar(args.spellId, 35.0)
	self:PlaySound(args.spellId, "alarm")
end

--------------------------------------------------------------------------------
-- Classic Event Handlers
--

function mod:InvocationOfFlame(_, msg)
	if msg:find(self:SpellName(75218)) then
		self:Message(75218, "yellow", CL.add_spawned)
		self:PlaySound(75218, "info")
	end
end

function mod:DevouringFlames(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end
