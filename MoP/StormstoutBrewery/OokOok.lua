
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Ook-Ook", 961, 668)
if not mod then return end
mod:RegisterEnableMob(56637)
mod.engageId = 1412
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Locals
--

local bananasStacks = 0
local poundCastTime = {
	[0] = 1.5,
	[1] = 1.304,
	[2] = 1.154,
	[3] = 1.034,
 }

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{106807, "CASTBAR"}, -- Ground Pound
		106651, -- Going Bananas
		106648, -- Brew Explosion
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "GroundPound", 106807)
	self:Log("SPELL_AURA_APPLIED", "GoingBananas", 106651)
	self:Log("SPELL_AURA_APPLIED_DOSE", "GoingBananas", 106651)
	self:Log("SPELL_AURA_APPLIED", "BrewExplosion", 106648)
	self:Log("SPELL_AURA_APPLIED_DOSE", "BrewExplosion", 106648)
end

function mod:OnEngage()
	bananasStacks = 0
	self:CDBar(106807, 10.5) -- Ground Pound
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:GroundPound(args)
	self:MessageOld(args.spellId, "red", self:Tank() and "alarm" or "long", CL.casting:format(args.spellName))
	self:CastBar(args.spellId, poundCastTime[bananasStacks] + 3) -- pre-cast depends on stacks of "Going Bananas", channel is constant-time
	self:CDBar(args.spellId, 10.9)
end

function mod:GoingBananas(args)
	bananasStacks = args.amount or 1
	self:MessageOld(args.spellId, "cyan", "info", CL.stack:format(bananasStacks, args.spellName, args.destName)) -- StackMessage transforms "Ook-Ook" to "Ook*"
end

function mod:BrewExplosion(args)
	local amount = args.amount or 1
	if self:Me(args.destGUID) then
		self:StackMessageOld(args.spellId, args.destName, amount, "blue", "alert")
	end
end
