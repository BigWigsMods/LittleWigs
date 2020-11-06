-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ley-Guardian Eregos", 578, 625)
if not mod then return end
mod:RegisterEnableMob(27656)
mod.engageId = 2013
mod.respawnTime = 30

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		51170, -- Enraged Assault
		51162, -- Planar Shift
	}, {
		[51170] = "general",
		[51162] = "heroic"
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "EnragedAssault", 51170)
	self:Log("SPELL_AURA_APPLIED", "PlanarShift", 51162)
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:EnragedAssault(args)
	self:MessageOld(args.spellId, "yellow")
	self:Bar(args.spellId, 12)
end

function mod:PlanarShift(args)
	self:MessageOld(args.spellId, "red")
	self:Bar(args.spellId, 18)
end

