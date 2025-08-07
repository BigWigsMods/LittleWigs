--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Operation: Floodgate Trash", 2773)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	230740, -- Shreddinator 3000
	229069, -- Mechadrone Sniper
	231014, -- Loaderbot
	229252, -- Darkfuse Hyena
	229212, -- Darkfuse Demolitionist
	231385, -- Darkfuse Inspector
	230748, -- Darkfuse Bloodwarper
	231380, -- Undercrawler
	229686, -- Venture Co. Surveyor
	229251, -- Venture Co. Architect
	231496, -- Venture Co. Diver
	231223, -- Disturbed Kelp
	234373, -- Bomb Pile
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
	L.loaderbot = "Loaderbot"
	L.darkfuse_hyena = "Darkfuse Hyena"
	L.darkfuse_demolitionist = "Darkfuse Demolitionist"
	L.darkfuse_inspector = "Darkfuse Inspector"
	L.darkfuse_bloodwarper = "Darkfuse Bloodwarper"
	L.undercrawler = "Undercrawler"
	L.venture_co_surveyor = "Venture Co. Surveyor"
	L.venture_co_architect = "Venture Co. Architect"
	L.venture_co_diver = "Venture Co. Diver"
	L.disturbed_kelp = "Disturbed Kelp"
	L.bomb_pile = "Bomb Pile"
	L.bubbles = "Bubbles"
	L.venture_co_electrician = "Venture Co. Electrician"
	L.darkfuse_jumpstarter = "Darkfuse Jumpstarter"

	L.geezle_gigazap_warmup = "This project can't continue without the scientist behind it all. Put that big brain on ice!"
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
		-- Loaderbot
		{465120, "NAMEPLATE"}, -- Wind Up
		-- Darkfuse Hyena
		{463058, "NAMEPLATE"}, -- Bloodthirsty Cackle
		-- Darkfuse Demolitionist
		1216039, -- R.P.G.G.
		-- Darkfuse Inspector
		{465682, "NAMEPLATE"}, -- Surprise Inspection
		-- Darkfuse Bloodwarper
		{465827, "NAMEPLATE"}, -- Warp Blood
		-- Undercrawler
		{465813, "DISPEL", "NAMEPLATE"}, -- Lethargic Venom
		-- Venture Co. Surveyor
		{462771, "NAMEPLATE"}, -- Surveying Beam
		{463169, "ME_ONLY", "NAMEPLATE", "OFF"}, -- EZ-Thro Dynamite III
		-- Venture Co. Architect
		{465408, "NAMEPLATE"}, -- Rapid Construction
		-- Venture Co. Diver
		{468726, "NAMEPLATE"}, -- Plant Seaforium Charge
		{468631, "NAMEPLATE"}, -- Harpoon
		-- Disturbed Kelp
		{471736, "NAMEPLATE"}, -- Jettison Kelp
		{471733, "NAMEPLATE"}, -- Restorative Algae
		-- Bomb Pile
		1214337, -- Plant Bombs
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
		[465813] = L.undercrawler,
		[462771] = L.venture_co_surveyor,
		[465408] = L.venture_co_architect,
		[468726] = L.venture_co_diver,
		[471736] = L.disturbed_kelp,
		[1214337] = L.bomb_pile,
		[469799] = L.venture_co_electrician,
		[465666] = L.darkfuse_jumpstarter,
	}
end

