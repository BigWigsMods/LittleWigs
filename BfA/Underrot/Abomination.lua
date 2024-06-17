--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Unbound Abomination", 1841, 2158)
if not mod then return end
mod:RegisterEnableMob(133007, 134419) -- Unbound Abomination, Titan Keeper Hezrel
mod:SetEncounterID(2123)
mod:SetRespawnTime(20)

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
		269310, -- Cleansing Light
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "VileExpulsion", 269843)
	self:Log("SPELL_CAST_START", "CleansingLight", 269310)
	self:Log("SPELL_AURA_APPLIED", "PutridBloodApplied", 269301)
	self:Log("SPELL_AURA_APPLIED_DOSE", "PutridBloodAppliedDose", 269301)
	self:Log("SPELL_AURA_REMOVED", "PutridBloodRemoved", 269301)
	self:RegisterUnitEvent("UNIT_POWER_UPDATE", nil, "boss1")
	self:Death("VisageDeath", 137103)
end

function mod:OnEngage()
	putridBloodList = {}
	visageRemaining = 6
	self:Bar(269843, 8.3) -- Vile Expulsion
	self:CDBar(269310, 18.0) -- Cleansing Light
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:VileExpulsion(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning", "watchwave")
	self:Bar(args.spellId, 15.8)
end

function mod:CleansingLight(args)
	-- the boss frame for Titan Keeper Hezrel was removed, so target scanning is no longer possible
	self:Message(args.spellId, "green")
	self:PlaySound(args.spellId, "long")
	-- use a CDBar because the Hezrel's casts can be delayed by the Purge Corruption channel
	if self:Normal() then
		self:CDBar(args.spellId, 16.2)
	else
		self:CDBar(args.spellId, 17.0)
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
		self:StackMessage(args.spellId, "orange", args.destName, args.amount, 10)
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

function mod:UNIT_POWER_UPDATE(_, unit)
	if UnitPower(unit) == 0 then
		self:Message("stages", "yellow", CL.adds_spawning, false)
		self:PlaySound("stages", "info")
	end
end

function mod:VisageDeath()
	visageRemaining = visageRemaining - 1
	if visageRemaining > 0 then
		self:Message("stages", "cyan", CL.add_remaining:format(visageRemaining), false)
		self:PlaySound("stages", "info")
	end
end
