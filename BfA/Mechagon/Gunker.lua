if not IsTestBuild() then return end

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Gunker", 2097, 2358)
if not mod then return end
mod:RegisterEnableMob(150222)
--mod.engageId = XXX

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		297985, -- Splatter
		297834, -- Toxic Wave
		297835, -- Coalesce
		298259, -- Gooped
		{298212, "TANK"}, -- Sludge Bolt
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Splatter", 297985)
	self:Log("SPELL_CAST_START", "ToxicWave", 297834)
	self:Log("SPELL_CAST_START", "Coalesce", 297835)
	self:Log("SPELL_AURA_APPLIED", "GoopedApplied", 298259)
	self:Log("SPELL_CAST_START", "SludgeBolt", 298212)
end

function mod:OnEngage()

end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Splatter(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:ToxicWave(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:Coalesce(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:GoopedApplied(args)
	self:TargetMessage2(args.spellId, "orange", args.destName)
	self:PlaySound(args.spellId, "warning", nil, args.destName)
end

function mod:SludgeBolt(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end
