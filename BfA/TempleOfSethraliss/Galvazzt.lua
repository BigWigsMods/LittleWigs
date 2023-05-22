
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Galvazzt", 1877, 2144)
if not mod then return end
mod:RegisterEnableMob(133389)
mod.engageId = 2126
mod.respawnTime = 25

--------------------------------------------------------------------------------
-- Locals
--

local galvanizeList = {}


--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.percent = "%s (%d%%)"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{266923, "INFOBOX"}, -- Galvanize
		{266512, "CASTBAR"}, -- Consume Charge
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_POWER_FREQUENT", nil, "boss1")

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

do
	local prev = 0
	function mod:UNIT_POWER_FREQUENT(_, unit, powerType)
		if powerType == "ALTERNATE" then
			local t = GetTime()
			if t-prev > (self:Normal() and 3 or 0.5) then
				prev = t
				local power = UnitPower(unit, 10) -- Alternate power, max 100
				if power > 0 then
					self:Message(266512, "orange", L.percent:format(self:SpellName(266512), power)) -- Consume Charge
					self:PlaySound(266512, "alarm") -- Consume Charge
				end
			end
		end
	end
end

function mod:Galvanize(args)
	galvanizeList[args.destName] = 1
	self:SetInfoByTable(args.spellId, galvanizeList)
end

function mod:GalvanizeStack(args)
	galvanizeList[args.destName] = args.amount
	self:SetInfoByTable(args.spellId, galvanizeList)
	if self:Me(args.destGUID) then
		if args.amount % 3 == 0 then
			self:StackMessageOld(args.spellId, args.destName, args.amount, "blue")
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
	self:Message(266923, "orange", -18921) -- Galvanize, Energy Core
	self:PlaySound(266923, "alert")
end

function mod:ConsumeCharge(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	self:CastBar(args.spellId, 3)
end
