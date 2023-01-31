-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ascendant Lord Obsidius", 645, 109)
if not mod then return end
mod:RegisterEnableMob(39705)
mod.engageId = 1036
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Locals
--

local nextTransformationWarning = 74

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		76188, -- Twilight Corruption
		76189, -- Crepuscular Veil
		{-2385, "ICON"}, -- Transformation
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "TwilightCorruption", 76188)
	self:Log("SPELL_AURA_REMOVED", "TwilightCorruptionRemoved", 76188)

	self:Log("SPELL_AURA_APPLIED", "CrepuscularVeil", 76189)

	self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1")
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
end

function mod:OnEngage()
	nextTransformationWarning = 74 -- 69% and 34%
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:TwilightCorruption(args)
	self:TargetMessageOld(args.spellId, args.destName, "red", "alarm", nil, nil, self:Dispeller("magic"))
	self:TargetBar(args.spellId, 12, args.destName)
end

function mod:TwilightCorruptionRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:CrepuscularVeil(args)
	if self:Tank(args.destName) then
		self:TargetMessageOld(args.spellId, args.destName, "yellow")
		self:TargetBar(args.spellId, 4, args.destName)
	end
end

function mod:UNIT_HEALTH(event, unit)
	local hp = self:GetHealth(unit)
	if hp < nextTransformationWarning then
		self:MessageOld(-2385, "yellow", nil, CL.soon:format(self:SpellName(-2385))) -- Transformation
		nextTransformationWarning = nextTransformationWarning - 35

		while nextTransformationWarning >= 34 and hp < nextTransformationWarning do
			-- account for high-level characters hitting multiple thresholds
			nextTransformationWarning = nextTransformationWarning - 35
		end

		if nextTransformationWarning < 34 then
			self:UnregisterUnitEvent(event, unit)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, unit, _, spellId)
	if spellId == 76196 then -- Transformation
		self:MessageOld(-2385, "orange")
		if self:CheckOption(-2385, "ICON") then
			self:CustomIcon(false, unit, 8) -- self:PrimaryIcon() is for group members
		end
	end
end
