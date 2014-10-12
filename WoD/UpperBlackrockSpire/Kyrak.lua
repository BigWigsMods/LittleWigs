
--------------------------------------------------------------------------------
-- Module Declaration
--

if not BigWigs.isWOD then return end -- XXX compat
local mod, CL = BigWigs:NewBoss("Kyrak", 995, 1227)
if not mod then return end
mod:RegisterEnableMob(76021)

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
		161199, -- Debilitating Fixation
		161203, -- Rejuvenating Serum
		161288, -- Vileblood Serum
		"bosskill",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_CAST_START", "DebilitatingFixation", 161199)
	self:Log("SPELL_CAST_START", "RejuvenatingSerumIncoming", 161203)
	self:Log("SPELL_CAST_SUCCESS", "RejuvenatingSerum", 161203)
	self:Log("SPELL_AURA_APPLIED", "VilebloodSerum", 161288)

	self:Death("Win", 76021)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DebilitatingFixation(args)
	self:Message(args.spellId, "Attention", "Alert", CL.casting:format(args.spellName))
end

function mod:RejuvenatingSerumIncoming(args)
	self:Message(args.spellId, "Urgent", nil, CL.incoming:format(args.spellName))
end

function mod:RejuvenatingSerum(args)
	self:TargetMessage(args.spellId, args.destName, "Urgent", "Warning")
end

function mod:VilebloodSerum(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "Personal", "Alarm", CL.underyou:format(args.spellName))
	end
end

