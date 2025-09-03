--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ara-Kara, City of Echoes Trash", 2660)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	219420, -- Discordant Attendant (gossip NPC)
	216336, -- Ravenous Crawler
	216341, -- Jabbing Flyer
	214840, -- Engorged Crawler
	216293, -- Trilling Attendant
	217531, -- Ixin
	218324, -- Nakt
	217533, -- Atik
	216338, -- Hulking Bloodguard
	228015, -- Hulking Bloodguard (Sentry Stagshell's summon)
	216340, -- Sentry Stagshell
	216333, -- Bloodstained Assistant
	223253, -- Bloodstained Webmage
	216364, -- Blood Overseer
	216363, -- Reinforced Drone
	216365 -- Winged Carrier
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.vile_webbing = 434830
	L.discordant_attendant = "Discordant Attendant"
	L.engorged_crawler = "Engorged Crawler"
	L.trilling_attendant = "Trilling Attendant"
	L.ixin = "Ixin"
	L.nakt = "Nakt"
	L.atik = "Atik"
	L.hulking_bloodguard = "Hulking Bloodguard"
	L.sentry_stagshell = "Sentry Stagshell"
	L.bloodstained_assistant = "Bloodstained Assistant"
	L.bloodstained_webmage = "Bloodstained Webmage"
	L.blood_overseer = "Blood Overseer"
	L.reinforced_drone = "Reinforced Drone"
	L.nerubian_hauler = "Nerubian Hauler"
	L.winged_carrier = "Winged Carrier"

	L.avanoxx_warmup_trigger = "The Attendants have been silenced... something emerges!"
	L.custom_on_autotalk = CL.autotalk
	L.custom_on_autotalk_desc = "|cFFFF0000Requires 25 skill in Khaz Algar Tailoring.|r Automatically select the NPC dialog option that grants you 'Silk Wrap' which you can use by clicking your extra action button."
	L.custom_on_autotalk_icon = mod:GetMenuIcon("SAY")
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Vile Webbing
		434830, -- Vile Webbing
		{436614, "DISPEL"}, -- Web Wrap
		-- Discordant Attendant
		"custom_on_autotalk",
		439208, -- Silk Wrap
		-- Engorged Crawler
		{438618, "DISPEL", "NAMEPLATE"}, -- Venomous Spit
		-- Trilling Attendant
		{434793, "NAMEPLATE"}, -- Resonant Barrage
		-- Ixin
		{434824, "NAMEPLATE"}, -- Web Spray
		{434802, "NAMEPLATE"}, -- Horrifying Shrill
		-- Nakt
		{438877, "NAMEPLATE"}, -- Call of the Brood
		-- Atik
		{438826, "NAMEPLATE"}, -- Poisonous Cloud
		-- Hulking Bloodguard
		{453161, "NAMEPLATE"}, -- Impale
		{1241693, "NAMEPLATE"}, -- Locust Swarm
		-- Sentry Stagshell
		432967, -- Alarm Shrill
		-- Bloodstained Assistant
		{433002, "TANK", "NAMEPLATE", "OFF"}, -- Extraction Strike
		-- Bloodstained Webmage
		{448248, "NAMEPLATE"}, -- Revolting Volley
		-- Blood Overseer
		{433845, "NAMEPLATE"}, -- Erupting Webs
		{433841, "NAMEPLATE"}, -- Venom Volley
		-- Reinforced Drone
		{1241785, "DISPEL"}, -- Tainted Blood
		-- Winged Carrier
		{433821, "NAMEPLATE", "OFF"}, -- Dashing Strike
	}, {
		{
			tabName = self:BossName(2583), -- Avanoxx
			{434830, 436614, "custom_on_autotalk", 439208, 438618, 434793, 434824, 434802, 438877, 438826},
		},
		{
			tabName = self:BossName(2584), -- Anub'zekt
			{"custom_on_autotalk", 439208, 453161, 1241693, 432967, 433002, 448248},
		},
		{
			tabName = self:BossName(2585), -- Ki'katal the Harvester
			{433845, 433841, 1241785, 433821, 453161, 1241693},
		},
		[434830] = L.vile_webbing,
		["custom_on_autotalk"] = L.discordant_attendant,
		[438618] = L.engorged_crawler,
		[434793] = L.trilling_attendant,
		[434824] = L.ixin,
		[438877] = L.nakt,
		[438826] = L.atik,
		[453161] = L.hulking_bloodguard,
		[432967] = L.sentry_stagshell,
		[433002] = L.bloodstained_assistant,
		[448248] = L.bloodstained_webmage,
		[433845] = L.blood_overseer,
		[1241785] = L.reinforced_drone,
		[433821] = L.winged_carrier,
	}
