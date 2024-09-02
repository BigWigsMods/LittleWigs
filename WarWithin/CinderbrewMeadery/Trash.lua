--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Cinderbrew Meadery Trash", 2661)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	218671, -- Venture Co. Pyromaniac
	210269, -- Hired Muscle
	214920, -- Tasting Room Attendant
	214697, -- Chef Chewie
	219415, -- Cooking Pot
	219667, -- Flamethrower
	214673, -- Flavor Scientist
	222964, -- Flavor Scientist
	223423, -- Careless Hopgoblin
	223562, -- Brew Drop
	210264, -- Bee Wrangler
	220946, -- Venture Co. Honey Harvester
	220141, -- Royal Jelly Purveyor
	219588 -- Yes Man
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.venture_co_pyromaniac = "Venture Co. Pyromaniac"
	L.hired_muscle = "Hired Muscle"
	L.tasting_room_attendant = "Tasting Room Attendant"
	L.chef_chewie = "Chef Chewie"
	L.cooking_pot = "Cooking Pot"
	L.flamethrower = "Flamethrower"
	L.flavor_scientist = "Flavor Scientist"
	L.careless_hopgoblin = "Careless Hopgoblin"
	L.brew_drop = "Brew Drop"
	L.bee_wrangler = "Bee Wrangler"
	L.venture_co_honey_harvester = "Venture Co. Honey Harvester"
	L.royal_jelly_purveyor = "Royal Jelly Purveyor"
	L.yes_man = "Yes Man"

	L.custom_on_cooking_autotalk = CL.autotalk
	L.custom_on_cooking_autotalk_desc = "|cFFFF0000Requires 25 skill in Khaz Algar Alchemy or Cooking.|r Automatically select the NPC dialog option that grants you 'Sticky Honey' which you can use by clicking your extra action button.\n\n|T451169:16|tSticky Honey\n{438997}"
	L.custom_on_cooking_autotalk_icon = mod:GetMenuIcon("SAY")
	L.custom_on_flamethrower_autotalk = CL.autotalk
	L.custom_on_flamethrower_autotalk_desc = "|cFFFF0000Requires Gnome, Goblin, Mechagnome, or 25 skill in Khaz Algar Engineering.|r Automatically select the NPC dialog option that grants you 'Flame On' which you can use by clicking your extra action button.\n\n|T135789:16|tFlame On\n{439616}"
	L.custom_on_flamethrower_autotalk_icon = mod:GetMenuIcon("SAY")
end

--------------------------------------------------------------------------------
-- Initialization
--

local failedBatchMarker = mod:AddMarkerOption(true, "npc", 7, 441501, 7) -- Failed Batch
function mod:GetOptions()
	return {
		-- Autotalk
		"custom_on_cooking_autotalk",
		"custom_on_flamethrower_autotalk",
		-- Venture Co. Pyromaniac
		{437721, "NAMEPLATE"}, -- Boiling Flames
		{437956, "NAMEPLATE"}, -- Erupting Inferno
		-- Hired Muscle
		434761, -- Mighty Stomp
		-- Tasting Room Attendant
		{434706, "NAMEPLATE"}, -- Cindrewbrew Toss
		-- Chef Chewie
		434998, -- High Steaks
		463206, -- Tenderize
		-- Flavor Scientist
		{441627, "NAMEPLATE"}, -- Rejuvenating Honey
		{441434, "NAMEPLATE"}, -- Failed Batch
		failedBatchMarker,
		-- Careless Hopgoblin
		{448619, "SAY", "NAMEPLATE"}, -- Reckless Delivery
		-- Brew Drop
		441179, -- Oozing Honey
		-- Bee Wrangler
		{441119, "SAY", "NAMEPLATE"}, -- Bee-Zooka
		-- Venture Co. Honey Harvester
		{442589, "NAMEPLATE"}, -- Beeswax
		{442995, "NAMEPLATE"}, -- Swarming Surprise
		-- Royal Jelly Purveyor
		{440687, "NAMEPLATE"}, -- Honey Volley
		{440876, "NAMEPLATE"}, -- Rain of Honey
		-- Yes Man
		{439467, "NAMEPLATE"}, -- Downward Trend
	}, {
		[437721] = L.venture_co_pyromaniac,
		[434761] = L.hired_muscle,
		[434706] = L.tasting_room_attendant,
		[434998] = L.chef_chewie,
		[441627] = L.flavor_scientist,
		[448619] = L.careless_hopgoblin,
		[441179] = L.brew_drop,
		[441119] = L.bee_wrangler,
		[442589] = L.venture_co_honey_harvester,
		[440687] = L.royal_jelly_purveyor,
		[439467] = L.yes_man,
	}, {
		["custom_on_cooking_autotalk"] = L.cooking_pot,
		["custom_on_flamethrower_autotalk"] = L.flamethrower,
	}
end

