if not BigWigsLoader.isTestBuild then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Operation: Floodgate Trash", 2773)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	230740, -- Shreddinator 3000
	229069, -- Mechadrone Sniper
	229252, -- Darkfuse Hyena
	229212, -- Darkfuse Demolitionist
	231385, -- Darkfuse Inspector
	230748, -- Darkfuse Bloodwarper
	229686, -- Venture Co. Surveyor
	231380, -- Undercrawler
	231223, -- Disturbed Kelp
	234373, -- Bomb Pile
	231197, -- Bubbles
	231312, -- Venture Co. Electrician
	231325 -- Darkfuse Jumpstarter
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.weapons_stockpiles_pilfered = "Weapons Stockpiles Pilfered"
	L.weapons_stockpiles_pilfered_desc = "Show an alert when a Weapons Stockpile has been pilfered."
	L.weapons_stockpiles_pilfered_icon = "garrison_greenweapon"

	L.shreddinator_3000 = "Shreddinator 3000"
	L.mechadrone_sniper = "Mechadrone Sniper"
	L.darkfuse_hyena = "Darkfuse Hyena"
	L.darkfuse_demolitionist = "Darkfuse Demolitionist"
	L.darkfuse_inspector = "Darkfuse Inspector"
	L.darkfuse_bloodwarper = "Darkfuse Bloodwarper"
	L.venture_co_surveyor = "Venture Co. Surveyor"
	L.undercrawler = "Undercrawler"
	L.disturbed_kelp = "Disturbed Kelp"
	L.bomb_pile = "Bomb Pile"
	L.bubbles = "Bubbles"
	L.venture_co_electrician = "Venture Co. Electrician"
	L.darkfuse_jumpstarter = "Darkfuse Jumpstarter"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Weapons Stockpile
		"weapons_stockpiles_pilfered",
		-- Shreddinator 3000
		{474337, "NAMEPLATE"}, -- Shreddation
		{465754, "NAMEPLATE"}, -- Flamethrower
		-- Mechadrone Sniper
		{1214468, "NAMEPLATE"}, -- Trickshot
		-- Darkfuse Hyena
		{463058, "NAMEPLATE"}, -- Bloodthirsty Cackle
		-- Darkfuse Demolitionist
		1216039, -- R.P.G.G.
		-- Darkfuse Inspector
		{465682, "NAMEPLATE"}, -- Surprise Inspection
		-- Darkfuse Bloodwarper
		{465827, "NAMEPLATE"}, -- Warp Blood
		-- Venture Co. Surveyor
		{462771, "NAMEPLATE"}, -- Surveying Beam
		-- Undercrawler
		{465813, "DISPEL", "NAMEPLATE"}, -- Lethargic Venom
		-- Disturbed Kelp
		{471736, "NAMEPLATE"}, -- Jettison Kelp
		{471733, "NAMEPLATE"}, -- Restorative Algae
		-- Bomb Pile
		1214337, -- Plant Bombs
		-- Bubbles
		{469818, "NAMEPLATE"}, -- Bubble Burp
		{1217496, "NAMEPLATE"}, -- Splish Splash
		{469721, "NAMEPLATE"}, -- Backwash
		-- Venture Co. Electrician
		{469799, "DISPEL", "NAMEPLATE"}, -- Overcharge
		-- Darkfuse Jumpstarter
		{465666, "TANK", "NAMEPLATE"}, -- Sparkslam
	}, {
		["weapons_stockpiles_pilfered"] = CL.general,
		[474337] = L.shreddinator_3000,
		[1214468] = L.mechadrone_sniper,
		[463058] = L.darkfuse_hyena,
		[1216039] = L.darkfuse_demolitionist,
		[465682] = L.darkfuse_inspector,
		[465827] = L.darkfuse_bloodwarper,
		[462771] = L.venture_co_surveyor,
		[465813] = L.undercrawler,
		[471733] = L.disturbed_kelp,
		[1214337] = L.bomb_pile,
		[469818] = L.bubbles,
		[469799] = L.venture_co_electrician,
		[465666] = L.darkfuse_jumpstarter,
	}
end

