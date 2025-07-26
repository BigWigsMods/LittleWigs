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

local nextSinlightVisions = 0

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
	self:CDBar(322936, 4.4) -- Crumbling Slam
	self:CDBar(322943, 12.0) -- Heave Debris
	if self:Mythic() then
		self:CDBar(322711, 32.8, CL.beams) -- Refracted Sinlight
	else -- Heroic/Normal
		nextSinlightVisions = GetTime() + 19.2
		self:CDBar(339237, 19.2, CL.fear) -- Sinlight Visions
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
	self:CDBar(args.spellId, 13.3)
	self:PlaySound(args.spellId, "alert")
end

function mod:HeaveDebris(args)
	self:Message(args.spellId, "yellow")
	if self:Mythic() then
		self:CDBar(args.spellId, 13.3)
	else -- Heroic / Normal
		self:CDBar(args.spellId, 11.0)
	end
	self:PlaySound(args.spellId, "alarm")
end

function mod:RefractedSinlight(args)
	self:Message(args.spellId, "red", CL.beams)
	if self:Mythic() then
		self:CDBar(322943, 15.0) -- Heave Debris
		self:CDBar(322936, 21.8) -- Crumbling Slam
		self:CDBar(args.spellId, 49.7, CL.beams)
	else -- Heroic / Normal
		self:CDBar(322936, 15.6) -- Crumbling Slam
		self:CDBar(322943, 15.6) -- Heave Debris
		local t = GetTime()
		if nextSinlightVisions - t < 15.6 then
			nextSinlightVisions = t + 15.6
			self:CDBar(339237, {15.6, 24.4}, CL.fear) -- Sinlight Visions
		end
		self:CDBar(args.spellId, 46.4, CL.beams)
	end
	self:PlaySound(args.spellId, "warning")
end

function mod:SinlightVisions(args) -- Heroic/Normal only
	nextSinlightVisions = GetTime() + 24.4
	self:CDBar(339237, 24.4, CL.fear) -- Sinlight Visions
end

function mod:SinlightVisionsApplied(args)
	self:TargetMessage(339237, "orange", args.destName, CL.fear)
	self:PlaySound(339237, "alert", nil, args.destName)
end
