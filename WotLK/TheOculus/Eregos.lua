-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ley-Guardian Eregos", 528, 625)
if not mod then return end
--mod.otherMenu = "Coldarra"
mod:RegisterEnableMob(27656)

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		51162, -- Planar Shift
		51170, -- Enraged Assault
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "PlanarShift", 51162)
	self:Log("SPELL_AURA_APPLIED", "EnragedAssault", 51170)
	self:Death("Win", 27656)
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:PlanarShift(args)
	self:Message(args.spellId, "Important")
	self:Bar(args.spellId, 18)
end

function mod:EnragedAssault(args)
	self:Message(args.spellId, "Important")
	self:Bar(args.spellId, 12)
end
