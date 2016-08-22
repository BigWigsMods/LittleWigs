-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("High Priest Venoxis", 793)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(52155)
mod.toggleOptions = {
	{96477, "ICON", "FLASHSHAKE"}, -- Toxic Link
	96509, -- Breath of Hethiss
	96466, -- Whispers of Hethiss
	96842, -- Bloodvenom
	96653, -- Venom Withdrawl (triggered by 97354)
	"bosskill",
}

--------------------------------------------------------------------------------
--  Locals

local linkTargets = mod:NewTargetList()
local breath = 2

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Link", 96477)
	self:Log("SPELL_AURA_REMOVED", "LinkRemoved", 96477)
	self:Log("SPELL_AURA_APPLIED", "Breath", 96509)
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
	local scheduled = nil
	local function linkWarn(spellName)
		mod:TargetMessage(96477, spellName, linkTargets, "Personal", 96477, "Alarm")
		scheduled = nil
	end
	function mod:Link(player, spellId, _, _, spellName)
		if UnitIsUnit(player, "player") then
			self:FlashShake(96477)
		end
		linkTargets[#linkTargets + 1] = player
		if not scheduled then
			scheduled = true
			self:ScheduleTimer(linkWarn, 0.2, spellName)
			self:PrimaryIcon(96477, player)
		else
			self:SecondaryIcon(96477, player)
		end
	end
end

function mod:LinkRemoved()
	self:PrimaryIcon(96477)
	self:SecondaryIcon(96477)
end

function mod:Breath(_, spellId, _, _, spellName)
	breath = breath - 1
	self:Message(96509, spellName, "Important", spellId)
	if (breath > 0) then
		self:Bar(96509, LW_CL["next"]:format(spellName), 12, spellId)
	end
end

function mod:Whisper(player, spellId, _, _, spellName)
	if UnitInParty(player) then
		self:Message(96466, LW_CL["casting"]:format(spellName), "Urgent", spellId, "Alert")
		self:Bar(96466, spellName..": "..player, 8, spellId)
	end
end

function mod:WhisperRemoved(player, _, _, _, spellName)
	if UnitInParty(player) then
		self:SendMessage("BigWigs_StopBar", self, spellName..": "..player)
	end
end

do
	local function BloodvenomActive()
		mod:Bar(96842, GetSpellInfo(96842), 14, 96842)
	end

	function mod:Bloodvenom(_, spellId, _, _, spellName)
		self:Message(96842, LW_CL["casting"]:format(spellName), "Important", spellId, "Alert")
		self:ScheduleTimer(BloodvenomActive, 3)
	end
end

function mod:Blessing(_, spellId, _, _, spellName)
	breath = 2
	self:Bar(96842, LW_CL["next"]:format(GetSpellInfo(96842)), 38, 96842)
	self:Bar(96509, LW_CL["next"]:format(GetSpellInfo(96509)), 5.5, 96509)
end

function mod:BlessingRemoved(_, spellId, _, _, spellName)
	self:Bar(96653, GetSpellInfo(96653), 10, 96653)
end
