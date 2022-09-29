--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Grimrail Enforcers", 1195, 1236)
if not mod then return end
mod:RegisterEnableMob(80805, 80808, 80816) -- Makogg Emberblade, Neesa Nox, Ahri'ok Dugru
mod:SetEncounterID(1748)
mod:SetRespawnTime(33)

--------------------------------------------------------------------------------
-- Locals
--

local firstBombSquadSent = false

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
		165152, -- Lava Sweep
		163376, -- Malfunctioning Jumper Cables 9000-XL
		163390, -- Ogre Traps
		163379, -- Big Boom
	}, {
		[163689] = -10449, -- Ahri'ok Dugru
		[163665] = -10453, -- Makogg Emberblade
		[163376] = -10456, -- Neesa Nox
	}, {
		[163689] = CL.shield -- Sanguine Sphere (Shield)
	}
end

function mod:OnBossEnable()
	-- Makogg Emberblade
	self:Log("SPELL_CAST_START", "FlamingSlash", 163665)
	self:Log("SPELL_CAST_SUCCESS", "EncounterEvent", 181089) -- Lava Sweep
	self:Death("MakoggDeath", 80805)

	-- Ahri'ok Dugru
	self:Log("SPELL_AURA_APPLIED", "SanguineSphere", 163689)
	self:Log("SPELL_AURA_REMOVED", "SanguineSphereRemoved", 163689)
	self:Log("SPELL_AURA_APPLIED", "AbruptRestoration", 163705)
	self:Log("SPELL_AURA_APPLIED", "TaintedBloodApplied", 163740)
	self:Death("AhriokDeath", 80816)

	-- Neesa Nox
	self:Log("SPELL_CAST_START", "MalfunctioningJumperCables9000XL", 163376)
	self:Log("SPELL_CAST_SUCCESS", "OgreTraps", 163390)
	self:Log("SPELL_CAST_START", "BigBoom", 163379)
	self:Death("NeesaDeath", 80808)
end

function mod:OnEngage()
	firstBombSquadSent = false
	self:CDBar(163689, 28, CL.shield) -- Shield
	self:Bar(163665, 4.9) -- Flaming Slash
	self:Bar(163390, 12.9) -- Ogre Traps
	self:Bar(165152, 14.6) -- Lava Sweep
	self:Bar(163376, 24.3) -- Malfunctioning Jumper Cables 9000-XL
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Ahri'ok Dugru

function mod:SanguineSphere(args)
	-- use a more severe warning if you are still targeting the boss which gains the shield
	if args.destGUID == self:UnitGUID("target") then
		self:TargetMessage(args.spellId, "red", args.destName, CL.shield) -- Shield on <boss>
		self:PlaySound(args.spellId, "warning")
	else
		self:TargetMessage(args.spellId, "yellow", args.destName, CL.shield) -- Shield on <boss>
		self:PlaySound(args.spellId, "alert")
	end
	self:TargetBar(args.spellId, 10, args.destName, CL.shield) -- Shield on <boss>
	self:Bar(args.spellId, 28, CL.shield) -- Shield
end

function mod:SanguineSphereRemoved(args)
	self:StopBar(CL.shield, args.destName) -- Shield on <boss>

	-- if args.amount > 0 then the shield was not broken
	if args.amount > 0 then
		self:Message(args.spellId, "green", CL.over:format(CL.shield)) -- Shield Over
		self:PlaySound(args.spellId, "info")
	end
end

do
	local prev = 0
	function mod:AbruptRestoration(args)
		self:StopBar(CL.shield, args.destName) -- Shield on <boss>
		local t = args.time
		if t-prev > 10 then
			prev = t
			self:Message(args.spellId, "yellow", L.sphere_fail_message) -- Shield was broken - They're all healing :(
			self:PlaySound(args.spellId, "warning")
		end
	end
end

function mod:AhriokDeath()
	self:StopBar(CL.shield) -- Shield
end

-- Makogg Emberblade

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

function mod:EncounterEvent(args) -- Lava Sweep
	self:Message(165152, "red")
	self:PlaySound(165152, "alarm")
	self:Bar(165152, 29.2)
end

function mod:MakoggDeath()
	self:StopBar(163665) -- Flaming Slash
	self:StopBar(165152) -- Lava Sweep
end

-- Neesa Nox

function mod:MalfunctioningJumperCables9000XL(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 29.2)
end

function mod:OgreTraps(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 29.2)
end

function mod:BigBoom(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, firstBombSquadSent and 29.2 or 15.8)
	firstBombSquadSent = true
end

function mod:NeesaDeath()
	self:StopBar(163376) -- Malfunctioning Jumper Cables 9000-XL
	self:StopBar(163390) -- Ogre Traps
	self:StopBar(163379) -- Big Boom
end
