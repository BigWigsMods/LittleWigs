
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Globgrog", 2289, 2419)
if not mod then return end
mod:RegisterEnableMob(164255) -- Globgrog
mod.engageId = 2382
--mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		324459, -- Beckon Slime
		324527, -- Plaguestomp
		324667, -- Slime Wave
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "BeckonSlime", 324459)
	self:Log("SPELL_CAST_START", "Plaguestomp", 324527)
	self:Log("SPELL_CAST_START", "SlimeWave", 324667)
end

function mod:OnEngage()
	--self:CDBar(324459, 17.1) -- Beckon Slime
	--self:CDBar(324527, 17.1) -- Plaguestomp
	--self:CDBar(324667, 17.1) -- Slime Wave
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:BeckonSlime(args)
	self:Message2(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	--self:Bar(args.spellId, 37.7)
end

function mod:Plaguestomp(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	--self:Bar(args.spellId, 37.7)
end

function mod:SlimeWave(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	--self:Bar(args.spellId, 37.7)
end
