
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Vizier Jin'bak", 1011, 693)
if not mod then return end
mod:RegisterEnableMob(61567)
mod.engageId = 1465
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-5960, -- Sap Residue
		-5958, -- Summon Sap Globule
		-5959, -- Detonate
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Log("SPELL_AURA_APPLIED_DOSE", "SapResidue", 119941)
	self:Log("SPELL_AURA_APPLIED", "Detonate", 120001)
end

function mod:OnEngage()
	self:CDBar(-5958, 10.8, CL.adds) -- Summon Sap Globule
	self:CDBar(-5959, 30.2) -- Detonate
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 119990 then -- Summon Saplings
		self:MessageOld(-5958, "yellow", "info", CL.incoming:format(CL.adds))
		self:CDBar(-5958, 46.1, CL.adds)
	end
end

function mod:SapResidue(args)
	if self:Me(args.destGUID) and args.amount % 2 == 0 then
		self:StackMessage(-5960, args.destName, args.amount, "blue", "alert")
	end
end

function mod:Detonate(args)
	self:MessageOld(-5959, "red", "alarm", CL.casting:format(args.spellName))
	self:CastBar(-5959, 5)
	self:CDBar(-5959, 46.1)
end
