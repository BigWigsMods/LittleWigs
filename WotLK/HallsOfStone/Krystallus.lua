-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Krystallus", 526)
if not mod then return end
mod.partycontent = true
mod.otherMenu = "The Storm Peaks"
mod:RegisterEnableMob(27977)
mod.toggleOptions = {
	50810, -- Shatter
}

-------------------------------------------------------------------------------
--  Localization

local L = mod:GetLocale()
if L then
	L["shatterBar_message"] = "~Shatter"
	L["shatter_warn"] = "Ground Slam - Shatter in ~8 sec"
end

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Slam", 50833)
	self:Log("SPELL_CAST_START", "Shatter", 50810, 61546)
	self:Death("Win", 27977)
end

----------------------------------
-------------------------------------------------------------------------------
--  Event Handlers

function mod:Slam(_, spellId, _, _, spellName)
	self:Message(50810, L["shatter_warn"], "Urgent", spellId)
	self:Bar(50810, L["shatterBar_message"], 8, spellId)
end

function mod:Shatter(_, spellId, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, L["shatterBar_message"])
	self:Message(50810, spellName, "Urgent", spellId)
end
