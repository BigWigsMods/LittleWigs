
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Vexallus", 798, 531)
if not mod then return end
mod:RegisterEnableMob(24744)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L["adds"] = "Pure Energy"
	L["adds_desc"] = "Warn when Pure Energy is discharged."
	L["adds_message"] = "Pure Energy discharged!"
	L["adds_trigger"] = "discharges pure energy!"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"adds",
		44335, -- Energy Feedback
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE", "AddSpawned")

	self:Log("SPELL_AURA_APPLIED", "Feedback", 44335)
	self:Log("SPELL_AURA_APPLIED_DOSE", "FeedbackDose", 44335)
	self:Log("SPELL_AURA_REMOVED", "FeedbackRemove", 44335)
	self:Death("Win", 24744)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:AddSpawned(_, msg)
	if msg:find(L.adds_trigger) then
		self:Message("adds", "Important", nil, L.adds_message, false)
	end
end

function mod:Feedback(args)
	self:TargetMessage(args.spellId, args.destName, "Urgent")
	self:TargetBar(args.spellId, 30, args.destName)
end

function mod:FeedbackDose(args)
	self:TargetBar(args.spellId, 30, args.destName)
end

function mod:FeedbackRemove(args)
	self:StopBar(args.spellName, args.destName)
end

