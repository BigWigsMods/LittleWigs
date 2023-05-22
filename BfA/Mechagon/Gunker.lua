--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Gunker", 2097, 2358)
if not mod then return end
mod:RegisterEnableMob(150222)
mod.engageId = 2292

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		297985, -- Splatter
		{297834, "CASTBAR"}, -- Toxic Wave
		297835, -- Coalesce
		298259, -- Gooped
		{298212, "TANK"}, -- Sludge Bolt
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Splatter", 297985)
	self:Log("SPELL_CAST_START", "ToxicWave", 297834)
	self:Log("SPELL_CAST_START", "Coalesce", 297835)
	self:Log("SPELL_AURA_APPLIED", "GoopedApplied", 298259, 298124) -- Player debuff, bot debuff
	self:Log("SPELL_CAST_START", "SludgeBolt", 298212)
end

function mod:OnEngage()
	self:Bar(297985, 8.3) -- Splatter
	self:Bar(297835, 20.5) -- Coalesce
	self:Bar(297834, 44.8) -- Toxic Wave
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Splatter(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 25)
end

function mod:ToxicWave(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 49)
	self:CastBar(args.spellId, 3.5)
end

function mod:Coalesce(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 49)
end

function mod:GoopedApplied(args)
	self:TargetMessage(298259, "orange", args.destName)
	self:PlaySound(298259, "warning", nil, args.destName)
end

function mod:SludgeBolt(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end