function mod:OnBossEnable()
	-- Autotalk
	self:RegisterEvent("GOSSIP_SHOW")

	-- Venture Co. Pyromaniac
	self:Log("SPELL_CAST_START", "BoilingFlames", 437721)
	self:Log("SPELL_INTERRUPT", "BoilingFlamesInterrupt", 437721)
	self:Log("SPELL_CAST_SUCCESS", "BoilingFlamesSuccess", 437721)
	self:Log("SPELL_CAST_SUCCESS", "EruptingInferno", 437956)
	self:Log("SPELL_AURA_APPLIED", "EruptingInfernoApplied", 437956)
	self:Death("VentureCoPyromaniacDeath", 218671)

	-- Hired Muscle
	self:Log("SPELL_CAST_START", "MightyStomp", 434761) -- TODO removed?
	--self:Death("HiredMuscleDeath", 210269)

	-- Tasting Room Attendant
	self:Log("SPELL_CAST_SUCCESS", "CindrewbrewToss", 434706)
	self:Death("TastingRoomAttendantDeath", 214920)

	-- Chef Chewie
	self:Log("SPELL_CAST_START", "HighSteaks", 434998)
	self:Log("SPELL_CAST_START", "Tenderize", 463206)
	self:Death("ChefChewieDeath", 214697)

	-- Flavor Scientist
	self:Log("SPELL_CAST_START", "RejuvenatingHoney", 441627)
	self:Log("SPELL_CAST_SUCCESS", "FailedBatch", 441434)
	self:Log("SPELL_SUMMON", "FailedBatchSummon", 441501)
	self:Death("FlavorScientistDeath", 214673, 222964)

	-- Careless Hopgoblin
	self:Log("SPELL_CAST_START", "RecklessDelivery", 448619)
	self:Death("CarelessHopgoblinDeath", 223423)

	-- Brew Drop
	self:Log("SPELL_PERIODIC_DAMAGE", "OozingHoneyDamage", 441179) -- no alert on APPLIED, doesn't damage for 1.5s
	self:Log("SPELL_PERIODIC_MISSED", "OozingHoneyDamage", 441179)

	-- Bee Wrangler
	self:Log("SPELL_CAST_START", "BeeZooka", 441119)
	self:Log("SPELL_CAST_SUCCESS", "BeeZookaSuccess", 441119)
	self:Death("BeeWranglerDeath", 210264)

	-- Venture Co. Honey Harvester
	self:Log("SPELL_CAST_START", "Beeswax", 442589)
	self:Log("SPELL_CAST_START", "SwarmingSurprise", 442995)
	self:Death("VentureCoHoneyHarvesterDeath", 220946)

	-- Royal Jelly Purveyor
	self:Log("SPELL_CAST_START", "HoneyVolley", 440687)
	self:Log("SPELL_INTERRUPT", "HoneyVolleyInterrupt", 440687)
	self:Log("SPELL_CAST_SUCCESS", "HoneyVolleySuccess", 440687)
	self:Log("SPELL_CAST_START", "RainOfHoney", 440876)
	self:Log("SPELL_CAST_SUCCESS", "RainOfHoneySuccess", 440876)
	self:Death("RoyalJellyPurveyorDeath", 220141)

	-- Yes Man
	self:Log("SPELL_CAST_START", "DownwardTrend", 439467)
	self:Death("YesManDeath", 219588)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Autotalk

function mod:GOSSIP_SHOW()
	if self:GetGossipID(121210) then -- Cooking Pot, 1st use
		if self:GetOption("custom_on_cooking_autotalk") then
			-- 121210:<Carefully boil the mead to extract the pure honey from it.>\r\n\r\n[Requires at least 25 skill in  Khaz Algar Alchemy or Cooking.]
			self:SelectGossipID(121210)
		end
	elseif self:GetGossipID(121215) then -- Cooking Pot, 2nd and 3rd use
		if self:GetOption("custom_on_cooking_autotalk") then
			-- 121215:<Carefully boil the mead to extract the pure honey from it.>\r\n\r\n[Requires at least 25 skill in  Khaz Algar Alchemy or Cooking.]
			self:SelectGossipID(121215)
		end
	elseif self:GetGossipID(121318) then -- Flamethrower
		if self:GetOption("custom_on_flamethrower_autotalk") then
			-- 121318:<You immediately understand the intricate mechanics of the flamethrower and how to handle it.>\r\n\r\n[Requires Gnome, Goblin, Mechagnome or at least 25 skill in Khaz Algar Engineering.]
			self:SelectGossipID(121318)
		end
	end
end

-- Venture Co. Pyromaniac

