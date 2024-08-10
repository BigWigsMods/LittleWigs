if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("City of Threads Trash", 2669)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	223254, -- Queen Ansurek / The Vizier (gossip NPC)
	220196, -- Herald of Ansurek
	220195, -- Sureki Silkbinder
	220197, -- Royal Swarmguard
	219984, -- Xeph'itik
	220401, -- Pale Priest
	220003, -- Eye of the Queen
	223844, -- Covert Webmancer
	224732, -- Covert Webmancer
	220777, -- Executor Nizrek (warmup NPC)
	220730, -- Royal Venomshell
	216328, -- Unstable Test Subject
	216339, -- Sureki Unnaturaler
	216329, -- Congealed Droplet
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

	L.xephitik_defeated_trigger = "Enough!"
	L.fangs_of_the_queen_warmup_trigger = "The Transformatory was once the home of our sacred evolution."
	L.izo_warmup_trigger = "Enough! You've earned a place in my collection. Let me usher you in."
	L.custom_on_autotalk = CL.autotalk
	L.custom_on_autotalk_desc = "|cFFFF0000Requires Rogue, Priest, or 25 skill in Khaz Algar Engineering.|r Automatically select the NPC dialog option that grants you the 'Stolen Power' aura.\n\n|T135888:16|tStolen Power\n{448305}"
	L.custom_on_autotalk_icon = mod:GetMenuIcon("SAY")
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"custom_on_autotalk",
		-- Herald of Ansurek
		{443437, "SAY", "SAY_COUNTDOWN", "NAMEPLATE"}, -- Shadows of Doubt
		-- Sureki Silkbinder
		{443430, "NAMEPLATE"}, -- Silk Binding
		-- Royal Swarmguard
		{443500, "NAMEPLATE"}, -- Earthshatter
		-- Xeph'itik
		450784, -- Perfume Toss
		451423, -- Gossamer Barrage
		441795, -- Pheromone Veil
		-- Pale Priest
		448047, -- Web Wrap
		-- Eye of the Queen
		{451543, "NAMEPLATE"}, -- Null Slam
		-- Covert Webmancer
		{452162, "NAMEPLATE"}, -- Mending Web
		-- Royal Venomshell
		{434137, "NAMEPLATE"}, -- Venomous Spray
		-- Unstable Test Subject
		{445813, "NAMEPLATE"}, -- Dark Barrage
		-- Sureki Unnaturaler
		{446086, "NAMEPLATE"}, -- Void Wave
		-- Elder Shadeweaver
		{446717, "NAMEPLATE"}, -- Umbral Weave
		-- Hulking Warshell
		{447271, "NAMEPLATE"}, -- Tremor Slam
	}, {
		[443437] = L.herald_of_ansurek,
		[443430] = L.sureki_silkbinder,
		[443500] = L.royal_swarmguard,
		[450784] = L.xephitik,
		[448047] = L.pale_priest,
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
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")

	-- Autotalk
	self:RegisterEvent("GOSSIP_SHOW")

	-- Herald of Ansurek
	self:Log("SPELL_CAST_SUCCESS", "ShadowsOfDoubt", 443436)
	self:Log("SPELL_AURA_APPLIED", "ShadowsOfDoubtApplied", 443437)
	self:Log("SPELL_AURA_REMOVED", "ShadowsOfDoubtRemoved", 443437)
	self:Death("HeraldOfAnsurekDeath", 220196)

	-- Sureki Silkbinder
	self:Log("SPELL_CAST_START", "SilkBinding", 443430)
	self:Log("SPELL_INTERRUPT", "SilkBindingInterrupt", 443430)
	self:Log("SPELL_CAST_SUCCESS", "SilkBindingSuccess", 443430)
	self:Death("SurekiSilkbinderDeath", 220195)

	-- Royal Swarmguard
	self:Log("SPELL_CAST_START", "Earthshatter", 443500)
	self:Death("RoyalSwarmguardDeath", 220197)

	-- Xeph'itik
	self:Log("SPELL_CAST_START", "PerfumeToss", 450784)
	self:Log("SPELL_CAST_START", "GossamerBarrage", 451423)
	self:Log("SPELL_CAST_SUCCESS", "PheromoneVeil", 441795)
	self:Log("SPELL_AURA_APPLIED", "PheromoneVeilApplied", 441795)

	-- Pale Priest
	self:Log("SPELL_AURA_APPLIED", "WebWrap", 448047)

	-- Eye of the Queen
	self:Log("SPELL_CAST_START", "NullSlam", 451543)
	self:Death("EyeOfTheQueenDeath", 220003)

	-- Covert Webmancer
	self:Log("SPELL_CAST_START", "MendingWeb", 452162)
	self:Log("SPELL_INTERRUPT", "MendingWebInterrupt", 452162)
	self:Log("SPELL_CAST_SUCCESS", "MendingWebSuccess", 452162)
	self:Death("CovertWebmancerDeath", 223844, 224732)

	-- Royal Venomshell
	self:Log("SPELL_CAST_START", "VenomousSpray", 434137)
	self:Death("RoyalVenomshellDeath", 220730)

	-- Unstable Test Subject
	self:Log("SPELL_CAST_START", "DarkBarrage", 445813)
	self:Death("UnstableTestSubjectDeath", 216328)

	-- Sureki Unnaturaler
	self:Log("SPELL_CAST_START", "VoidWave", 446086)
	self:Log("SPELL_INTERRUPT", "VoidWaveInterrupt", 446086)
	self:Log("SPELL_CAST_SUCCESS", "VoidWaveSuccess", 446086)
	self:Death("SurekiUnnaturalerDeath", 216339)

	-- Congealed Droplet
	self:Death("CongealedDropletDeath", 216329)

	-- Elder Shadeweaver
	self:Log("SPELL_CAST_START", "UmbralWeave", 446717)
	self:Death("ElderShadeweaverDeath", 221102)

	-- Hulking Warshell
	self:Log("SPELL_CAST_START", "TremorSlam", 447271)
	self:Death("HulkingWarshellDeath", 221103)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Warmups

function mod:CHAT_MSG_MONSTER_SAY(_, msg)
	if msg == L.izo_warmup_trigger then
		-- Izo, the Grand Splicer warmup
		local izoModule = BigWigs:GetBossModule("Izo, the Grand Splicer", true)
		if izoModule then
			izoModule:Enable()
			izoModule:Warmup()
		end
	elseif msg == L.fangs_of_the_queen_warmup_trigger then
		-- Fangs of the Queen warmup
		local fangsOfTheQueenModule = BigWigs:GetBossModule("Fangs of the Queen", true)
		if fangsOfTheQueenModule then
			fangsOfTheQueenModule:Enable()
			fangsOfTheQueenModule:Warmup()
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(_, msg)
	if msg == L.xephitik_defeated_trigger then
		-- clean up bars a bit early
		self:XephitikDefeated()
	end
end

-- Autotalk

function mod:GOSSIP_SHOW()
	if self:GetOption("custom_on_autotalk")then
		if self:GetGossipID(122351) then -- Rogue
			-- 122351:<Sabotage the device and steal some of its power.>\r\n[Requires Rogue, Priest, or at least 25 skill in Khaz Algar Engineering.]|r
			self:SelectGossipID(122351)
		elseif self:GetGossipID(122352) then -- Engineering
			-- 122352:<Tinker with the device and steal some of its power.>\r\n[Requires Rogue, Priest, or at least 25 skill in Khaz Algar Engineering.]|r
			self:SelectGossipID(122352)
		elseif self:GetGossipID(122353) then -- Priest
			-- 122353:<Manipulate the device with shadow magic and steal some of its power.>\r\n[Requires Rogue, Priest, or at least 25 skill in Khaz Algar Engineering.]|r
			self:SelectGossipID(122353)
		end
	end
end

-- Herald of Ansurek

function mod:ShadowsOfDoubt(args)
	self:Nameplate(443437, 12.2, args.sourceGUID)
end

function mod:ShadowsOfDoubtApplied(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Shadows of Doubt")
		self:SayCountdown(args.spellId, 8)
	end
end

function mod:ShadowsOfDoubtRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
end

function mod:HeraldOfAnsurekDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Sureki Silkbinder

function mod:SilkBinding(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	self:Nameplate(args.spellId, 0, args.sourceGUID)
end

function mod:SilkBindingInterrupt(args)
	self:Nameplate(443430, 20.9, args.destGUID)
end

function mod:SilkBindingSuccess(args)
	self:Nameplate(args.spellId, 20.9, args.sourceGUID)
end

function mod:SurekiSilkbinderDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Royal Swarmguard

function mod:Earthshatter(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:Nameplate(args.spellId, 14.6, args.sourceGUID)
end

function mod:RoyalSwarmguardDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Xeph'itik

do
	local timer

	function mod:PerfumeToss(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		self:PlaySound(args.spellId, "alarm")
		self:CDBar(args.spellId, 15.8)
		timer = self:ScheduleTimer("XephitikDefeated", 30)
	end

	function mod:GossamerBarrage(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red")
		self:PlaySound(args.spellId, "long")
		self:CDBar(args.spellId, 23.1)
		timer = self:ScheduleTimer("XephitikDefeated", 30)
	end

	function mod:PheromoneVeil()
		-- backup in case xephitik_defeated_trigger isn't translated
		self:XephitikDefeated()
	end

	function mod:PheromoneVeilApplied(args)
		if self:Me(args.destGUID) then
			self:Message(args.spellId, "green", CL.you:format(args.spellName))
			self:PlaySound(args.spellId, "info")
		end
	end

	function mod:XephitikDefeated()
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(450784) -- Perfume Toss
		self:StopBar(451423) -- Gossamer Barrage
	end
end

-- Pale Priest

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
	self:Nameplate(args.spellId, 26.7, args.sourceGUID)
end

function mod:EyeOfTheQueenDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Covert Webmancer

function mod:MendingWeb(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	self:Nameplate(args.spellId, 0, args.sourceGUID)
end

function mod:MendingWebInterrupt(args)
	self:Nameplate(452162, 16.5, args.destGUID)
end

function mod:MendingWebSuccess(args)
	self:Nameplate(args.spellId, 16.5, args.sourceGUID)
end

function mod:CovertWebmancerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Royal Venomshell

function mod:VenomousSpray(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:Nameplate(args.spellId, 24.2, args.sourceGUID)
end

function mod:RoyalVenomshellDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Unstable Test Subject

function mod:DarkBarrage(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "long")
	self:Nameplate(args.spellId, 27.9, args.sourceGUID)
end

function mod:UnstableTestSubjectDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Sureki Unnaturaler

do
	local prev = 0
	function mod:VoidWave(args)
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
			return
		end
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
		self:Nameplate(args.spellId, 0, args.sourceGUID)
	end
end

function mod:VoidWaveInterrupt(args)
	self:Nameplate(446086, 15.5, args.destGUID)
end

function mod:VoidWaveSuccess(args)
	self:Nameplate(args.spellId, 15.5, args.sourceGUID)
end

function mod:SurekiUnnaturalerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Congealed Droplet

do
	local prev, deathCount = 0, 0
	function mod:CongealedDropletDeath(args)
		local t = args.time
		if t - prev > 120 then -- 1
			deathCount = 1
		elseif deathCount < 9 then -- 2 through 9
			deathCount = deathCount + 1
		else -- 10
			deathCount = 0
			local coaglamationModule = BigWigs:GetBossModule("The Coaglamation", true)
			if coaglamationModule then
				coaglamationModule:Enable()
				coaglamationModule:Warmup()
			end
		end
		prev = t
	end
end

-- Elder Shadeweaver

function mod:UmbralWeave(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:Nameplate(args.spellId, 23.1, args.sourceGUID)
end

function mod:ElderShadeweaverDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Hulking Warshell

function mod:TremorSlam(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:Nameplate(args.spellId, 23.0, args.sourceGUID)
end

function mod:HulkingWarshellDeath(args)
	self:ClearNameplate(args.destGUID)
end
