--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Chargath, Bane of Scales", 2519, 2490)
if not mod then return end
mod:RegisterEnableMob(189340) -- Chargath, Bane of Scales
mod:SetEncounterID(2613)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local recalculateFieryFocus = false

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		373424, -- Grounding Spear
		388523, -- Fetter
		375056, -- Fiery Focus
		373733, -- Dragon Strike
		373742, -- Magma Wave
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_POWER_UPDATE", nil, "boss1")
	self:Log("SPELL_CAST_START", "GroundingSpear", 373424)
	-- 3 different Fetter debuffs: 388523=long, 374655=short, 374638=player
	self:Log("SPELL_AURA_APPLIED", "FetterApplied", 388523, 374655)
	self:Log("SPELL_AURA_REMOVED", "FetterRemoved", 388523, 374655)
	self:Log("SPELL_CAST_START", "FieryFocus", 375056)
	self:Log("SPELL_CAST_SUCCESS", "FieryFocusOver", 375056)
	self:Log("SPELL_CAST_START", "DragonStrike", 373733)
	self:Log("SPELL_CAST_START", "MagmaWave", 373742)
end

function mod:OnEngage()
	self:CDBar(373733, 3.4) -- Dragon Strike
	self:CDBar(373424, 10.7) -- Grounding Spear
	self:CDBar(373742, 15.5) -- Magma Wave
	self:CDBar(375056, 29.3) -- Fiery Focus
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_POWER_UPDATE(_, unit)
	if recalculateFieryFocus then
		-- ~29 seconds between Fiery Focus casts, cast at max Energy
		local nextFieryFocus = ceil(29 * (1 - UnitPower(unit) / 100))
		if nextFieryFocus > 0 then
			recalculateFieryFocus = false
			self:Bar(375056, {nextFieryFocus + .2, 29.2}) -- Fiery Focus, ~.2s delay at max energy
		end
	end
end

function mod:GroundingSpear(args)
	-- targets all players in Mythic, but just one player in Normal/Heroic
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 9.7)
end

-- TODO might need to be redone for Mythic depending on spell IDs
-- Normal/Heroic: 1 stack of Fetter always stuns
-- Mythic: 1 or 2 hits of Fetter just slows, 3 hits stuns
function mod:FetterApplied(args)
	recalculateFieryFocus = true
	if args.spellId == 388523 then -- 14s long Fetter on boss
		self:Message(388523, "green", CL.onboss:format(args.spellName))
		self:PlaySound(388523, "info")
		self:Bar(388523, 14, CL.onboss:format(args.spellName))
	else -- 5s Short Fetter on boss
		self:Bar(388523, 5, CL.onboss:format(args.spellName))
		self:PauseBar(375056) -- Fiery Focus, Chargath doesn't gain energy during Fetter
	end
end

function mod:FetterRemoved(args)
	recalculateFieryFocus = true
end

function mod:FieryFocus(args)
	self:StopBar(args.spellName)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
end

function mod:FieryFocusOver(args)
	recalculateFieryFocus = true
end

do
	local function printTarget(self, name, guid)
		if self:Me(guid) or self:Healer() then
			self:TargetMessage(373733, "yellow", name)
			self:PlaySound(373733, "alert", nil, name)
		end
	end

	function mod:DragonStrike(args)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
		self:CDBar(args.spellId, 20.9)
	end
end

function mod:MagmaWave(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 22.4)
end
