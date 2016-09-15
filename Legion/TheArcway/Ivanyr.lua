
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ivanyr", 1079, 1497)
if not mod then return end
mod:RegisterEnableMob(98203)
mod.engageId = 1827

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{196805, "PROXIMITY"}, -- Nether Link
		{196562, "PROXIMITY"}, -- Volatile Magic
		196392, -- Overcharge Mana
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "NetherLinkApplied", 196805)
	self:Log("SPELL_AURA_REMOVED", "NetherLinkRemoved", 196805)
	self:Log("SPELL_AURA_APPLIED", "VolatileMagicApplied", 196562)
	self:Log("SPELL_AURA_REMOVED", "VolatileMagicRemoved", 196562)
	self:Log("SPELL_CAST_SUCCESS", "OverchargeMana", 196392)
end

function mod:OnEngage()
	self:CDBar(196562, 13) -- Volatile Magic
	self:CDBar(196805, 20) -- Nether Link
	self:CDBar(196392, 38) -- Overcharge Mana
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local targets, isOnMe = {}
	local function printTarget(self, spellId)
		if isOnMe then
			-- pushes pretty hard at 8ish, 15 should be good enough to get you running at the other players
			self:OpenProximity(spellId, 15, targets, true)
		end
		self:TargetMessage(spellId, self:ColorName(targets), "Attention", "Info")
		wipe(targets)
		isOnMe = nil
	end

	function mod:NetherLinkApplied(args)
		targets[#targets+1] = args.destName
		if #targets == 1 then
			self:ScheduleTimer(printTarget, 0.1, self, args.spellId)
			self:CDBar(args.spellId, 35)
		end
		if self:Me(args.destGUID) then
			self:TargetBar(args.spellId, 5, args.destName)
			isOnMe = true
		end
	end

	function mod:NetherLinkRemoved(args)
		if self:Me(args.destGUID) then
			self:CloseProximity(args.spellId)
		end
	end
end

do
	local targets, isOnMe = {}
	local function printTarget(self, spellId)
		if isOnMe then
			self:OpenProximity(spellId, 8)
		else
			self:OpenProximity(spellId, 8, targets)
		end
		self:TargetMessage(spellId, self:ColorName(targets), "Urgent", "Alarm", nil, nil, true)
		wipe(targets)
		isOnMe = nil
	end

	function mod:VolatileMagicApplied(args)
		targets[#targets+1] = args.destName
		if #targets == 1 then
			self:ScheduleTimer(printTarget, 0.1, self, args.spellId)
			self:Bar(args.spellId, 4, ("<%s>"):format(args.spellName))
			self:CDBar(args.spellId, 35)
		end
		if self:Me(args.destGUID) then
			self:TargetBar(args.spellId, 5, args.destName)
			isOnMe = true
		end
	end

	function mod:VolatileMagicRemoved(args)
		self:CloseProximity(args.spellId)
	end
end

function mod:OverchargeMana(args)
	self:Message(args.spellId, "Important", "Long", CL.casting:format(args.spellName))
end
