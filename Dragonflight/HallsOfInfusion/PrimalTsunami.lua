--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Primal Tsunami", 2527, 2511)
if not mod then return end
mod:RegisterEnableMob(
	189729, -- Primal Tsunami
	196043  -- Primalist Infuser
)
mod:SetEncounterID(2618)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		-- Stage 1
		387559, -- Infused Globules
		388424, -- Tempest's Fury
		{387504, "TANK"}, -- Squall Buffet
		-- Stage 2
		388882, -- Inundate
	}, {
		[387559] = -25529, -- Stage One: Violent Swells
		[388882] = -25531, -- Stage Two: Infused Waters
	}
end

function mod:OnBossEnable()
	-- Stages
	self:Log("SPELL_AURA_APPLIED", "SubmergeApplied", 387585)
	self:Log("SPELL_AURA_REMOVED", "SubmergeRemoved", 387585)

	-- Stage 1
	self:Log("SPELL_CAST_START", "InfusedGlobules", 387559)
	self:Log("SPELL_CAST_START", "TempestsFury", 388424)
	self:Log("SPELL_CAST_START", "SquallBuffet", 387504)

	-- Stage 2
	self:Log("SPELL_CAST_START", "Inundate", 388882)
end

function mod:OnEngage()
	self:SetStage(1)
	self:Bar(388424, 4) -- Tempest's Fury
	self:Bar(387504, 16) -- Squall Buffet
	self:Bar(387559, 17.6) -- Infused Globules
	self:Bar("stages", 51, CL.stage:format(2), 387585) -- Stage 2 (Submerge)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Stages

function mod:SubmergeApplied(args)
	self:SetStage(2)
	self:Message("stages", "cyan", CL.stage:format(2), args.spellId)
	self:PlaySound("stages", "long")
end

function mod:SubmergeRemoved(args)
	self:SetStage(1)
	self:Message("stages", "cyan", CL.stage:format(1), args.spellId)
	self:PlaySound("stages", "info")
end

-- Stage 1

function mod:InfusedGlobules(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 17.6)
end

function mod:TempestsFury(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 30)
end

function mod:SquallBuffet(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
end

-- Stage 2

function mod:Inundate(args)
	if self:MobId(args.sourceGUID) == 196043 then -- Primalist Infuser
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "alert")
	end
end
