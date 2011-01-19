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

local spout1 = nil

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:RegisterEvent("UNIT_HEALTH")
	self:Log("SPELL_AURA_APPLIED", "Waterspout", 75683)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Death("Win", 40586)
end

function mod:OnEngage()
	spout1 = nil
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Waterspout(_, spellId, _, _, spellName)
	self:Bar(75683, spellName, 60, spellId)
	self:DelayedMessage(75683, 50, LW_CL["ends"]:format(spellName, 10), "Attention")
end

function mod:UNIT_HEALTH(_, unit)
	if unit ~= "boss1" then return end
	if UnitName(unit) == self.displayName then
		local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
		if hp < 69 and not spout1 then
			self:Message(75683, LW_CL["soon"]:format(GetSpellInfo(75683)), "Attention")
			spout1 = true
		elseif hp < 36 then
			self:Message(75683, LW_CL["soon"]:format(GetSpellInfo(75683)), "Attention")
			self:UnregisterEvent("UNIT_HEALTH")
		end
	end
end

