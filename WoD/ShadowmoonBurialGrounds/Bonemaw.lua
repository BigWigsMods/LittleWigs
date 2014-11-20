
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Bonemaw", 969, 1140)
if not mod then return end
mod:RegisterEnableMob(75452)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{153804, "FLASH"}, -- Inhale
		154175, -- Body Slam
		"bosskill",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "InhaleIncUnitEvent", "boss1")
	self:Log("SPELL_CAST_SUCCESS", "Inhale", 153804)
	self:Log("SPELL_CAST_START", "BodySlam", 154175)

	self:Death("Win", 75452)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:InhaleIncUnitEvent(unit, spellName, _, _, spellId)
	if spellId == 154868 then
		-- Unit event is 1s faster than emote, but only works for first Inhale, so register Emote after that.
		self:InhaleInc()
		self:ScheduleTimer("Emote", 5, "InhaleInc", "153804")
	end
end

function mod:InhaleInc()
	self:Message(153804, "Urgent", "Warning", CL.incoming:format(self:SpellName(153804)))
	self:Flash(153804)
end

function mod:Inhale(args)
	self:Bar(args.spellId, 9, CL.cast:format(args.spellName))
	self:Message(args.spellId, "Urgent", "Warning")
end

function mod:BodySlam(args)
	self:Message(args.spellId, "Attention", "Alert")
end