function mod:OnBossEnable()
	-- Weapons Stockpile
	self:RegisterWidgetEvent(6270, "WeaponsStockpilePilfered", true)

	-- Zeppelin
	-- 1213704 Zeppelin Barrage, hidden
	-- [CHAT_MSG_RAID_BOSS_WHISPER] |TInterface\\ICONS\\Ability_Vehicle_SiegeEngineCannon.blp:20|t You are targeted by |cFFFF0000|Hspell:1213704|h[Zeppelin Barrage]|h|r!#Zeppelin###playerName

	-- Shreddinator 3000
	self:RegisterEngageMob("Shreddinator3000Engaged", 230740)
	self:Log("SPELL_CAST_START", "Shreddation", 474337)
	self:Log("SPELL_AURA_APPLIED", "ShreddationSawbladeDamage", 474351)
	self:Log("SPELL_DAMAGE", "ShreddationSawbladeDamage", 474350)
	self:Log("SPELL_CAST_START", "Flamethrower", 465754)
	self:Death("Shreddinator3000Death", 230740)

	-- Mechadrone Sniper
	self:RegisterEngageMob("MechadroneSniperEngaged", 229069)
	self:Log("SPELL_CAST_START", "Trickshot", 1214468)
	self:Death("MechadroneSniperDeath", 229069)

	-- Loaderbot
	-- TODO Windup

	-- Darkfuse Hyena
	self:RegisterEngageMob("DarkfuseHyenaEngaged", 229252)
	self:Log("SPELL_CAST_START", "BloodthirstyCackle", 463058)
	self:Log("SPELL_INTERRUPT", "BloodthirstyCackleInterrupt", 463058)
	self:Log("SPELL_CAST_SUCCESS", "BloodthirstyCackleSuccess", 463058)
	self:Death("DarkfuseHyenaDeath", 229252)

	-- Darkfuse Demolitionist
	--self:RegisterEngageMob("DarkfuseDemolitionistEngaged", 229212)
	self:Log("SPELL_CAST_SUCCESS", "RPGG", 1216039)
	--self:Death("DarkfuseDemolitionistDeath", 229212)

	-- Darkfuse Inspector
	self:RegisterEngageMob("DarkfuseInspectorEngaged", 231385)
	self:Log("SPELL_CAST_START", "SurpriseInspection", 465682)
	self:Death("DarkfuseInspectorDeath", 231385)

	-- Darkfuse Bloodwarper
	self:RegisterEngageMob("DarkfuseBloodwarperEngaged", 230748)
	self:Log("SPELL_CAST_START", "WarpBlood", 465827)
	self:Death("DarkfuseBloodwarperDeath", 230748)

	-- Venture Co. Surveyor
	self:RegisterEngageMob("VentureCoSurveyorEngaged", 229686)
	self:Log("SPELL_CAST_START", "SurveyingBeam", 462771)
	self:Log("SPELL_INTERRUPT", "SurveyingBeamInterrupt", 462771)
	self:Log("SPELL_CAST_SUCCESS", "SurveyingBeamSuccess", 462771)
	self:Death("VentureCoSurveyorDeath", 229686)

	-- Undercrawler
	self:RegisterEngageMob("UndercrawlerEngaged", 231380)
	self:Log("SPELL_CAST_START", "LethargicVenom", 465813)
	self:Log("SPELL_INTERRUPT", "LethargicVenomInterrupt", 465813)
	self:Log("SPELL_CAST_SUCCESS", "LethargicVenomSuccess", 465813)
	self:Log("SPELL_AURA_APPLIED", "LethargicVenomApplied", 465813)
	self:Death("UndercrawlerDeath", 231380)

	-- Venture Co. Diver
	-- TODO Plant Seaforium Charge

	-- Disturbed Kelp
	self:RegisterEngageMob("DisturbedKelpEngaged", 231223)
	self:Log("SPELL_CAST_SUCCESS", "JettisonKelp", 471736)
	self:Log("SPELL_CAST_START", "RestorativeAlgae", 471733)
	self:Log("SPELL_INTERRUPT", "RestorativeAlgaeInterrupt", 471733)
	self:Log("SPELL_CAST_SUCCESS", "RestorativeAlgaeSuccess", 471733)
	self:Death("DisturbedKelpDeath", 231223)

	-- Bomb Pile
	self:Log("SPELL_CAST_START", "PlantBombs", 1214337)

	-- Bubbles
	self:RegisterEngageMob("BubblesEngaged", 231197)
	self:Log("SPELL_CAST_START", "BubbleBurp", 469818)
	self:Log("SPELL_CAST_START", "SplishSplash", 1217496)
	self:Log("SPELL_CAST_START", "Backwash", 469721)
	self:Death("BubblesDeath", 231197)

	-- Venture Co. Electrician
	self:RegisterEngageMob("VentureCoElectricianEngaged", 231312)
	self:Log("SPELL_CAST_SUCCESS", "Overcharge", 469799)
	self:Log("SPELL_AURA_APPLIED", "OverchargeApplied", 469799)
	self:Death("VentureCoElectricianDeath", 231312)

	-- Darkfuse Jumpstarter
	self:RegisterEngageMob("DarkfuseJumpstarterEngaged", 231325)
	self:Log("SPELL_CAST_START", "Sparkslam", 465666)
	self:Death("DarkfuseJumpstarterDeath", 231325)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Weapons Stockpile

