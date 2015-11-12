
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("High Priestess Azil", 768, 113)
if not mod then return end
mod:RegisterEnableMob(42333)

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

	self:Death("Win", 42333)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CurseOfBlood(args)
	self:TargetMessage(args.spellId, args.destName, "Attention")
end

function mod:EnergyShield(args)
	self:Message(79050, "Important", "Alert")
end

