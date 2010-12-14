-- XXX Ulic: Not yet implemented

-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Lord Godfrey", "Shadowfang Keep")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(1)
mod.toggleOptions = {
	93675, -- Mortal Wound
	93629, -- Cursed Bullets
	93707, -- Summon Bloodthirsty Ghouls
	93520, -- Pistol Barrage
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "MortalWound", 93675)
	self:Log("SPELL_AURA_APPLIED", "CursedBullets", 93629)
	self:Log("SPELL_AURA_APPLIED_DOSE", "CursedBullets", 93629)
	self:Log("SPELL_AURA_REMOVED", "CBRemoved", 93629)
	self:Log("SPELL_AURA_APPLIED", "Summon", 93707)
	self:Log("SPELL_CAST_START", "Barrage", 93520)
	
	self:Death("Win", 1)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:MortalWound(player, spellId, _, _, spellName)
	self:Message(93675, spellName..": "..player, "Urgent", spellId)
	self:Bar(93675, player..": "..spellName, 6, spellId)
end

function mod:CursedBullets(player, spellId, _, _, spellName)
	self:Message(93629, spellName..": "..player, "Urgent", spellId)
	self:Bar(93629, player..": "..spellName, 15, spellId)
end

function mod:CBRemoved(player, _, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, player..": "..spellName)
end

function mod:Summon(_, spellId, _, _, spellName)
	self:Message(93707, spellName, "Alert", spellId)
end

function mod:Barrage(_, spellId, _, _, spellName)
	self:Message(93520, spellName, "Info", spellId)
	self:Bar(93520, LCL["next"]:format(spellName, 30), spellId)
end
