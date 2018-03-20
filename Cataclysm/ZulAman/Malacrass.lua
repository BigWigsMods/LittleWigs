-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Hex Lord Malacrass", 568, 190)
if not mod then return end
mod:RegisterEnableMob(24239)
-- mod.engageId = 1193 -- it works, but... it returns status 0 on a kill triggering the respawn timer
-- mod.respawnTime = 30

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		43383, -- Spirit Bolts
		43501, -- Siphon Soul
		43421, -- Lifebloom
		43548, -- Healing Wave
		43451, -- Holy Light
		43431, -- Flash Heal
	}, {
		[43383] = "general",
		[43421] = 43501, -- Siphon Soul
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "SpiritBolts", 43383)
	self:Log("SPELL_AURA_APPLIED", "SoulSiphon", 43501)
	self:Log("SPELL_CAST_START", "HealingCasts", 43548, 43451, 43431) -- Healing Wave, Holy Light, Flash Heal
	self:Log("SPELL_AURA_APPLIED", "Lifebloom", 43421)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Death("Win", 24239)
end

function mod:OnEngage()
	self:CDBar(43383, 30) -- Spirit Bolts
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:SpiritBolts(args)
	self:Message(args.spellId, "Important")
	self:CDBar(args.spellId, 30)
end

function mod:SoulSiphon(args)
	self:TargetMessage(args.spellId, args.destName, "Attention")
	self:CDBar(args.spellId, 60)
end

function mod:HealingCasts(args)
	self:Message(args.spellId, "Urgent", "Alarm", CL.casting:format(args.spellName))
end

function mod:Lifebloom(args)
	self:TargetMessage(args.spellId, args.destName, "Urgent", "Alarm", nil, nil, self:Dispeller("magic", true))
end
