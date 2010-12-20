
-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Rajh", "Halls of Origination")
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

	self:Death("Win", 39378)
end

function mod:OnEngage()
	strike = 0
	blessingTime = 0
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:SunStrike(_, spellId, _, _, spellName)
	self:LocalMessage(73874, spellName, "Personal", spellId, "Info")
end

function mod:Orb(_, spellId, _, _, spellName)
	self:Message(80352, spellName, "Important", spellId)
end

function mod:Blessing(player, spellId, _, _, spellName)
	if UnitIsUnit(player, "player")
		self:Message(76355, spellName, "Urgent", spellId, "Alert")
		self:FlashShake(76355)
	end
end

function mod:UNIT_POWER(_, unit)
	if strike = 2 then
		self:UnregisterEvent("UNIT_POWER")
		return
	end
	local guid = UnitGUID(unit)
	if not guid then return end
	guid = tonumber((guid):sub(-12, -9), 16)
	if guid == 40586 then
		local power = UnitPower(unit) / UnitPowerMax(unit) * 100
		if power <= 20 and strike <= 1 and (GetTime() - blessingTime) > 20 then -- massive throttling as energy fills up again, needs testing
			self:Message(76355, LW_CL["soon"]:format(GetSpellInfo(76355)), "Attention")
			strike = strike + 1
			blessingTime = GetTime()
		end
	end
end

