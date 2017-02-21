if not IsTestBuild() then return end -- XXX dont load on live
--------------------------------------------------------------------------------
-- TODO List:
-- - Do we need warnings for the add spells?
-- - Approaching Doom might be a cast we can track instead

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

local cleaveCounter = 1
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
	self:Log("SPELL_CAST_START", "FelsoulCleave", 236543)
	self:Log("SPELL_CAST_START", "ChaoticEnergy", 234107)
end

function mod:OnEngage()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
	cleaveCounter = 1
	felPortalGuardiansCounter = 1

	self:CDBar(236543, 8.4)
	self:CDBar(234107, 31.4)
end

--------------------------------------------------------------------------------
-- Event Handlers
--
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
					if self:Mythic() then
						self:CDBar(241622, 60, CL.count:format(self:SpellName(241622), felPortalGuardianCollector[guid]))
					end
					self:Message(-15076, "Attention", "Alert", CL.count:format(CL.spawned:format(self:SpellName(-15076)), felPortalGuardiansCounter))
					felPortalGuardiansCounter = felPortalGuardiansCounter + 1
				end
				felPortalGuardians[guid] = true
			end
		end
	end

	for guid,_ in pairs(felPortalGuardianCollector) do
		if not felPortalGuardians[guid] then
			-- Fel Portal Guardian Died
			self:StopBar(CL.count:format(self:SpellName(241622), felPortalGuardianCollector[guid]))
			felPortalGuardianCollector[guid] = nil
		end
	end
end

function mod:FelsoulCleave(args)
	cleaveCounter = cleaveCounter + 1
	self:Message(args.spellId, "Attention", "Alert")
	self:CDBar(args.spellId, cleaveCounter <= 2 and 18.2 or 17)
end

function mod:ChaoticEnergy(args)
	self:Message(args.spellId, "Urgent", "Warning")
	self:CDBar(args.spellId, 35.3)
end
