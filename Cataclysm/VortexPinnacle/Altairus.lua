-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Altairus", 769)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(43873)
mod.toggleOptions = {
	88282, -- Upwind of Altairus
	88286, -- Downwind of Altairus
	{88308, "ICON"}, -- Breath
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Upwind", 88282)
	self:Log("SPELL_AURA_APPLIED", "Downwind", 88286)
	self:Log("SPELL_CAST_START", "Breath", 88308, 93989)

	self:Death("Win", 43873)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Upwind(unit, spellId, _, _, spellName)
	if UnitIsUnit("player", unit) then
		self:LocalMessage(88282, spellName, "Positive", spellId, "Info")
	end
end

function mod:Downwind(unit, spellId, _, _, spellName)
	if UnitIsUnit("player", unit) then
		self:LocalMessage(88286, spellName, "Important", spellId, "Alarm")
	end
end

do
	local function clearIcon()
		mod:PrimaryIcon(88308)
	end
	
	function mod:Breath(_, spellId, _, _, spellName)
		mod:Bar(88308, LW_CL["next"]:format(spellName), 12, spellId)
		mod:TargetMessage(88308, spellName, UnitName("boss1target"), "Urgent", spellId)
		mod:PrimaryIcon(88308, UnitName("boss1target"))
		self:ScheduleTimer(clearIcon, 4)
	end
end

