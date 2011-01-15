-- XXX Ulic: Other suggestions?

-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Baron Ashbury", "Shadowfang Keep")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(46962)
mod.toggleOptions = {
	93712, -- Pain and Suffering
	93710, -- Asphyxiate
	93713, -- Mend Rotten Flesh
	93757, -- Dark Archangel Form
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "PnS", 93712)
	self:Log("SPELL_AURA_REMOVED", "PnSRemoved", 93712)
	self:Log("SPELL_CAST_SUCCESS", "Asphyxiate", 93710)
	self:Log("SPELL_CAST_START", "Flesh", 93713)
	self:Log("SPELL_CAST_START", "Archangel", 93757)

	self:Death("Win", 46962)
end

function mod:VerifyEnable()
	if GetInstanceDifficulty() == 2 then return true end
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:PnS(player, spellId, _, _, spellName)
	self:Message(93712, spellName..": "..player, "Urgent", spellId)
	self:Bar(93712, player..": "..spellName, 12, spellId)
end

function mod:PnSRemoved(player, _, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, player..": "..spellName)
end

function mod:Asphyxiate(_, spellId, _, _, spellName)
	self:Message(93710, spellName, "Attention", spellId)
	self:Bar(93710, LW_CL["next"]:format(spellName), 40, spellId)
end

function mod:Flesh(_, spellId, _, _, spellName)
	self:Message(93713, spellName, "Important", spellId, "Alert")
end

function mod:Archangel(_, spellId, _, _, spellName)
	self:Message(93757, spellName, "Positive", spellId)
end

