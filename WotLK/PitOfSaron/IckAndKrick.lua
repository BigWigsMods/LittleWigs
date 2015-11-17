
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Ick & Krick", 602, 609)
if not mod then return end
mod:RegisterEnableMob(36476, 36477)

local barrage = nil
local pursuitWarned = {}

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		70274, -- Toxic Waste
		68989, -- Poison Nova
		69263, -- Explosive Barrage
		68987, -- Pursuit
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Barrage", 69263)
	self:Log("SPELL_AURA_REMOVED", "BarrageEnd", 69263)
	self:Log("SPELL_AURA_APPLIED", "ToxicWaste", 70274)
	self:Log("SPELL_CAST_START", "PoisonNova", 68989)
	self:Death("Win", 36476)

	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
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
	self:Message(args.spellId, "Important")
	self:Bar(args.spellId, 18)
end

function mod:BarrageEnd(args)
	barrage = false
	self:StopBar(args.spellName)
end

function mod:ToxicWaste(args)
	if self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, args.destName, "Personal", "Alarm")
		self:Flash(args.spellId)
	end
end

function mod:PoisonNova(args)
	self:Message(args.spellId, "Urgent", nil, CL.casting:format(args.spellName))
	self:Bar(args.spellId, 5)
end

function mod:UNIT_AURA(event, unit)
	local name = UnitDebuff(unit, self:SpellName(68987))
	local n = self:UnitName(unit)
	if pursuitWarned[n] and not name then
		pursuitWarned[n] = nil
	elseif name and not pursuitWarned[n] then
		self:TargetMessage(68987, n, "Attention", "Alert")
		pursuitWarned[n] = true
	end
end

