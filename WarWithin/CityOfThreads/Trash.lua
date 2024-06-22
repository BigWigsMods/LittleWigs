if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("City of Threads Trash", 2669)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	223254, -- Queen Ansurek (gossip NPC)
	220196, -- Herald of Ansurek
	220195, -- Sureki Silkbinder
	220197, -- Royal Swarmguard
	219984, -- Xeph'itik
	220401, -- Pale Priest
	220003, -- Eye of the Queen
	223844, -- Covert Webmancer
	224732, -- Covert Webmancer
	220730, -- Royal Venomshell
	216328, -- Unstable Test Subject
	216339, -- Sureki Unnaturaler
	221102, -- Elder Shadeweaver
	221103 -- Hulking Warshell
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.herald_of_ansurek = "Herald of Ansurek"
	L.sureki_silkbinder = "Sureki Silkbinder"
	L.royal_swarmguard = "Royal Swarmguard"
	L.xephitik = "Xeph'itik"
	L.pale_priest = "Pale Priest"
	L.eye_of_the_queen = "Eye of the Queen"
	L.covert_webmancer = "Covert Webmancer"
	L.royal_venomshell = "Royal Venomshell"
	L.unstable_test_subject = "Unstable Test Subject"
	L.sureki_unnaturaler = "Sureki Unnaturaler"
	L.elder_shadeweaver = "Elder Shadeweaver"
	L.hulking_warshell = "Hulking Warshell"

	L.izo_warmup_trigger = "Enough! You've earned a place in my collection. Let me usher you in."
end

--------------------------------------------------------------------------------
-- Initialization
--

local autotalk = mod:AddAutoTalkOption(true)
function mod:GetOptions()
	return {
		autotalk,
		-- Herald of Ansurek
		443437, -- Shadows of Doubt
		-- Sureki Silkbinder
		443430, -- Silk Binding
		-- Royal Swarmguard
		443500, -- Earthshatter
		-- Xeph'itik
		450784, -- Perfume Toss
		451423, -- Gossamer Barrage
		-- Pale Priest
		442653, -- What's That?
		448047, -- Web Wrap
		-- Eye of the Queen
		451543, -- Null Slam
		-- Covert Webmancer
		452162, -- Mending Web
		-- Royal Venomshell
		434137, -- Venomous Spray
		-- Unstable Test Subject
		445813, -- Dark Barrage
		-- Sureki Unnaturaler
		446086, -- Void Wave
		-- Elder Shadeweaver
		446717, -- Umbral Weave
		-- Hulking Warshell
		447271, -- Tremor Slam
	}, {
		[443437] = L.herald_of_ansurek,
		[443430] = L.sureki_silkbinder,
		[443500] = L.royal_swarmguard,
		[450784] = L.xephitik,
		[442653] = L.pale_priest,
		[451543] = L.eye_of_the_queen,
		[452162] = L.covert_webmancer,
		[434137] = L.royal_venomshell,
		[445813] = L.unstable_test_subject,
		[446086] = L.sureki_unnaturaler,
		[446717] = L.elder_shadeweaver,
		[447271] = L.hulking_warshell,
	}
end

function mod:OnBossEnable()
	-- Warmups
	self:RegisterEvent("CHAT_MSG_MONSTER_SAY")

	-- Autotalk
	self:RegisterEvent("GOSSIP_SHOW")

	-- Herald of Ansurek
	self:Log("SPELL_AURA_APPLIED", "ShadowsOfDoubtApplied", 443437)

	-- Sureki Silkbinder
	self:Log("SPELL_CAST_START", "SilkBinding", 443430)

	-- Royal Swarmguard
	self:Log("SPELL_CAST_START", "Earthshatter", 443500)

	-- Xeph'itik
	self:Log("SPELL_CAST_START", "PerfumeToss", 450784)
	self:Log("SPELL_CAST_START", "GossamerBarrage", 451423)
	self:Log("SPELL_CAST_SUCCESS", "PheromoneVeil", 441795)

	-- Pale Priest
	self:Log("SPELL_CAST_START", "WhatsThat", 442653) -- Normal only
	self:Log("SPELL_AURA_APPLIED", "WebWrap", 448047)

	-- Eye of the Queen
	self:Log("SPELL_CAST_START", "NullSlam", 451543)

	-- Covert Webmancer
	self:Log("SPELL_CAST_START", "MendingWeb", 452162)

	-- Royal Venomshell
	self:Log("SPELL_CAST_START", "VenomousSpray", 434137)

	-- Unstable Test Subject
	self:Log("SPELL_CAST_START", "DarkBarrage", 445813)

	-- Sureki Unnaturaler
	self:Log("SPELL_CAST_START", "VoidWave", 446086)

	-- Elder Shadeweaver
	self:Log("SPELL_CAST_START", "UmbralWeave", 446717)

	-- Hulking Warshell
	self:Log("SPELL_CAST_START", "TremorSlam", 447271)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Warmups

function mod:CHAT_MSG_MONSTER_SAY(event, msg)
	if msg == L.izo_warmup_trigger then
		-- Izo, the Grand Splicer warmup
		local izoModule = BigWigs:GetBossModule("Izo, the Grand Splicer", true)
		if izoModule then
			izoModule:Enable()
			izoModule:Warmup()
		end
	end
end

-- Autotalk

function mod:GOSSIP_SHOW()
	if self:GetOption(autotalk) and self:GetGossipID(122352) then
		-- 122352:<Tinker with the device and steal some of its power.> [Requires Rogue, Priest, or at least 25 skill in Khaz Algar Engineering.]
		-- gives a temporary damage buff to the group
		self:SelectGossipID(122352)
	end
end

-- Herald of Ansurek

function mod:ShadowsOfDoubtApplied(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
end

-- Sureki Silkbinder

function mod:SilkBinding(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Royal Swarmguard

function mod:Earthshatter(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Xeph'itik

function mod:PerfumeToss(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 15.8)
end

function mod:GossamerBarrage(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 23.1)
end

function mod:PheromoneVeil(args)
	-- TODO could clean up bars a little earlier with [CHAT_MSG_MONSTER_YELL] Enough!#Xeph'itik
	self:StopBar(450784) -- Perfume Toss
	self:StopBar(451423) -- Gossamer Barrage
end

-- Pale Priest

function mod:WhatsThat(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
end

do
	local prev = 0
	function mod:WebWrap(args)
		self:TargetMessage(args.spellId, "cyan", args.destName)
		local t = args.time
		if t - prev > 1.5 then
			-- just a short sound throttle in case the whole group gets caught at once
			prev = t
			self:PlaySound(args.spellId, "info", nil, args.destName)
		end
	end
end

-- Eye of the Queen

function mod:NullSlam(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Covert Webmender

function mod:MendingWeb(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Royal Venomshell

function mod:VenomousSpray(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
end

-- Unstable Test Subject

function mod:DarkBarrage(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "long")
end

-- Sureki Unnaturaler

function mod:VoidWave(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Elder Shadeweaver

function mod:UmbralWeave(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

-- Hulking Warshell

function mod:TremorSlam(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end
