
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Raigonn", 962, 649)
if not mod then return end
mod:RegisterEnableMob(56877)
mod.engageId = 1419
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Locals
--

local stompCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		111668, -- Battering Headbutt
		111723, -- Fixate
		111728, -- Stomp
	}, {
		["stages"] = "general",
		[111668] = 107118, -- Impervious Carapace
		[111723] = 107146, -- Broken Carapace
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "BatteringHeadbutt", 111668)
	self:Log("SPELL_AURA_APPLIED", "BrokenCarapace", 107146)
	self:Log("SPELL_AURA_APPLIED", "Fixate", 111723)
	self:Log("SPELL_AURA_REMOVED", "FixateRemoved", 111723)
	self:Log("SPELL_CAST_START", "Stomp", 111728)

	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "boss2")
end

function mod:OnEngage()
	self:Message("stages", "cyan", nil, CL.other:format(CL.stage:format(1), self:SpellName(107118)), false)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:BatteringHeadbutt(args)
	self:Message(args.spellId, "orange", "Alarm")
	self:CDBar(args.spellId, 32.5)
end

function mod:BrokenCarapace(args)
	stompCount = 0
	self:Message("stages", "green", "Info", CL.other:format(CL.stage:format(2), args.spellName), false)
	self:CDBar(111723, 3) -- Fixate

	self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", "boss2") -- in case Weak Spot died too fast
end

function mod:Fixate(args)
	self:TargetMessage(args.spellId, args.destName, "red", "Long")
	self:TargetBar(args.spellId, 15, args.destName)
end

function mod:FixateRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:Stomp(args)
	stompCount = stompCount + 1
	self:Message(args.spellId, "yellow", "Alert", CL.count:format(args.spellName, stompCount))
end

function mod:UNIT_HEALTH_FREQUENT(event, unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < 15 then
		self:UnregisterUnitEvent(event, unit)
		self:Message("stages", "green", nil, CL.soon:format(CL.stage:format(2)), false)
	end
end
