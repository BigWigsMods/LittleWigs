--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Halkias, the Sin-Stained Goliath", 2287, 2406)
if not mod then return end
mod:RegisterEnableMob(165408) -- Halkias
mod:SetEncounterID(2401)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local crumblingSlamCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self:SetSpellRename(322711, CL.beams) -- Refracted Sinlight (Beams)
	self:SetSpellRename(339237, CL.fear) -- Sinlight Visions (Fear)
end

function mod:GetOptions()
	return {
		323001, -- Glass Shards
		322936, -- Crumbling Slam
		322943, -- Heave Debris
		322711, -- Refracted Sinlight
		339237, -- Sinlight Visions
	}, nil, {
		[322711] = CL.beams, -- Refracted Sinlight (Beams)
		[339237] = CL.fear, -- Sinlight Visions (Fear)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_PERIODIC_DAMAGE", "GlassShardsDamage", 323001)
	self:Log("SPELL_PERIODIC_MISSED", "GlassShardsDamage", 323001)
	self:Log("SPELL_CAST_START", "CrumblingSlam", 322936)
	self:Log("SPELL_CAST_START", "HeaveDebris", 322943)
	self:Log("SPELL_CAST_START", "RefractedSinlight", 322711)
	self:Log("SPELL_CAST_START", "SinlightVisions", 322977) -- Heroic/Normal only
	self:Log("SPELL_AURA_APPLIED", "SinlightVisionsApplied", 339237, 322977) -- Mythic, Heroic/Normal
end

function mod:OnEngage()
	crumblingSlamCount = 0
	self:CDBar(322936, 4.5) -- Crumbling Slam
	self:CDBar(322943, 13.1) -- Heave Debris
	if self:Mythic() then
		self:CDBar(322711, 49.8, CL.beams) -- Refracted Sinlight
	else -- Heroic/Normal
		self:CDBar(339237, 13.1, CL.fear) -- Sinlight Visions
		self:CDBar(322711, 32.6, CL.beams) -- Refracted Sinlight
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prev = 0
	function mod:GlassShardsDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 2.25 then -- 0.5s tick rate
			prev = args.time
			self:PersonalMessage(args.spellId, "underyou")
			self:PlaySound(args.spellId, "underyou")
		end
	end
end

function mod:CrumblingSlam(args)
	self:Message(args.spellId, "purple")
	crumblingSlamCount = crumblingSlamCount + 1
	-- only the second Crumbling Slam of the fight is delayed
	self:CDBar(args.spellId, crumblingSlamCount == 1 and 13.4 or 12.1)
	self:PlaySound(args.spellId, "alert")
end

function mod:HeaveDebris(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 12.1)
	self:PlaySound(args.spellId, "alarm")
end

function mod:RefractedSinlight(args)
	self:Message(args.spellId, "red", CL.beams)
	self:CDBar(322936, 15.7) -- Crumbling Slam
	self:CDBar(322943, 17.2) -- Heave Debris
	self:CDBar(args.spellId, 47.3, CL.beams)
	self:PlaySound(args.spellId, "warning")
end

function mod:SinlightVisions(args) -- Heroic/Normal only
	self:CDBar(339237, 30.1, CL.fear) -- Sinlight Visions
end

function mod:SinlightVisionsApplied(args)
	self:TargetMessage(339237, "orange", args.destName, CL.fear)
	self:PlaySound(339237, "alert", nil, args.destName)
end
