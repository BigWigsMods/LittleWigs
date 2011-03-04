--------------------------------------------------------------------------------
-- Module Declaration
--

local mod = BigWigs:NewBoss("High Priestess Jeklik", "Zul'Gurub")
if not mod then return end
mod:RegisterEnableMob(14517)
mod.toggleOptions = {23918, 23954, "bomb", "bosskill"}

--------------------------------------------------------------------------------
-- Localization
--

local L = LibStub("AceLocale-3.0"):NewLocale("Big Wigs: High Priestess Jeklik", "enUS", true)
if L then
	L.bomb = "Bomb Bats"
	L.bomb_desc = "Warn for Bomb Bats"
	L.bomb_message = "Incoming bomb bats!"
end
L = LibStub("AceLocale-3.0"):GetLocale("Big Wigs: High Priestess Jeklik")
mod.locale = L

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Heal", 23954)
	self:Log("SPELL_INTERRUPT", "HealStop")
	self:Log("SPELL_CAST_SUCCESS", "Silence", 23918)
	self:Log("SPELL_AURA_APPLIED", "Bats", 23968)
	self:Death("Win", 14517)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Heal(_, spellId, _, _, spellName)
	self:Message(spellId, spellName, "Urgent", spellId)
end

function mod:HealStop(_, spellId, source, secSpellId, spellName)
	if secSpellId == 23954 then
		self:TargetMessage(23954, "%2$s: %1$s", source, "Positive", spellId, nil, spellName)
		self:SendMessage("BigWigs_StopBar", self, GetSpellInfo(secSpellId))
	end
end

function mod:Silence(_, spellId, _, _, spellName)
	self:Message(spellId, spellName, "Important", spellId)
	self:Bar(spellId, spellName, 10, spellId)
end

function mod:Bats()
	self:Message("bomb", L["bomb_message"], "Attention")
end