end

function mod:OnBossEnable()
	-- Warmup
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")

	-- Vile Webbing
	self:Log("SPELL_AURA_APPLIED", "VileWebbingApplied", 434830)
	self:Log("SPELL_AURA_APPLIED_DOSE", "VileWebbingApplied", 434830)
	self:Log("SPELL_AURA_APPLIED", "WebWrapApplied", 436614)

	-- Discordant Attendant
	self:RegisterEvent("GOSSIP_SHOW")
	self:Log("SPELL_AURA_APPLIED", "SilkThreadApplied", 439201)

	-- Engorged Crawler
	self:RegisterEngageMob("EngorgedCrawlerEngaged", 214840)
	self:Log("SPELL_CAST_SUCCESS", "VenomousSpit", 438618)
	self:Log("SPELL_AURA_APPLIED", "VenomousSpitApplied", 438618)
	self:Log("SPELL_AURA_APPLIED_DOSE", "VenomousSpitApplied", 438618)
	self:Death("EngorgedCrawlerDeath", 214840)

	-- Trilling Attendant
	self:RegisterEngageMob("TrillingAttendantEngaged", 216293)
	self:Log("SPELL_CAST_SUCCESS", "ResonantBarrage", 434793)
	self:Death("TrillingAttendantDeath", 216293)

	-- Ixin, Nakt, Atik
	self:Log("SPELL_CAST_START", "WebSpray", 434824)

	-- Ixin
	self:RegisterEngageMob("IxinEngaged", 217531)
	self:Log("SPELL_CAST_START", "HorrifyingShrill", 434802)
	self:Log("SPELL_INTERRUPT", "HorrifyingShrillInterrupt", 434802)
	self:Log("SPELL_CAST_SUCCESS", "HorrifyingShrillSuccess", 434802)
	self:Death("IxinDeath", 217531)

	-- Nakt
	self:RegisterEngageMob("NaktEngaged", 218324)
	self:Log("SPELL_CAST_START", "CallOfTheBrood", 438877)
	self:Death("NaktDeath", 218324)

	-- Atik
	self:RegisterEngageMob("AtikEngaged", 217533)
	self:Log("SPELL_CAST_START", "PoisonousCloud", 438826)
	self:Log("SPELL_PERIODIC_DAMAGE", "PoisonousCloudDamage", 438825)
	self:Log("SPELL_PERIODIC_MISSED", "PoisonousCloudDamage", 438825)
	self:Death("AtikDeath", 217533)

	-- Hulking Bloodguard
	self:RegisterEngageMob("HulkingBloodguardEngaged", 216338, 228015)
	self:Log("SPELL_CAST_START", "Impale", 453161)
	self:Log("SPELL_CAST_START", "LocustSwarm", 1241693)
	self:Death("HulkingBloodguardDeath", 216338, 228015)

	-- Sentry Stagshell
	self:Log("SPELL_CAST_START", "AlarmShrill", 432967)
	self:Log("SPELL_SUMMON", "AlarmShrillSummon", 432967)

	-- Bloodstained Assistant
	self:RegisterEngageMob("BloodstainedAssistantEngaged", 216333)
	self:Log("SPELL_CAST_START", "ExtractionStrike", 433002)
	self:Log("SPELL_CAST_SUCCESS", "ExtractionStrikeSuccess", 433002)
	self:Death("BloodstainedAssistantDeath", 216333)

	-- Bloodstained Webmage
	self:RegisterEngageMob("BloodstainedWebmageEngaged", 223253)
	self:Log("SPELL_CAST_START", "RevoltingVolley", 448248)
	self:Log("SPELL_INTERRUPT", "RevoltingVolleyInterrupt", 448248)
	self:Log("SPELL_CAST_SUCCESS", "RevoltingVolleySuccess", 448248)
	self:Death("BloodstainedWebmageDeath", 223253)

	-- Blood Overseer
	self:RegisterEngageMob("BloodOverseerEngaged", 216364)
	self:Log("SPELL_CAST_START", "EruptingWebs", 433845)
	self:Log("SPELL_CAST_START", "VenomVolley", 433841)
	self:Log("SPELL_INTERRUPT", "VenomVolleyInterrupt", 433841)
	self:Log("SPELL_CAST_SUCCESS", "VenomVolleySuccess", 433841)
	self:Death("BloodOverseerDeath", 216364)

	-- Reinforced Drone
	self:Log("SPELL_AURA_APPLIED_DOSE", "TaintedBloodApplied", 1241785)

	-- Winged Carrier
	self:RegisterEngageMob("WingedCarrierEngaged", 216365)
	self:Log("SPELL_CAST_SUCCESS", "DashingStrike", 433821)
	self:Death("WingedCarrierDeath", 216365)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Warmup

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg)
	if msg == L.avanoxx_warmup_trigger then
		-- Avanoxx warmup
		local avanoxxModule = BigWigs:GetBossModule("Avanoxx", true)
		if avanoxxModule then
			avanoxxModule:Enable()
			avanoxxModule:Warmup()
		end
	end
