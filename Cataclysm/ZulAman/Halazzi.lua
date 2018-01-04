-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Halazzi", 781)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(23577)
mod.toggleOptions = {
	"phase",
	97490, -- Flameshock
	43139, -- Enrage
	97492, -- Lightning Totem
	97500, -- Water Totem
	"bosskill",
}

--------------------------------------------------------------------------------
--  Locals

local spirit = false
local count = true

-------------------------------------------------------------------------------
--  Localization

local L = mod:GetLocale()
if L then
	L["phase"] = "Phases"
	L["phase_desc"] = "Warn for phase changes."
	L["spirit_soon"] = "Spirit Phase soon!"
	L["spirit_message"] = "%d%% - Spirit Phase!"
	L["normal_message"] = "Normal Phase!"
	L["spirit_trigger"] = "I fight wit' untamed spirit...."
	L["normal_trigger"] = "Spirit, come back to me!"
end

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Shock", 97490)
	self:Log("SPELL_AURA_REMOVED", "ShockRemoved", 97490)
	self:Log("SPELL_AURA_APPLIED", "Frenzy", 43139)
	self:Log("SPELL_CAST_START", "LightingTotem", 97492)
	self:Log("SPELL_CAST_START", "WaterTotem", 97500)

	self:Yell("Spirit", L["spirit_trigger"])
	self:Yell("Normal", L["normal_trigger"])

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Win", 23577)
end

function mod:OnEngage()
	spirit = false
	count = true
	self:RegisterEvent("UNIT_HEALTH")
end

-------------------------------------------------------------------------------
--  Event Handlers

do
	function mod:Shock(player, spellId, _, _, spellName)
		self:TargetMessage(97490, spellName, player, "Attention", spellId, "Alarm")
		self:Bar(97490, spellName..": "..player, 12, spellId)
	end
	function mod:ShockRemoved(player, _, _, _, spellName)
		self:SendMessage("BigWigs_StopBar", self, spellName..": "..player)
	end
end

function mod:Frenzy(_, spellId, _, _, spellName)
	self:Message(43139, spellName, "Important", spellId)
end

function mod:LightingTotem(_, spellId, _, _, spellName)
	self:Message(97492, LW_CL["casting"]:format(spellName), "Urgent", spellId, "Alert")
end

function mod:WaterTotem(_, spellId, _, _, spellName)
	self:Message(97500, LW_CL["casting"]:format(spellName), "Urgent", spellId, "Alert")
end

function mod:Spirit()
	if count then
		self:Message("phase", L["spirit_message"]:format(66), "Positive", 24183)
		count = false
	else
		self:Message("phase", L["spirit_message"]:format(33), "Positive", 24183)
	end
end

function mod:Normal()
	self:Message("phase", L["normal_message"], "Positive", 89259)
end

function mod:UNIT_HEALTH()
	local hp = UnitHealth("boss1") / UnitHealthMax("boss1") * 100
	if hp > 69 and hp <= 71 and not spirit then
		self:Message("phase", L["spirit_soon"], "Attention")
		spirit = true
	elseif hp > 36 and hp <= 38 and spirit then
		self:Message("phase", L["spirit_soon"], "Attention")
		self:UnregisterEvent("UNIT_HEALTH")
	end
end

