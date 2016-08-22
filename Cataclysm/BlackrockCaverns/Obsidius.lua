-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Ascendant Lord Obsidius", 753)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(39705)
mod.toggleOptions = {
	93613, -- Twilight Corruption
	{76200, "ICON"}, -- Transformation
	76189, -- Veil
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Corruption", 76188, 93613)
	self:Log("SPELL_AURA_REMOVED", "CorruptionRemoved", 76188, 93613)
	self:Log("SPELL_AURA_APPLIED", "Change", 76200)
	self:Log("SPELL_AURA_APPLIED", "Veil", 76189)

	self:Death("Win", 39705)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Corruption(player, spellId, _, _, spellName)
	self:TargetMessage(93613, spellName, player, "Important", spellId, "Alarm")
	self:Bar(93613, spellName..": "..player, 12, spellId)
end

function mod:CorruptionRemoved(player, _, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, spellName..": "..player)
end

do
	local changeThrottle = 0
	function mod:Change(_, spellId, _, _, spellName)
		local time = GetTime()
		if (time - changeThrottle) > 2 then
			self:Message(76200, spellName, "Urgent", spellId)
		end
		self:PrimaryIcon(76200, mod.displayName)
		changeThrottle = time
	end
end

function mod:Veil(player, spellId, _, _, spellName)
	if UnitGroupRolesAssigned(player) == "TANK" then
		self:TargetMessage(76189, spellName, player, "Attention", spellId)
		self:Bar(76189, spellName..": "..player, 4, spellId)
	end
end

