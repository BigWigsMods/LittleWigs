
--------------------------------------------------------------------------------
-- TODO List:
-- - Do we need warnings for the add spells?
-- - Mythic Abilities

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Domatrax", 1146, 1904)
if not mod then return end
mod:RegisterEnableMob(118804)
mod.engageId = 2053

--------------------------------------------------------------------------------
-- Locals
--

local felPortalGuardianCollector = {}
local felPortalGuardiansCounter = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		236543, -- Felsoul Cleave
		234107, -- Chaotic Energy
		-15076, -- Fel Portal Guardian
		241622, -- Approaching Doom
	},{
		[236543] = -15011,
		[241622] = "mythic",
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Log("SPELL_CAST_START", "FelsoulCleave", 236543)
	self:Log("SPELL_CAST_START", "ChaoticEnergy", 234107)
end

function mod:OnEngage()
	self:CDBar(236543, 8.3) -- Felsoul Cleave
	self:CDBar(234107, 32.5) -- Chaotic Energy
	if self:Mythic() then
		self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
		felPortalGuardiansCounter = 1
		wipe(felPortalGuardianCollector)
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--
function mod:UNIT_SPELLCAST_SUCCEEDED(unit, spellName, _, _, spellId)
	if spellId == 235822 or spellId == 235862 then -- Start Wave 1 + 2
		self:Message(-15076, "Important", "Alarm", CL.incoming:format(self:SpellName(-15076)))
	end
end

function mod:FelsoulCleave(args)
	self:Message(args.spellId, "Attention", "Alert")
	self:CDBar(args.spellId, 18.5)
end

function mod:ChaoticEnergy(args)
	self:Message(args.spellId, "Urgent", "Warning")
	self:CDBar(args.spellId, 37.6)
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	local felPortalGuardians = {}

	for i = 1, 5 do
		local guid = UnitGUID(("boss%d"):format(i))
		if guid then
			local mobId = self:MobId(guid)
			if mobId == 118834 then -- Fel Portal Guardian
				if not felPortalGuardianCollector[guid] then
					-- New Fel Portal Guardian
					felPortalGuardianCollector[guid] = felPortalGuardiansCounter
					self:CDBar(241622, 20, CL.cast:format(CL.count:format(self:SpellName(241622), felPortalGuardiansCounter)))
					felPortalGuardiansCounter = felPortalGuardiansCounter + 1
				end
				felPortalGuardians[guid] = true
			end
		end
	end

	for guid,_ in pairs(felPortalGuardianCollector) do
		if not felPortalGuardians[guid] then
			-- Fel Portal Guardian Died
			self:StopBar(CL.cast:format(CL.count:format(self:SpellName(241622), felPortalGuardianCollector[guid])))
			felPortalGuardianCollector[guid] = nil
		end
	end
end