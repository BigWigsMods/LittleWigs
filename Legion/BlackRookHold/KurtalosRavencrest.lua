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
local nextCloudOfHypnosis = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.phase_2_trigger = "Enough! I tire of this."
end

--------------------------------------------------------------------------------
-- Initialization
--

local stingingSwarmMarker = mod:AddMarkerOption(true, "npc", 8, 201733, 8) -- Stinging Swarm
function mod:GetOptions()
	return {
		"stages",
		-- Stage One: Lord of the Keep
		{198635, "TANK"}, -- Unerring Shear
		198641, -- Whirling Blade
		198820, -- Dark Blast
		-- Stage Two: Vengeance of the Ancients
		199368, -- Legacy of the Ravencrest
		{201733, "SAY"}, -- Stinging Swarm
		stingingSwarmMarker,
		199143, -- Cloud of Hypnosis
		{199193, "CASTBAR"}, -- Dreadlord's Guile
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
	self:RegisterEvent("CHAT_MSG_MONSTER_SAY")
	self:Death("KurtalosDeath", 98965)

	-- Stage Two: Vengeance of the Ancients
	self:Log("SPELL_CAST_SUCCESS", "LegacyOfTheRavencrest", 199368)
	self:Log("SPELL_CAST_START", "StingingSwarm", 201733)
	self:Log("SPELL_AURA_APPLIED", "StingingSwarmApplied", 201733)
	self:Log("SPELL_CAST_START", "CloudOfHypnosis", 199143)
	self:Log("SPELL_CAST_START", "DreadlordsGuile", 199193)
	self:Log("SPELL_CAST_START", "ShadowBoltVolley", 202019)
end

function mod:OnEngage()
	unerringShearCount = 1
	shadowBoltVolleyCount = 1
	nextCloudOfHypnosis = 0
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

function mod:CHAT_MSG_MONSTER_SAY(event, msg)
	if msg == L.phase_2_trigger then
		self:UnregisterEvent(event)
		self:StopBar(CL.count:format(self:SpellName(198635), unerringShearCount)) -- Unerring Shear
		self:StopBar(198641) -- Whirling Blade
		self:StopBar(198820) -- Dark Blast
	end
end

function mod:KurtalosDeath()
	self:StopBar(CL.count:format(self:SpellName(198635), unerringShearCount)) -- Unerring Shear
	self:StopBar(198641) -- Whirling Blade
	self:StopBar(198820) -- Dark Blast
	self:SetStage(2)
	self:Message("stages", "cyan", -12509, false) -- Stage Two: Vengeance of the Ancients
	self:PlaySound("stages", "long")
	self:CDBar(202019, 17.5, CL.count:format(self:SpellName(202019), shadowBoltVolleyCount)) -- Shadow Bolt Volley
	if not self:Normal() then
		self:CDBar(201733, 22.3) -- Stinging Swarm
	end
	self:CDBar(199368, 22.7) -- Legacy of the Ravencrest
	self:CDBar(199143, 27.2) -- Cloud of Hypnosis
	self:CDBar(199193, 38.2) -- Dreadlord's Guile
end

-- Stage Two: Vengeance of the Ancients

function mod:LegacyOfTheRavencrest(args)
	self:StopBar(args.spellId)
	self:Message(args.spellId, "green")
	self:PlaySound(args.spellId, "info")
end

function mod:StingingSwarm(args)
	self:CDBar(args.spellId, 17.0)
end

function mod:StingingSwarmApplied(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Stinging Swarm")
	end
	-- register events to auto-mark Stinging Swarm
	if self:GetOption(stingingSwarmMarker) then
		self:RegisterTargetEvents("MarkStingingSwarm")
	end
end

function mod:MarkStingingSwarm(_, unit, guid)
	-- there is no SUMMON event and the debuff is applied by Dantalionax,
	-- so we have to match on the mob ID for Stinging Swarm
	if self:MobId(guid) == 101008 then -- Stinging Swarm
		self:CustomIcon(stingingSwarmMarker, unit, 8)
		self:UnregisterTargetEvents()
	end
end

function mod:CloudOfHypnosis(args)
	local t = GetTime()
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 32.8)
	nextCloudOfHypnosis = t + 32.8
end

function mod:DreadlordsGuile(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "long")
	if self:Mythic() then
		local t = GetTime()
		-- 4s cast + 15.9s phase
		self:CastBar(args.spellId, 19.9)
		-- no other abilities until 5s cast + 15.9s phase + ~3.2s delay is over
		self:CDBar(202019, 23.1, CL.count:format(self:SpellName(202019), shadowBoltVolleyCount)) -- Shadow Bolt Volley
		self:CDBar(201733, 23.1) -- Stinging Swarm
		if nextCloudOfHypnosis - t < 23.1 then
			self:CDBar(199143, 23.1) -- Cloud of Hypnosis
		end
		self:CDBar(args.spellId, 82.7)
	elseif self:Heroic() then
		-- 5s cast + 23.5s phase
		self:CastBar(args.spellId, 28.5)
		-- no other abilities until 5s cast + 23.5s phase + ~3.2s delay is over
		self:CDBar(202019, 31.7, CL.count:format(self:SpellName(202019), shadowBoltVolleyCount)) -- Shadow Bolt Volley
		self:CDBar(201733, 31.7) -- Stinging Swarm
		self:CDBar(199143, 31.7) -- Cloud of Hypnosis
		self:CDBar(args.spellId, 92.0)
	else -- Normal
		-- 5s cast + 24.7s phase
		self:CastBar(args.spellId, 29.7)
		-- no other abilities until 5s cast + 24.7s phase + ~3.2s delay is over
		self:CDBar(202019, 32.9, CL.count:format(self:SpellName(202019), shadowBoltVolleyCount)) -- Shadow Bolt Volley
		self:CDBar(199143, 32.9) -- Cloud of Hypnosis
		self:CDBar(args.spellId, 93.2)
	end
end

function mod:ShadowBoltVolley(args)
	self:StopBar(CL.count:format(args.spellName, shadowBoltVolleyCount))
	self:Message(args.spellId, "yellow", CL.count:format(args.spellName, shadowBoltVolleyCount))
	if shadowBoltVolleyCount == 1 then
		-- players won't have the Legacy of the Ravencrest buff yet, making the first Shadow Bolt Volley especially dangerous
		self:PlaySound(args.spellId, "warning")
	else
		self:PlaySound(args.spellId, "alert")
	end
	shadowBoltVolleyCount = shadowBoltVolleyCount + 1
	self:CDBar(args.spellId, 9.7, CL.count:format(args.spellName, shadowBoltVolleyCount))
end
