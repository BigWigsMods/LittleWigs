
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Nhallish", 1176, 1168)
if not mod then return end
mod:RegisterEnableMob(75829)
mod.engageId = 1688
mod.respawnTime = 33

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		153623, -- Planar Shift
		152801, -- Void Vortex
		152979, -- Soul Shred
		153067, -- Void Devastation
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "PlanarShift", 153623)
	self:Log("SPELL_CAST_START", "VoidVortex", 152801)
	self:Log("SPELL_CAST_SUCCESS", "SoulShred", 152979)
	self:Log("SPELL_CAST_START", "VoidDevastation", 153067)
end

function mod:OnEngage()
	self:CDBar(153623, 21) -- Planar Shift
	self:CDBar(152801, 23) -- Void Vortex
	self:CDBar(152979, 37) -- Soul Shred
	self:CDBar(153067, 65.7) -- Void Devastation
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:PlanarShift(args)
	self:CDBar(args.spellId, 77)
	self:MessageOld(args.spellId, "yellow")
end

function mod:VoidVortex(args)
	self:CDBar(args.spellId, 77)
	self:MessageOld(args.spellId, "yellow", "alarm")
end

function mod:SoulShred(args)
	self:CDBar(args.spellId, 77)
	self:MessageOld(args.spellId, "red")
end

function mod:VoidDevastation(args)
	self:CDBar(args.spellId, 77)
	self:MessageOld(args.spellId, "orange", "warning")
end
