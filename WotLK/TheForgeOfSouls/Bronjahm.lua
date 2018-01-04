-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Bronjahm", 601)
if not mod then return end
mod.partyContent = true
mod.otherMenu = "The Frozen Halls"
mod:RegisterEnableMob(36497)
mod.toggleOptions = {
	68872, -- Soulstorm
	68839, -- Corrupt Soul
}

-------------------------------------------------------------------------------
--  Locals

local stormannounced = nil

-------------------------------------------------------------------------------
--  Localization

local L = mod:GetLocale()
if L then
	L["storm_soon"] = "Soulstorm Soon!"
end

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	if bit.band(self.db.profile[(GetSpellInfo(68872))], BigWigs.C.MESSAGE) == BigWigs.C.MESSAGE then
		self:RegisterEvent("UNIT_HEALTH")
	end
	self:Log("SPELL_AURA_APPLIED", "Corrupt", 68839)
	self:Log("SPELL_AURA_REMOVED", "CorruptRemoved", 68839)
	self:Death("Win", 36497)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:UNIT_HEALTH(event, msg)
	if UnitName(msg) ~= mod.displayName then return end
	local health = UnitHealth(msg)
	if health > 30 and health <= 35 and not stormannounced then
		self:Message(68872, L["storm_soon"], "Important")
		stormannounced = true
	elseif health > 40 and stormannounced then
		stormannounced = nil
	end
end

function mod:Corrupt(player, spellId, _, _, spellName)
	self:TargetMessage(68839, spellName, player, "Personal", spellId, "Alert")
	self:Bar(68839, player..": "..spellName, 4, spellId)
	self:PrimaryIcon(68839, player)
end

function mod:CorruptRemoved()
	self:PrimaryIcon(68839, false)
end
