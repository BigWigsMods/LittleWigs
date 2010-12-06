-- XXX Ulic: Need some help with this. Either I don't understand the mechanics or something.
-- XXX Ulic: My group got pwnd repeatedly on NORMAL

-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Rajh", "Halls of Origination")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(39378)
mod.toggleOptions = {
	73874, -- Sun Strike
	"bosskill",
}

--------------------------------------------------------------------------------
-- Locals
--

local strike = nil

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:RegisterEvent("UNIT_HEALTH")
	self:Log("SPELL_AURA_APPLIED", "SunStrike", 73874, 90009)

	self:Death("Win", 39378)
end

function mod:OnEngage()
	strike = nil
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:SunStrike(unit, _, _, _, spellName)
	if GetUnitName(unit) == GetUnitName("player") then
		self:Bar(73874, spellName, 20, 73874)
	end
end

function mod:UNIT_HEALTH(_, unit)
	if strike then
		self:UnregisterEvent("UNIT_HEALTH")
		return
	end
	local guid = UnitGUID(unit)
	if not guid then return end
	guid = tonumber((guid):sub(-12, -9), 16)
	if guid == 40586 then
		local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
		if hp <= 55 and not strike then
			self:Message(73874, LCL["soon"]:format(GetSpellInfo(73874)), "Attention")
			strike = true
		end
	end
end