end

-- Vile Webbing

function mod:VileWebbingApplied(args)
	if self:Me(args.destGUID) then
		local amount = args.amount or 1
		if amount % 2 == 0 then -- alert 2, 4, stuns at 6
			self:StackMessage(args.spellId, "blue", args.destName, amount, 3)
			self:PlaySound(args.spellId, "underyou")
		end
	end
end

function mod:WebWrapApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("magic", nil, args.spellId) then
		self:TargetMessage(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "warning", nil, args.destName)
	end
end

-- Discordant Attendant

function mod:GOSSIP_SHOW()
	if self:GetOption("custom_on_autotalk") and self:GetGossipID(121214) then
		-- 121214:<Carefully pull on a bit of thread.> \r\n[Requires at least 25 skill in Khaz Algar Tailoring.]
		-- grants a buff (439201 Silk Thread) which gives an extra action button to stun an enemy (439208 Silk Wrap).
		self:SelectGossipID(121214)
	end
end

function mod:SilkThreadApplied(args)
	if self:Me(args.destGUID) then
		-- use Silk Wrap key, which is the stun which can now be applied when you gain this buff
		self:Message(439208, "green", CL.you:format(args.spellName))
		self:PlaySound(439208, "info")
	end
end

-- Engorged Crawler

function mod:EngorgedCrawlerEngaged(guid)
	if self:Dispeller("poison", nil, 438618) then
		self:Nameplate(438618, 5.6, guid) -- Venomous Spit
	end
end

function mod:VenomousSpit(args)
	if self:Dispeller("poison", nil, args.spellId) then
		self:Nameplate(args.spellId, 10.9, args.sourceGUID)
	end
end

do
	local prev = 0
	function mod:VenomousSpitApplied(args)
		if self:Dispeller("poison", nil, args.spellId) then
			local amount = args.amount or 1
			if amount % 2 == 0 and args.time - prev > 3 then
				prev = args.time
				self:StackMessage(args.spellId, "yellow", args.destName, amount, 2)
				self:PlaySound(args.spellId, "alert", nil, args.destName)
			end
		end
	end
end

function mod:EngorgedCrawlerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Trilling Attendant

function mod:TrillingAttendantEngaged(guid)
	self:Nameplate(434793, 2.5, guid) -- Resonant Barrage
end

do
	local prev = 0
	function mod:ResonantBarrage(args)
		self:Nameplate(args.spellId, 17.0, args.sourceGUID)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:TrillingAttendantDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Ixin, Nakt, Atik

