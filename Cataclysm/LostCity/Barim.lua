
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("High Prophet Barim", 755, 119)
if not mod then return end
mod:RegisterEnableMob(43612)
mod.engageId = 1053
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{82622, "FLASH", "ICON"}, -- Plague of Ages
		82506, -- Fifty Lashings
		{88814, "FLASH"}, -- Hallowed Ground
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Plague", 82622)
	self:Log("SPELL_AURA_REMOVED", "PlagueRemoved", 82622)
	self:Log("SPELL_AURA_APPLIED", "FiftyLashings", 82506)
	self:Log("SPELL_AURA_APPLIED", "HallowedGround", 88814)

	self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Plague(args)
	if self:Me(args.destGUID) then
		self:TargetMessageOld(args.spellId, args.destName, "blue", "alarm")
		self:Flash(args.spellId)
	end
	self:PrimaryIcon(args.spellId, args.destName)
end

function mod:PlagueRemoved(args)
	self:PrimaryIcon(args.spellId)
end

function mod:FiftyLashings(args)
	self:MessageOld(args.spellId, "red")
end

function mod:HallowedGround(args)
	if self:Me(args.destGUID) then
		self:TargetMessageOld(args.spellId, args.destName, "blue")
		self:Flash(args.spellId)
	end
end

function mod:UNIT_HEALTH(event, unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < 55 then
		self:UnregisterUnitEvent(event, unit)
		self:MessageOld(88814, "yellow", nil, CL.soon:format(CL.phase:format(2)))
	end
end