function mod:BoilingFlames(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	self:Nameplate(args.spellId, 0, args.sourceGUID)
end

function mod:BoilingFlamesInterrupt(args)
	self:Nameplate(437721, 20.1, args.destGUID)
end

function mod:BoilingFlamesSuccess(args)
	self:Nameplate(args.spellId, 20.1, args.sourceGUID)
end

function mod:EruptingInferno(args)
	self:Nameplate(args.spellId, 13.3, args.sourceGUID)
end

function mod:EruptingInfernoApplied(args)
	self:TargetMessage(args.spellId, "orange", args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
end

function mod:VentureCoPyromaniacDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Hired Muscle

function mod:MightyStomp(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
	--self:Nameplate(args.spellId, 100, args.sourceGUID)
end

--function mod:HiredMuscleDeath(args)
	--self:ClearNameplate(args.destGUID)
--end

-- Tasting Room Attendant

function mod:CindrewbrewToss(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:Nameplate(args.spellId, 12.1, args.sourceGUID)
end

function mod:TastingRoomAttendantDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Chef Chewie

do
	local timer

	function mod:HighSteaks(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "red")
		self:PlaySound(args.spellId, "long")
		self:CDBar(args.spellId, 21.8)
		timer = self:ScheduleTimer("ChefChewieDeath", 30)
	end

	function mod:Tenderize(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "alert")
		self:CDBar(args.spellId, 18.2)
		timer = self:ScheduleTimer("ChefChewieDeath", 30)
	end

	function mod:ChefChewieDeath()
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(434998) -- High Steaks
		self:StopBar(463206) -- Tenderize
	end
end

-- Flavor Scientist

do
	local prev = 0
	function mod:RejuvenatingHoney(args)
		if args.time - prev > 1.5 then
			prev = args.time
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
		self:Nameplate(args.spellId, 15.8, args.sourceGUID) -- CD triggers on cast start
	end
end

function mod:FailedBatch(args)
	self:Message(args.spellId, "cyan", CL.spawning:format(args.spellName))
	self:PlaySound(args.spellId, "info")
	self:Nameplate(args.spellId, 23.1, args.sourceGUID)
end

do
	local failedBatchGUID = nil

	function mod:FailedBatchSummon(args)
		-- register events to auto-mark Failed Batch
		if self:GetOption(failedBatchMarker) then
			failedBatchGUID = args.destGUID
			self:RegisterTargetEvents("MarkFailedBatch")
		end
	end

	function mod:MarkFailedBatch(_, unit, guid)
		if failedBatchGUID == guid then
			failedBatchGUID = nil
			self:CustomIcon(failedBatchMarker, unit, 7)
			self:UnregisterTargetEvents()
		end
	end
end

function mod:FlavorScientistDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Careless Hopgoblin

do
	local function printTarget(self, name, guid)
		self:TargetMessage(448619, "orange", name)
		self:PlaySound(448619, "alarm", nil, name)
		if self:Me(guid) then
			self:Say(448619, nil, nil, "Reckless Delivery")
		end
	end

	function mod:RecklessDelivery(args)
		self:GetUnitTarget(printTarget, 0.2, args.sourceGUID)
		self:Nameplate(args.spellId, 25.5, args.sourceGUID)
	end
end

function mod:CarelessHopgoblinDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Brew Drop

do
	local prev = 0
	function mod:OozingHoneyDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 2 then
			prev = args.time
			self:PersonalMessage(args.spellId, "underyou")
			self:PlaySound(args.spellId, "underyou")
		end
	end
end

-- Bee Wrangler

do
	local prev = 0
	local function printTarget(self, name, guid)
		self:TargetMessage(441119, "orange", name)
		local t = GetTime()
		if t - prev > 2 then
			prev = t
			if self:Me(guid) then
				self:Say(441119, nil, nil, "Bee-Zooka")
			end
			self:PlaySound(441119, "alarm", nil, name)
		end
	end

	function mod:BeeZooka(args)
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
			return
		end
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
	end
end

function mod:BeeZookaSuccess(args)
	self:Nameplate(args.spellId, 18.2, args.sourceGUID)
end

function mod:BeeWranglerDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Venture Co. Honey Harvester

function mod:Beeswax(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:Nameplate(args.spellId, 18.2, args.sourceGUID)
end

function mod:SwarmingSurprise(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:Nameplate(args.spellId, 23.1, args.sourceGUID)
end

function mod:VentureCoHoneyHarvesterDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Royal Jelly Purveyor

do
	local prev = 0
	function mod:HoneyVolley(args)
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
			return
		end
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
		self:Nameplate(args.spellId, 0, args.sourceGUID)
	end
end

function mod:HoneyVolleyInterrupt(args)
	self:Nameplate(440687, 9.3, args.destGUID)
end

function mod:HoneyVolleySuccess(args)
	self:Nameplate(args.spellId, 9.3, args.sourceGUID)
end

do
	local prev = 0
	function mod:RainOfHoney(args)
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
			return
		end
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

function mod:RainOfHoneySuccess(args)
	self:Nameplate(args.spellId, 16.2, args.sourceGUID)
end

function mod:RoyalJellyPurveyorDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Yes Man

do
	local prev = 0
	function mod:DownwardTrend(args)
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
		self:Nameplate(args.spellId, 14.6, args.sourceGUID)
	end
end

function mod:YesManDeath(args)
	self:ClearNameplate(args.destGUID)
end
