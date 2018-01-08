-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Grand Champions", 542)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(
	-- Horde NPCs
	34657, 34701, 34702, 34703, 34705,
	-- Announcers
	35004, 35005,
	-- Alliance NPCs
	35569, 35570, 35571, 35572, 35617
)
mod.toggleOptions = {
	{"rogue_poison", "FLASHSHAKE"},
	67534, -- Shaman Hex
	68318, -- Shaman Heal
	66043, -- Mage Poly
}

-------------------------------------------------------------------------------
--  Localization

local L = mod:GetLocale()
if L then
	L["defeat_trigger"] = "Well Fought!"
	L["mage_poly_message"] = "%s Polymorphed!"
	L["rogue_poison"] = "Poison Bottle"
	L["rogue_poison_desc"] = "Throws a poison bottle to a random player, leaving a 5 yard radius poison cloud dealing 1,000 (Heroic: 1,750) Nature damage every second to everyone standing in it. Last 20 seconds."
end

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "ShamanHexApplied", 67534)
	self:Log("SPELL_AURA_REMOVED", "ShamanHexRemoved", 67534)
	self:Log("SPELL_CAST_START", "ShamanHeal", 68318, 67528)
	self:Log("SPELL_AURA_APPLIED", "MagePolyApplied", 66043, 68311)
	self:Log("SPELL_AURA_REMOVED", "MagePolyRemoved", 66043, 68311)
	self:Log("SPELL_AURA_APPLIED", "RoguePoisonOnYou", 67701, 67594, 68316)

	self:Yell("Win", L["defeat_trigger"])
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:ShamanHexApplied(player, spellId, _, _, spellName)
	self:Message(67534, spellName..": "..player, "Attention", spellId)
	self:Bar(67534, player..": "..spellName, 10, 67534)
end

function mod:ShamanHexRemoved(player, _, _, _, spellName)
	self:SendMessage(67534, "BigWigs_StopBar", self, player..": "..spellName)
end

function mod:ShamanHeal(boss, spellId, _, _, spellName)
	self:Message(68318, spellName, "Urgent", spellId)
	self:Bar(68318, spellName, 3, 67528)
end

function mod:MagePolyApplied(player, spellId)
	self:Message(66043, L["mage_poly_message"]:format(player), "Attention", spellId)
end

function mod:MagePolyRemoved(player, spellId)
	self:SendMessage(66043, "BigWigs_StopBar", self, L["mage_poly_message"]:format(player))
end

do
	local last = nil
	local pName = UnitName("player")
	function mod:RoguePoisonOnYou(player, spellId, _, _, spellName)
		if player == pName then
			local t = GetTime()
			if not last or (t > last + 4) then
				self:TargetMessage("rogue_poison", spellName, player, "Personal", spellId, last and nil or "Alarm")
				self:FlashShake("rogue_poison")
				last = t
			end
		end
	end
end
