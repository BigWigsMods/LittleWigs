
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("High Inquisitor Whitemane", 1004, 674)
if not mod then return end
mod:RegisterEnableMob(3977, 60040) -- Whitemane, Durand

--------------------------------------------------------------------------------
-- Locals
--

local deaths = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.engage_yell = "My legend begins NOW!"

	L.steel = -5636 -- Flash of Steel
	L.steel_icon = 115629
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		113134, -- Mass Ressurection
		"steel",
		"stages",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "MassRes", 113134)
	self:Log("SPELL_INTERRUPT", "MassResStopped", "*")

	self:Log("SPELL_CAST_SUCCESS", "Sleep", 9256)

	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "Steel", "boss1", "boss2")

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Deaths", 3977, 60040)
end

function mod:OnEngage()
	deaths = 0
	self:MessageOld("stages", "green", nil, CL.other:format(CL.phase:format(1), self:SpellName(-5635)), false) -- Phase 1: Commander Duran
	self:Bar("steel", 10.8, 115629)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:MassRes(args)
	self:MessageOld(args.spellId, "orange", "alarm")
	self:Bar(args.spellId, 10)
end

function mod:MassResStopped(args)
	if args.extraSpellId == 113134 then
		self:StopBar(args.extraSpellName)
	end
end

function mod:Sleep(args)
	self:MessageOld("stages", "green", nil, CL["phase"]:format(3), args.spellId)
	self:Bar("stages", 10, args.spellId)
end

function mod:Steel(_, _, _, spellId)
	if spellId == 115627 then
		self:MessageOld("steel", "yellow", nil, 115629)
		self:CDBar("steel", 26, 115629) -- 26.x - 27.x
	end
end

function mod:Deaths()
	deaths = deaths + 1
	if deaths == 1 then
		self:MessageOld("stages", "green", nil, CL.other:format(CL.phase:format(2), self:SpellName(-5638)), false) -- Phase 2: High Inquisitor Whitemane
		self:StopBar(115629)
	elseif deaths == 3 then
		self:Win()
	end
end

