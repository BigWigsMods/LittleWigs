-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("High Priest Venoxis", "Zul'Gurub")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(52155)
mod.toggleOptions = {
	{96477, "FLASHSHAKE"},
	96509,
	96466,
	96842,
	"bosskill",
}

--------------------------------------------------------------------------------
--  Locals

local linkTargets = mod:NewTargetList()

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Link", 96477)
	self:Log("SPELL_AURA_APPLIED", "Breath", 96509)
	self:Log("SPELL_AURA_APPLIED", "Whisper", 96466)
	self:Log("SPELL_AURA_REMOVED", "WhisperRemoved", 96466)
	self:Log("SPELL_CAST_START", "Bloodvenom", 96842)

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
		end
	end
end

function mod:Breath(_, spellId, _, _, spellName)
	self:Message(96509, spellName, "Important", spellId)
	self:Bar(96509, spellName, 12, spellId)
end

do
	function mod:Whisper(player, spellId, _, _, spellName)
		self:TargetMessage(96466, spellName, player, "Attention", spellId, "Alert")
		self:Bar(96466, spellName..": "..player, 8, spellId)
	end

	function mod:WhisperRemoved(player, _, _, _, spellName)
		self:SendMessage("BigWigs_StopBar", self, spellName..": "..player)
	end
end

function mod:Bloodvenom(_, spellId, _, _, spellName)
	self:Message(96842, spellName, "Important", spellId, "Alert")
end

