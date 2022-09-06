
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ivanyr", 1516, 1497)
if not mod then return end
mod:RegisterEnableMob(98203)
mod.engageId = 1827

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		196805, -- Nether Link
		{196562, "PROXIMITY"}, -- Volatile Magic
		196392, -- Overcharge Mana
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "NetherLink", 196805)
	self:Log("SPELL_AURA_APPLIED", "VolatileMagicApplied", 196562)
	self:Log("SPELL_AURA_REMOVED", "VolatileMagicRemoved", 196562)
	self:Log("SPELL_CAST_SUCCESS", "OverchargeMana", 196392)
end

function mod:OnEngage()
	self:CDBar(196562, 10) -- Volatile Magic
	self:CDBar(196805, 18) -- Nether Link
	self:CDBar(196392, 37.5) -- Overcharge Mana
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local list = mod:NewTargetList()
	function mod:NetherLink(args)
		list[#list+1] = args.destName
		if #list == 1 then
			self:ScheduleTimer("TargetMessageOld", 0.1, args.spellId, list, "yellow", "info")
			self:CDBar(args.spellId, 33)
		end
	end
end

do
	local targets, isOnMe = {}, nil
	local function printTarget(self, spellId)
		if isOnMe then
			self:OpenProximity(spellId, 8)
		else
			self:OpenProximity(spellId, 8, targets)
		end
		self:TargetMessageOld(spellId, self:ColorName(targets), "orange", "alarm", nil, nil, true)
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
	self:MessageOld(args.spellId, "red", "long", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 40)
end
