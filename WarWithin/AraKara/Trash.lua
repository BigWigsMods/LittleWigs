--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ara-Kara, City of Echoes Trash", 2660)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	216336, -- Ravenous Crawler
	216341, -- Jabbing Flyer
	214840, -- Engorged Crawler
	216293, -- Trilling Attendant
	219420, -- Discordant Attendant (gossip NPC)
	217531, -- Ixin
	218324, -- Nakt
	217533, -- Atik
	216338, -- Hulking Bloodguard
	223253, -- Bloodstained Webmage
	216364, -- Blood Overseer
	217039 -- Nerubian Hauler
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.engorged_crawler = "Engorged Crawler"
	L.trilling_attendant = "Trilling Attendant"
	L.ixin = "Ixin"
	L.nakt = "Nakt"
	L.atik = "Atik"
	L.hulking_bloodguard = "Hulking Bloodguard"
	L.bloodstained_webmage = "Bloodstained Webmage"
	L.blood_overseer = "Blood Overseer"
	L.nerubian_hauler = "Nerubian Hauler"

	L.custom_on_autotalk = CL.autotalk
	L.custom_on_autotalk_desc = "|cFFFF0000Requires 25 skill in Khaz Algar Tailoring.|r Automatically select the NPC dialog option that grants you 'Silk Wrap' which you can use by clicking your extra action button."
	L.custom_on_autotalk_icon = mod:GetMenuIcon("SAY")
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Autotalk
		"custom_on_autotalk",
		439208, -- Silk Wrap
		-- Engorged Crawler
		438622, -- Toxic Rupture
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
		-- Bloodstained Webmage
		{448248, "NAMEPLATE"}, -- Revolting Volley
		-- Blood Overseer
		{433845, "NAMEPLATE"}, -- Erupting Webs
		{433841, "NAMEPLATE"}, -- Venom Volley
		-- Nerubian Hauler
		{434252, "NAMEPLATE"}, -- Massive Slam
	}, {
		["custom_on_autotalk"] = CL.general,
		[438622] = L.engorged_crawler,
		[434793] = L.trilling_attendant,
		[434824] = L.ixin,
		[438877] = L.nakt,
		[438826] = L.atik,
		[453161] = L.hulking_bloodguard,
		[448248] = L.bloodstained_webmage,
		[433845] = L.blood_overseer,
		[434252] = L.nerubian_hauler,
	}
end

function mod:OnBossEnable()
	-- TODO Avanoxx warmup?
	-- [CHAT_MSG_RAID_BOSS_EMOTE] The Attendants have been silenced... something emerges!#Avanoxx
	-- ~15s

	-- Autotalk
	self:RegisterEvent("GOSSIP_SHOW")
	self:Log("SPELL_AURA_APPLIED", "SilkThreadApplied", 439201)

	-- Interrupts
	self:Log("SPELL_INTERRUPT", "Interrupt", "*")

	-- Engorged Crawler
	self:Log("SPELL_CAST_SUCCESS", "ToxicRupture", 438622)

	-- Trilling Attendant
	self:Log("SPELL_CAST_SUCCESS", "ResonantBarrage", 434793)
	self:Death("TrillingAttendantDeath", 216293)

	-- Ixin
	self:Log("SPELL_CAST_START", "WebSpray", 434824)
	self:Log("SPELL_CAST_START", "HorrifyingShrill", 434802)
	self:Log("SPELL_CAST_SUCCESS", "HorrifyingShrillSuccess", 434802)
	self:Death("IxinDeath", 217531)

	-- Nakt
	self:Log("SPELL_CAST_START", "CallOfTheBrood", 438877)
	self:Death("NaktDeath", 218324)

	-- Atik
	self:Log("SPELL_CAST_START", "PoisonousCloud", 438826)
	self:Log("SPELL_PERIODIC_DAMAGE", "PoisonousCloudDamage", 438825)
	self:Death("AtikDeath", 217533)

	-- Hulking Bloodguard
	self:Log("SPELL_CAST_START", "Impale", 453161)
	self:Death("HulkingBloodguardDeath", 216338)

	-- Bloodstained Webmage
	self:Log("SPELL_CAST_START", "RevoltingVolley", 448248)
	self:Log("SPELL_CAST_SUCCESS", "RevoltingVolleySuccess", 448248)
	self:Death("BloodstainedWebmageDeath", 223253)

	-- Blood Overseer
	self:Log("SPELL_CAST_START", "EruptingWebs", 433845)
	self:Log("SPELL_CAST_START", "VenomVolley", 433841)
	self:Log("SPELL_CAST_SUCCESS", "VenomVolleySuccess", 433841)
	self:Death("BloodOverseerDeath", 216364)

	-- Nerubian Hauler
	self:Log("SPELL_CAST_START", "MassiveSlam", 434252)
	self:Death("NerubianHaulerDeath", 217039)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Autotalk

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

