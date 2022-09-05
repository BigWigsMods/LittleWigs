
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Forgemaster Throngus", 670, 132)
if not mod then return end
mod:RegisterEnableMob(40177)
mod.engageId = 1050
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		74908, -- Personal Phalanx
		75007, -- Encumbered
		74981, -- Dual Blades
		{74976, "FLASH"}, -- Disorienting Roar
		75056, -- Impaling Slam
		{74987, "FLASH"}, -- Cave In
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Phalanx", 74908)
	self:Log("SPELL_AURA_APPLIED", "Encumbered", 75007)
	self:Log("SPELL_AURA_APPLIED", "Blades", 74981)
	self:Log("SPELL_CAST_SUCCESS", "Impale", 75056)
	self:Log("SPELL_AURA_APPLIED", "CaveIn", 74987)
	self:Log("SPELL_AURA_APPLIED", "Roar", 74976)
	self:Log("SPELL_AURA_REMOVED_DOSE", "RoarRemoved", 74976)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Roar(args)
	if self:Me(args.destGUID) then
		self:Flash(args.spellId)
		self:StackMessageOld(args.spellId, args.destName, 3, "blue", "long", self:SpellName(56748)) -- 56748 = "Roar"
	end
end

function mod:RoarRemoved(args)
	if self:Me(args.destGUID) then
		self:StackMessageOld(args.spellId, args.destName, args.amount, "blue", nil, self:SpellName(56748)) -- 56748 = "Roar"
	end
end

function mod:Phalanx(args)
	self:MessageOld(args.spellId, "red", "alert")
	self:Bar(args.spellId, 30)
end

function mod:Encumbered(args)
	self:MessageOld(args.spellId, "red", "alert")
	self:Bar(args.spellId, 30)
end

function mod:Blades(args)
	self:MessageOld(args.spellId, "red", "alert")
	self:Bar(args.spellId, 30)
end

function mod:Impale(args)
	self:TargetMessageOld(args.spellId, args.destName, "orange")
end

function mod:CaveIn(args)
	if self:Me(args.destGUID) then
		self:TargetMessageOld(args.spellId, args.destName, "blue", "alarm")
		self:Flash(args.spellId)
	end
end

