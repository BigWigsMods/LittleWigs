if not IsTestBuild() then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Gulping Goliath", 2527, 2507)
if not mod then return end
mod:RegisterEnableMob(189722) -- Gulping Goliath
mod:SetEncounterID(2616)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		385551, -- Gulp
		385181, -- Overpowering Croak
		385531, -- Belly Slam
		385442, -- Toxic Effluvia
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Gulp", 385551)
	self:Log("SPELL_CAST_START", "OverpoweringCroak", 385181)
	self:Log("SPELL_CAST_START", "BellySlam", 385531)
	self:Log("SPELL_CAST_START", "ToxicEffluvia", 385442)
end

function mod:OnEngage()
	self:Bar(385181, 8.5) -- Overpowering Croak
	self:Bar(385551, 19.1) -- Gulp
	self:Bar(385442, 31.6) -- Toxic Effluvia
	self:Bar(385531, 40.1) -- Belly Slam
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Gulp(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	-- TODO timer
end

function mod:OverpoweringCroak(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 40.1)
end

function mod:BellySlam(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	-- TODO timer
end

function mod:ToxicEffluvia(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 27.5)
end
