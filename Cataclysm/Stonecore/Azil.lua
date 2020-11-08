
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("High Priestess Azil", 725, 113)
if not mod then return end
mod:RegisterEnableMob(42333)
mod.engageId = 1057
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		79345, -- Curse of Blood
		79050, -- Energy Shield
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "CurseOfBlood", 79345)
	self:Log("SPELL_CAST_START", "EnergyShield", 79050, 82858)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CurseOfBlood(args)
	self:TargetMessageOld(args.spellId, args.destName, "yellow")
end

function mod:EnergyShield()
	self:MessageOld(79050, "red", "alert")
end

