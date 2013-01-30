
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Taran Zhu", 877, 686)
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
	return {115002, {107087, "FLASHSHAKE"}, 107356, "bosskill"}
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
			self:Message(args.spellId, args.spellName, "Urgent", args.spellId, "Info")
		end
	end
end

function mod:HazeOfHate(args)
	if UnitIsUnit(args.destName, "player") then
		self:LocalMessage(args.spellId, CL["you"]:format(args.spellName), "Personal", args.spellId, "Long")
		self:FlashShake(args.spellId)
	end
end

function mod:RisingHateStart(args)
	self:Message(args.spellId, CL["cast"]:format(args.spellName), "Important", args.spellId, "Alert")
	self:Bar(args.spellId, CL["cast"]:format(args.spellName), 5, args.spellId)
	self:Bar(args.spellId, "~"..args.spellName, 16.5, args.spellId) -- 16-19
end

function mod:RisingHateStop(args)
	self:StopBar(CL["cast"]:format(args.spellName))
end

