
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Halkias, the Sin-Stained Goliath", 2287, 2406)
if not mod then return end
mod:RegisterEnableMob(165408) -- Halkias
mod.engageId = 2401
--mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Locals
--

local slamCount = 1
local debrisCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		323001, -- Glass Shards
		{322936, "TANK"}, -- Crumbling Slam
		322943, -- Heave Debris
		322711, -- Refracted Sinlight
		322977, -- Sinlight Visions
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "GlassShardsDamage", 323001)
	self:Log("SPELL_PERIODIC_DAMAGE", "GlassShardsDamage", 323001)
	self:Log("SPELL_PERIODIC_MISSED", "GlassShardsDamage", 323001)
	self:Log("SPELL_CAST_START", "CrumblingSlam", 322936)
	self:Log("SPELL_CAST_SUCCESS", "HeaveDebris", 322943)
	self:Log("SPELL_CAST_START", "RefractedSinlight", 322711)
	self:Log("SPELL_CAST_START", "SinlightVisions", 322977)
	--self:Log("SPELL_AURA_APPLIED", "SinlightVisionsApplied", 322977)
end

function mod:OnEngage()
	slamCount = 1
	debrisCount = 1

	self:CDBar(322936, 5) -- Crumbling Slam
	self:CDBar(322943, 12) -- Heave Debris
	self:CDBar(322977, 27) -- Sinlight Visions
	self:CDBar(322711, 35) -- Refracted Sinlight
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prev = 0
	function mod:GlassShardsDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t-prev > 2 then
				prev = t
				self:PlaySound(args.spellId, "alarm")
				self:PersonalMessage(args.spellId, "underyou")
			end
		end
	end
end

function mod:CrumblingSlam(args)
	self:Message2(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	slamCount = slamCount + 1
	self:CDBar(args.spellId, slamCount % 2 == 0 and 14 or 45)
end

function mod:HeaveDebris(args)
	self:Message2(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
	debrisCount = debrisCount + 1
	self:CDBar(args.spellId, debrisCount % 2 == 0 and 17 or 28)
end

function mod:RefractedSinlight(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	self:Bar(args.spellId, 45) -- XXX Estimated
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage2(322977, "orange", name) -- Sinlight Visions
		self:PlaySound(322977, "alarm", nil, name) -- Sinlight Visions
	end

	function mod:SinlightVisions(args)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
		self:Bar(args.spellId, 45)
	end
end
