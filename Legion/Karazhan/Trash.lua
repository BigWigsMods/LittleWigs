--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Karazhan Trash", 1651)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	-- Return to Karazhan: Lower
	114544, -- Skeletal Usher
	114339, -- Barnes
	114542, -- Ghostly Philanthropist
	114633, -- Spectral Valet
	114632, -- Spectral Attendant
	114636, -- Phantom Guardsman
	114783, -- Reformed Maiden
	114796, -- Wholesome Hostess
	114804, -- Spectral Charger
	-- Return to Karazhan: Upper
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
	-- Opera Event
	L.custom_on_autotalk = "Autotalk"
	L.custom_on_autotalk_desc = "Instantly selects Barnes' gossip option to start the Opera Hall encounter."
	L.custom_on_autotalk_icon = "ui_chat"
	L.opera_hall_wikket_story_text = "Opera Hall: Wikket"
	L.opera_hall_wikket_story_trigger = "Shut your jabber" -- Shut your jabber, drama man! The Monkey King got another plan!
	L.opera_hall_westfall_story_text = "Opera Hall: Westfall Story"
	L.opera_hall_westfall_story_trigger = "we meet two lovers" -- Tonight... we meet two lovers born on opposite sides of Sentinel Hill.
	L.opera_hall_beautiful_beast_story_text = "Opera Hall: Beautiful Beast"
	L.opera_hall_beautiful_beast_story_trigger = "a tale of romance and rage" -- Tonight... a tale of romance and rage, one which will prove once and for all if beaty is more than skin deep.

	-- Return to Karazhan: Lower
	L.barnes = "Barnes"
	L.ghostly_philanthropist = "Ghostly Philanthropist"
	L.skeletal_usher = "Skeletal Usher"
	L.spectral_attendant = "Spectral Attendant"
	L.spectral_valet = "Spectral Valet"
	L.spectral_retainer = "Spectral Retainer"
	L.phantom_guardsman = "Phantom Guardsman"
	L.wholesome_hostess = "Wholesome Hostess"
	L.reformed_maiden = "Reformed Maiden"
	L.spectral_charger = "Spectral Charger"

	-- Return to Karazhan: Upper
	L.chess_event = "Chess Event"
	L.king = "King"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Return to Karazhan: Lower
		"custom_on_autotalk", -- Barnes
		"warmup", -- Opera Hall event timer
		227999, -- Pennies from Heaven
		227966, -- Flashlight
		228279, -- Shadow Rejuvenation
		228278, -- Demoralizing Shout
		{228280, "DISPEL"}, -- Oath of Fealty
		228575, -- Alluring Aura
		{228576, "DISPEL"}, -- Allured
		228625, -- Banshee Wail
		228528, -- Heartbreaker
		241828, -- Trampling Stomp
		{228603, "TANK"}, -- Charge
		-- Return to Karazhan: Upper
		229489, -- Royalty
	}, {
		-- Return to Karazhan: Lower
		["custom_on_autotalk"] = "general",
		[227999] = L.ghostly_philanthropist,
		[227966] = L.skeletal_usher,
		[228279] = L.spectral_attendant,
		[228278] = L.spectral_valet,
		[228280] = L.spectral_retainer,
		[228575] = L.wholesome_hostess,
		[228528] = L.reformed_maiden,
		[241828] = L.spectral_charger,
		-- Return to Karazhan: Upper
		[229489] = L.chess_event,
	}, {
		[229489] = self:SpellName(229495) -- Royalty (Vulnerable)
	}
end

function mod:OnBossEnable()
	-- Return to Karazhan: Lower
	self:RegisterEvent("GOSSIP_SHOW")
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "Warmup")
	self:Log("SPELL_CAST_START", "PenniesFromHeaven", 227999)
	self:Log("SPELL_CAST_START", "Flashlight", 227966)
	self:Log("SPELL_CAST_START", "ShadowRejuvenation", 228279)
	self:Log("SPELL_CAST_START", "DemoralizingShout", 228278)
	self:Log("SPELL_AURA_APPLIED", "OathOfFealtyApplied", 228280)
	self:Log("SPELL_CAST_START", "AlluringAura", 228575)
	self:Log("SPELL_AURA_APPLIED_DOSE", "AlluredApplied", 228576)
	self:Log("SPELL_CAST_START", "BansheeWail", 228625)
	self:Log("SPELL_CAST_START", "Heartbreaker", 228528)
	self:Log("SPELL_CAST_START", "TramplingStomp", 241828)
	self:Log("SPELL_CAST_START", "Charge", 228603)

	-- Return to Karazhan: Upper
	self:Log("SPELL_AURA_APPLIED", "RoyaltyApplied", 229489)
	self:Death("ChessEventPieceDied", 115395, 115407, 115401, 115402, 115406) -- Queen, Rook, Bishop, Bishop, Knight
	self:Death("ChessEventOver", 115388) -- King
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Barnes

