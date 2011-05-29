-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Helix Gearbreaker", 756)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(47296, 47297)
mod.toggleOptions = {
	{88352, "ICON", "FLASHSHAKE"}, -- Chest Bomb
	"bosskill",
}


-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Bomb", 88352)
	self:Log("SPELL_AURA_REMOVED", "BombRemoved", 88352)

	self:Death("Win", 47162)
end

function mod:VerifyEnable()
	if GetInstanceDifficulty() == 2 then return true end
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Bomb(player, spellId, _, _, spellName)
	self:TargetMessage(88352, spellName, player, "Important", spellId, "Alert")
	self:PrimaryIcon(88352, player)
	self:Bar(88352, player..": "..spellName, 10, spellId) 
	if UnitIsUnit("player", player) then
		self:FlashShake(88352)
	end
end

function mod:BombRemoved()
	self:PrimaryIcon(88352)
end

