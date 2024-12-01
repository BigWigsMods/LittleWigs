--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Admiral Ripsnarl", 36, 92)
if not mod then return end
mod:RegisterEnableMob(47626) -- Admiral Ripsnarl
mod:SetEncounterID(mod:Retail() and 2979 or 1062)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local vanishCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Admiral Ripsnarl
		88840, -- Vanish
		88836, -- Go For the Throat
		-- Vapor
		92042, -- Coalesce
	}, {
		[88840] = self.displayName, -- Admiral Ripsnarl
		[92042] = -2049, -- Vapor
	}
end

function mod:OnBossEnable()
	if self:Retail() then
		if self:Normal() then
			self:SetEncounterID(2974)
		else -- Heroic
			self:SetEncounterID(2979)
		end
		-- no ENCOUNTER_END in Retail since 11.0.5
		self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
		self:Death("Win", 47626) -- Admiral Ripsnarl
	end

	-- Admiral Ripsnarl
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1") -- Vanish
	self:Log("SPELL_CAST_SUCCESS", "GoForTheThroat", 88836)

	-- Vapor
	self:Log("SPELL_CAST_START", "Coalesce", 92042)
end

function mod:OnEngage()
	vanishCount = 1
	if self:Heroic() then
		self:CDBar(88836, 9.7) -- Go For the Throat
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Admiral Ripsnarl

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 88840 then -- Vanish
		-- cast at 75%, 50%, 25%
		self:Message(spellId, "cyan", CL.percent:format(100 - 25 * vanishCount, self:SpellName(spellId)))
		self:PlaySound(spellId, "long")
		vanishCount = vanishCount + 1
		if self:Normal() then
			self:Bar(spellId, 8.9, CL.over:format(self:SpellName(spellId)))
		else
			self:Bar(spellId, 23.4, CL.over:format(self:SpellName(spellId)))
			self:CDBar(88836, 33.9) -- Go For the Throat
		end
	end
end

function mod:GoForTheThroat(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
	if self:Heroic() then
		self:CDBar(args.spellId, 9.7)
	end
end

-- Vapor

function mod:Coalesce(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "warning")
end