function mod:GOSSIP_SHOW()
	if self:GetOption("custom_on_autotalk") then
		-- Opera Event gossip
		-- you have to gossip with Barnes twice to start the RP which spawns the first boss
		if self:GetGossipID(46684) then
			-- Barnes's first line
			-- 46684: I'm not an actor.
			self:SelectGossipID(46684)
		elseif self:GetGossipID(46685) then
			-- Barnes's second line
			-- 46685: Ok, I'll give it a try then.
			self:SelectGossipID(46685)
		end
	end
end

function mod:Warmup(_, msg)
	if msg:find(L.opera_hall_wikket_story_trigger, nil, true) then
		self:Bar("warmup", 70, L.opera_hall_wikket_story_text, "achievement_raid_karazhan")
	elseif msg:find(L.opera_hall_westfall_story_trigger, nil, true) then
		self:Bar("warmup", 42, L.opera_hall_westfall_story_text, "achievement_raid_karazhan")
	elseif msg:find(L.opera_hall_beautiful_beast_story_trigger, nil, true) then
		self:Bar("warmup", 47, L.opera_hall_beautiful_beast_story_text, "achievement_raid_karazhan")
	end
end

-- Ghostly Philanthropist

do
	local prev = 0
	function mod:PenniesFromHeaven(args)
		local t = args.time
		if t-prev > 1.5 then
			prev = t
			self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

-- Skeletal Usher

do
	local prev = 0
	function mod:Flashlight(args)
		local t = args.time
		if t-prev > 1.5 then
			prev = t
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "alarm")
		end
		self:Bar(args.spellId, 3)
	end
end

-- Spectral Attendant

function mod:ShadowRejuvenation(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

-- Spectral Valet

function mod:DemoralizingShout(args)
	if self:Interrupter() then
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "warning")
	end
end

-- Spectral Retainer

function mod:OathOfFealtyApplied(args)
	if self:Dispeller("magic", true, args.spellId) or self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "warning", nil, args.destName)
	end
end

-- Wholesome Hostess

function mod:AlluringAura(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:AlluredApplied(args)
	if (args.amount >= 50 and args.amount % 5 == 0) and (self:Dispeller("magic", nil, args.spellId) or self:Me(args.destGUID)) then
		self:StackMessage(args.spellId, "orange", args.destName, args.amount, 85) -- MC at 100 stacks
		self:PlaySound(args.spellId, "warning", nil, args.destName)
	end
end

function mod:BansheeWail(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by DKs
		return
	end
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Reformed Maiden

function mod:Heartbreaker(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
end

-- Spectral Charger

function mod:Charge(args)
	self:Message(args.spellId, "purple", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:TramplingStomp(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

-- Chess Event

function mod:RoyaltyApplied(args)
	local unit = self:UnitTokenFromGUID(args.sourceGUID)
	if unit and UnitAffectingCombat(unit) then
		self:Message(args.spellId, "red", CL.buff_other:format(args.destName, args.spellName))
		self:PlaySound(args.spellId, "info")
	end
end

do
	local timeKingDied = 0

	function mod:ChessEventPieceDied(args)
		if args.time - timeKingDied < 10 then
			-- if the king just died, ignore all other piece deaths as the event is over
			return
		end
		local remainingVulnerable = self:BarTimeLeft(229495) -- Vulnerable
		if remainingVulnerable > 0 then
			-- we can't track Vulnerable refresh because it's a hidden aura, but if another add dies then 20s is added to the existing buff
			self:Bar(229489, remainingVulnerable + 20, 229495) -- Royality, Vulnerable
		else
			self:Message(229489, "green", CL.on:format(self:SpellName(229495), L.king)) -- Royality, Vulnerable
			self:PlaySound(229489, "long") -- Royalty
			self:Bar(229489, 20, 229495) -- Royality, Vulnerable
		end
	end

	function mod:ChessEventOver(args)
		timeKingDied = args.time
		self:StopBar(229495) -- Vulnerable
	end
end