function mod:WeaponsStockpilePilfered(_, text)
	-- [UPDATE_UI_WIDGET] widgetID:6270, widgetType:8, text:Weapons Stockpiles Pilfered: 1/5
	self:Message("weapons_stockpiles_pilfered", "green", text, L.weapons_stockpiles_pilfered_icon)
	self:PlaySound("weapons_stockpiles_pilfered", "info")
end

-- Shreddinator 3000

function mod:Shreddinator3000Engaged(guid)
	self:Nameplate(474337, 2.4, guid) -- Shreddation
	self:Nameplate(465754, 7.0, guid) -- Flamethrower
end

function mod:Shreddation(args)
	self:Message(args.spellId, "orange")
	self:Nameplate(args.spellId, 9.8, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

do
	local prev = 0
	function mod:ShreddationSawbladeDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 1.5 then
			prev = args.time
			self:PersonalMessage(474337, "underyou", args.spellName)
			self:PlaySound(474337, "underyou")
		end
	end
end

function mod:Flamethrower(args)
	self:Message(args.spellId, "yellow") -- TODO purple?
	self:Nameplate(args.spellId, 25.4, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:Shreddinator3000Death(args)
	self:ClearNameplate(args.destGUID)
end

-- Mechadrone Sniper

function mod:MechadroneSniperEngaged(guid)
	self:Nameplate(1214468, 6.0, guid) -- Trickshot
end

do
	local prev = 0
	function mod:Trickshot(args)
		-- TODO is this a success/interrupt timer?
		self:Nameplate(args.spellId, 11.0, args.sourceGUID)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:MechadroneSniperDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Darkfuse Hyena

function mod:DarkfuseHyenaEngaged(guid)
	self:Nameplate(463058, 4.9, guid) -- Bloodthirsty Cackle
end

do
	local prev = 0
	function mod:BloodthirstyCackle(args)
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:BloodthirstyCackleInterrupt(args)
	self:Nameplate(463058, 15.7, args.destGUID)
end

function mod:BloodthirstyCackleSuccess(args)
	self:Nameplate(args.spellId, 15.7, args.sourceGUID)
end

function mod:DarkfuseHyenaDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Darkfuse Demolitionist

--function mod:DarkfuseDemolitionistEngaged(guid)
	--self:Nameplate(1216039, 2.4, guid) -- R.P.G.G.
--end

function mod:RPGG(args)
	self:Message(args.spellId, "orange")
	-- this mob needs to cast Reload before R.P.G.G. can be cast again
	self:PlaySound(args.spellId, "alarm")
end

--function mod:DarkfuseDemolitionistDeath(args)
	--self:ClearNameplate(args.destGUID)
--end

-- Darkfuse Inspector

function mod:DarkfuseInspectorEngaged(guid)
	self:Nameplate(465682, 6.3, guid) -- Surprise Inspection
end

do
	local prev = 0
	function mod:SurpriseInspection(args)
		self:Nameplate(args.spellId, 8.5, args.sourceGUID)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

function mod:DarkfuseInspectorDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Darkfuse Bloodwarper

function mod:DarkfuseBloodwarperEngaged(guid)
	self:Nameplate(465827, 5.9, guid) -- Warp Blood
end

function mod:WarpBlood(args)
	self:Message(args.spellId, "yellow")
	self:Nameplate(args.spellId, 19.4, args.sourceGUID)
	self:PlaySound(args.spellId, "info")
end

function mod:DarkfuseBloodwarperDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Venture Co. Surveyor

function mod:VentureCoSurveyorEngaged(guid)
	self:Nameplate(462771, 7.2, guid) -- Surveying Beam
end

do
	local prev = 0
	function mod:SurveyingBeam(args)
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:SurveyingBeamInterrupt(args)
	self:Nameplate(462771, 22.3, args.destGUID)
end

function mod:SurveyingBeamSuccess(args)
	self:Nameplate(args.spellId, 22.3, args.sourceGUID)
end

function mod:VentureCoSurveyorDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Undercrawler

function mod:UndercrawlerEngaged(guid)
	self:Nameplate(465813, 9.6, guid) -- Lethargic Venom
end

function mod:LethargicVenom(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 0, args.sourceGUID)
	self:PlaySound(args.spellId, "alert")
end

function mod:LethargicVenomInterrupt(args)
	self:Nameplate(465813, 10.1, args.destGUID)
end

function mod:LethargicVenomSuccess(args)
	self:Nameplate(args.spellId, 10.1, args.sourceGUID)
end

function mod:LethargicVenomApplied(args)
	if self:Dispeller("poison", nil, args.spellId) or self:Dispeller("movement", nil, args.spellId) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

function mod:UndercrawlerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Disturbed Kelp

function mod:DisturbedKelpEngaged(guid)
	self:Nameplate(471736, 6.0, guid) -- Jettison Kelp
	-- the first Restorative Kelp cast is HP based
end

do
	local prev = 0
	function mod:JettisonKelp(args)
		self:Nameplate(args.spellId, 17.0, args.sourceGUID)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

do
	local prev = 0
	function mod:RestorativeAlgae(args)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Nameplate(args.spellId, 0, args.sourceGUID)
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		end
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:RestorativeAlgaeInterrupt(args)
	self:Nameplate(471733, 19.9, args.destGUID)
end

function mod:RestorativeAlgaeSuccess(args)
	self:Nameplate(args.spellId, 19.9, args.sourceGUID)
end

function mod:DisturbedKelpDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Bomb Pile

function mod:PlantBombs(args)
	self:Message(args.spellId, "green", CL.other:format(self:ColorName(args.sourceName), args.spellName))
	self:PlaySound(args.spellId, "info")
end

-- Bubbles

do
	local timer

	function mod:BubblesEngaged(guid)
		self:CDBar(469818, 4.6) -- Bubble Burp
		self:Nameplate(469818, 4.6, guid) -- Bubble Burp
		self:CDBar(1217496, 9.2) -- Splish Splash
		self:Nameplate(1217496, 9.2, guid) -- Splish Splash
		self:CDBar(469721, 15.3) -- Backwash
		self:Nameplate(469721, 15.3, guid) -- Backwash
		timer = self:ScheduleTimer("BubblesDeath", 30)
	end

	function mod:BubbleBurp(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red")
		self:CDBar(args.spellId, 21.9)
		self:Nameplate(args.spellId, 21.9, args.sourceGUID)
		self:PlaySound(args.spellId, "alarm")
		timer = self:ScheduleTimer("BubblesDeath", 30)
	end

	function mod:SplishSplash(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		self:CDBar(args.spellId, 21.9)
		self:Nameplate(args.spellId, 21.9, args.sourceGUID)
		self:PlaySound(args.spellId, "alarm")
		timer = self:ScheduleTimer("BubblesDeath", 30)
	end

	function mod:Backwash(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "yellow")
		self:CDBar(args.spellId, 21.9)
		self:Nameplate(args.spellId, 21.9, args.sourceGUID)
		self:PlaySound(args.spellId, "alert")
		timer = self:ScheduleTimer("BubblesDeath", 30)
	end

	function mod:BubblesDeath(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(469818) -- Bubble Burp
		self:StopBar(1217496) -- Splish Splash
		self:StopBar(469721) -- Backwash
		if args then
			self:ClearNameplate(args.destGUID)
		end
	end
end

-- Venture Co. Electrician

function mod:VentureCoElectricianEngaged(guid)
	self:Nameplate(469799, 3.4, guid) -- Overcharge
end

function mod:Overcharge(args)
	self:Nameplate(args.spellId, 10.0, args.sourceGUID)
end

function mod:OverchargeApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("magic", nil, args.spellId) then
		self:TargetMessage(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end

function mod:VentureCoElectricianDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Darkfuse Jumpstarter

function mod:DarkfuseJumpstarterEngaged(guid)
	self:Nameplate(465666, 5.7, guid) -- Sparkslam
end

do
	local prev = 0
	function mod:Sparkslam(args)
		self:Nameplate(args.spellId, 11.7, args.sourceGUID)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:DarkfuseJumpstarterDeath(args)
	self:ClearNameplate(args.destGUID)
end
