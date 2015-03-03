
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Kyrak", 995, 1227)
if not mod then return end
mod:RegisterEnableMob(76021)
--BOSS_KILL#1758#Kyrak

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		161199, -- Debilitating Fixation
		161203, -- Rejuvenating Serum
		161288, -- Vileblood Serum
		{155037, "TANK"}, -- Eruption
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_CAST_START", "DebilitatingFixation", 161199)
	self:Log("SPELL_CAST_START", "RejuvenatingSerumIncoming", 161203)
	self:Log("SPELL_CAST_START", "Eruption", 155037)
	self:Log("SPELL_CAST_SUCCESS", "RejuvenatingSerum", 161203)
	self:Log("SPELL_AURA_APPLIED", "VilebloodSerum", 161288)

	self:Death("Win", 76021)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DebilitatingFixation(args)
	self:Message(args.spellId, "Attention", "Alert", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 20) -- 20-23
end

function mod:RejuvenatingSerumIncoming(args)
	self:Message(args.spellId, "Urgent", "Long", CL.incoming:format(args.spellName))
end

function mod:Eruption(args)
	local raidIcon = CombatLog_String_GetIcon(args.sourceRaidFlags)
	self:Message(args.spellId, "Important", "Info", raidIcon.. args.spellName)
end

function mod:RejuvenatingSerum(args)
	self:TargetMessage(args.spellId, args.destName, "Urgent", "Warning", nil, nil, true)
end

function mod:VilebloodSerum(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "Personal", "Alarm", CL.underyou:format(args.spellName))
	end
end

