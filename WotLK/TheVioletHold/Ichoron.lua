--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ichoron", 608, 628)
if not mod then return end
mod:RegisterEnableMob(
	29313, -- Ichoron
	32224 -- Swirling Water Revenant (replacement boss)
)
-- mod.engageId = 0 -- no IEEU and ENCOUNTER_* events
-- mod.respawnTime = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		54306, -- Protective Bubble
		54312, -- Frenzy
		54241, -- Water Bolt Volley
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Drained", 59820)
	self:Log("SPELL_AURA_APPLIED", "ProtectiveBubble", 54306)
	self:Log("SPELL_AURA_REMOVED", "ProtectiveBubbleRemoved", 54306)
	self:Log("SPELL_AURA_APPLIED", "Frenzy", 54312, 59522) -- Normal, Heroic
	self:Log("SPELL_CAST_START", "WaterBoltVolley", 54241, 59521) -- Normal, Heroic

	self:Death("Win", 29313, 32224)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Drained()
	self:Bar("stages", 15, CL.intermission, "spell_frost_summonwaterelemental_2")
end

function mod:ProtectiveBubble(args)
	self:Message(args.spellId, "yellow", CL.onboss:format(args.spellName))
	self:PlaySound(args.spellId, "long")
end

function mod:ProtectiveBubbleRemoved(args)
	self:Message(args.spellId, "green", CL.removed:format(args.spellName))
	self:PlaySound(args.spellId, "info")
end

function mod:Frenzy()
	self:Message(54312, "red")
	self:PlaySound(54312, "alert")
end

function mod:WaterBoltVolley(args)
	self:Message(54241, "orange", CL.casting:format(args.spellName))
	if self:Interrupter() then
		self:PlaySound(54312, "alarm")
	end
end
