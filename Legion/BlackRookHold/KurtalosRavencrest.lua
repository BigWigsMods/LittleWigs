--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Kurtalos Ravencrest", 1501, 1672)
if not mod then return end
mod:RegisterEnableMob(
	98965, -- Kur'talos Ravencrest
	98970  -- Latosius / Dantalionax
)
mod:SetEncounterID(1835)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local unerringShearCount = 1
local shadowBoltVolleyCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		-- Stage One: Lord of the Keep
		{198635, "TANK"}, -- Unerring Shear
		198641, -- Whirling Blade
		198820, -- Dark Blast
		-- Stage Two: Vengeance of the Ancients
		{201733, "SAY"}, -- Stinging Swarm
		199143, -- Cloud of Hypnosis
		199193, -- Dreadlord's Guile
		202019, -- Shadow Bolt Volley
	}, {
		[198635] = -12502, -- Stage One: Lord of the Keep
		[201733] = -12509, -- Stage Two: Vengeance of the Ancients
	}
end

function mod:OnBossEnable()
	-- Stage One: Lord of the Keep
	self:Log("SPELL_CAST_SUCCESS", "UnerringShear", 198635)
	self:Log("SPELL_CAST_START", "WhirlingBlade", 198641)
	self:Log("SPELL_CAST_START", "DarkBlast", 198820)
	self:Death("KurtalosDeath", 98965)

	-- Stage Two: Vengeance of the Ancients
	self:Log("SPELL_CAST_START", "StingingSwarm", 201733)
	self:Log("SPELL_AURA_APPLIED", "StingingSwarmApplied", 201733)
	self:Log("SPELL_CAST_START", "CloudOfHypnosis", 199143)
	self:Log("SPELL_CAST_START", "DreadlordsGuile", 199193)
	self:Log("SPELL_CAST_START", "ShadowBoltVolley", 202019)
end

function mod:OnEngage()
	unerringShearCount = 1
	shadowBoltVolleyCount = 1
	self:SetStage(1)
	self:CDBar(198635, 5.9, CL.count:format(self:SpellName(198635), unerringShearCount)) -- Unerring Shear
	self:CDBar(198641, 10.8) -- Whirling Blade
	self:CDBar(198820, 11.3) -- Dark Blast
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Stage One: Lord of the Keep

function mod:UnerringShear(args)
	self:StopBar(CL.count:format(args.spellName, unerringShearCount))
	self:Message(args.spellId, "purple", CL.count:format(args.spellName, unerringShearCount))
	self:PlaySound(args.spellId, "alert")
	unerringShearCount = unerringShearCount + 1
	self:CDBar(args.spellId, 12.1, CL.count:format(args.spellName, unerringShearCount))
end

function mod:WhirlingBlade(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 23.0)
end

function mod:DarkBlast(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 18.2)
end

function mod:KurtalosDeath()
	-- TODO could clean up stage 1 bars earlier using [CHAT_MSG_MONSTER_SAY] Enough! I tire of this.#Latosius
	self:StopBar(CL.count:format(self:SpellName(198635), unerringShearCount)) -- Unerring Shear
	self:StopBar(198641) -- Whirling Blade
	self:StopBar(198820) -- Dark Blast
	self:SetStage(2)
	self:Message("stages", "cyan", -12509, false) -- Stage Two: Vengeance of the Ancients
	self:PlaySound("stages", "long")
	self:CDBar(202019, 17.5, CL.count:format(self:SpellName(202019), shadowBoltVolleyCount)) -- Shadow Bolt Volley
	self:CDBar(201733, 22.3) -- Stinging Swarm
	self:CDBar(199143, 27.2) -- Cloud of Hypnosis
	self:CDBar(199193, 38.2) -- Dreadlord's Guile
end

-- Stage Two: Vengeance of the Ancients

function mod:StingingSwarm(args)
	self:CDBar(args.spellId, 18.2)
end

function mod:StingingSwarmApplied(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
	end
end

function mod:CloudOfHypnosis(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "info")
	self:Bar(args.spellId, 32.8)
end

function mod:DreadlordsGuile(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 83.8)
	-- TODO delay / reset other timers
end

function mod:ShadowBoltVolley(args)
	self:StopBar(CL.count:format(args.spellName, shadowBoltVolleyCount))
	self:Message(args.spellId, "yellow", CL.count:format(args.spellName, shadowBoltVolleyCount))
	if shadowBoltVolleyCount == 1 then
		self:PlaySound(args.spellId, "warning")
	else
		self:PlaySound(args.spellId, "alert")
	end
	shadowBoltVolleyCount = shadowBoltVolleyCount + 1
	self:CDBar(args.spellId, 9.7, CL.count:format(args.spellName, shadowBoltVolleyCount))
end
