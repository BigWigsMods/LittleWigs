------------------------------
--      Are you local?      --
------------------------------

if not GetSpellInfo then return end

local boss = BB["Vexallus"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)
local pName = UnitName("player")
local db = nil

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Vexallus",

	adds = "Pure Energy",
	adds_desc = "Warn when Pure Energy is discharged",
	adds_message = "Pure Energy discharged!",
	adds_trigger = "discharges pure energy!",

	feedback = "Energy Feedback",
	feedback_desc = "Warn when someone gets the Energy Feedback debuff",
	feedback_you = "Energy Feedback on YOU!",
	feedback_other = "Energy Feedback on %s!",
} end )

--[[
	Magister's Terrace modules are PTR beta, as so localization is not
	supported in any way. This gives the authors the freedom to change the
	modules in way that	can potentially break localization.  Feel free to
	localize, just be aware that you may need to change it frequently.
]]--

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.zonename = BZ["Magisters' Terrace"]
mod.enabletrigger = boss 
mod.toggleoptions = {"adds","feedback","bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE","AddSpawned")

	self:AddCombatListener("SPELL_AURA_APPLIED", "Feedback", 44335)
	self:AddCombatListener("SPELL_AURA_REMOVED", "FeedbackRemove", 44335)
	self:AddCombatListener("UNIT_DIED", "GenericBossDeath")

	db = self.db.profile
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:AddSpawned(msg)
	if db.adds and msg:find(L["adds_trigger"]) then
		self:Message(L["adds_message"], "Important")
	end
end

function mod:Feedback(player, spellID)
	if db.feedback then
		local other = L["feedback_other"]:format(player)
		if player == pName then
			self:Message(L["feedback_you"], "Personal", true, "Alert", nil, spellID)
			self:Message(other, "Attention", nil, nil, true)
		else
			self:Message(other, "Attention", nil, nil, nil, spellID)
		end
		self:Bar(other, 30, spellID)
	end
end

function mod:FeedbackRemove(player)
	if db.feedback then
		self:TriggerEvent("BigWigs_StopBar", self, L["feedback_other"]:format(player))
	end
end
