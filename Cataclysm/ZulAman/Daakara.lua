-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Daakara", 568, 191)
if not mod then return end
mod:RegisterEnableMob(23863)

-------------------------------------------------------------------------------
--  Localization

local L = mod:GetLocale()
if L then
	L.form = "Phases"
	L.form_desc = "Warn when Daakara changes form."
	L[42594] = "Bear Form!" -- short form for "Essence of the Bear"
	L[42606] = "Eagle Form!"
	L[42607] = "Lynx Form!"
	L[42608] = "Dragonhawk Form!"
end

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		"form",
		{97639, "ICON"}, -- Grievous Throw
		17207, -- Whirlwind
		43095, -- Creeping Paralysis
		43150, -- Claw Rage
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "GrievousThrow", 97639)
	self:Log("SPELL_AURA_REMOVED", "GrievousThrowRemoved", 97639)
	self:Log("SPELL_AURA_APPLIED", "Whirlwind", 17207)
	self:Log("SPELL_CAST_SUCCESS", "CreepingParalysis", 43095)
	self:Log("SPELL_AURA_APPLIED", "ClawRage", 43150)
	self:Log("SPELL_CAST_START", "Forms", 42594, 42606, 42607, 42608) -- Bear, Eagle, Lynx, Dragonhawk

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Death("Win", 23863)
end

-------------------------------------------------------------------------------
--  Event Handlers

do
	function mod:GrievousThrow(args)
		self:TargetMessage(args.spellId, args.destName, "Attention", "Alarm")
		self:TargetBar(args.spellId, 15, args.destName)
		self:PrimaryIcon(args.spellId, args.destName)
	end
	function mod:GrievousThrowRemoved(args)
		self:StopBar(args.spellId, args.destName)
		self:PrimaryIcon(args.spellId)
	end
end

function mod:Whirlwind(args)
	self:Message(args.spellId, "Urgent")
end

function mod:CreepingParalysis(args)
	self:Message(args.spellId, "Attention", nil, CL.casting:format(args.spellName))
	self:CastBar(args.spellId, 6)
	self:CDBar(args.spellId, 27)
end

function mod:ClawRage(args)
	self:TargetMessage(args.spellId, args.destName, "Important", "Alert")
end

function mod:Forms(args)
	self:Message("form", "Important", nil, L[args.spellId], args.spellId)
end
