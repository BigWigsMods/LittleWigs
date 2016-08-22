-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Baron Ashbury", 764)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(46962)
mod.toggleOptions = {
	93712, -- Pain and Suffering
	93710, -- Asphyxiate
	93757, -- Dark Archangel Form
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "PnS", 93712)
	self:Log("SPELL_CAST_SUCCESS", "Asphyxiate", 93710)
	self:Log("SPELL_CAST_START", "Archangel", 93757)

	self:RegisterEvent("UNIT_HEALTH")

	self:Death("Win", 46962)
end

function mod:VerifyEnable()
	if GetInstanceDifficulty() == 2 then return true end
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:PnS(player, spellId, _, _, spellName)
	self:TargetMessage(93712, spellName, player, "Urgent", spellId)
end

function mod:Asphyxiate(_, spellId, _, _, spellName)
	self:Message(93710, spellName, "Important", spellId)
	self:Bar(93710, LW_CL["next"]:format(spellName), 40, spellId)
end

function mod:Archangel(_, spellId, _, _, spellName)
	self:Message(93757, spellName, "Attention", spellId, "Long")
end

function mod:UNIT_HEALTH(_, unit)
	if unit == "boss1" then
		local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
		if hp < 25 then
			self:Message(93757, LW_CL["soon"]:format(GetSpellInfo(93757)), "Attention")
			self:UnregisterEvent("UNIT_HEALTH")
		end
	end
end

