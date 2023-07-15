--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Vizier Jin'bak", 1011, 693)
if not mod then return end
mod:RegisterEnableMob(61567)
mod:SetEncounterID(1465)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-5960, -- Sap Residue
		-5958, -- Summon Sap Globule
		{-5959, "CASTBAR"}, -- Detonate
	}, nil, {
		[-5958] = CL.adds,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED_DOSE", "SapResidue", 119941)
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1") -- Summon Sap Globule
	self:Log("SPELL_AURA_APPLIED", "Detonate", 120001)
end

function mod:OnEngage()
	self:CDBar(-5958, 10.0, CL.adds) -- Summon Sap Globule
	self:CDBar(-5959, 30.2) -- Detonate
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SapResidue(args)
	if self:Me(args.destGUID) and args.amount % 2 == 0 then
		self:StackMessage(-5960, "blue", args.destName, args.amount, 2)
		self:PlaySound(-5960, "alert")
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 119990 then -- Summon Sappling
		self:Message(-5958, "yellow", CL.incoming:format(CL.adds))
		self:PlaySound(-5958, "info")
		self:CDBar(-5958, 45.0, CL.adds)
	end
end

function mod:Detonate(args)
	self:Message(-5959, "red", CL.casting:format(args.spellName))
	self:PlaySound(-5959, "alarm")
	self:CastBar(-5959, 5)
	self:CDBar(-5959, 45.0)
end
