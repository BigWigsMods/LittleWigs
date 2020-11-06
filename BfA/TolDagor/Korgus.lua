
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Overseer Korgus", 1771, 2096)
if not mod then return end
mod:RegisterEnableMob(127503)
mod.engageId = 2104

--------------------------------------------------------------------------------
-- Locals
--

local crossIgnitionCount = 0 -- XXX If we track which Azerite Rounds are used we can better timers if a player disconnects
local explosiveBurstCount = 0
local deadeyes = {}

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		256198, -- Azerite Rounds: Incendiary
		256199, -- Azerite Rounds: Blast
		256083, -- Cross Ignition
		{256105, "SAY", "SAY_COUNTDOWN", "PROXIMITY"}, -- Explosive Burst
		{256038, "INFOBOX"}, -- Deadeye
		263345, -- Massive Blast
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "AzeriteRoundsIncendiary", 256198)
	self:Log("SPELL_CAST_START", "AzeriteRoundsBlast", 256199)
	self:Log("SPELL_CAST_START", "CrossIgnition", 256083)
	self:Log("SPELL_CAST_SUCCESS", "ExplosiveBurst", 256101)
	self:Log("SPELL_AURA_APPLIED", "ExplosiveBurstApplied", 256105)
	self:Log("SPELL_AURA_REMOVED", "ExplosiveBurstRemoved", 256105)
	self:Log("SPELL_CAST_SUCCESS", "Deadeye", 256038)
	self:Log("SPELL_AURA_APPLIED", "DeadeyeApplied", 256044)
	self:Log("SPELL_AURA_APPLIED_DOSE", "DeadeyeApplied", 256044)
	self:Log("SPELL_AURA_REMOVED", "DeadeyeRemoved", 256044)
	self:Log("SPELL_CAST_START", "MassiveBlast", 263345)
end

function mod:OnEngage()
	crossIgnitionCount = 1
	explosiveBurstCount = 1
	deadeyes = {}

	self:CDBar(256198, 6) -- Azerite Rounds: Incendiary
	self:CDBar(256105, 13) -- Explosive Burst
	self:CDBar(256083, 18) -- Cross Ignition
	self:CDBar(256038, 28) -- Deadeye

	self:OpenInfo(256038, self:SpellName(256038)) -- Deadeye
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:AzeriteRoundsIncendiary(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
	self:CDBar(256199, 27.5) -- Azerite Rounds: Blast
end

function mod:AzeriteRoundsBlast(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
	self:Bar(256198, 27.5) -- Azerite Rounds: Incendiary
end

function mod:CrossIgnition(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	crossIgnitionCount = crossIgnitionCount + 1
	self:Bar(args.spellId, crossIgnitionCount % 2 == 0 and 21 or 34)
	self:CastBar(args.spellId, 5.5)
end

function mod:ExplosiveBurst()
	explosiveBurstCount = explosiveBurstCount + 1
	self:Bar(256105, explosiveBurstCount % 2 == 0 and 38 or 17)
end

do
	local playerList, isOnMe = {}, nil
	local function warn(self)
		if isOnMe then
			self:PersonalMessage(256105)
			self:PlaySound(256105, "warning", "moveout")
			self:OpenProximity(256105, 5)
		else
			self:Message(256105, "orange")
			self:PlaySound(256105, "alarm")
			self:OpenProximity(256105, 5, playerList)
		end
		playerList = {}
		isOnMe = nil
	end

	function mod:ExplosiveBurstApplied(args)
		playerList[#playerList + 1] = args.destName
		if self:Me(args.destGUID) then
			isOnMe = true
			self:Say(args.spellId)
			self:SayCountdown(args.spellId, 4)
		end
		if #playerList == 1 then
			self:ScheduleTimer(warn, 0.1, self)
		end
	end
end

function mod:ExplosiveBurstRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
	self:CloseProximity(args.spellId)
end

function mod:Deadeye(args)
	local deadeyeInfo = deadeyes[args.destName] -- [1] is stacks
	if deadeyeInfo then
		self:StackMessage(args.spellId, args.destName, deadeyeInfo[1]+1, "red")
		self:PlaySound(args.spellId, "warning", nil, args.destName)
	else
		self:TargetMessage(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
	self:Bar(args.spellId, 27.5)
	self:CastBar(args.spellId, 5)
end

function mod:DeadeyeApplied(args)
	deadeyes[args.destName] = {args.amount or 1, GetTime()+80, 80}
	self:SetInfoBarsByTable(256038, deadeyes)
end

function mod:DeadeyeRemoved(args)
	deadeyes[args.destName] = nil
	self:SetInfoBarsByTable(256038, deadeyes)
	if self:Me(args.destGUID) then
		self:Message(256038, "green", CL.removed:format(args.spellName))
	end
end

function mod:MassiveBlast(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 27.5)
	self:CastBar(args.spellId, 4)
end
