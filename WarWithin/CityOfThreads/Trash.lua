--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("City of Threads Trash", 2669)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	223254, -- Queen Ansurek / The Vizier (gossip NPC)
	220196, -- Herald of Ansurek
	220193, -- Sureki Venomblade
	220195, -- Sureki Silkbinder
	220197, -- Royal Swarmguard
	219984, -- Xeph'itik
	220401, -- Pale Priest
	219983, -- Eye of the Queen
	223844, -- Covert Webmancer (with Eye of the Queen)
	224732, -- Covert Webmancer (after Fangs of the Queen)
	223182, -- Web Marauder (with Eye of the Queen)
	224731, -- Web Marauder (after Fangs of the Queen)
	220423, -- Retired Lord Vul'azak
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
	L.sureki_venomblade = "Sureki Venomblade"
	L.sureki_silkbinder = "Sureki Silkbinder"
	L.royal_swarmguard = "Royal Swarmguard"
	L.xephitik = "Xeph'itik"
	L.pale_priest = "Pale Priest"
	L.eye_of_the_queen = "Eye of the Queen"
	L.covert_webmancer = "Covert Webmancer"
	L.web_marauder = "Web Marauder"
	L.royal_venomshell = "Royal Venomshell"
	L.unstable_test_subject = "Unstable Test Subject"
	L.sureki_unnaturaler = "Sureki Unnaturaler"
	L.elder_shadeweaver = "Elder Shadeweaver"
	L.hulking_warshell = "Hulking Warshell"

	L.xephitik_defeated_trigger = "Enough!"
	L.fangs_of_the_queen_warmup_trigger = "The Transformatory was once the home of our sacred evolution."
	L.izo_warmup_trigger = "Enough! You've earned a place in my collection. Let me usher you in."
	L.custom_on_autotalk = CL.autotalk
	L.custom_on_autotalk_desc = "|cFFFF0000Requires Rogue, Priest, or 25 skill in Khaz Algar Engineering.|r Automatically select the NPC dialog option that grants you the 'Stolen Power' aura."
	L.custom_on_autotalk_icon = mod:GetMenuIcon("SAY")
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"custom_on_autotalk",
		448305, -- Stolen Power
		-- Herald of Ansurek
		{443437, "SAY", "SAY_COUNTDOWN", "NAMEPLATE"}, -- Shadows of Doubt
		443433, -- Twist Thoughts
		-- Sureki Venomblade
		{443397, "DISPEL", "NAMEPLATE"}, -- Venom Strike
		-- Sureki Silkbinder
		{443430, "NAMEPLATE"}, -- Silk Binding
		-- Royal Swarmguard
		{443500, "NAMEPLATE"}, -- Earthshatter
		{443507, "NAMEPLATE"}, -- Ravenous Swarm
		-- Xeph'itik
		{450784, "NAMEPLATE"}, -- Perfume Toss
		{451423, "NAMEPLATE"}, -- Gossamer Barrage
		441795, -- Pheromone Veil
		-- Pale Priest
		448047, -- Web Wrap
		-- Eye of the Queen
		{451543, "NAMEPLATE"}, -- Null Slam
		{451222, "NAMEPLATE"}, -- Void Rush
		-- Covert Webmancer
		{452162, "NAMEPLATE"}, -- Mending Web
		-- Web Marauder
		{452151, "TANK", "NAMEPLATE", "OFF"}, -- Rigorous Jab
		-- Royal Venomshell
		{434137, "NAMEPLATE"}, -- Venomous Spray
		-- Unstable Test Subject
		{445813, "NAMEPLATE"}, -- Dark Barrage
		{436205, "NAMEPLATE"}, -- Fierce Stomping
		-- Sureki Unnaturaler
		{446086, "NAMEPLATE"}, -- Void Wave
		-- Elder Shadeweaver
		{446717, "NAMEPLATE"}, -- Umbral Weave
		-- Hulking Warshell
		{447271, "NAMEPLATE"}, -- Tremor Slam
	}, {
		[443437] = L.herald_of_ansurek,
		[443397] = L.sureki_venomblade,
		[443430] = L.sureki_silkbinder,
		[443500] = L.royal_swarmguard,
		[450784] = L.xephitik,
		[448047] = L.pale_priest,
		[451543] = L.eye_of_the_queen,
		[452162] = L.covert_webmancer,
		[452151] = L.web_marauder,
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
	self:Log("SPELL_AURA_APPLIED", "StolenPowerApplied", 448305)

	-- Herald of Ansurek
	self:RegisterEngageMob("HeraldOfAnsurekEngaged", 220196)
	self:Log("SPELL_CAST_SUCCESS", "ShadowsOfDoubt", 443436)
	self:Log("SPELL_AURA_APPLIED", "ShadowsOfDoubtApplied", 443437)
	self:Log("SPELL_AURA_REMOVED", "ShadowsOfDoubtRemoved", 443437)
	self:Log("SPELL_CAST_START", "TwistThoughts", 443433)
	self:Log("SPELL_PERIODIC_DAMAGE", "TwistThoughtsDamage", 443435)
	self:Log("SPELL_PERIODIC_MISSED", "TwistThoughtsDamage", 443435)
	self:Death("HeraldOfAnsurekDeath", 220196)

	-- Sureki Venomblade
	self:RegisterEngageMob("SurekiVenombladeEngaged", 220193)
	self:Log("SPELL_CAST_SUCCESS", "VenomStrikeSuccess", 443397)
	self:Log("SPELL_AURA_APPLIED", "VenomStrikeApplied", 443401)
	self:Death("SurekiVenombladeDeath", 220193)

	-- Sureki Silkbinder
	self:RegisterEngageMob("SurekiSilkbinderEngaged", 220195)
	self:Log("SPELL_CAST_START", "SilkBinding", 443430)
	self:Log("SPELL_INTERRUPT", "SilkBindingInterrupt", 443430)
	self:Log("SPELL_CAST_SUCCESS", "SilkBindingSuccess", 443430)
	self:Death("SurekiSilkbinderDeath", 220195)

	-- Royal Swarmguard
	self:RegisterEngageMob("RoyalSwarmguardEngaged", 220197, 220423) -- Royal Swarmguard, Retired Lord Vul'azak
	self:Log("SPELL_CAST_START", "Earthshatter", 443500)
	self:Log("SPELL_CAST_START", "RavenousSwarm", 443507)
	self:Death("RoyalSwarmguardDeath", 220197, 220423) -- Royal Swarmguard, Retired Lord Vul'azak

	-- Xeph'itik
	self:RegisterEngageMob("XephitikEngaged", 219984)
	self:Log("SPELL_CAST_START", "PerfumeToss", 450784)
	self:Log("SPELL_CAST_START", "GossamerBarrage", 451423)
	self:Log("SPELL_CAST_SUCCESS", "PheromoneVeil", 441795) -- Xeph'itik defeated
	self:Log("SPELL_AURA_APPLIED", "PheromoneVeilApplied", 441795)

	-- Pale Priest
	self:Log("SPELL_AURA_APPLIED", "WebWrap", 448047)

	-- Eye of the Queen
	self:RegisterEngageMob("EyeOfTheQueenEngaged", 219983)
	self:Log("SPELL_CAST_START", "NullSlam", 451543)
	self:Log("SPELL_CAST_START", "VoidRush", 451222)
	self:Death("EyeOfTheQueenDeath", 219983)

	-- Covert Webmancer
	self:RegisterEngageMob("CovertWebmancerEngaged", 223844, 224732)
	self:Log("SPELL_CAST_START", "MendingWeb", 452162)
	self:Log("SPELL_INTERRUPT", "MendingWebInterrupt", 452162)
	self:Log("SPELL_CAST_SUCCESS", "MendingWebSuccess", 452162)
	self:Death("CovertWebmancerDeath", 223844, 224732)

	-- Web Marauder
	self:RegisterEngageMob("WebMarauderEngaged", 223182, 224731)
	self:Log("SPELL_CAST_SUCCESS", "RigorousJab", 452151)
	self:Log("SPELL_AURA_APPLIED", "RigorousJabApplied", 452151)
	self:Log("SPELL_AURA_APPLIED_DOSE", "RigorousJabApplied", 452151)
	self:Death("WebMarauderDeath", 223182, 224731)

	-- Royal Venomshell
	self:RegisterEngageMob("RoyalVenomshellEngaged", 220730)
	self:Log("SPELL_CAST_START", "VenomousSpray", 434137)
	self:Death("RoyalVenomshellDeath", 220730)

	-- Unstable Test Subject
	self:RegisterEngageMob("UnstableTestSubjectEngaged", 216328)
	self:Log("SPELL_CAST_START", "DarkBarrage", 445813)
	self:Log("SPELL_CAST_START", "FierceStomping", 436205)
	self:Death("UnstableTestSubjectDeath", 216328)

	-- Sureki Unnaturaler
	self:RegisterEngageMob("SurekiUnnaturalerEngaged", 216339)
	self:Log("SPELL_CAST_START", "VoidWave", 446086)
	self:Log("SPELL_INTERRUPT", "VoidWaveInterrupt", 446086)
	self:Log("SPELL_CAST_SUCCESS", "VoidWaveSuccess", 446086)
	self:Death("SurekiUnnaturalerDeath", 216339)

	-- Congealed Droplet
	self:Death("CongealedDropletDeath", 216329)

	-- Elder Shadeweaver
	self:RegisterEngageMob("ElderShadeweaverEngaged", 221102)
	self:Log("SPELL_CAST_START", "UmbralWeave", 446717)
	self:Death("ElderShadeweaverDeath", 221102)

	-- Hulking Warshell
	self:RegisterEngageMob("HulkingWarshellEngaged", 221103)
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
	if self:GetOption("custom_on_autotalk") then
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

function mod:StolenPowerApplied(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "green", CL.on_group:format(args.spellName))
		self:PlaySound(args.spellId, "info")
	end
end

-- Herald of Ansurek

function mod:HeraldOfAnsurekEngaged(guid)
	self:Nameplate(443437, 8.2, guid) -- Shadows of Doubt
end

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

function mod:TwistThoughts(args)
	local _, isReady = self:Interrupter()
	if isReady then
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alert")
	end
end

do
	local prev = 0
	function mod:TwistThoughtsDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 2 then
			prev = args.time
			self:PersonalMessage(443433, "underyou")
			self:PlaySound(443433, "underyou")
		end
	end
end

function mod:HeraldOfAnsurekDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Sureki Venomblade

function mod:SurekiVenombladeEngaged(guid)
	if self:Tank() or self:Dispeller("poison", nil, 443397) then
		self:Nameplate(443397, 2.6, guid) -- Silk Binding
	end
end

function mod:VenomStrikeSuccess(args)
	if self:Tank() or self:Dispeller("poison", nil, args.spellId) then
		self:Nameplate(args.spellId, 11.1, args.sourceGUID)
	end
end

do
	local prev = 0
	function mod:VenomStrikeApplied(args)
		-- throttle because separate debuffs can be applied by multiple mobs at once
		if (self:Me(args.destGUID) or (self:Dispeller("poison", nil, 443397) and self:Friendly(args.destFlags))) and args.time - prev > 2.5 then
			prev = args.time
			self:TargetMessage(443397, "purple", args.destName)
			self:PlaySound(443397, "alert", nil, args.destName)
		end
	end
end

function mod:SurekiVenombladeDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Sureki Silkbinder

function mod:SurekiSilkbinderEngaged(guid)
	self:Nameplate(443430, 4.7, guid) -- Silk Binding
end

function mod:SilkBinding(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
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

function mod:RoyalSwarmguardEngaged(guid)
	self:Nameplate(443500, 5.5, guid) -- Earthshatter
	self:Nameplate(443507, 10.4, guid) -- Ravenous Swarm
end

function mod:Earthshatter(args)
	self:Message(args.spellId, "orange")
	self:Nameplate(args.spellId, 14.6, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:RavenousSwarm(args)
	self:Message(args.spellId, "yellow")
	if self:MobId(args.sourceGUID) == 221103 then -- Hulking Warshell
		self:RavenousSwarmHulkingWarshell(args)
	else
		self:Nameplate(args.spellId, 18.2, args.sourceGUID)
	end
	self:PlaySound(args.spellId, "info")
end

function mod:RoyalSwarmguardDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Xeph'itik

do
	local timer
	local xephitikGuid

	function mod:XephitikEngaged(guid)
		xephitikGuid = guid
		self:CDBar(450784, 7.0) -- Perfume Toss
		self:Nameplate(450784, 7.0, guid) -- Perfume Toss
		self:CDBar(451423, 12.6) -- Gossamer Barrage
		self:Nameplate(451423, 12.6, guid) -- Gossamer Barrage
		timer = self:ScheduleTimer("XephitikDefeated", 30)
	end

	function mod:PerfumeToss(args)
		xephitikGuid = args.sourceGUID
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		self:CDBar(args.spellId, 15.8)
		self:Nameplate(args.spellId, 15.8, xephitikGuid)
		self:PlaySound(args.spellId, "alarm")
		timer = self:ScheduleTimer("XephitikDefeated", 30)
	end

	function mod:GossamerBarrage(args)
		xephitikGuid = args.sourceGUID
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red")
		self:CDBar(args.spellId, 23.1)
		self:Nameplate(args.spellId, 23.1, xephitikGuid)
		self:PlaySound(args.spellId, "long")
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
		if xephitikGuid then
			self:ClearNameplate(xephitikGuid)
			xephitikGuid = nil
		end
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

function mod:EyeOfTheQueenEngaged(guid)
	self:Nameplate(451222, 6.8, guid) -- Void Rush
	self:Nameplate(451543, 17.9, guid) -- Null Slam
end

function mod:NullSlam(args)
	self:Message(args.spellId, "orange")
	self:Nameplate(args.spellId, 26.7, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:VoidRush(args)
	self:Message(args.spellId, "yellow")
	self:Nameplate(args.spellId, 18.2, args.sourceGUID)
	self:PlaySound(args.spellId, "info")
end

function mod:EyeOfTheQueenDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Covert Webmancer

function mod:CovertWebmancerEngaged(guid)
	self:Nameplate(452162, 5.8, guid) -- Mending Web
end

function mod:MendingWeb(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
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

-- Web Marauder

function mod:WebMarauderEngaged(guid)
	self:Nameplate(452151, 3.7, guid) -- Rigorous Jab
end

function mod:RigorousJab(args)
	self:Nameplate(args.spellId, 6.1, args.sourceGUID)
end

do
	local prev = 0
	function mod:RigorousJabApplied(args)
		if args.time - prev > 2 then
			prev = args.time
			self:StackMessage(args.spellId, "purple", args.destName, args.amount, 5)
			self:PlaySound(args.spellId, "alert", nil, args.destName)
		end
	end
end

function mod:WebMarauderDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Royal Venomshell

function mod:RoyalVenomshellEngaged(guid)
	self:Nameplate(434137, 4.9, guid) -- Venomous Spray
	self:Nameplate(443500, 19.5, guid) -- Earthshatter
end

function mod:VenomousSpray(args)
	self:Message(args.spellId, "yellow")
	self:Nameplate(args.spellId, 24.2, args.sourceGUID)
	self:PlaySound(args.spellId, "long")
end

function mod:RoyalVenomshellDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Unstable Test Subject

function mod:UnstableTestSubjectEngaged(guid)
	self:Nameplate(445813, 5.4, guid) -- Dark Barrage
	self:Nameplate(436205, 15.1, guid) -- Fierce Stomping
end

function mod:DarkBarrage(args)
	self:Message(args.spellId, "orange")
	self:Nameplate(args.spellId, 27.9, args.sourceGUID)
	self:PlaySound(args.spellId, "long")
end

function mod:FierceStomping(args)
	self:Message(args.spellId, "yellow")
	self:Nameplate(args.spellId, 27.9, args.sourceGUID)
	self:PlaySound(args.spellId, "info")
end

function mod:UnstableTestSubjectDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Sureki Unnaturaler

function mod:SurekiUnnaturalerEngaged(guid)
	self:Nameplate(446086, 4.8, guid) -- Void Wave
end

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

do
	local timer

	function mod:ElderShadeweaverEngaged(guid)
		self:CDBar(446717, 4.1) -- Umbral Weave
		self:Nameplate(446717, 4.1, guid) -- Umbral Weave
		timer = self:ScheduleTimer("ElderShadeweaverDeath", 30)
	end

	function mod:UmbralWeave(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "yellow")
		self:CDBar(args.spellId, 23.1)
		self:Nameplate(args.spellId, 23.1, args.sourceGUID)
		self:PlaySound(args.spellId, "alert")
		timer = self:ScheduleTimer("ElderShadeweaverDeath", 30)
	end

	function mod:ElderShadeweaverDeath(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(446717) -- Umbral Weave
		if args then
			self:ClearNameplate(args.destGUID)
		end
	end
end

-- Hulking Warshell

do
	local timer

	function mod:HulkingWarshellEngaged(guid)
		-- Ravenous Swarm is cast immediately
		self:CDBar(447271, 9.9) -- Tremor Slam
		self:Nameplate(447271, 9.9, guid) -- Tremor Slam
		timer = self:ScheduleTimer("HulkingWarshellDeath", 30)
	end

	function mod:RavenousSwarmHulkingWarshell(args)
		if timer then
			self:CancelTimer(timer)
		end
		if not self:IsMobEngaged(args.sourceGUID) then
			-- this cast can beat the engage callback, so trigger it manually
			self:HulkingWarshellEngaged(args.sourceGUID)
		else
			timer = self:ScheduleTimer("HulkingWarshellDeath", 30)
		end
		self:CDBar(443507, 18.2)
		self:Nameplate(443507, 18.2, args.sourceGUID)
	end

	function mod:TremorSlam(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		self:CDBar(args.spellId, 23.0)
		self:Nameplate(args.spellId, 23.0, args.sourceGUID)
		self:PlaySound(args.spellId, "alarm")
		timer = self:ScheduleTimer("HulkingWarshellDeath", 30)
	end

	function mod:HulkingWarshellDeath(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(443507) -- Ravenous Swarm
		self:StopBar(447271) -- Tremor Slam
		if args then
			self:ClearNameplate(args.destGUID)
		end
	end
end
