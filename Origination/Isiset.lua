-- XXX English engage trigger!

-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Isiset", "Halls of Origination")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(39587)
mod.toggleOptions = {
	74373, -- Veil of Sky
	74137, -- Supernova
	"split",
	"bosskill",
}

--------------------------------------------------------------------------------
-- Locals
--

local split1, split2 = nil, nil

-------------------------------------------------------------------------------
--  Localization

local L = mod:NewLocale("enUS", true)
if L then
--@do-not-package@
L["engage_trigger"] = ""
L["split"] = "Isiset Split"
L["split_desc"] = "Warn when Isiset Split."
L["split_message"] = "Isiset Split soon!"--@localization(locale="enUS", namespace="Origination/Isiset", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = mod:GetLocale()
BCL = LibStub("AceLocale-3.0"):GetLocale("Big Wigs: Common")

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Veil", 74133, 74372, 74373, 90760, 90761, 90762)
	self:Log("SPELL_AURA_REMOVED", "VeilRemoved", 74133, 74372, 74373, 90760, 90761, 90762)
	self:Log("SPELL_CAST_START", "Supernova", 74136, 74137, 76670, 90758)
	self:RegisterEvent("UNIT_HEALTH")
	self:Yell("Engage", L["engage_trigger"])

	self:Death("Win", 39587)
end

function mod:OnEngage()
	split1, split2 = nil, nil
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Veil(_, spellId, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, spellName) -- cancel running bar from split/normal phases
	self:Message(74373, spellName, "Urgent", spellId)
	self:Bar(74373, spellName, 60, spellId)
end

function mod:VeilRemoved(_, _, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, spellName)
end

function mod:Supernova(_, spellId, _, _, spellName)
	self:Message(74137, LW_CL["casting"]:format(spellName), "Urgent", spellId, "Alert")
	self:Bar(74137, spellName, 3, spellId)
end

function mod:UNIT_HEALTH(_, unit)
	if split1 and split2 then
		self:UnregisterEvent("UNIT_HEALTH")
		return
	end
	local guid = UnitGUID(unit)
	if not guid then return end
	guid = tonumber((guid):sub(-12, -9), 16)
	if guid == 39587 then
		local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
		if hp <= 65 and not split1 then
			self:Message("split", L["split_message"], "Attention")
			split1 = true
		elseif hp <= 35 and not split2 then
			self:Message("split", L["split_message"], "Attention")
			split2 = true
		end
	end
end

