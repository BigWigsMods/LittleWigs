-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Hex Lord Malacrass", 568, 190)
if not mod then return end
mod:RegisterEnableMob(24239)

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		43383, -- Spirit Bolts
		43501, -- Siphon Soul
		43548, -- Healing Wave
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "SpiritBolts", 43383)
	self:Log("SPELL_AURA_APPLIED", "SoulSiphon", 43501)
	self:Log("SPELL_CAST_START", "Heal", 43548, 43451, 43431) -- Healing Wave, Holy Light, Flash Light

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Death("Win", 24239)
end

function mod:OnEngage()
	self:CDBar(43383, 30) -- Spirit Bolts
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:SpiritBolts(args)
	self:Message(args.spellId, "Important")
	self:CDBar(args.spellId, 30)
end

function mod:SoulSiphon(args)
	self:TargetMessage(args.spellId, args.destName, "Attention")
	self:CDBar(args.spellId, 60)
end

function mod:Heal(args)
	self:Message(43548, "Urgent", "Alarm", CL.casting:format(args.spellName), args.spellId)
end
