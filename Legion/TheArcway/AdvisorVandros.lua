
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Advisor Vandros", 1079, 1501)
if not mod then return end
mod:RegisterEnableMob(98208)
mod.engageId = 1829

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		202974, -- Force Bomb
		220871, -- Unstable Mana
		203882, -- Banish In Time
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ForceBomb", 202974)
	self:Log("SPELL_AURA_APPLIED", "UnstableMana", 220871)
	self:Log("SPELL_CAST_START", "BanishInTime", 203882)
end

function mod:OnEngage()
	-- TODO Timers
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ForceBomb(args)
	self:Message(args.spellId, "Attention", "Info")
end

function mod:UnstableMana(args)
	self:TargetMessage(args.spellId, args.destName, "Urgent", "Alarm")
	self:TargetBar(args.spellId, 8, args.destName)
end

function mod:BanishInTime(args)
	self:Message(args.spellId, "Important", "Long")
	-- self:Bar(args.spellId, 120, CL.cast:format(args.spellName))
end
