-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Lord Walden", "Shadowfang Keep")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(46963)
mod.toggleOptions = {
	93527, -- Ice Shards
	93702, -- Conjure Frost Mixture
	93704, -- Conjure Poisonous Mixture
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "IceShards", 93527)
	self:Log("SPELL_CAST_START", "Frost", 93702)
	self:Log("SPELL_CAST_START", "Poisonous", 93704)

	self:Death("Win", 4278)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:IceShards(_, spellId, _, _, spellName)
	self:Message(93527, spellName, "Info", spellId)
	self:Bar(93527, spellName, 5, spellId)
end

function mod:Frost(_, spellId, _, _, spellName)
	self:Message(93702, spellName, "Alert", spellId)
end

function mod:Poisonous(_, spellId, _, _, spellName)
	self:Message(93704, spellName, "Alert", spellId)
end
