--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Erudax", 670, 134)
if not mod then return end
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
		-- TODO Abyssal Corruption (Mythic)
	}, {
		--[] = CL.mythic, -- Abyssal Corruption
	}, {
		[450088] = CL.adds, -- Void Infusion (Adds)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ShadowGale", 449939)
	self:Log("SPELL_CAST_START", "VoidSurge", 450077)
	self:Log("SPELL_CAST_SUCCESS", "VoidInfusion", 450088)
	self:Log("SPELL_CAST_START", "Crush", 450100)
end

function mod:OnEngage()
	self:CDBar(450077, 5.0) -- Void Surge
	self:CDBar(449939, 12.0) -- Shadow Gale
	self:CDBar(450088, 39.0, CL.adds) -- Void Infusion
	self:CDBar(450100, 45.0) -- Crush
end

--------------------------------------------------------------------------------
-- Classic Initialization
--

if not BigWigsLoader.isBeta then
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
	self:Message(args.spellId, "cyan", CL.spawning:format(CL.adds))
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 50.0, CL.adds)
end

function mod:Crush(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 50.0)
end

--------------------------------------------------------------------------------
-- Classic Event Handlers
--

function mod:ShadowGaleClassic(args)
	self:Bar(args.spellId, 5)
	self:MessageOld(args.spellId, "orange", "alert", CL.casting:format(args.spellName))
end

function mod:Summon(_, msg)
	if msg:find(L.summon_trigger) then
		self:MessageOld("summon", "yellow", nil, L.summon_message, false)
	end
end

do
	local prev = 0
	function mod:UmbralMending(args)
		local t = GetTime()
		if t-prev > 1 then
			prev = t
			self:MessageOld(args.spellId, "red", self:Interrupter() and "warning", CL.casting:format(args.spellName))
		end
	end
end

do
	local prev = 0
	function mod:SiphonEssence(args)
		local t = GetTime()
		if t-prev > 1 then
			prev = t
			self:MessageOld(args.spellId, "red", self:Interrupter() and "alarm", CL.casting:format(args.spellName))
		end
	end
end
