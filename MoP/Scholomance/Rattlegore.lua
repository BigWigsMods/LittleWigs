--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Rattlegore", 1007, 665)
if not mod then return end
mod:RegisterEnableMob(
	59304, -- Bone Pile
	59153 -- Rattlegore
)
mod:SetEncounterID(1428)
--mod:SetRespawnTime(30) resets, doesn't respawn

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{113765, "TANK"}, -- Rusting
		113999, -- Bone Spike
		113996, -- Bone Armor
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED_DOSE", "RustingApplied", 113765)
	self:Log("SPELL_CAST_START", "BoneSpike", 113999)
	self:Log("SPELL_AURA_APPLIED", "BoneArmorApplied", 113996)
	self:Log("SPELL_AURA_REMOVED", "BoneArmorRemoved", 113996)
end

function mod:OnEngage()
	self:CDBar(113999, 6.1)	-- Bone Spike
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:RustingApplied(args)
	if args.amount % 5 == 0 then
		self:Message(args.spellId, "purple", CL.stack:format(args.amount, args.spellName, CL.boss))
		self:PlaySound(args.spellId, "info")
	end
end

function mod:BoneSpike(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 7.3)
end

function mod:BoneArmorApplied(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "green", CL.you:format(args.spellName))
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end

function mod:BoneArmorRemoved(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "red", CL.removed:format(args.spellName))
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
	end
end
