--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Xeri'tac", 1279, 1209)
if not mod then return end
mod:RegisterEnableMob(84550) -- Xeri'tac
mod:SetEncounterID(1752)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local spiderAddDeaths = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		-- Stage One: The Venomous Brood
		172643, -- Descend
		-- Stage Two: The Spider Matriarch
		169376, -- Venomous Sting
		169382, -- Gaseous Volley
		169248, -- Consume
		-- Venom-Crazed Pale One
		-10502, -- Venom-Crazed Pale One
		169233, -- Inhale
		-- Toxic Spiderling
		-10492, -- Toxic Spiderling
		-- Gorged Bursters
		173080, -- Fixate
	}, {
		[172643] = -10506, -- Stage One: The Venomous Brood
		[169248] = -10507, -- Stage Two: Spider Matriarch
		[-10502] = -10502, -- Venom-Crazed Pale One
		[-10492] = -10492, -- Toxic Spiderling
		[173080] = -10691, -- Gorged Bursters
	}
end

function mod:OnBossEnable()
	-- Stages
	self:Death("SpiderDeath", 84552, 86547) -- Toxic Spiderling, Venom Sprayer
	self:RegisterUnitEvent("UNIT_TARGETABLE_CHANGED", nil, "boss1")

	-- Stage One: The Venomous Brood
	self:Log("SPELL_CAST_START", "Descend", 172643)

	-- Stage Two: Spider Matriarch
	self:Log("SPELL_CAST_START", "VenomousSting", 169376)
	self:Log("SPELL_CAST_START", "GaseousVolley", 169382)
	self:Log("SPELL_CAST_START", "Consume", 169248)

	-- Venom-Crazed Pale One
	self:Log("SPELL_CAST_SUCCESS", "EncounterSpawn", 181113)
	self:Log("SPELL_CAST_START", "Inhale", 169233)

	-- Toxic Spiderling
	self:Log("SPELL_CAST_SUCCESS", "ToxicBlood", 169218)

	-- Gorged Bursters
	self:Log("SPELL_AURA_APPLIED", "Fixate", 173080)
end

function mod:OnEngage()
	spiderAddDeaths = 0
	self:SetStage(1)
	self:CDBar(172643, 8.6) -- Descend
	self:Bar(-10502, 19.6, CL.spawning:format(self:SpellName(-10502)), "spell_festergutgas") -- Venom-Crazed Pale One
	if self:Normal() then
		-- Normal is 40s or when you kill the last set, whichever comes first
		self:Bar(-10492, 40, CL.spawning:format(self:SpellName(-10492)), "ability_hunter_pet_spider") -- Toxic Spiderling
	else
		-- Heroic, Mythic are 30s fixed timer
		self:Bar(-10492, 30, CL.spawning:format(self:SpellName(-10492)), "ability_hunter_pet_spider") -- Toxic Spiderling
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Stages

function mod:SpiderDeath()
	-- Toxic Spiderling (84552) and Venom Sprayer (86547) deaths count
	-- the Heroic+ Gorged Burster (86552) does not count
	spiderAddDeaths = spiderAddDeaths + 1
	if spiderAddDeaths < 8 then
		self:Message("stages", "cyan", CL.add_killed:format(spiderAddDeaths, 8), false)
	end
end

function mod:UNIT_TARGETABLE_CHANGED(_, unit)
	if self:GetStage() == 1 and UnitCanAttack("player", unit) then
		self:SetStage(2)
		self:Message("stages", "cyan", CL.incoming:format(self.displayName), "inv_misc_monsterspidercarapace_01")
		self:PlaySound("stages", "long")
		self:StopBar(172643) -- Descend
		self:StopBar(CL.spawning:format(self:SpellName(-10492))) -- Toxic Spiderling
	end
end

-- Stage One: The Venomous Brood

function mod:Descend(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 13.0)
end

-- Stage Two: Spider Matriarch

function mod:VenomousSting(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 31.6)
end

function mod:GaseousVolley(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 24.0)
end

function mod:Consume(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "warning")
	self:CDBar(args.spellId, 31.6)
end

-- Venom-Crazed Pale One

function mod:EncounterSpawn()
	self:Message(-10502, "cyan", CL.spawned:format(self:SpellName(-10502)), "spell_festergutgas") -- Venom-Crazed Pale One
	self:PlaySound(-10502, "info")
	self:Bar(-10502, 30, CL.spawning:format(self:SpellName(-10502)), "spell_festergutgas")
end

do
	local prev = 0
	function mod:Inhale(args)
		-- the add can interrupt its own cast if there are multiple clouds nearby
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

-- Toxic Spiderling

do
	local prev = 0
	function mod:ToxicBlood(args)
		local t = args.time
		-- throttle because 2 adds spawn at once in Normal, 3 in Heroic/Mythic.
		-- each adds casts this on spawn
		if t - prev > 5 then
			prev = t
			self:Message(-10492, "yellow", CL.spawned:format(self:SpellName(-10492)), "ability_hunter_pet_spider") -- Toxic Spiderling
			if self:Normal() then
				-- Normal is 40s or when you kill the last set, whichever comes first
				self:Bar(-10492, 40, CL.spawning:format(self:SpellName(-10492)), "ability_hunter_pet_spider") -- Toxic Spiderling
			else
				-- Heroic, Mythic are 30s fixed timer
				self:Bar(-10492, 30, CL.spawning:format(self:SpellName(-10492)), "ability_hunter_pet_spider") -- Toxic Spiderling
			end
		end
	end
end

-- Gorged Bursters

function mod:Fixate(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId)
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
	end
end
