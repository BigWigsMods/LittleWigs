
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Grimrail Enforcers", 1195, 1236)
if not mod then return end
mod:RegisterEnableMob(80805, 80808, 80816) -- Makogg Emberblade, Neesa Nox, Ahri'ok Dugru

--------------------------------------------------------------------------------
-- Locals
--

local deaths = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.sphere = "{-10450} ({119924})" -- Sanguine Sphere (Bubble)
	L.sphere_desc = -10450
	L.sphere_icon = 163689
	L.sphere_fail_message = "Bubble was removed - They're all healing :("
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"sphere", -- Sanguine Sphere
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_AURA_APPLIED", "SanguineSphere", 163689)
	self:Log("SPELL_AURA_REMOVED", "SanguineSphereRemoved", 163689)
	self:Log("SPELL_AURA_APPLIED", "AbruptRestoration", 163705)

	self:Death("Deaths", 80805, 80808, 80816) -- Makogg Emberblade, Neesa Nox, Ahri'ok Dugru
end

function mod:OnEngage()
	deaths = 0
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SanguineSphere(args)
	local bubble = self:SpellName(119924) -- 119924 = "Bubble"
	self:TargetMessage("sphere", args.destName, "Attention", UnitIsUnit("target", args.destName) and "Warning", bubble, args.spellId)
	self:TargetBar("sphere", 15, args.destName, bubble, args.spellId)
end

do
	local scheduled = nil
	function mod:SanguineSphereRemoved(args)
		scheduled = self:ScheduleTimer("Message", 0.3, "sphere", "Positive", "Info", CL.over:format(self:SpellName(119924)), args.spellId)
	end

	local prev = 0
	function mod:AbruptRestoration(args)
		self:CancelTimer(scheduled)
		self:StopBar(119924, args.destName) -- Bubble target bar
		local t = GetTime()
		if t-prev > 10 then
			prev = t
			self:Message("sphere", "Attention", nil, L.sphere_fail_message, args.spellId)
		end
	end
end

function mod:Deaths()
	deaths = deaths + 1
	if deaths > 2 then
		self:Win()
	end
end

