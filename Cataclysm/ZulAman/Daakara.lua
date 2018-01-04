-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Daakara", 781)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(23863)
mod.toggleOptions = {
	"form",
	{97639, "ICON"}, -- Grievous Throw
	17207, -- Whirlwind
	43095, -- Creeping Paralysis
	43150, -- Claw Rage
	"bosskill",
}

-------------------------------------------------------------------------------
--  Localization

local L = mod:GetLocale()
if L then
	L["form"] = "Phases"
	L["form_desc"] = "Warn when Daakara changes form."
	L["bear_message"] = "Bear Form!"
	L["eagle_message"] = "Eagle Form!"
	L["lynx_message"] = "Lynx Form!"
	L["dragonhawk_message"] = "Dragonhawk Form!"
end

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Whirlwind", 17207)
	self:Log("SPELL_AURA_APPLIED", "Throw", 97639)
	self:Log("SPELL_AURA_REMOVED", "ThrowRemoved", 97639)
	self:Log("SPELL_CAST_SUCCESS", "Paralyze", 43095)
	self:Log("SPELL_AURA_APPLIED", "ClawRage", 43150)
	self:Log("SPELL_CAST_START", "Forms", 42594, 42606, 42607, 42608) -- Bear, Eagle, Lynx, Dragonhawk

	-- self:Yell("Form1", L["bear_trigger"])
	-- self:Yell("Form2", L["eagle_trigger"])
	-- self:Yell("Form3", L["lynx_trigger"])
	-- self:Yell("Form4", L["dragonhawk_trigger"])

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Win", 23863)
end

-------------------------------------------------------------------------------
--  Event Handlers

do
	function mod:Throw(player, spellId, _, _, spellName)
		self:TargetMessage(97639, spellName, player, "Attention", spellId, "Alarm")
		self:Bar(97639, spellName..": "..player, 15, spellId)
		self:PrimaryIcon(97639, player)
	end
	function mod:ThrowRemoved(player, _, _, _, spellName)
		self:SendMessage("BigWigs_StopBar", self, spellName..": "..player)
		self:PrimaryIcon(97639)
	end
end

function mod:Whirlwind(_, spellId, _, _, spellName)
	self:Message(17207, spellName, "Urgent", spellId)
end

function mod:Paralyze(_, spellId, _, _, spellName)
	self:Message(43095, LW_CL["casting"]:format(spellName), "Attention", spellId)
	self:Bar(43095, spellName, 6, spellId)
	self:Bar(43095, LW_CL["next"]:format(spellName), 27, spellId)
end

function mod:ClawRage(player, spellId, _, _, spellName)
	self:TargetMessage(43150, spellName, player, "Important", spellId, "Alert")
end

function mod:Forms(_, spellId)
	if spellId == 42594 then
		self:Message("form", L["bear_message"], "Important", spellId)
	elseif spellId == 42606 then
		self:Message("form", L["eagle_message"], "Important", spellId)
	elseif spellId == 42607 then
		self:Message("form", L["lynx_message"], "Important", spellId)
	elseif spellId == 42608 then
		self:Message("form", L["dragonhawk_message"], "Important", spellId)
	end
end