-- Interrupts

function mod:Interrupt(args)
	if args.extraSpellId == 434802 then -- Horrifying Shrill
		self:Nameplate(434802, 13.1, args.destGUID)
	elseif args.extraSpellId == 448248 then -- Revolting Volley
		self:Nameplate(448248, 18.0, args.destGUID)
	elseif args.extraSpellId == 433841 then -- Venom Volley
		self:Nameplate(433841, 18.6, args.destGUID)
	end
end

-- Engorged Crawler

do
	local prev = 0
	function mod:ToxicRupture(args)
		local t = args.time
		if t - prev > 2.5 then
			prev = t
			-- cast at low hp, recast if stopped
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Trilling Attendant

do
	local prev = 0
	function mod:ResonantBarrage(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
		self:Nameplate(args.spellId, 17.0, args.sourceGUID)
	end
end

function mod:TrillingAttendantDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Ixin

function mod:WebSpray(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:Nameplate(args.spellId, 10.9, args.sourceGUID)
end

function mod:HorrifyingShrill(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
	self:Nameplate(args.spellId, 0, args.sourceGUID)
end

function mod:HorrifyingShrillSuccess(args)
	self:Nameplate(args.spellId, 13.1, args.sourceGUID)
end

function mod:IxinDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Nakt

function mod:CallOfTheBrood(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
	self:Nameplate(args.spellId, 26.7, args.sourceGUID)
end

function mod:NaktDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Atik

function mod:PoisonousCloud(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:Nameplate(args.spellId, 15.8, args.sourceGUID)
end

function mod:PoisonousCloudDamage(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(438826, "underyou")
		self:PlaySound(438826, "underyou", nil, args.destName)
	end
end

function mod:AtikDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Hulking Bloodguard

function mod:Impale(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:Nameplate(args.spellId, 14.6, args.sourceGUID)
end

function mod:HulkingBloodguardDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Bloodstained Webmage

do
	local prev = 0
	function mod:RevoltingVolley(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
		self:Nameplate(args.spellId, 0, args.sourceGUID)
	end
end

function mod:RevoltingVolleySuccess(args)
	self:Nameplate(args.spellId, 18.0, args.sourceGUID)
end

function mod:BloodstainedWebmageDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Blood Overseer

do
	local prev = 0
	function mod:EruptingWebs(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
		self:Nameplate(args.spellId, 18.2, args.sourceGUID)
	end
end

do
	local prev = 0
	function mod:VenomVolley(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
		self:Nameplate(args.spellId, 0, args.sourceGUID)
	end
end

function mod:VenomVolleySuccess(args)
	self:Nameplate(args.spellId, 18.6, args.sourceGUID)
end

function mod:BloodOverseerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Nerubian Hauler

function mod:MassiveSlam(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
	self:Nameplate(args.spellId, 15.4, args.sourceGUID)
end

function mod:NerubianHaulerDeath(args)
	self:ClearNameplate(args.destGUID)
end