function mod:OnBossEnable()
	-- Weapons Stockpile
	self:RegisterWidgetEvent(6270, "WeaponsStockpilePilfered", true)

	-- Warmup
	self:RegisterEvent("CHAT_MSG_MONSTER_SAY")

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
	self:Log("SPELL_INTERRUPT", "TrickshotInterrupt", 1214468)
	self:Log("SPELL_CAST_SUCCESS", "TrickshotSuccess", 1214468)
	self:Death("MechadroneSniperDeath", 229069)

	-- Loaderbot
	self:RegisterEngageMob("LoaderbotEngaged", 231014)
	self:Log("SPELL_CAST_SUCCESS", "WindUp", 465120)
	self:Death("LoaderbotDeath", 231014)

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

	-- Undercrawler
	self:RegisterEngageMob("UndercrawlerEngaged", 231380)
	self:Log("SPELL_CAST_START", "LethargicVenom", 465813)
	self:Log("SPELL_INTERRUPT", "LethargicVenomInterrupt", 465813)
	self:Log("SPELL_CAST_SUCCESS", "LethargicVenomSuccess", 465813)
	self:Log("SPELL_AURA_APPLIED", "LethargicVenomApplied", 465813)
	self:Death("UndercrawlerDeath", 231380)

	-- Venture Co. Surveyor
	self:RegisterEngageMob("VentureCoSurveyorEngaged", 229686)
	self:Log("SPELL_CAST_START", "SurveyingBeam", 462771)
	self:Log("SPELL_INTERRUPT", "SurveyingBeamInterrupt", 462771)
	self:Log("SPELL_CAST_SUCCESS", "SurveyingBeamSuccess", 462771)
	self:Log("SPELL_PERIODIC_DAMAGE", "SurveyedGroundDamage", 472338)
	self:Log("SPELL_PERIODIC_MISSED", "SurveyedGroundDamage", 472338)
	self:Log("SPELL_CAST_START", "EZThroDynamiteIII", 463169)
	self:Log("SPELL_CAST_SUCCESS", "EZThroDynamiteIIISuccess", 463169)
	self:Death("VentureCoSurveyorDeath", 229686)

	-- Venture Co. Architect
	self:Log("SPELL_AURA_REMOVED", "HighGroundRemoved", 465420)
	self:Log("SPELL_CAST_START", "RapidConstruction", 465408)
	self:Death("VentureCoArchitectDeath", 229686)

	-- Venture Co. Diver
	self:RegisterEngageMob("VentureCoDiverEngaged", 231496)
	self:Log("SPELL_CAST_START", "PlantSeaforiumCharge", 468726)
	self:Log("SPELL_CAST_START", "Harpoon", 468631)
	self:Log("SPELL_INTERRUPT", "HarpoonInterrupt", 468631)
	self:Log("SPELL_CAST_SUCCESS", "HarpoonSuccess", 468631)
	self:Death("VentureCoDiverDeath", 231496)

	-- Disturbed Kelp
	self:RegisterEngageMob("DisturbedKelpEngaged", 231223)
	self:Log("SPELL_CAST_SUCCESS", "JettisonKelp", 471736)
	self:Log("SPELL_CAST_START", "RestorativeAlgae", 471733)
	self:Log("SPELL_INTERRUPT", "RestorativeAlgaeInterrupt", 471733)
	self:Log("SPELL_CAST_SUCCESS", "RestorativeAlgaeSuccess", 471733)
	self:Death("DisturbedKelpDeath", 231223)

	-- Bomb Pile
	self:Log("SPELL_CAST_START", "PlantBombs", 1214337)
	self:Log("SPELL_CAST_SUCCESS", "PlantBombsSuccess", 1214337)

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

-- Warmups

function mod:CHAT_MSG_MONSTER_SAY(event, msg)
	if msg == L.geezle_gigazap_warmup then
		self:UnregisterEvent(event)
		local geezleGigazapModule = BigWigs:GetBossModule("Geezle Gigazap", true)
		if geezleGigazapModule then
			geezleGigazapModule:Enable()
			geezleGigazapModule:Warmup()
		end
	end
end

-- Shreddinator 3000

function mod:Shreddinator3000Engaged(guid)
	self:Nameplate(474337, 3.4, guid) -- Shreddation
	self:Nameplate(465754, 7.0, guid) -- Flamethrower
end

function mod:Shreddation(args)
	self:Message(args.spellId, "orange")
	self:Nameplate(args.spellId, 25.5, args.sourceGUID)
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
	self:Message(args.spellId, "yellow")
	self:Nameplate(args.spellId, 25.5, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

function mod:Shreddinator3000Death(args)
	self:ClearNameplate(args.destGUID)
end

-- Mechadrone Sniper

function mod:MechadroneSniperEngaged(guid)
	self:Nameplate(1214468, 5.7, guid) -- Trickshot
end

do
	local prev = 0
	function mod:Trickshot(args)
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:TrickshotInterrupt(args)
	-- TODO 10.5?
	self:Nameplate(1214468, 12.3, args.destGUID)
end

function mod:TrickshotSuccess(args)
	self:Nameplate(args.spellId, 12.3, args.sourceGUID)
end

function mod:MechadroneSniperDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Loaderbot

function mod:LoaderbotEngaged(guid)
	self:Nameplate(465120, 9.1, guid) -- Wind Up
end

do
	local prev = 0
	function mod:WindUp(args)
		self:Nameplate(args.spellId, 18.2, args.sourceGUID)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

function mod:LoaderbotDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Darkfuse Hyena

function mod:DarkfuseHyenaEngaged(guid)
	self:Nameplate(463058, 3.4, guid) -- Bloodthirsty Cackle
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

do
	local prev = 0
	function mod:RPGG(args)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "orange")
			-- this mob needs to cast Reload before R.P.G.G. can be cast again
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

