if not IsTestBuild() then return end -- XXX dont load on live
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

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		236543, -- Felsoul Cleave
		234107, -- Chaotic Energy
		-15076, -- Fel Portal Guardian
		--241622, -- Approaching Doom
	},{
		[236543] = -15011,
		--[241622] = "mythic",
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Log("SPELL_CAST_START", "FelsoulCleave", 236543)
	self:Log("SPELL_CAST_START", "ChaoticEnergy", 234107)
end

function mod:OnEngage()
	self:CDBar(236543, 8.4) -- Felsoul Cleave
	self:CDBar(234107, 31.4) -- Chaotic Energy
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
	self:CDBar(args.spellId, 17)
end

function mod:ChaoticEnergy(args)
	self:Message(args.spellId, "Urgent", "Warning")
	self:CDBar(args.spellId, 35.2)
end
