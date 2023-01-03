--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Bonemaw", 1176, 1140)
if not mod then return end
mod:RegisterEnableMob(75452) -- Bonemaw
mod:SetEncounterID(1679)
mod:SetRespawnTime(33)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.summon_worms = "Summon Carrion Worms"
	L.summon_worms_desc = "Bonemaw summons two Carrion Worms."
	L.summon_worms_icon = "ability_hunter_pet_worm"
	L.summon_worms_trigger = "piercing screech attracts nearby Carrion Worms!"

	L.submerge = "Submerge"
	L.submerge_desc = "Bonemaw submerges and repositions."
	L.submerge_icon = "misc_arrowdown"
	L.submerge_trigger = "hisses, slinking back into the shadowy depths!"
end

--------------------------------------------------------------------------------
-- Locals
--

local bodySlamCount = 0
local corpseBreathCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		165578, -- Corpse Breath
		154175, -- Body Slam
		{153804, "FLASH"}, -- Inhale
		"summon_worms",
		"submerge",
	}, nil, {
		["summon_worms"] = CL.adds,
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "InhaleIncUnitEvent", "boss1")
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
	self:Log("SPELL_CAST_START", "CorpseBreath", 165578)
	self:Log("SPELL_CAST_SUCCESS", "CorpseBreathSuccess", 165578)
	self:Log("SPELL_CAST_START", "BodySlam", 154175)
	self:Log("SPELL_CAST_SUCCESS", "BodySlamSuccess", 154175)
	self:Log("SPELL_CAST_SUCCESS", "Inhale", 153804)
	self:Log("SPELL_AURA_REMOVED", "InhaleOver", 153804)
end

function mod:OnEngage()
	bodySlamCount = 0
	corpseBreathCount = 0
	self:CDBar(165578, 6) -- Corpse Breath
	self:CDBar(153804, 16.7) -- Inhale
	self:Bar("summon_worms", 26.9, CL.spawning:format(CL.adds), L.summon_worms_icon)
	self:CDBar(154175, 31.5) -- Body Slam
	self:Bar("submerge", 64.8, L.submerge, L.submerge_icon)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:InhaleIncUnitEvent(event, unit, _, spellId)
	if spellId == 154868 then
		-- unit event is 1s faster than emote (and the first emote is 1s late),
		-- but the unit event only fires for the first Inhale.
		self:InhaleInc()
		self:UnregisterUnitEvent(event, unit)
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg)
	-- %s's piercing screech attracts nearby Carrion Worms!
	if msg:find(L.summon_worms_trigger, nil, true) then
		self:Message("summon_worms", "cyan", CL.spawning:format(CL.adds), L.summon_worms_icon)
		self:PlaySound("summon_worms", "info")
		return
	end

	-- %s hisses, slinking back into the shadowy depths!
	if msg:find(L.submerge_trigger, nil, true) then
		self:Message("submerge", "cyan", L.submerge, L.submerge_icon)
		self:PlaySound("submerge", "info")
		self:Bar("submerge", 36, L.submerge, L.submerge_icon)
		return
	end

	-- %s begins to |cFFFF0404|Hspell:153804|h[Inhale]|h|r his enemies!
	if msg:find("153804", nil, true) then -- Inhale
		self:InhaleInc()
		return
	end
end

function mod:CorpseBreath(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
end

function mod:CorpseBreathSuccess(args)
	-- boss can interrupt his own cast by submerging, so timer has to be on success
	corpseBreathCount = corpseBreathCount + 1
	if corpseBreathCount == 1 then
		self:CDBar(args.spellId, 27.1)
	elseif corpseBreathCount == 2 then
		self:CDBar(args.spellId, 25.9)
	else
		self:CDBar(args.spellId, 34.3)
	end
end

do
	local prev = 0
	function mod:BodySlam(args)
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

function mod:BodySlamSuccess(args)
	-- boss can interrupt his own cast by submerging, so timer has to be on success
	if self:MobId(args.sourceGUID) == 75452 then -- Bonemaw
		-- boss adds also cast this, timer is just for the boss
		bodySlamCount = bodySlamCount + 1
		if bodySlamCount == 1 then
			self:CDBar(args.spellId, 21.1)
		else
			self:CDBar(args.spellId, 23.5)
		end
	end
end

do
	local prev = 0
	function mod:InhaleInc()
		local t = GetTime()
		if t - prev > 5 then
			prev = t
			self:Message(153804, "orange", CL.incoming:format(self:SpellName(153804))) -- Inhale Incoming
			self:PlaySound(153804, "warning")
			self:Flash(153804)
		end
	end
end

function mod:Inhale(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 36.3)
end

function mod:InhaleOver(args)
	self:Message(args.spellId, "green", CL.over:format(args.spellName))
	self:PlaySound(args.spellId, "info")
end
