-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Zanzil", "Zul'Gurub")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(52053)
mod.toggleOptions = {
	"phase",
	96435,
	96958,
	96592,
	96594,
	96457,
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Elixir", 96316)
	self:Log("SPELL_CAST_START", "Fire", 96914)
	self:Log("SPELL_CAST_START", "Gas", 96338)
	self:Log("SPELL_CAST_START", "Gaze", 96342)
	
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	
	self:Death("Win", 52053)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Gas(_, spellId, _, _, spellName)
	self:Message(96338, LW_CL["casting"]:format(spellName), "Attention", spellId, "Alert")
	self:Bar(96338, spellName, 7, spellId)
end

function mod:Elixir(_, spellId, _, _, spellName)
	self:Message(96316, spellName, "Attention", spellId, "Alert")
end

function mod:Fire(_, spellId, _, _, spellName)
	self:Message(96914, spellName, "Attention", spellId, "Info")
end

do
	local function checkTarget()
		local player = UnitName("boss1target")
		if UnitIsUnit("player", player) then
			mod:FlashShake(96342)
		end
		mod:TargetMessage(96342, spellName, player, "Important", 96342, "Alert")
		mod:PrimaryIcon(96342, player)
	end
	function mod:Gaze(_, spellId, _, _, spellName)
		self:ScheduleTimer(checkTarget, 0.2, spellName)
	end
end