--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ick & Krick", 658, 609)
if not mod then return end
mod:RegisterEnableMob(36476, 36477)
mod:SetEncounterID(mod:Classic() and 835 or 2001)

--------------------------------------------------------------------------------
-- Locals
--

local barrage = nil
local pursuitWarned = {}

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{70274, "ICON", "FLASH"}, -- Toxic Waste
		68989, -- Poison Nova
		69263, -- Explosive Barrage
		68987, -- Pursuit
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Barrage", 69263)
	self:Log("SPELL_AURA_REMOVED", "BarrageEnd", 69263)
	self:Log("SPELL_AURA_APPLIED", "ToxicWaste", 69024, 70274)
	self:Log("SPELL_CAST_START", "PoisonNova", 68989)

	self:RegisterEvent("UNIT_AURA")
end

function mod:OnEngage()
	barrage = nil
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Barrage(args)
	if barrage then return end
	barrage = true
	self:Message(args.spellId, "red")
	self:Bar(args.spellId, 18)
end

function mod:BarrageEnd(args)
	barrage = false
	self:StopBar(args.spellName)
end

function mod:ToxicWaste(args)
	if self:Me(args.destGUID) then
		self:MessageOld(70274, "blue", "alarm", CL.underyou:format(args.spellName))
		self:Flash(70274)
	end
end

function mod:PoisonNova(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:Bar(args.spellId, 5)
end

function mod:UNIT_AURA(_, unit)
	local name = self:UnitDebuff(unit, 68987) -- Pursuit
	local n = self:UnitName(unit)
	if pursuitWarned[n] and not name then
		pursuitWarned[n] = nil
	elseif name and not pursuitWarned[n] then
		self:TargetMessageOld(68987, n, "yellow", "alert")
		pursuitWarned[n] = true
	end
end
