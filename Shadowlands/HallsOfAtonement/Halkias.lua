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

local refractedSinlightTime = 0
local crumblingSlamCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		323001, -- Glass Shards
		{322936, "TANK"}, -- Crumbling Slam
		322943, -- Heave Debris
		322711, -- Refracted Sinlight
		339237, -- Sinlight Visions
	}, nil, {
		[322711] = CL.beams, -- Refracted Sinlight (Beams)
		[339237] = CL.fear, -- Sinlight Visions (Fear)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "GlassShardsDamage", 323001)
	self:Log("SPELL_PERIODIC_DAMAGE", "GlassShardsDamage", 323001)
	self:Log("SPELL_PERIODIC_MISSED", "GlassShardsDamage", 323001)
	self:Log("SPELL_CAST_START", "CrumblingSlam", 322936)
	self:Log("SPELL_CAST_SUCCESS", "HeaveDebris", 322943)
	self:Log("SPELL_CAST_START", "RefractedSinlight", 322711)
	self:Log("SPELL_AURA_APPLIED", "SinlightVisionsApplied", 339237, 322977)

	self:RegisterMessage("BigWigs_BarCreated", "BarCreated")
end

function mod:OnEngage()
	refractedSinlightTime = GetTime() + 49.8
	crumblingSlamCount = 0
	self:CDBar(322936, 4.9) -- Crumbling Slam
	self:CDBar(322943, 13.7) -- Heave Debris
	self:CDBar(322711, 49.8, CL.beams) -- Refracted Sinlight
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local function stopAtZeroSec(bar)
		if bar.remaining < 0.15 then -- Pause at 0.0
			bar:SetDuration(0.01) -- Make the bar look full
			bar:Start()
			bar:Pause()
			bar:SetTimeVisibility(false)
		end
	end

	function mod:BarCreated(_, _, bar, _, key)
		if key == 322711 then -- Refracted Sinlight
			bar:AddUpdateFunction(stopAtZeroSec)
		end
	end
end

do
	local prev = 0
	function mod:GlassShardsDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t-prev > 2 then
				prev = t
				self:PersonalMessage(args.spellId, "underyou")
				self:PlaySound(args.spellId, "underyou")
			end
		end
	end
end

function mod:CrumblingSlam(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	crumblingSlamCount = crumblingSlamCount + 1
	if refractedSinlightTime - GetTime() > 12.1 then
		-- only the second Crumbling Slam of the fight is delayed
		self:CDBar(args.spellId, crumblingSlamCount == 1 and 13.4 or 12.1)
	end
end

function mod:HeaveDebris(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
	if refractedSinlightTime - GetTime() > 12.1 then
		self:CDBar(args.spellId, 12.1)
	end
end

function mod:RefractedSinlight(args)
	refractedSinlightTime = GetTime() + 45
	self:Message(args.spellId, "red", CL.beams)
	self:PlaySound(args.spellId, "warning")
	self:Bar(args.spellId, 47.3, CL.beams)
	self:CDBar(322936, 15.7) -- Crumbling Slam
	self:CDBar(322943, 17.2) -- Heave Debris
end

function mod:SinlightVisionsApplied(args)
	self:TargetMessage(339237, "orange", args.destName, CL.fear)
	self:PlaySound(339237, "alert")
end
