-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Isiset", 759)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(39587)
mod.toggleOptions = {74373, 74137, "split", "bosskill"}

--------------------------------------------------------------------------------
-- Locals
--

local split1 = nil

-------------------------------------------------------------------------------
--  Localization

local L = mod:GetLocale()
if L then
	L["split"] = "Isiset Split"
	L["split_desc"] = "Warn when Isiset Split."
	L["split_message"] = "Isiset Split soon!"
end

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Veil", 74133, 74372, 74373, 90760, 90761, 90762)
	self:Log("SPELL_AURA_REMOVED", "VeilRemoved", 74133, 74372, 74373, 90760, 90761, 90762)
	self:Log("SPELL_CAST_START", "Supernova", 74136, 74137, 76670, 90758)

	self:RegisterEvent("UNIT_HEALTH")
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Win", 39587)
end

function mod:OnEngage()
	split1 = nil
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Veil(_, spellId, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, spellName) -- cancel running bar from split/normal phases
	self:Message(74373, spellName, "Attention", spellId)
	self:Bar(74373, LW_CL["next"]:format(spellName), 60, spellId)
end

function mod:VeilRemoved(_, _, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, LW_CL["next"]:format(spellName))
end

function mod:Supernova(_, spellId, _, _, spellName)
	self:Message(74137, LW_CL["casting"]:format(spellName), "Important", spellId, "Alert")
	self:Bar(74137, LW_CL["casting"]:format(spellName), 3, spellId)
end

function mod:UNIT_HEALTH(_, unit)
	if unit == "boss1" and UnitName(unit) == self.displayName then
		local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
		if hp < 72 and not split1 then
			self:Message("split", L["split_message"], "Attention")
			split1 = true
		elseif hp < 39 then
			self:Message("split", L["split_message"], "Attention")
			self:UnregisterEvent("UNIT_HEALTH")
		end
	end
end

