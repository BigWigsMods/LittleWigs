
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Bonemaw", 969, 1140)
if not mod then return end
mod:RegisterEnableMob(75452)
--BOSS_KILL#1679#Bonemaw

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
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Emote("InhaleInc", "153804")
	self:Log("SPELL_CAST_SUCCESS", "Inhale", 153804)
	self:Log("SPELL_CAST_START", "BodySlam", 154175)

	self:Death("Win", 75452)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:InhaleInc()
	self:Message(153804, "Urgent", "Warning", CL.incoming:format(self:SpellName(153804)))
	self:Flash(153804)
end

function mod:Inhale(args)
	self:Bar(args.spellId, 9, CL.cast:format(args.spellName))
	self:Message(args.spellId, "Urgent", "Alarm")
end

function mod:BodySlam(args)
	self:Message(args.spellId, "Attention", "Alert")
end

