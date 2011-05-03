-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Rajh", 759)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(39378)
mod.toggleOptions = {73874, 80352, {76355, "FLASHSHAKE"}, "bosskill"}

--------------------------------------------------------------------------------
-- Locals
--

local strike = 0
local blessingTime = 0

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "SunStrike", 73872, 89887)
	self:Log("SPELL_AURA_APPLIED", "Orb", 80352)
	self:Log("SPELL_AURA_APPLIED", "Blessing", 76355, 89879)
	self:RegisterEvent("UNIT_POWER")

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Death("Win", 39378)
end

function mod:OnEngage()
	strike = 0
	blessingTime = 0
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:SunStrike(_, spellId, _, _, spellName)
	self:LocalMessage(73874, spellName, "Attention", spellId)
end

function mod:Orb(_, spellId, _, _, spellName)
	self:Message(80352, spellName, "Urgent", spellId)
end

function mod:Blessing(player, spellId, _, _, spellName)
	if UnitIsUnit(player, "player") then
		self:Message(76355, spellName, "Important", spellId, "Alert")
		self:FlashShake(76355)
		strike = strike + 1
	end
end

function mod:UNIT_POWER(_, unit)
	if unit ~= "boss1" then return end
	if strike == 2 then
		self:UnregisterEvent("UNIT_POWER")
		return
	end
	if UnitName(unit) == self.displayName then
		local power = UnitPower(unit) / UnitPowerMax(unit) * 100
		if power < 20 and strike < 2 and (GetTime() - blessingTime) > 20 then -- massive throttling as energy fills up again, needs testing
			self:Message(76355, LW_CL["soon"]:format(GetSpellInfo(76355)), "Attention")
			blessingTime = GetTime()
		end
	end
end

