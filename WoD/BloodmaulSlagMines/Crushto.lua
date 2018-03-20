
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Slave Watcher Crushto", 1175, 888)
if not mod then return end
mod:RegisterEnableMob(74787)
--BOSS_KILL#1653#Slave Watcher Crushto

--------------------------------------------------------------------------------
-- Locals
--

local yellCount = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then

end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		150753, -- Wild Slam
		150759, -- Ferocious Yell
		{150751, "FLASH", "ICON"}, -- Crushing Leap
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_CAST_START", "FerociousYell", 150759)
	self:Log("SPELL_CAST_START", "WildSlam", 150753)
	self:Log("SPELL_AURA_APPLIED", "CrushingLeap", 150751)
	self:Log("SPELL_AURA_REMOVED", "CrushingLeapOver", 150751)

	self:Death("Win", 74787)
end

function mod:OnEngage()
	yellCount = 0
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:FerociousYell(args)
	yellCount = yellCount + 1
	self:Message(args.spellId, "Urgent", "Warning", CL.count:format(args.spellName, yellCount))
	self:CDBar(args.spellId, 13.3) -- Something will randomly delay this up to 19s
end

function mod:WildSlam(args)
	self:Message(args.spellId, "Attention", "Long")
end

function mod:CrushingLeap(args)
	self:TargetMessage(args.spellId, args.destName, "Important", "Alert")
	self:TargetBar(args.spellId, 8, args.destName)
	self:PrimaryIcon(args.spellId, args.destName)
	if self:Me(args.destGUID) then
		self:Flash(args.spellId)
	end
end

function mod:CrushingLeapOver(args)
	self:PrimaryIcon(args.spellId)
end
