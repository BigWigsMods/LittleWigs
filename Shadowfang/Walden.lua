-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Lord Walden", 764)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(46963)
mod.toggleOptions = {
	93527, -- Ice Shards
	93702, -- Conjure Frost Mixture
	93704, -- Conjure Poisonous Mixture
	93617, -- Toxic Coagulant
	93689, -- Toxic Catalyst
	"bosskill",
}

-------------------------------------------------------------------------------
--  Locals

local coagulantTime = 0

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "IceShards", 93527)
	self:Log("SPELL_CAST_START", "Frost", 93702)
	self:Log("SPELL_CAST_START", "Poisonous", 93704)
	self:Log("SPELL_AURA_APPLIED", "Coagulant", 93572, 93617)
	self:Log("SPELL_AURA_APPLIED", "Catalyst", 93573, 93689)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Win", 46963)
end

function mod:VerifyEnable()
	if GetInstanceDifficulty() == 2 then return true end
end

function mod:OnEngage()
	coagulantTime = 0
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:IceShards(_, spellId, _, _, spellName)
	self:Message(93527, spellName, "Attention", spellId)
end

function mod:Frost(_, spellId, _, _, spellName)
	self:Message(93702, LW_CL["casting"]:format(spellName), "Important", spellId)
end

function mod:Poisonous(_, spellId, _, _, spellName)
	self:Message(93704, LW_CL["casting"]:format(spellName), "Important", spellId)
end

function mod:Coagulant(player, spellId, _, _, spellName)
	if UnitIsUnit(player, "player") and (GetTime() - coagulantTime > 5) then
		self:Message(93617, spellName, "Urgent", spellId, "Alert")
		coagulantTime = GetTime()
	end
end

function mod:Catalyst(player, spellId, _, _, spellName)
	if UnitIsUnit(player, "player") then
		self:Message(93689, spellName, "Urgent", spellId, "Alert")
	end
end

