
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Galvazzt", 1877, 2144)
if not mod then return end
mod:RegisterEnableMob(133389)
mod.engageId = 2126

--------------------------------------------------------------------------------
-- Locals
--

local galvanizeList = {}

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{266923, "INFOBOX"}, -- Galvanize
		266512, -- Consume Charge
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Galvanize", 266923)
	self:Log("SPELL_AURA_APPLIED_DOSE", "GalvanizeStack", 266923)
	self:Log("SPELL_AURA_REMOVED", "GalvanizeRemoved", 266923)
	self:Log("SPELL_AURA_APPLIED", "GalvanizeOnBoss", 265986) -- Spell aura on boss is called 'Arc'
	self:Log("SPELL_CAST_START", "ConsumeCharge", 266512)
end

function mod:OnEngage()
	galvanizeList = {}
	self:OpenInfo(266923, self:SpellName(266923)) -- Galvanize
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Galvanize(args)
	galvanizeList[args.destName] = 1
	self:SetInfoByTable(args.spellId, galvanizeList)
end

function mod:GalvanizeStack(args)
	galvanizeList[args.destName] = args.amount
	self:SetInfoByTable(args.spellId, galvanizeList)
	if self:Me(args.destGUID) then
		if args.amount % 3 == 0 then
			self:StackMessage(args.spellId, args.destName, args.amount, "blue")
			if args.amount > 6 then
				self:PlaySound(args.spellId, "info")
			end
		end
	end
end

function mod:GalvanizeRemoved(args)
	galvanizeList[args.destName] = 0
	self:SetInfoByTable(args.spellId, galvanizeList)
end

function mod:GalvanizeOnBoss(args)
	self:Message2(266923, "orange", CL.other:format(args.spellName, args.destName))
	self:PlaySound(266923, "alarm")
end

function mod:ConsumeCharge(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
end
