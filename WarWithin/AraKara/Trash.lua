if not BigWigsLoader.isBeta then return end
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
	L.ixin = "Ixin"
	L.nakt = "Nakt"
	L.atik = "Atik"
	L.hulking_bloodguard = "Hulking Bloodguard"
	L.bloodstained_webmage = "Bloodstained Webmage"
	L.blood_overseer = "Blood Overseer"

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
		-- Ixin
		434824, -- Web Spray
		434802, -- Horrifying Shrill
		-- Nakt
		438877, -- Call of the Brood
		-- Atik
		438826, -- Poisonous Cloud
		-- Hulking Bloodguard
		453161, -- Impale
		434252, -- Massive Slam
		-- Bloodstained Webmage
		448248, -- Revolting Volley
		-- Blood Overseer
		433845, -- Erupting Webs
		433841, -- Venom Volley
	}, {
		["custom_on_autotalk"] = CL.general,
		[434824] = L.ixin,
		[438877] = L.nakt,
		[438826] = L.atik,
		[453161] = L.hulking_bloodguard,
		[448248] = L.bloodstained_webmage,
		[433845] = L.blood_overseer,
	}
end

function mod:OnBossEnable()
	-- Autotalk
	self:RegisterEvent("GOSSIP_SHOW")
	self:Log("SPELL_AURA_APPLIED", "SilkThreadApplied", 439201)

	-- Ixin
	self:Log("SPELL_CAST_START", "WebSpray", 434824)
	self:Log("SPELL_CAST_START", "HorrifyingShrill", 434802)

	-- Nakt
	self:Log("SPELL_CAST_START", "CallOfTheBrood", 438877)

	-- Atik
	self:Log("SPELL_CAST_START", "PoisonousCloud", 438826)
	self:Log("SPELL_PERIODIC_DAMAGE", "PoisonousCloudDamage", 438825)

	-- Hulking Bloodguard
	self:Log("SPELL_CAST_START", "Impale", 453161)
	self:Log("SPELL_CAST_START", "MassiveSlam", 434252)

	-- Bloodstained Webmage
	self:Log("SPELL_CAST_START", "RevoltingVolley", 448248)

	-- Blood Overseer
	self:Log("SPELL_CAST_START", "EruptingWebs", 433845)
	self:Log("SPELL_CAST_START", "VenomVolley", 433841)
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

-- Ixin

function mod:WebSpray(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

function mod:HorrifyingShrill(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

-- Nakt

function mod:CallOfTheBrood(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
end

-- Atik

function mod:PoisonousCloud(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

function mod:PoisonousCloudDamage(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(438826, "underyou")
		self:PlaySound(438826, "underyou", nil, args.destName)
	end
end

-- Hulking Bloodguard

function mod:Impale(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

function mod:MassiveSlam(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
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
	end
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
	end
end
