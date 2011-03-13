-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Halazzi", "Zul'Aman")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(23577)
mod.toggleOptions = {
	"phase",
	97490,
	43139,
	97492,
	97500,
	"bosskill",
}

--------------------------------------------------------------------------------
--  Locals

local one, two, three = nil, nil, nil
local count = 1

-------------------------------------------------------------------------------
--  Localization

local L = mod:NewLocale("enUS", true)
if L then
--@do-not-package@
L["phase"] = "Phases"
L["phase_desc"] = "Warn for phase changes."
L["spirit_soon"] = "Spirit Phase soon!"
L["spirit_message"] = "%d% HP! - Spirit Phase!"
L["normal_message"] = "Normal Phase!"
L["spirit_trigger"] = "I fight wit' untamed spirit...."
L["normal_trigger"] = "Spirit, come back to me!"
--@localization(locale="enUS", namespace="ZulAman/Halazzi", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = mod:GetLocale()

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Shock", 97490)
	self:Log("SPELL_AURA_REMOVED", "ShockRemoved", 90004)
	self:Log("SPELL_AURA_APPLIED", "Frenzy", 43139)
	self:Log("SPELL_CAST_START", "LightingTotem", 97492)
	self:Log("SPELL_CAST_START", "WaterTotem", 97500)
	
	self:Yell("Spirit", L["spirit_trigger"])
	self:Yell("Normal", L["normal_trigger"])
	
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	
	self:Death("Win", 23577)
end

function mod:OnEngage()
	self:Berserk(600)
	one, two, three = nil, nil, nil
	count = 1
	self:RegisterEvent("UNIT_HEALTH")
end

-------------------------------------------------------------------------------
--  Event Handlers

do
	function mod:Shock(player, spellId, _, _, spellName)
		self:TargetMessage(97490, spellName, player, "Attention", spellId, "Alert")
		self:Bar(97490, spellName..": "..player, 12, spellId)
	end

	function mod:ShockRemoved(player, _, _, _, spellName)
		self:SendMessage("BigWigs_StopBar", self, spellName..": "..player)
	end
end

function mod:Frenzy(_, spellId, _, _, spellName)
	self:Message(43139, spellName, "Important", spellId, "Long")
	self:Bar(43139, spellName, 6, spellId)
end

function mod:LightingTotem(_, spellId, _, _, spellName)
	self:Message(97492, spellName, "Attention", spellId)
end

function mod:WaterTotem(_, spellId, _, _, spellName)
	self:Message(97500, spellName, "Attention", spellId)
end

function mod:Spirit()
	if count == 1 then
		self:Message("phase", L["spirit_message"]:format(75), "Positive", 24183)
		count = count + 1
	elseif count == 2 then
		self:Message("phase", L["spirit_message"]:format(50), "Positive", 24183)
		count = count + 1
	elseif count == 3 then
		self:Message("phase", L["spirit_message"]:format(25), "Positive", 24183)
	end
	self:Bar("phase", L["normal_message"], 50, 24183)
end

function mod:Normal()
	self:Message("phase", L["normal_message"], "Important", 89259)
end

function mod:UNIT_HEALTH()
	if unit == "boss1" and UnitName(unit) == self.displayName then
		local hp = UnitHealth("boss1") / UnitHealthMax("boss1") * 100
		if hp > 77 and hp <= 80 and not one then
			one = true
			self:Message("phase", L["spirit_soon"], "Attention")
		elseif hp > 52 and hp <= 55 and not two then
			two = true
			self:Message("phase", L["spirit_soon"], "Attention")
		elseif hp > 27 and hp <= 30 and not three then
			three = true
			self:Message("phase", L["spirit_soon"], "Attention")
			self:UnregisterEvent("UNIT_HEALTH")
		end
	end
end

