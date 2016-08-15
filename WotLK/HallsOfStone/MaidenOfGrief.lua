-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Maiden of Grief", 526)
if not mod then return end
mod.partycontent = true
mod.otherMenu = "The Storm Peaks"
mod:RegisterEnableMob(27975)
mod.toggleOptions = {
	50760, --Shock
}

-------------------------------------------------------------------------------
--  Locals

local stun = mod:NewTargetList()

-------------------------------------------------------------------------------
--  Localization

local LCL = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Common")

-------------------------------------------------------------------------------
--  Initialization

function mod:OnEnable()
	self:Log("SPELL_CAST_START", "Shock", 50760, 59726)
	self:Log("SPELL_AURA_APPLIED", "Stun", 50760, 59726)
	self:Death("Win", 27975)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Shock(_, spellId, _, _, spellName)
	self:Message(50760, LCL["casting"]:format(spellName), "Urgent", spellId)
	self:Bar(50760, LCL["casting"]:format(spellName), 4, spellId)
end

do
	local handle = nil
	local id, name = nil, nil
	local time = 6
	local function StunWarn()
		if id==59726 then time=10 end 
		mod:TargetMessage(50760, name, stun, "Urgent", id)
		mod:Bar(50760, name, time, id)
		handle = nil
	end
	function mod:Stun(player, spellId, _, _, spellName)
		stun[#stun + 1] = player
		if handle then self:CancelTimer(handle) end
		id, name = spellId, spellName
		handle = self:ScheduleTimer(StunWarn, 0.2)
	end
end
