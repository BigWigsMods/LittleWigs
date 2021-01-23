--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ventunax", 2285, 2416)
if not mod then return end
mod:RegisterEnableMob(162058) -- Ventunax
mod.engageId = 2356
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Locals
--

local darkStrideCount = 0

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
	darkStrideCount = 0

	self:Bar(324146, 10.7) -- Dark Stride
	self:Bar(324205, 15.5) -- Blinding Flash
	self:Bar(334485, 43.5) -- Recharge
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DarkStride(args)
	darkStrideCount = darkStrideCount + 1

	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, darkStrideCount % 2 == 0 and 25.5 or 18.2)
end

function mod:BlindingFlash(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
	self:Bar(args.spellId, 21.8)
	self:CastBar(args.spellId, 3)
end

function mod:Recharge(args)
	self:Message(args.spellId, "cyan", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "long")
	self:Bar(args.spellId, 43.6)
	self:CastBar(args.spellId, 11) -- 1s cast + 10s channel
end
