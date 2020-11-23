--------------------------------------------------------------------------------
-- TODO:
-- - Mythic Abilties
-- - Improve timers
-- - Respawn

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ventunax", 2285, 2416)
if not mod then return end
mod:RegisterEnableMob(162058) -- Ventunax
mod.engageId = 2356
--mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		324146, -- Dark Stride
		324205, -- Blinding Flash
		334485, -- Recharge
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "DarkStride", 324146)
	self:Log("SPELL_CAST_START", "BlindingFlash", 324205)
	self:Log("SPELL_CAST_START", "Recharge", 334485)
end

function mod:OnEngage()
	self:Bar(324146, 11) -- Dark Stride
	self:Bar(324205, 15.5) -- Blinding Flash
	self:Bar(334485, 43.8) -- Recharge
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DarkStride(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 17)
end

function mod:BlindingFlash(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	self:Bar(args.spellId, 22)
	self:CastBar(args.spellId, 3)
end

function mod:Recharge(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "long")
	--self:Bar(args.spellId, 0)
end