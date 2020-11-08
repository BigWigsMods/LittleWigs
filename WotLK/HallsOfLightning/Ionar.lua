
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Ionar", 602, 599)
if not mod then return end
mod:RegisterEnableMob(28546)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{59795, "SAY", "FLASH", "PROXIMITY"}, -- Static Overload
		52770, -- Disperse
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "StaticOverload", 52658, 59795) -- normal, heroic
	self:Log("SPELL_AURA_REMOVED", "StaticOverloadRemoved", 52658, 59795)
	self:Log("SPELL_CAST_START", "Disperse", 52770)

	self:Death("Win", 28546)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:StaticOverload(args)
	self:TargetMessageOld(59795, args.destName, "yellow", "alarm")
	self:TargetBar(59795, 10, args.destName)
	if self:Me(args.destGUID) then
		self:Say(59795)
		self:OpenProximity(59795, 10)
		self:Flash(59795)
	end
end

function mod:StaticOverloadRemoved(args)
	self:StopBar(args.spellName, args.destName)
	if self:Me(args.destGUID) then
		self:CloseProximity(59795)
	end
end

function mod:Disperse(args)
	self:MessageOld(args.spellId, "orange", "info")
end

