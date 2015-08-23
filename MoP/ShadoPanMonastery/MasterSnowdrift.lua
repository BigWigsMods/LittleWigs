
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Master Snowdrift", 877, 657)
if not mod then return end
mod:RegisterEnableMob(56541)

local phase = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.engage_yell = "Very well then, outsiders. Let us see your true strength."

	-- When I was but a cub I could scarcely throw a punch, but after years of training I can do so much more!
	L.phase3_yell = "was but a cub"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {106434, 118961, 106747, "stages"}
end

function mod:VerifyEnable(unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp > 15 then
		return true
	end
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "TornadoKick", 106434)
	self:Log("SPELL_AURA_APPLIED", "ChaseDown", 118961)
	self:Log("SPELL_AURA_REMOVED", "ChaseDownRemoved", 118961)

	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Yell("Phase3", L["phase3_yell"])

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
end

function mod:OnEngage()
	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", "PhaseWarn", "boss1")
	local tornado = self:SpellName(106434)
	self:CDBar(106434, 15)
	self:Message(106434, "Attention", nil, CL["custom_start_s"]:format(self.displayName, tornado, 15), false)
	phase = 1
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:TornadoKick(args)
	self:Message(args.spellId, "Urgent", "Alert")
	self:Bar(args.spellId, 6.5, CL["cast"]:format(args.spellName)) -- 5s channel + 1.5s cast
end

function mod:ChaseDown(args)
	self:TargetMessage(args.spellId, args.destName, "Important", "Alarm")
	self:TargetBar(args.spellId, 11, args.destName)
end

function mod:ChaseDownRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:Phase3()
	self:Message("stages", "Positive", "Info", CL["phase"]:format(3), 118961)
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, _, spellId)
	if spellId == 110324 then -- Shado-pan Vanish
		if phase == 1 then
			phase = 2
			local mirror = mod:SpellName(106747) -- Shado-pan Mirror Image
			self:Message(106747, "Positive", "Info", (CL["phase"]:format(2))..": "..mirror)
			self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", "PhaseWarn", "boss1")
		else
			self:Message(106747, "Positive")
		end
	elseif spellId == 123096 then -- Master Snowdrift Kill - Achievement
		self:Win()
	end
end

function mod:PhaseWarn(unitId)
	local hp = UnitHealth(unitId) / UnitHealthMax(unitId) * 100
	if hp < 65 and phase == 1 then
		self:Message("stages", "Positive", nil, CL["soon"]:format(CL["phase"]:format(2)), false)
		self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", unitId)
	elseif hp < 35 and phase == 2 then
		self:Message("stages", "Positive", nil, CL["soon"]:format(CL["phase"]:format(3)), false)
		self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", unitId)
	end
end

