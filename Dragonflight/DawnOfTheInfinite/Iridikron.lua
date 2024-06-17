--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Iridikron the Stonescaled", 2579, 2537)
if not mod then return end
mod:RegisterEnableMob(
	204459, -- Iridikron the Stonescaled (RP version)
	198933  -- Iridikron the Stonescaled (actual boss)
)
mod:SetEncounterID(2669)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local earthsurgeCount = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.warmup_icon = "achievement_dungeon_dawnoftheinfinite"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		{409261, "SAY"}, -- Extinction Blast
		414535, -- Stonecracker Barrage
		409456, -- Earthsurge
		409635, -- Pulverizing Exhalation
		{409879, "SAY"}, -- Pulverizing Creations
		{414184, "CASTBAR"}, -- Cataclysmic Obliteration
	}, nil, {
		[409879] = CL.adds,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "ExtinctionBlast", 409266)
	self:Log("SPELL_CAST_START", "StonecrackerBarrage", 414535)
	self:Log("SPELL_CAST_START", "Earthsurge", 409456)
	self:Log("SPELL_AURA_APPLIED", "EarthsurgeApplied", 409456)
	self:Log("SPELL_AURA_REMOVED", "EarthsurgeRemoved", 409456)
	self:Log("SPELL_CAST_START", "PulverizingExhalation", 409635)
	self:Log("SPELL_AURA_APPLIED", "PulverizingCreationsApplied", 409879)
	self:Log("SPELL_CAST_START", "CataclysmicObliteration", 414184, 414652) -- Stage 2, wiping because Chromie died
	self:Log("SPELL_AURA_REMOVED", "CatacylsmicObliterationRemoved", 414177)
end

function mod:OnEngage()
	earthsurgeCount = 1
	self:StopBar(CL.active) -- Warmup
	self:SetStage(1)
	self:CDBar(409261, 8.4) -- Extinction Blast
	self:CDBar(414535, 16.0) -- Stonecracker Barrage
	self:CDBar(409456, 35.1, CL.count:format(self:SpellName(409456), earthsurgeCount)) -- Earthsurge
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Warmup()
	-- triggered from trash module
	-- 267.93 [CHAT_MSG_MONSTER_YELL] So the titans' puppets have come to face me.#Iridikron
	-- 301.78 [NAME_PLATE_UNIT_ADDED] Iridikron
	self:Bar("warmup", 33.8, CL.active, L.warmup_icon)
end

function mod:ExtinctionBlast(args)
	self:StopBar(409261)
	self:TargetMessage(409261, "orange", args.destName)
	if self:Me(args.destGUID) then
		self:PlaySound(409261, "warning", nil, args.destName)
		self:Say(409261, nil, nil, "Extinction Blast")
	else
		self:PlaySound(409261, "alert", nil, args.destName)
	end
end

function mod:StonecrackerBarrage(args)
	-- TODO could alert ~.8s sooner using emote
	-- [CHAT_MSG_RAID_BOSS_EMOTE] |TInterface\\ICONS\\INV_10_ElementalCombinedFoozles_Earth.BLP:20|t Protect Chromie from Iridikron's |cFFFF0000|Hspell:414535|h[Stonecracker Barrage]|h|r!#Iridikron#####0#0##0#426#nil#0#false#false#false#false
	self:StopBar(args.spellId)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
end

function mod:Earthsurge(args)
	self:StopBar(CL.count:format(args.spellName, earthsurgeCount))
	self:Message(args.spellId, "red", CL.count:format(args.spellName, earthsurgeCount))
	self:PlaySound(args.spellId, "alert")
	earthsurgeCount = earthsurgeCount + 1
end

do
	local earthsurgeStart = 0

	function mod:EarthsurgeApplied(args)
		earthsurgeStart = args.time
	end

	function mod:EarthsurgeRemoved(args)
		local earthsurgeDuration = args.time - earthsurgeStart
		self:Message(args.spellId, "green", CL.removed_after:format(args.spellName, earthsurgeDuration))
		self:PlaySound(args.spellId, "info")
		-- Earthsurge being removed is what starts the rest of the timers
		self:CDBar(409635, 9.2) -- Pulverizing Exhalation
		self:CDBar(409261, 41.1) -- Extinction Blast
		self:CDBar(414535, 49.3) -- Stonecracker Barrage
		self:CDBar(args.spellId, 69.0, CL.count:format(args.spellName, earthsurgeCount)) -- Earthsurge
	end
end

function mod:PulverizingExhalation(args)
	self:StopBar(args.spellId)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

function mod:PulverizingCreationsApplied(args)
	-- happens simultaneously with Pulverizing Exhalation
	-- affects 0 players in Heroic, 2 players in Mythic+, all players in hard mode
	if self:Me(args.destGUID) then
		self:Say(args.spellId, CL.add_spawning, nil, "Add Spawning")
	end
end

function mod:CataclysmicObliteration(args)
	self:SetStage(2)
	self:Message(414184, "red")
	self:StopBar(409261) -- Extinction Blast
	self:StopBar(414535) -- Stonecracker Barrage
	self:StopBar(CL.count:format(self:SpellName(409456), earthsurgeCount)) -- Earthsurge
	self:StopBar(409635) -- Pulverizing Exhalation
	if args.spellId == 414184 then -- hard enrage in 30 seconds
		self:PlaySound(414184, "long")
		self:CastBar(414184, 30)
	else -- 414652, wipe in 6 seconds
		self:PlaySound(414184, "warning")
		self:CastBar(414184, 6)
	end
end

function mod:CatacylsmicObliterationRemoved(args)
	-- when you beat the enrage
	self:StopBar(CL.cast:format(args.spellName))
end
