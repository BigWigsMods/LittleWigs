-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Foe Reaper 5000", "The Deadmines")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(43778)
mod.toggleOptions = {88481, 88495, 91720, "bosskill"}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Overdrive", 88481)
	self:Log("SPELL_CAST_START", "Harvest", 88495)
	self:Log("SPELL_CAST_SUCCESS", "Safety", 91720)

	self:Death("Win", 43778)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
end

function mod:VerifyEnable()
	if GetInstanceDifficulty() == 2 then return true end
end

function mod:OnEngage()
	self:Bar(88481, LW_CL["next"]:format(GetSpellInfo(88481)), 10, 88481)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Overdrive(_, spellId, _, _, spellName)
	self:Message(88481, spellName, "Urgent", spellId, "Alarm")
	self:Bar(88481, LW_CL["next"]:format(spellName), 53, spellId)
end

do
	local function checkTarget()
		local player = UnitName("boss1target")
		mod:TargetMessage(88495, GetSpellInfo(88495), player, "Important", 88495, "Alert")
		mod:Bar(88495, LW_CL["next"]:format(GetSpellInfo(88495)), 56, 88495)
	end
	function mod:Harvest()
		self:ScheduleTimer(checkTarget, 0.1)
	end
end

function mod:Safety(_, spellId, _, _, spellName)
	self:Message(91720, GetSpellInfo(5229), "Attention", spellId, "Long") -- Enrage
end

