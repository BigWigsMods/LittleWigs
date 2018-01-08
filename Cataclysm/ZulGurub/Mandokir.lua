-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Bloodlord Mandokir", 793)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(52151, 52157)
mod.toggleOptions = {
	"rebirth",
	96740, -- Devastating Slam
	96684, -- Decapitate
	96776, -- Bloodletting
	96800, -- Frenzy
	96724, -- Reanimate Ohgan
	"bosskill",
}

--------------------------------------------------------------------------------
--  Locals

local rebirthcount = 8

-------------------------------------------------------------------------------
--  Localization

local L = mod:GetLocale()
if L then
	L["rebirth"] = "Ghost rebirth"
	L["rebirth_desc"] = "Warn for Ghost rebirth remaining."
	L["rebirth_message"] = "Ghost rebirth - %d left"
	L["Ohgan_message"] = "Ohgan rebirth!"
end

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Rebirth", 96484)
	self:Log("SPELL_CAST_START", "Slam", 96740)
	self:Log("SPELL_CAST_SUCCESS", "Decapitate", 96684)
	self:Log("SPELL_AURA_APPLIED", "Blood", 96776)
	self:Log("SPELL_AURA_APPLIED", "Frenzy", 96800)
	self:Log("SPELL_HEAL", "OhganRebirth", 96724)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Deaths", 52151, 52156)
end

function mod:OnEngage()
	rebirthcount = 8
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Rebirth(_, spellId)
	rebirthcount = rebirthcount - 1
	self:Message("rebirth", L["rebirth_message"]:format(rebirthcount), "Attention", spellId, "Alarm")
end

function mod:Slam(_, spellId, _, _, spellName)
	self:Message(96740, spellName, "Important", spellId, "Info")
end

function mod:Decapitate(player, spellId, _, _, spellName)
	self:TargetMessage(96684, spellName, player, "Attention", spellId, "Alert")
	self:Bar(96684, LW_CL["next"]:format(GetSpellInfo(96684)), 30, spellId)
end

function mod:Blood(player, spellId, _, _, spellName)
	self:Message(96776, spellName, "Attention", spellId, "Alert")
	self:Bar(96776, spellName..": "..player, 10, spellId)
	self:Bar(96776, LW_CL["next"]:format(GetSpellInfo(96776)), 25, spellId)
end

function mod:Frenzy(_, spellId, _, _, spellName)
	self:Message(96800, spellName, "Important", spellId, "Long")
end

function mod:OhganRebirth(_, spellId)
	self:Message(96724, L["Ohgan_message"], "Attention", spellId, "Info")
end

function mod:Deaths(mobId)
	if mobId == 52156 then
		rebirthcount = rebirthcount - 1
		self:Message("rebirth", L["rebirth_message"]:format(rebirthcount), "Attention", spellId, "Alarm")
	elseif mobId == 52151 then
		self:Win()
	end
end

