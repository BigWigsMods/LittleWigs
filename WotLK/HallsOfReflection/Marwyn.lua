-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Marwyn", 668, 602)
if not mod then return end
--mod.otherMenu = "The Frozen Halls"
mod:RegisterEnableMob(38113)

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		72363, -- Corrupted Flesh
		{72368, "ICON"}, -- Shared Suffering
		{72383, "ICON"}, -- Corrupted Touch
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "CorruptedFlesh", 72363) -- 10s no dispell

	self:Log("SPELL_AURA_APPLIED", "DebuffApplied", 72368, 72383) -- Shared Suffering, Corrupted Touch
	self:Log("SPELL_AURA_REMOVED", "DebuffRemoved", 72368, 72383)

	self:Death("Win", 38113)
end

-------------------------------------------------------------------------------
--  Event Handlers

do
	-- local flesh = mod:NewTargetList() -- XXX what is this list used for? Was TargetMessage() intended to be used here?
	local timer, warned = nil, nil

	local function fleshWarn(self, spellId)
		if not warned then
			self:Message(spellId, "Urgent")
			warned = true
		else
			warned = nil
			--wipe(flesh)
		end
		timer = nil
	end

	function mod:CorruptedFlesh(args)
		--flesh[#flesh + 1] = args.destName
		if timer then self:CancelTimer(timer) end
		timer = self:ScheduleTimer(fleshWarn, 0.1, self, args.spellId) -- has been 0.2 before
	end
end

function mod:DebuffApplied(args)
	local time = 10
	if args.spellId == 72363 then -- Corrupted Flesh
		self:PrimaryIcon(args.spellId, args.destName)
	elseif args.spellId == 72368 then -- Shared Suffering
		time = 12
		self:SecondaryIcon(args.spellId, args.destName)
	end
	self:TargetMessage(args.spellId, args.destName, "Urgent")
	self:TargetBar(args.spellId, time, args.destName)
end

function mod:DebuffRemoved(args)
	self:StopBar(args.spellId, args.destName)
	self:PrimaryIcon(args.spellId, false)
	self:SecondaryIcon(args.spellId, false)
end
