--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Nhallish", 1176, 1168)
if not mod then return end
mod:RegisterEnableMob(75829) -- Nhallish
mod:SetEncounterID(1688)
mod:SetRespawnTime(33)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		153623, -- Planar Shift
		152801, -- Void Vortex
		152792, -- Void Blast
		153067, -- Void Devastation
		152979, -- Soul Shred
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "PlanarShift", 153623)
	self:Log("SPELL_CAST_START", "VoidVortex", 152801)
	self:Log("SPELL_CAST_START", "VoidBlast", 152792)
	self:Log("SPELL_CAST_START", "VoidDevastation", 153067)
	self:Log("SPELL_CAST_SUCCESS", "SoulShred", 152979)
end

function mod:OnEngage()
	self:CDBar(152792, 10.7) -- Void Blast
	self:CDBar(153623, 25.3) -- Planar Shift
	self:CDBar(152801, 27.3) -- Void Vortex
	self:CDBar(152979, 37.1) -- Soul Shred
	self:CDBar(153067, 65.4) -- Void Devastation
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:PlanarShift(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 77.7)
end

function mod:VoidVortex(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 77.7)
end

function mod:VoidBlast(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 76.5)
end

function mod:VoidDevastation(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "long")
	self:Bar(args.spellId, 77.7)
end

function mod:SoulShred(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "info")
	self:Bar(args.spellId, 77.7)
end
