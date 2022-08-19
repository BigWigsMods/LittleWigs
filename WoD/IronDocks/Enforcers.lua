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
	L.sphere_fail_message = "Shield was broken - They're all healing :("
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		163689, -- Sanguine Sphere
		163705, -- Abrupt Restoration
		{163740, "DISPEL"}, -- Tainted Blood
		163665, -- Flaming Slash
		164956, -- Lava Swipe
	}, {
		[163689] = -10449, -- Ahri'ok Dugru
		[163665] = -10453, -- Makogg Emberblade
		--[?] = -10456, -- Neesa Nox
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	-- Makogg Emberblade
	self:Log("SPELL_CAST_START", "FlamingSlash", 163665)
	self:Death("MakoggDeath", 80805)

	-- Ahri'ok Dugru
	self:Log("SPELL_AURA_APPLIED", "SanguineSphere", 163689)
	self:Log("SPELL_AURA_REMOVED", "SanguineSphereRemoved", 163689)
	self:Log("SPELL_AURA_APPLIED", "AbruptRestoration", 163705)
	self:Log("SPELL_AURA_APPLIED", "TaintedBloodApplied", 163740)
	self:Death("AhriokDeath", 80816)

	-- Neesa Nox
	-- big boom?
end

function mod:OnEngage()
	self:CDBar(163689, 28) -- Sanguine Sphere
	self:Bar(163665, 4.9) -- Flaming Slash
	self:Bar(164956, 16.6) -- Lava Swipe
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 164956 then -- Lava Swipe
		self:Message(spellId, "red")
		self:PlaySound(spellId, "alert")
		self:Bar(spellId, 29.2)
	end
end

function mod:SanguineSphere(args)
	if UnitIsUnit("target", args.destGUID) then
		self:TargetMessage(args.spellId, "red", args.destName)	
		self:PlaySound(args.spellId, "warning")
	else
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "alert")
	end
	self:TargetBar(args.spellId, 10, args.destName)
	self:Bar(args.spellId, 28)
end

function mod:SanguineSphereRemoved(args)
	self:StopBar(args.spellId, args.destName)

	-- if args.amount > 0 then the shield was not broken
	if args.amount > 0 then
		self:Message(args.spellId, "green", CL.over:format(args.spellName))
		self:PlaySound(args.spellId, "info")
	end
end

do
	local prev = 0
	function mod:AbruptRestoration(args)
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

function mod:TaintedBloodApplied(args)
	if self:Dispeller("disease", nil, args.spellId) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

function mod:FlamingSlash(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 29.2)
end

function mod:MakoggDeath()
	self:StopBar(163665) -- Flaming Slash
	self:StopBar(164956) -- Lava Swipe
end
