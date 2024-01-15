--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Devos, Paragon of Doubt", 2285, 2412)
if not mod then return end
mod:RegisterEnableMob(162061) -- Devos
mod:SetEncounterID(2359)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local runThroughCount = 1
local lostConfidenceCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		{334625, "EMPHASIZE", "CASTBAR"}, -- Abyssal Detonation
		{322818, "SAY", "SAY_COUNTDOWN"}, -- Lost Confidence
		{323943, "SAY"}, -- Run Through
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Activate", 322999)
	self:Log("SPELL_CAST_START", "AbyssalDetonation", 334625)
	self:Log("SPELL_CAST_SUCCESS", "LostConfidence", 322818)
	self:Log("SPELL_AURA_APPLIED", "LostConfidenceApplied", 322818)
	self:Log("SPELL_AURA_REMOVED", "LostConfidenceRemoved", 322818)
	self:Log("SPELL_CAST_START", "RunThrough", 323943)
	self:Log("SPELL_CAST_SUCCESS", "RunThroughSuccess", 323943)
end

function mod:OnEngage()
	runThroughCount = 1
	lostConfidenceCount = 1
	self:SetStage(1)
	self:CDBar(323943, 12) -- Run Through
	self:CDBar(334625, 21) -- Abyssal Detonation
	self:CDBar(322818, 25.5) -- Lost Confidence
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Activate(args)
	self:SetStage(2)
	self:Message("stages", "cyan", CL.stage:format(2), false)
	self:PlaySound("stages", "long")
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:StopBar(323943) -- Run Through
	self:StopBar(334625) -- Abyssal Detonation
	self:StopBar(322818) -- Lost Confidence
end

function mod:UNIT_SPELLCAST_SUCCEEDED(event, unit, _, spellId)
	if spellId == 330433 then -- Shut Down
		self:UnregisterUnitEvent(event, unit)
		runThroughCount = 1
		lostConfidenceCount = 1
		self:SetStage(1)
		self:Message("stages", "cyan", CL.stage:format(1), false)
		self:PlaySound("stages", "long")
		self:CDBar(323943, 11.8) -- Run Through
		self:CDBar(334625, 20.7) -- Abyssal Detonation
		self:CDBar(322818, 25.5) -- Lost Confidence
	end
end

function mod:AbyssalDetonation(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "warning")
	self:Bar(args.spellId, 20.6)
	self:CastBar(args.spellId, 4)
end

function mod:LostConfidence(args)
	lostConfidenceCount = lostConfidenceCount + 1
	self:Bar(args.spellId, lostConfidenceCount == 2 and 31.6 or 20.6)
end

do
	local playerList = mod:NewTargetList()
	function mod:LostConfidenceApplied(args)
		playerList[#playerList+1] = args.destName
		if self:Me(args.destGUID) then
			self:Say(args.spellId, nil, nil, "Lost Confidence")
			self:SayCountdown(args.spellId, 15)
			self:PlaySound(args.spellId, "alarm")
		end
		self:TargetsMessageOld(args.spellId, "yellow", playerList)
	end

	function mod:LostConfidenceRemoved(args)
		if self:Me(args.destGUID) then
			self:Message(args.spellId, "green", CL.removed:format(args.spellName))
			self:PlaySound(args.spellId, "info")
			self:CancelSayCountdown(args.spellId)
		end
	end
end

function mod:RunThrough(args)
	runThroughCount = runThroughCount + 1
	self:Bar(args.spellId, runThroughCount == 3 and 14.6 or 20.6)
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
end

function mod:RunThroughSuccess()
	self:UnregisterEvent("CHAT_MSG_MONSTER_YELL")
end

function mod:CHAT_MSG_MONSTER_YELL(event, _, _, _, _, target)
	if target then
		self:UnregisterEvent(event)

		self:TargetMessage(323943, "orange", target) -- Run Through
		self:PlaySound(323943, "alert", nil, target)

		local guid = self:UnitGUID(target)
		if self:Me(guid) then
			self:Say(323943, nil, nil, "Run Through")
		end
	end
end
