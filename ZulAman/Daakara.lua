-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Daakara", "Zul'Aman")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(23863)
mod.toggleOptions = {
	"form",
	{97639, "ICON"},
	17207,
	43095,
	{43150, "ICON"},
	"bosskill",
}

-------------------------------------------------------------------------------
--  Localization

local L = mod:NewLocale("enUS", true)
if L then
--@do-not-package@
L["form"] = "Phases"
L["form_desc"] = "Warn when Daakara changes form."
L["bear_trigger"] = "Got me some new tricks... like me brudda bear...."
L["bear_message"] = "Bear Form!"
L["eagle_trigger"] = "Dere be no hidin' from da eagle!"
L["eagle_message"] = "Eagle Form!"
L["lynx_trigger"] = "Let me introduce you to me new bruddas: fang and claw!"
L["lynx_message"] = "Lynx Form!"
L["dragonhawk_trigger"] = "Ya don' have to look to da sky to see da dragonhawk!"
L["dragonhawk_message"] = "Dragonhawk Form!"
--@localization(locale="enUS", namespace="ZulAman/Daakara", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = mod:GetLocale()

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Whirlwind", 17207)
	self:Log("SPELL_AURA_APPLIED", "Throw", 97639)
	self:Log("SPELL_AURA_REMOVED", "ThrowRemoved", 97639)
	self:Log("SPELL_CAST_SUCCESS", "Paralyze", 43095)
	self:Log("SPELL_AURA_APPLIED", "ClawRage", 43150)
	self:Log("SPELL_AURA_REMOVED", "ClawRemoved", 43150)

	self:Yell("Form1", L["bear_trigger"])
	self:Yell("Form2", L["eagle_trigger"])
	self:Yell("Form3", L["lynx_trigger"])
	self:Yell("Form4", L["dragonhawk_trigger"])

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Win", 23863)
end

-------------------------------------------------------------------------------
--  Event Handlers

do
	function mod:Throw(player, spellId, _, _, spellName)
		self:TargetMessage(97639, spellName, player, "Attention", spellId, "Alert")
		self:Bar(97639, spellName..": "..player, 15, spellId)
		self:PrimaryIcon(97639, player)
	end
	function mod:ThrowRemoved(player, _, _, _, spellName)
	 self:SendMessage("BigWigs_StopBar", self, spellName..": "..player)
	end
end

function mod:Whirlwind(_, spellId, _, _, spellName)
	self:Message(17207, spellName, "Important", spellId)
end

function mod:Paralyze(_, spellId, _, _, spellName)
	self:Message(43095, LW_CL["casting"]:format(spellName), "Important", spellId)
	self:Bar(43095, spellName, 5, spellId)
	self:Bar(43095, LW_CL["next"]:format(spellName), 27, spellId)
end

do
	function mod:ClawRage(player, spellId, _, _, spellName)
		self:TargetMessage(43150, spellName, player, "Attention", spellId, "Alert")
		self:PrimaryIcon(43150, player)
	end
	function mod:ClawRemoved(player, _, _, _, spellName)
	 self:SendMessage("BigWigs_StopBar", self, spellName..": "..player)
	end
end

-- XXX use one function for the yells
function mod:Form1()
	self:Message("form", L["bear_message"], "Important", 89259)
end

function mod:Form2()
	self:Message("form", L["eagle_message"], "Important", 89259)
end

function mod:Form3()
	self:Message("form", L["lynx_message"], "Important", 89259)
end

function mod:Form4()
	self:Message("form", L["dragonhawk_message"], "Important", 89259)
end

