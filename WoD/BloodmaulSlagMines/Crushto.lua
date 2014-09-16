
--------------------------------------------------------------------------------
-- Module Declaration
--

if not BigWigs.isWOD then return end -- XXX compat
local mod, CL = BigWigs:NewBoss("Slave Watcher Crushto", 964, 888)
if not mod then return end
mod:RegisterEnableMob(74787)

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
		150753, 150759, {150751, "FLASH", "ICON"}, "bosskill",
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

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:FerociousYell(args)
	self:Message(args.spellId, "Urgent", "Warning")
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

