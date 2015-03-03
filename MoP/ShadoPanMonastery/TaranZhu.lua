
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Taran Zhu", 877, 686)
if not mod then return end
mod:RegisterEnableMob(56884)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.engage_yell = "Hatred will consume and conquer all!"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {115002, {107087, "FLASH"}, 107356}
end

function mod:VerifyEnable(unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp > 15 then
		return true
	end
end

function mod:OnBossEnable()
	self:Log("SPELL_SUMMON", "GrippingHatred", 115002)
	self:Log("SPELL_AURA_APPLIED", "HazeOfHate", 107087)
	self:Log("SPELL_AURA_APPLIED", "RisingHateStart", 107356)
	self:Log("SPELL_AURA_REMOVED", "RisingHateStop", 107356)

	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "Kneel", "boss1")

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Kneel(_, _, _, _, spellId)
	if spellId == 125920 then -- Kneel
		self:Win()
	end
end

do
	local prev = 0
	function mod:GrippingHatred(args)
		local t = GetTime()
		if t-prev > 5 then
			prev = t
			self:Message(args.spellId, "Urgent", "Info")
		end
	end
end

function mod:HazeOfHate(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "Personal", "Long", CL["you"]:format(args.spellName))
		self:Flash(args.spellId)
	end
end

function mod:RisingHateStart(args)
	self:Message(args.spellId, "Important", "Warning", CL["casting"]:format(args.spellName))
	self:Bar(args.spellId, 5, CL["cast"]:format(args.spellName))
	self:CDBar(args.spellId, 16.5) -- 16-19
end

function mod:RisingHateStop(args)
	self:StopBar(CL["cast"]:format(args.spellName))
end

