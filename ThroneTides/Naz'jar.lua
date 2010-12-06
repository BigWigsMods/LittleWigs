-- XXX Ulic: Other suggestions?

-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Lady Naz'jar", "Throne of the Tides")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(40586)
mod.toggleOptions = {
	75683, -- Waterspout
	"bosskill",
}

--------------------------------------------------------------------------------
-- Locals
--

local spout1, spout2 = nil, nil

-------------------------------------------------------------------------------
--  Localization

LCL = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Common")

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:RegisterEvent("UNIT_HEALTH")
	self:Log("SPELL_AURA_APPLIED", "Waterspout", 75683)

	self:Death("Win", 40586)
end

function mod:OnEngage()
	spout1, spout2 = nil, nil
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Waterspout(_, spellId, _, _, spellName)
	self:Bar(75683, spellName, 60, spellId)
	mod:DelayedMessage(75683, 50, LCL["ends"]:format(spellName, 10), "Attention")
end

function mod:UNIT_HEALTH(_, unit)
	if spout1 and spout2 then
		self:UnregisterEvent("UNIT_HEALTH")
		return
	end
	local guid = UnitGUID(unit)
	if not guid then return end
	guid = tonumber((guid):sub(-12, -9), 16)
	if guid == 40586 then
		local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
		if hp <= 55 and not spout1 then
			self:Message(75683, LCL["soon"]:format(GetSpellInfo(75683)), "Attention")
			spout1 = true
		elseif hp <= 35 and not spout2 then
			self:Message(75683, LCL["soon"]:format(GetSpellInfo(75683)), "Attention")
			spout2 = true
		end
	end
end