--function mod:DarkfuseDemolitionistDeath(args)
	--self:ClearNameplate(args.destGUID)
--end

-- Darkfuse Inspector

function mod:DarkfuseInspectorEngaged(guid)
	self:Nameplate(465682, 5.9, guid) -- Surprise Inspection
end

do
	local prev = 0
	function mod:SurpriseInspection(args)
		self:Nameplate(args.spellId, 10.9, args.sourceGUID) -- cd on cast start
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

-- Undercrawler

function mod:UndercrawlerEngaged(guid)
	self:Nameplate(465813, 8.3, guid) -- Lethargic Venom
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
		self:TargetMessage(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

function mod:UndercrawlerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Venture Co. Surveyor

function mod:VentureCoSurveyorEngaged(guid)
	self:Nameplate(462771, 7.1, guid) -- Surveying Beam
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
	self:Nameplate(462771, 19.5, args.destGUID)
end

function mod:SurveyingBeamSuccess(args)
	self:Nameplate(args.spellId, 19.5, args.sourceGUID)
end

do
	local prev = 0
	function mod:SurveyedGroundDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 1.5 then
			prev = args.time
			self:PersonalMessage(462771, "underyou", args.spellName)
			self:PlaySound(462771, "underyou")
		end
	end
end

do
	local function printTarget(self, name)
		self:TargetMessage(463169, "yellow", name)
		self:PlaySound(463169, "info", nil, name)
	end

	function mod:EZThroDynamiteIII(args)
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		self:GetUnitTarget(printTarget, 0.2, args.sourceGUID)
	end
end

function mod:EZThroDynamiteIIISuccess(args)
	self:Nameplate(args.spellId, 8.6, args.sourceGUID)
end

function mod:VentureCoSurveyorDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Venture Co. Architect

function mod:HighGroundRemoved(args)
	self:Nameplate(465408, 21.4, args.destGUID) -- Rapid Construction
end

function mod:RapidConstruction(args)
	self:Message(args.spellId, "cyan")
	self:StopNameplate(args.spellId, args.sourceGUID)
	self:PlaySound(args.spellId, "info")
end

function mod:VentureCoArchitectDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Venture Co. Diver

function mod:VentureCoDiverEngaged(guid)
	self:Nameplate(468631, 5.8, guid) -- Harpoon
	self:Nameplate(468726, 10.8, guid) -- Plant Seaforium Charge
end

do
	local prev = 0
	function mod:PlantSeaforiumCharge(args)
		self:Nameplate(args.spellId, 20.7, args.sourceGUID)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "cyan")
			self:PlaySound(args.spellId, "info")
		end
	end
end

do
	local prev = 0
	function mod:Harpoon(args)
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:HarpoonInterrupt(args)
	self:Nameplate(468631, 15.7, args.destGUID)
end

function mod:HarpoonSuccess(args)
	self:Nameplate(args.spellId, 15.7, args.sourceGUID)
end

function mod:VentureCoDiverDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Disturbed Kelp

function mod:DisturbedKelpEngaged(guid)
	self:Nameplate(471736, 5.4, guid) -- Jettison Kelp
	-- the first Restorative Algae cast is HP based
end

do
	local prev = 0
	function mod:JettisonKelp(args)
		self:Nameplate(args.spellId, 15.8, args.sourceGUID)
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
		self:Nameplate(args.spellId, 0, args.sourceGUID)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:RestorativeAlgaeInterrupt(args)
	self:Nameplate(471733, 16.2, args.destGUID)
end

function mod:RestorativeAlgaeSuccess(args)
	self:Nameplate(args.spellId, 16.2, args.sourceGUID)
end

function mod:DisturbedKelpDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Bomb Pile

do
	local prev = 0
	function mod:PlantBombs(args)
		self:Message(args.spellId, "green", CL.other:format(self:ColorName(args.sourceName), args.spellName))
		if args.time - prev > 5 then
			prev = args.time
			self:PlaySound(args.spellId, "info")
		end
	end
end

do
	local prev = 0
	function mod:PlantBombsSuccess(args)
		if args.time - prev > 10 then
			prev = args.time
			local swampfaceModule = BigWigs:GetBossModule("Swampface", true)
			if swampfaceModule then
				swampfaceModule:Enable()
				swampfaceModule:Warmup()
			end
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
	if self:Me(args.destGUID) or (self:Dispeller("magic", nil, args.spellId) and self:Friendly(args.destFlags)) then
		self:TargetMessage(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end

function mod:VentureCoElectricianDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Darkfuse Jumpstarter

function mod:DarkfuseJumpstarterEngaged(guid)
	self:Nameplate(465666, 5.6, guid) -- Sparkslam
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
