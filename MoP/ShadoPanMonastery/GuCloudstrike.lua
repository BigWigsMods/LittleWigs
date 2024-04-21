--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Gu Cloudstrike", 959, 673)
if not mod then return end
mod:RegisterEnableMob(
	56747, -- Gu Cloudstrike
	56754  -- Azure Serpent
)
mod:SetEncounterID(1303)
mod:SetRespawnTime(15)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		-- Stage One: Let Me Show You My Power!
		-5630, -- Static Field
		-- Stage Two: Charge Me With Your Power!
		107140, -- Magnetic Shroud
		102573, -- Lightning Breath
	}, {
		[-5630] = -5621, -- Stage One: Let Me Show You My Power!
		[107140] = -5624, -- Stage Two: Charge Me With Your Power!
	}
end

function mod:OnBossEnable()
	-- Stage One: Let Me Show You My Power!
	self:Log("SPELL_CAST_SUCCESS", "StaticField", 106923)
	self:Log("SPELL_DAMAGE", "StaticFieldDamage", 106932, 128889) -- initial cast, void zone
	self:Log("SPELL_MISSED", "StaticFieldDamage", 106932, 128889) -- initial cast, void zone

	-- Stage Two: Charge Me With Your Power!
	self:Log("SPELL_AURA_APPLIED", "ChargingSoulApplied", 110945)
	self:Log("SPELL_CAST_START", "MagneticShroud", 107140)
	self:Log("SPELL_CAST_START", "LightningBreath", 102573)

	-- Stage Three: Do Not Fail Me!
	self:Log("SPELL_AURA_REMOVED", "ChargingSoulRemoved", 110945)
end

function mod:OnEngage()
	self:SetStage(1)
	self:CDBar(-5630, 19.2) -- Static Field
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Stage One: Let Me Show You My Power!

function mod:StaticField()
	self:Message(-5630, "red")
	self:PlaySound(-5630, "alarm")
	self:CDBar(-5630, 8.1)
end

do
	local prev = 0
	function mod:StaticFieldDamage(args)
		local t = args.time
		if self:Me(args.destGUID) and t - prev > 2.5 then
			prev = t
			self:PersonalMessage(-5630, "underyou")
			self:PlaySound(-5630, "underyou")
		end
	end
end

-- Stage Two: Charge Me With Your Power!

function mod:ChargingSoulApplied()
	self:StopBar(-5630) -- Static Field
	self:SetStage(2)
	local _, serpent = EJ_GetCreatureInfo(2, 673) -- Azure Serpent
	self:Message("stages", "cyan", CL.other:format(CL.stage:format(2), serpent), false)
	self:PlaySound("stages", "long")
	self:CDBar(102573, 2.0) -- Lightning Breath
	self:CDBar(107140, 17.8) -- Magnetic Shroud
end

function mod:MagneticShroud(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 13.2)
end

function mod:LightningBreath(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 8.5)
end

-- Stage Three: Do Not Fail Me!

function mod:ChargingSoulRemoved()
	self:StopBar(102573) -- Lightning Breath
	self:StopBar(107140) -- Magnetic Shroud
	self:SetStage(3)
	self:Message("stages", "cyan", CL.stage:format(3)..": "..self.displayName.. " ("..self:SpellName(65294)..")", false) -- (Empowered)
	self:PlaySound("stages", "long")
end
