
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Sha of Doubt", 867, 335)
if not mod then return end
mod:RegisterEnableMob(56439)

local canEnable = true

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

function mod:VerifyEnable()
	return canEnable
end

function mod:OnBossEnable()
	self:Log("SPELL_SUMMON", "GrippingHatred", 115002)
	self:Log("SPELL_AURA_APPLIED", "HazeOfHate", 107087)
	self:Log("SPELL_AURA_APPLIED", "RisingHateStart", 107356)
	self:Log("SPELL_AURA_REMOVED", "RisingHateStop", 107356)

	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
end

function mod:OnWin()
	canEnable = false
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, unitId, _, _, _, spellId)
	if spellId == 125920 and unitId == "boss1" then -- Kneel
		self:Win()
	end
end

do
	local prev = 0
	function mod:GrippingHatred(_, spellId, _, _, spellName)
		local t = GetTime()
		if t-prev > 5 then
			prev = t
			self:Message(115002, spellName, "Urgent", spellId, "Info")
		end
	end
end

function mod:HazeOfHate(player, spellId, _, _, spellName)
	if UnitIsUnit(player, "player") then
		self:Message(107087, CL["you"]:format(spellName), "Personal", spellId, "Long")
		self:Flash(107087)
	end
end

function mod:RisingHateStart(_, spellId, _, _, spellName)
	self:Message(107356, CL["casting"]:format(spellName), "Important", spellId, "Alert")
	self:Bar(107356, CL["cast"]:format(spellName), 5, spellId)
	self:Bar(107356, "~"..spellName, 16.5, spellId) -- 16-19
end

function mod:RisingHateStop(_, spellId, _, _, spellName)
	self:StopBar(CL["cast"]:format(spellName))
end

