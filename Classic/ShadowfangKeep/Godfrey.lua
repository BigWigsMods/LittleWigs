-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Lord Godfrey", 764)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(46964)
mod.toggleOptions = {
	93771, -- Mortal Wound
	93707, -- Summon Bloodthirsty Ghouls
	93520, -- Pistol Barrage
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "MortalWound", 93771)
	self:Log("SPELL_AURA_APPLIED", "Summon", 93707)
	self:Log("SPELL_CAST_START", "Barrage", 93520)

	self:Death("Win", 46964)
end

function mod:VerifyEnable()
	if GetInstanceDifficulty() == 2 then return true end
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:MortalWound(player, spellId, _, _, spellName)
	self:TargetMessage(93771, spellName, player, "Attention", spellId)
end

function mod:Summon(_, spellId, _, _, spellName)
	self:Message(93707, spellName, "Attention", spellId, "Info")
end

function mod:Barrage(_, spellId, _, _, spellName)
	self:Message(93520, spellName, "Important", spellId, "Alert")
	self:Bar(93520, LW_CL["next"]:format(spellName), 30, spellId)
end

