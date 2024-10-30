--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Erudax", 670, 134)
if not mod then return end
if mod:Retail() then
	mod:SetJournalID(2619) -- Journal ID was changed in The War Within
end
mod:RegisterEnableMob(40484) -- Erudax
mod:SetEncounterID(1049)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Classic Localization
--

local L = mod:GetLocale()
if L then
	L.summon = "Summon Faceless Corruptor"
	L.summon_desc = "Warn when Erudax summons a Faceless Corruptor"
	L.summon_message = "Faceless Corruptor Summoned"
	L.summon_trigger = "summons a"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		449939, -- Shadow Gale
		450077, -- Void Surge
		450088, -- Void Infusion
		{450100, "TANK_HEALER"}, -- Crush
		-- Void Tendril
		450087, -- Depth's Grasp
		-- Mythic
		{448057, "SAY"}, -- Abyssal Corruption
	}, {
		[450087] = -29619, -- Void Tendril
		[448057] = CL.mythic,
	}, {
		[450088] = CL.adds, -- Void Infusion (Adds)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ShadowGale", 449939)
	self:Log("SPELL_CAST_START", "VoidSurge", 450077)
	self:Log("SPELL_CAST_SUCCESS", "VoidInfusion", 450088)
	self:Log("SPELL_CAST_START", "Crush", 450100)

	-- Void Tendril
	self:Log("SPELL_AURA_APPLIED", "DepthsGraspApplied", 450087)

	-- Mythic
	self:Log("SPELL_CAST_START", "AbyssalCorruption", 448057)
	self:Log("SPELL_AURA_APPLIED", "AbyssalCorruptionApplied", 448057)
end

function mod:OnEngage()
	self:CDBar(450077, 5.0) -- Void Surge
	self:CDBar(449939, 12.0) -- Shadow Gale
	if self:Mythic() then
		self:CDBar(448057, 30.0) -- Abyssal Corruption
	end
	self:CDBar(450088, 39.0, CL.adds) -- Void Infusion
	self:CDBar(450100, 45.0) -- Crush
end

--------------------------------------------------------------------------------
-- Classic Initialization
--

if mod:Classic() then
	function mod:GetOptions()
		return {
			75664, -- Shadow Gale
			"summon",
			75763, -- Umbral Mending
			75755, -- Siphon Essence
		}, {
			[75664] = "general",
			[75763] = -3378, -- Faceless Corruptor
		}
	end

	function mod:OnBossEnable()
		self:Log("SPELL_CAST_START", "ShadowGaleClassic", 75664)
		self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE", "Summon")
		self:Log("SPELL_CAST_START", "UmbralMending", 75763)
		self:Log("SPELL_AURA_APPLIED", "SiphonEssence", 75755) -- channeled
	end

	function mod:OnEngage()
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ShadowGale(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 50.0)
end

function mod:VoidSurge(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 50.0)
end

function mod:VoidInfusion(args)
	self:Message(args.spellId, "cyan", CL.adds_spawning)
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 50.0, CL.adds)
end

function mod:Crush(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 50.0)
end

-- Void Tendril

function mod:DepthsGraspApplied(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId)
		self:PlaySound(args.spellId, "alarm")
	end
end

-- Mythic

do
	local playerList = {}

	function mod:AbyssalCorruption(args)
		playerList = {}
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:CDBar(args.spellId, 50.0)
	end

	function mod:AbyssalCorruptionApplied(args)
		playerList[#playerList + 1] = args.destName
		self:TargetsMessage(args.spellId, "red", playerList, 2)
		if self:Me(args.destGUID) then
			self:Say(args.spellId, nil, nil, "Abyssal Corruption")
		end
		self:PlaySound(args.spellId, "alarm", nil, playerList)
	end
end

--------------------------------------------------------------------------------
-- Classic Event Handlers
--

function mod:ShadowGaleClassic(args)
	self:Bar(args.spellId, 5)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:Summon(_, msg)
	if msg:find(L.summon_trigger) then
		self:Message("summon", "yellow", L.summon_message, false)
	end
end

do
	local prev = 0
	function mod:UmbralMending(args)
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			if self:Interrupter() then
				self:PlaySound(args.spellId, "warning")
			end
		end
	end
end

do
	local prev = 0
	function mod:SiphonEssence(args)
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			if self:Interrupter() then
				self:PlaySound(args.spellId, "alarm")
			end
		end
	end
end
