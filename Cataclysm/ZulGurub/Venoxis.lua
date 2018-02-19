-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("High Priest Venoxis", 859, 175)
if not mod then return end
mod:RegisterEnableMob(52155)

--------------------------------------------------------------------------------
--  Locals

local breath = 2

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		{96477, "ICON", "FLASH"}, -- Toxic Link
		96509, -- Breath of Hethiss
		96466, -- Whispers of Hethiss
		96842, -- Bloodvenom
		96653, -- Venom Withdrawal (triggered by 97354)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "ToxicLink", 96477)
	self:Log("SPELL_AURA_REMOVED", "ToxicLinkRemoved", 96477)
	self:Log("SPELL_AURA_APPLIED", "BreathOfHethiss", 96509)
	self:Log("SPELL_AURA_APPLIED", "Whisper", 96466)
	self:Log("SPELL_AURA_REMOVED", "WhisperRemoved", 96466)
	self:Log("SPELL_CAST_START", "Bloodvenom", 96842)
	self:Log("SPELL_AURA_APPLIED", "Blessing", 97354)
	self:Log("SPELL_AURA_REMOVED", "BlessingRemoved", 97354)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Death("Win", 52155)
end

-------------------------------------------------------------------------------
--  Event Handlers

do
	local linkTargets = mod:NewTargetList()

	function mod:ToxicLink(args)
		if self:Me(args.destGUID) then
			self:Flash(args.spellId)
		end
		linkTargets[#linkTargets + 1] = args.destName
		if #linkTargets == 1 then
			self:ScheduleTimer("TargetMessage", 0.2, args.spellId, linkTargets, "Urgent", "Alarm")
			self:PrimaryIcon(args.spellId, args.destName)
		else
			self:SecondaryIcon(args.spellId, args.destName)
		end
	end

	function mod:ToxicLinkRemoved(args)
		self:PrimaryIcon(args.spellId)
		self:SecondaryIcon(args.spellId)
	end
end

function mod:BreathOfHethiss(args)
	breath = breath - 1
	self:Message(args.spellId, "Important")
	if (breath > 0) then
		self:CDBar(args.spellId, 12)
	end
end

function mod:Whisper(args)
	if UnitInParty(args.destName) then
		self:Message(args.spellId, "Urgent", "Alert", CL.casting:format(args.spellName))
		self:TargetBar(args.spellId, 8, args.destName)
	end
end

function mod:WhisperRemoved(args)
	if UnitInParty(args.destName) then
		self:StopBar(args.spellId, args.destName)
	end
end

function mod:Bloodvenom(args)
	self:Message(args.spellId, "Important", "Alert", CL.casting:format(args.spellName))
	self:ScheduleTimer("Bar", 3, args.spellId, 14)
end

function mod:Blessing(args)
	breath = 2
	self:CDBar(96842, 38) -- Bloodvenom
	self:CDBar(96509, 5.5) -- Breath of Hethiss
end

function mod:BlessingRemoved(args)
	self:Bar(96653, 10) -- Venom Withdrawal
end
