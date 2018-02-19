-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Falric", 668, 601)
if not mod then return end
--mod.otherMenu = "The Frozen Halls"
mod:RegisterEnableMob(38112)

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		{72426, "ICON"}, -- Impending Despair
		{72422, "ICON"}, -- Quivering Strike
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "DebuffApplied", 72422, 72426) -- Quivering Strike, Impending Despair
	self:Log("SPELL_AURA_REMOVED", "DebuffRemoved", 72422, 72426)
	self:Death("Win", 38112)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:DebuffApplied(args)
	local time = 5
	if args.spellId == 72422 then -- Quivering Strike
		self:PrimaryIcon(args.spellId, args.destName)
	elseif args.spellId == 72426 then -- Impending Despair
		time = 6
		self:SecondaryIcon(args.spellId, args.destName)
	end
	self:TargetMessage(args.spellId, args.destName, "Urgent")
	self:TargetBar(args.spellId, time, args.destName)
end

function mod:DebuffRemoved(args)
	self:StopBar(args.spellId, args.destName)
	self:PrimaryIcon(args.spellId)
	self:SecondaryIcon(args.spellId)
end