function mod:WebSpray(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 10.9)
	self:Nameplate(args.spellId, 10.9, args.sourceGUID)
	local mobId = self:MobId(args.sourceGUID)
	if mobId == 217531 then -- Ixin
		self:IxinWebSpray(args.sourceGUID)
	elseif mobId == 218324 then -- Nakt
		self:NaktWebSpray(args.sourceGUID)
	else -- 217533, Atik
		self:AtikWebSpray(args.sourceGUID)
	end
	self:PlaySound(args.spellId, "alarm")
end

-- Ixin

do
	local timer

	function mod:IxinEngaged(guid)
		self:CDBar(434824, 5.3) -- Web Spray
		self:Nameplate(434824, 5.3, guid) -- Web Spray
		self:CDBar(434802, 11.1) -- Horrifying Shrill
		self:Nameplate(434802, 11.1, guid) -- Horrifying Shrill
		timer = self:ScheduleTimer("IxinDeath", 30, nil, guid)
	end

	function mod:IxinWebSpray(guid)
		if timer then
			self:CancelTimer(timer)
		end
		timer = self:ScheduleTimer("IxinDeath", 30, nil, guid)
	end

	function mod:HorrifyingShrill(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:Nameplate(args.spellId, 0.0, args.sourceGUID)
		timer = self:ScheduleTimer("IxinDeath", 30, nil, args.sourceGUID)
		self:PlaySound(args.spellId, "warning")
	end

	function mod:HorrifyingShrillInterrupt(args)
		self:CDBar(434802, 20.6)
		self:Nameplate(434802, 20.6, args.destGUID)
	end

	function mod:HorrifyingShrillSuccess(args)
		self:CDBar(args.spellId, 20.6)
		self:Nameplate(args.spellId, 20.6, args.sourceGUID)
	end

	function mod:IxinDeath(args, guidFromTimer)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(434824) -- Web Spray
		self:StopBar(434802) -- Horrifying Shrill
		self:ClearNameplate(guidFromTimer or args.destGUID)
	end
end

-- Nakt

do
	local timer

	function mod:NaktEngaged(guid)
		self:CDBar(438877, 10.3) -- Call of the Brood
		self:Nameplate(438877, 10.3, guid) -- Call of the Brood
		self:CDBar(434824, 15.3) -- Web Spray
		self:Nameplate(434824, 15.3, guid) -- Web Spray
		timer = self:ScheduleTimer("NaktDeath", 30, nil, guid)
	end

	function mod:NaktWebSpray(guid)
		if timer then
			self:CancelTimer(timer)
		end
		timer = self:ScheduleTimer("NaktDeath", 30, nil, guid)
	end

	function mod:CallOfTheBrood(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "cyan")
		self:CDBar(args.spellId, 20.9)
		self:Nameplate(args.spellId, 20.9, args.sourceGUID)
		timer = self:ScheduleTimer("NaktDeath", 30, nil, args.sourceGUID)
		self:PlaySound(args.spellId, "info")
	end

	function mod:NaktDeath(args, guidFromTimer)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(434824) -- Web Spray
		self:StopBar(438877) -- Call of the Brood
		self:ClearNameplate(guidFromTimer or args.destGUID)
	end
end

-- Atik

do
	local timer

	function mod:AtikEngaged(guid)
		self:CDBar(434824, 3.5) -- Web Spray
		self:Nameplate(434824, 3.5, guid) -- Web Spray
		self:CDBar(438826, 8.4) -- Poisonous Cloud
		self:Nameplate(438826, 8.4, guid) -- Poisonous Cloud
		timer = self:ScheduleTimer("AtikDeath", 30, nil, guid)
	end

	function mod:AtikWebSpray(guid)
		if timer then
			self:CancelTimer(timer)
		end
		timer = self:ScheduleTimer("AtikDeath", 30, nil, guid)
	end

	function mod:PoisonousCloud(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "yellow")
		self:CDBar(args.spellId, 15.7)
		self:Nameplate(args.spellId, 15.7, args.sourceGUID)
		timer = self:ScheduleTimer("AtikDeath", 30, nil, args.sourceGUID)
		self:PlaySound(args.spellId, "alert")
	end

	do
		local prev = 0
		function mod:PoisonousCloudDamage(args)
			if self:Me(args.destGUID) and args.time - prev > 2.5 then -- ticks every 1s
				prev = args.time
				self:PersonalMessage(438826, "underyou")
				self:PlaySound(438826, "underyou")
			end
		end
	end

	function mod:AtikDeath(args, guidFromTimer)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(434824) -- Web Spray
		self:StopBar(438826) -- Poisonous Cloud
		self:ClearNameplate(guidFromTimer or args.destGUID)
	end
end

-- Hulking Bloodguard

function mod:HulkingBloodguardEngaged(guid)
	self:Nameplate(1241693, 5.1, guid) -- Locust Swarm
	self:Nameplate(453161, 16.0, guid) -- Impale
end

function mod:Impale(args)
	self:Message(args.spellId, "orange")
	self:Nameplate(args.spellId, 10.9, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:LocustSwarm(args)
	self:Message(args.spellId, "yellow")
	self:Nameplate(args.spellId, 30.2, args.sourceGUID)
	self:PlaySound(args.spellId, "info")
end

function mod:HulkingBloodguardDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Sentry Stagshell

do
	local prev = 0
	function mod:AlarmShrill(args)
		if args.time - prev > 3 then
			prev = args.time
			self:Message(args.spellId, "cyan", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "info")
		end
	end
end

function mod:AlarmShrillSummon(args)
	self:Message(args.spellId, "cyan", CL.spawning:format(args.destName))
	self:PlaySound(args.spellId, "warning")
end

-- Bloodstained Assistant

function mod:BloodstainedAssistantEngaged(guid)
	self:Nameplate(433002, 5.4, guid) -- Extraction Strike
end

do
	local prev = 0
	function mod:ExtractionStrike(args)
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:ExtractionStrikeSuccess(args)
	self:Nameplate(args.spellId, 12.5, args.sourceGUID)
end

function mod:BloodstainedAssistantDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Bloodstained Webmage

function mod:BloodstainedWebmageEngaged(guid)
	self:Nameplate(448248, 5.9, guid) -- Revolting Volley
end

do
	local prev = 0
	function mod:RevoltingVolley(args)
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:RevoltingVolleyInterrupt(args)
	self:Nameplate(448248, 22.5, args.destGUID)
end

function mod:RevoltingVolleySuccess(args)
	self:Nameplate(args.spellId, 22.5, args.sourceGUID)
end

function mod:BloodstainedWebmageDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Blood Overseer

function mod:BloodOverseerEngaged(guid)
	self:Nameplate(433841, 6.0, guid) -- Venom Volley
	self:Nameplate(433845, 13.2, guid) -- Erupting Webs
end

do
	local prev = 0
	function mod:EruptingWebs(args)
		self:Nameplate(args.spellId, 21.8, args.sourceGUID)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

do
	local prev = 0
	function mod:VenomVolley(args)
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:VenomVolleyInterrupt(args)
	self:Nameplate(433841, 18.3, args.destGUID)
end

function mod:VenomVolleySuccess(args)
	self:Nameplate(args.spellId, 18.3, args.sourceGUID)
end

function mod:BloodOverseerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Reinforced Drone

function mod:TaintedBloodApplied(args)
	if (self:Me(args.destGUID) or self:Dispeller("magic", nil, args.spellId) or self:Dispeller("movement", nil, args.spellId)) and args.amount % 5 == 0 then
		self:StackMessage(args.spellId, "purple", args.destName, args.amount, 10)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

-- Winged Carrier

function mod:WingedCarrierEngaged(guid)
	self:Nameplate(433821, 3.2, guid) -- Dashing Strike
end

function mod:DashingStrike(args)
	self:Nameplate(args.spellId, 8.5, args.sourceGUID)
end

function mod:WingedCarrierDeath(args)
	self:ClearNameplate(args.destGUID)
end
