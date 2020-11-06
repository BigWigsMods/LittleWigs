
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Unbound Abomination", 1841, 2158)
if not mod then return end
mod:RegisterEnableMob(133007, 134419) -- Unbound Abomination, Titan Keeper Hezrel
mod.engageId = 2123

--------------------------------------------------------------------------------
-- Locals
--

local putridBloodList = {}
local visageRemaining = 6

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		{269301, "INFOBOX"}, -- Putrid Blood
		269843, -- Vile Expulsion
		{269310, "SAY", "ICON", "PROXIMITY"}, -- Cleansing Light
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "VileExpulsion", 269843)
	self:Log("SPELL_CAST_START", "CleansingLight", 269310)
	self:Log("SPELL_CAST_SUCCESS", "CleansingLightSuccess", 269310)

	self:Log("SPELL_AURA_APPLIED", "PutridBloodApplied", 269301)
	self:Log("SPELL_AURA_APPLIED_DOSE", "PutridBloodAppliedDose", 269301)
	self:Log("SPELL_AURA_REMOVED", "PutridBloodRemoved", 269301)

	self:Death("VisageDeath", 137103)
end

function mod:OnEngage()
	putridBloodList = {}
	visageRemaining = 6
	self:Bar(269843, 8.5) -- Vile Expulsion
	self:Bar(269310, 18) -- Cleansing Light
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:VileExpulsion(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning", "watchwave")
	self:Bar(args.spellId, 15.5)
end

do
	local startTime = 0
	local function printTarget(self, player, guid)
		self:TargetMessage(269310, "green", player)
		self:PlaySound(269310, "long", "runin", player)
		local elapsed = GetTime() - startTime -- Subtract time spent scanning for the target
		self:TargetBar(269310, 5 - elapsed, player)
		self:SecondaryIcon(269310, player)
		if self:Me(guid) then
			self:Say(269310)
			self:OpenProximity(269310, 10, nil, true)
		else
			self:OpenProximity(269310, 10, player, true)
		end
	end
	function mod:CleansingLight(args)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
		self:Bar(args.spellId, 26)
		startTime = GetTime()
	end
	function mod:CleansingLightSuccess(args)
		self:SecondaryIcon(args.spellId)
		self:CloseProximity(args.spellId)
	end
end

function mod:PutridBloodApplied(args)
	if not next(putridBloodList) then
		self:OpenInfo(args.spellId, args.spellName)
	end
	putridBloodList[args.destName] = 1
	self:SetInfoByTable(args.spellId, putridBloodList)
end

function mod:PutridBloodAppliedDose(args)
	putridBloodList[args.destName] = args.amount
	self:SetInfoByTable(args.spellId, putridBloodList)

	-- 1 stack is applied every 8 seconds
	if self:Me(args.destGUID) and args.amount >= 4 and args.amount % 2 == 0 then
		self:StackMessage(args.spellId, args.destName, args.amount, "orange")
		if args.amount < 9 then
			self:PlaySound(args.spellId, "alarm")
		else
			self:PlaySound(args.spellId, "warning")
		end
	end
end

function mod:PutridBloodRemoved(args)
	putridBloodList[args.destName] = nil
	if not next(putridBloodList) then
		self:CloseInfo(args.spellId)
	else
		self:SetInfoByTable(args.spellId, putridBloodList)
	end
end

function mod:VisageDeath()
	visageRemaining = visageRemaining - 1
	self:Message("stages", "cyan", CL.add_remaining:format(visageRemaining), false)
	self:PlaySound("stages", "info")
end
