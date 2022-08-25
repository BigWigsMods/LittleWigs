--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Karazhan Trash", 1651)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	114544, -- Skeletal Usher
	114339, -- Barnes
	114542, -- Ghostly Philanthropist
	114632, -- Spectral Attendant
	114636, -- Phantom Guardsman
	114783, -- Reformed Maiden
	114796, -- Wholesome Hostess
	115388, -- King
	115395, -- Queen
	115407, -- Rook
	115401, -- Bishop
	115402, -- Bishop
	115406  -- Knight
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.skeletalUsher = "Skeletal Usher"
	L.custom_on_autotalk = "Autotalk"
	L.custom_on_autotalk_desc = "Instantly selects Barnes' gossip option to start the Opera Hall encounter."
	L.attendant = "Spectral Attendant"
	L.hostess = "Wholesome Hostess"
	L.opera_hall_westfall_story_text = "Opera Hall: Westfall Story"
	L.opera_hall_westfall_story_trigger = "we meet two lovers" -- Tonight... we meet two lovers born on opposite sides of Sentinel Hill.
	L.opera_hall_beautiful_beast_story_text = "Opera Hall: Beautiful Beast"
	L.opera_hall_beautiful_beast_story_trigger = "a tale of romance and rage" -- Tonight... a tale of romance and rage, one which will prove once and for all if beaty is more than skin deep.
	L.opera_hall_wikket_story_text = "Opera Hall: Wikket"
	L.opera_hall_wikket_story_trigger = "Shut your jabber" -- Shut your jabber, drama man! The Monkey King got another plan!
	L.barnes = "Barnes"
	L.maiden = "Reformed Maiden"
	L.philanthropist = "Ghostly Philanthropist"
	L.guardsman = "Phantom Guardsman"
	L.chess_event = "Chess Event"
	L.king = "King"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		227966, -- Flashlight
		"custom_on_autotalk", -- Barnes
		"warmup", -- Opera Hall event timer
		228279, -- Shadow Rejuvenation
		228575, -- Alluring Aura
		228625, -- Banshee Wail
		227999, -- Pennies from Heaven
		228528, -- Heartbreaker
		229489, -- Royalty
	}, {
		[227966] = L.skeletalUsher,
		["custom_on_autotalk"] = "general",
		[228279] = L.attendant,
		[228575] = L.hostess,
		[227999] = L.philanthropist,
		[228528] = L.maiden,
		[229489] = L.chess_event,
	}, {
		[229489] = self:SpellName(229495) -- Royalty (Vulnerable)
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")
	self:Log("SPELL_CAST_START", "Flashlight", 227966)
	self:Log("SPELL_CAST_START", "ShadowRejuvenation", 228279)
	self:Log("SPELL_CAST_START", "AlluringAura", 228575)
	self:Log("SPELL_CAST_START", "BansheeWail", 228625)
	self:Log("SPELL_CAST_START", "PenniesFromHeaven", 227999)
	self:Log("SPELL_CAST_START", "Heartbreaker", 228528)

	-- Chess Event
	self:Death("ChessEventPieceDied", 115395, 115407, 115401, 115402, 115406) -- Queen, Rook, Bishop, Bishop, Knight
	self:Log("SPELL_AURA_APPLIED", "RoyaltyApplied", 229489)
	self:Death("ChessEventOver", 115388) -- King

	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "Warmup")
	self:RegisterEvent("GOSSIP_SHOW")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Skeletal Usher
do
	local prev = 0
	function mod:Flashlight(args)
		local t = GetTime()
		if t-prev > 3 then
			prev = t
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "info")
		end
		self:Bar(args.spellId, 3)
	end
end

-- Barnes
function mod:GOSSIP_SHOW()
	if self:GetOption("custom_on_autotalk") and self:MobId(self:UnitGUID("npc")) == 114339 then
		if self:GetGossipOptions() then
			self:SelectGossipOption(1)
		end
	end
end

function mod:Warmup(_, msg)
	if msg:find(L.opera_hall_westfall_story_trigger, nil, true) then
		self:Bar("warmup", 42, L.opera_hall_westfall_story_text, "achievement_raid_karazhan")
	end

	if msg:find(L.opera_hall_beautiful_beast_story_trigger, nil, true) then
		self:Bar("warmup", 47, L.opera_hall_beautiful_beast_story_text, "achievement_raid_karazhan")
	end

	if msg:find(L.opera_hall_wikket_story_trigger, nil, true) then
		self:Bar("warmup", 70, L.opera_hall_wikket_story_text, "achievement_raid_karazhan")
	end
end

-- Spectral Attendant
function mod:ShadowRejuvenation(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

-- Wholesome Hostess
function mod:AlluringAura(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:BansheeWail(args)
	if not self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by DKs
		self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "warning")
	end
end

-- Ghostly Philanthropist
do
	local prev = 0
	function mod:PenniesFromHeaven(args)
		local t = GetTime()
		if t-prev > 1.5 then
			prev = t
			self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

-- Reformed Maiden
function mod:Heartbreaker(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

-- Chess Event
function mod:ChessEventPieceDied(args)
	local remainingVulnerable = self:BarTimeLeft(self:SpellName(229495)) -- Vulnerable
	if remainingVulnerable > 0 then
		-- we can't track Vulnerable refresh because it's a hidden aura, but if another add dies then 20s is added to the existing buff
		self:Bar(229489, remainingVulnerable + 20, self:SpellName(229495)) -- Royality, Vulnerable
	else
		self:Message(229489, "green", CL.on:format(self:SpellName(229495), L.king)) -- Royality, Vulnerable
		self:PlaySound(229489, "long") -- Royalty
		self:Bar(229489, 20, self:SpellName(229495)) -- Royality, Vulnerable
	end
end

function mod:RoyaltyApplied(args)
	self:Message(args.spellId, "red", CL.buff_other:format(args.destName, args.spellName))
	self:PlaySound(args.spellId, "info")
end

function mod:ChessEventOver(args)
	self:StopBar(self:SpellName(229495)) -- Vulnerable
end
