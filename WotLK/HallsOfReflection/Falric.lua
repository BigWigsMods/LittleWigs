-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Falric", 668, 601)
if not mod then return end
mod:RegisterEnableMob(38112)
mod.engageId = 1992
mod.respawnTime = 30 -- you have to actually walk towards the altar, nothing will respawn on its own

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		72426, -- Impending Despair
		72422, -- Quivering Strike
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "QuiveringStrike", 72422)
	self:Log("SPELL_AURA_REMOVED", "QuiveringStrikeRemoved", 72422)
	self:Log("SPELL_AURA_APPLIED", "ImpendingDespair", 72426)
	self:Log("SPELL_AURA_REMOVED", "ImpendingDespairRemoved", 72426)
end

function mod:OnWin()
	local marwynMod = BigWigs:GetBossModule("Marwyn", true)
	if marwynMod then
		marwynMod:Enable()
		marwynMod:Warmup()
	end
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:QuiveringStrike(args)
	if self:Me(args.destGUID) or self:Dispeller("magic") then
		self:TargetMessageOld(args.spellId, args.destName, "orange")
		self:TargetBar(args.spellId, 5, args.destName)
	end
end

function mod:QuiveringStrikeRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:ImpendingDespair(args)
	if self:Me(args.destGUID) or self:Dispeller("magic") then
		self:TargetMessageOld(args.spellId, args.destName, "red", "warning", nil, nil, true)
		self:TargetBar(args.spellId, 6, args.destName)
	end
end

function mod:ImpendingDespairRemoved(args)
	self:StopBar(args.spellName, args.destName)
end
