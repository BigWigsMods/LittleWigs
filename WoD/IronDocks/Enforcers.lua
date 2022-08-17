--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Grimrail Enforcers", 1195, 1236)
if not mod then return end
mod:RegisterEnableMob(80805, 80808, 80816) -- Makogg Emberblade, Neesa Nox, Ahri'ok Dugru
mod:SetEncounterID(1748)
mod:SetRespawnTime(33)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.sphere_fail_message = "Bubble was removed - They're all healing :("
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		163689, -- Sanguine Sphere
		163705, -- Abrupt Restoration
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_AURA_APPLIED", "SanguineSphere", 163689)
	self:Log("SPELL_AURA_REMOVED", "SanguineSphereRemoved", 163689)
	self:Log("SPELL_AURA_APPLIED", "AbruptRestoration", 163705)
	self:Death("AhriokDeath", 80816)
end

function mod:OnEngage()
	-- TODO when is Sanguine Sphere first cast?
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SanguineSphere(args)
	self:TargetMessage(args.spellId, UnitIsUnit("target", args.destName) and "red" or "yellow", args.destName)
	self:PlaySound(args.spellId, UnitIsUnit("target", args.destName) and "warning" or "alert")
	self:TargetBar(args.spellId, 15, args.destName)
	self:Bar(args.spellId, 26.7)
end

do
	local function alertSanguineSphereExpired(spellName)
		mod:Message(163689, "green", CL.over:format(spellName))
		mod:PlaySound(163689, "info")
	end

	local scheduled = nil
	function mod:SanguineSphereRemoved(args)
		scheduled = self:ScheduleTimer(alertSanguineSphereExpired, 0.3, args.spellName)
	end

	local prev = 0
	function mod:AbruptRestoration(args)
		self:CancelTimer(scheduled)
		self:StopBar(163689, args.destName) -- Sanguine Sphere
		local t = GetTime()
		if t-prev > 10 then
			prev = t
			self:Message(args.spellId, "yellow", L.sphere_fail_message)
			self:PlaySound(args.spellId, "warning")
		end
	end
end

function mod:AhriokDeath()
	self:StopBar(163689) -- Sanguine Sphere
end
