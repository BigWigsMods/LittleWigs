-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Daakara", 568, 191)
if not mod then return end
mod:RegisterEnableMob(23863)
mod.engageId = 1194
mod.respawnTime = 30

-------------------------------------------------------------------------------
--  Localization
--

local L = mod:GetLocale()
if L then
	L[42594] = "Bear Form" -- short form for "Essence of the Bear"
	L[42607] = "Lynx Form"
	L[42606] = "Eagle Form"
	L[42608] = "Dragonhawk Form"
end

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		"stages",
		{43093, "ICON"}, -- Grievous Throw
		17207, -- Whirlwind
		43095, -- Creeping Paralysis
		43150, -- Claw Rage
	}, {
		["stages"] = "general",
		[43095] = L[42594],
		[43150] = L[42607],
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "GrievousThrow", 43093)
	self:Log("SPELL_AURA_REMOVED", "GrievousThrowRemoved", 43093)
	self:Log("SPELL_AURA_APPLIED", "Whirlwind", 17207)
	self:Log("SPELL_CAST_SUCCESS", "CreepingParalysis", 43095)
	self:Log("SPELL_AURA_APPLIED", "ClawRage", 43150)
	self:Log("SPELL_CAST_START", "Forms", 42594, 42606, 42607, 42608) -- Bear, Eagle, Lynx, Dragonhawk
end

-------------------------------------------------------------------------------
--  Event Handlers
--

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
	self:Message(args.spellId, "Attention", self:Dispeller("magic") and "Warning", CL.casting:format(args.spellName))
	self:CastBar(args.spellId, 6)
	self:CDBar(args.spellId, 27)
end

function mod:ClawRage(args)
	self:TargetMessage(args.spellId, args.destName, "Important", "Alert")
end

function mod:Forms(args)
	self:Message("stages", "Important", nil, L[args.spellId], args.spellId)
end
