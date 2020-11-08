
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Erudax", 670, 134)
if not mod then return end
mod:RegisterEnableMob(40484)
mod.engageId = 1049
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Localization
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
	self:Log("SPELL_CAST_START", "ShadowGale", 75664)
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE", "Summon")
	self:Log("SPELL_CAST_START", "UmbralMending", 75763)
	self:Log("SPELL_AURA_APPLIED", "SiphonEssence", 75755) -- channeled
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ShadowGale(args)
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
