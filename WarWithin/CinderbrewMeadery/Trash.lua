if not BigWigsLoader.isBeta then return end
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
	219667, -- Flamethrower
	214673, -- Flavor Scientist
	223423, -- Careless Hopgoblin
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
	L.flavor_scientist = "Flavor Scientist"
	L.careless_hopgoblin = "Careless Hopgoblin"
	L.bee_wrangler = "Bee Wrangler"
	L.venture_co_honey_harvester = "Venture Co. Honey Harvester"
	L.royal_jelly_purveyor = "Royal Jelly Purveyor"
	L.yes_man = "Yes Man"
end

--------------------------------------------------------------------------------
-- Initialization
--

local autotalk = mod:AddAutoTalkOption(true)
local failedBatchMarker = mod:AddMarkerOption(true, "npc", 7, 441501, 7) -- Failed Batch
function mod:GetOptions()
	return {
		autotalk,
		-- Venture Co. Pyromaniac
		437721, -- Boiling Flames
		437956, -- Erupting Inferno
		-- Hired Muscle
		434761, -- Mighty Stomp
		-- Tasting Room Attendant
		434706, -- Cindrewbrew Toss
		-- Chef Chewie
		434998, -- High Steaks
		463206, -- Tenderize
		-- Flavor Scientist
		441627, -- Rejuvenating Honey
		441434, -- Failed Batch
		failedBatchMarker,
		-- Careless Hopgoblin
		448619, -- Reckless Delivery
		-- Bee Wrangler
		{441119, "SAY"}, -- Bee-Zooka
		-- Venture Co. Honey Harvester
		442589, -- Beeswax
		442995, -- Swarming Surprise
		-- Royal Jelly Purveyor
		440687, -- Honey Volley
		440876, -- Rain of Honey
		-- Yes Man
		439467, -- Downward Trend
	}, {
		[437721] = L.venture_co_pyromaniac,
		[434761] = L.hired_muscle,
		[434706] = L.tasting_room_attendant,
		[434998] = L.chef_chewie,
		[441627] = L.flavor_scientist,
		[448619] = L.careless_hopgoblin,
		[441119] = L.bee_wrangler,
		[442589] = L.venture_co_honey_harvester,
		[440687] = L.royal_jelly_purveyor,
		[439467] = L.yes_man,
	}
end

function mod:OnBossEnable()
	-- Autotalk
	self:RegisterEvent("GOSSIP_SHOW")

	-- Venture Co. Pyromaniac
	self:Log("SPELL_CAST_START", "BoilingFlames", 437721)
	self:Log("SPELL_AURA_APPLIED", "EruptingInferno", 437956)

	-- Hired Muscle
	self:Log("SPELL_CAST_START", "MightyStomp", 434761)

	-- Tasting Room Attendant
	self:Log("SPELL_CAST_SUCCESS", "CindrewbrewToss", 434706)

	-- Chef Chewie
	self:Log("SPELL_CAST_START", "HighSteaks", 434998)
	self:Log("SPELL_CAST_START", "Tenderize", 463206)
	self:Death("ChefChewieDeath", 214697)

	-- Flavor Scientist
	self:Log("SPELL_CAST_START", "RejuvenatingHoney", 441627)
	self:Log("SPELL_CAST_SUCCESS", "FailedBatch", 441434)
	self:Log("SPELL_SUMMON", "FailedBatchSummon", 441501)

	-- Careless Hopgoblin
	self:Log("SPELL_CAST_START", "RecklessDelivery", 448619)

	-- Bee Wrangler
	self:Log("SPELL_CAST_START", "BeeZooka", 441119)

	-- Venture Co. Honey Harvester
	self:Log("SPELL_CAST_START", "Beeswax", 442589)
	self:Log("SPELL_CAST_START", "SwarmingSurprise", 442995)

	-- Royal Jelly Purveyor
	self:Log("SPELL_CAST_START", "HoneyVolley", 440687)
	self:Log("SPELL_CAST_START", "RainOfHoney", 440876)

	-- Yes Man
	self:Log("SPELL_CAST_START", "DownwardTrend", 439467)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Autotalk

function mod:GOSSIP_SHOW()
	if self:GetOption(autotalk) then
		if self:GetGossipID(121318) then
			-- 121318:<You immediately understand the intricate mechanics of the flamethrower and how to handle it.>\r\n\r\n[Requires Gnome, Goblin, Mechagnome or at least 25 skill in Khaz Algar Engineering.]
			self:SelectGossipID(121318)
		end
	end
end

-- Venture Co. Pyromaniac

function mod:BoilingFlames(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:EruptingInferno(args)
	self:TargetMessage(args.spellId, "orange", args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
end

-- Hired Muscle

function mod:MightyStomp(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
end

-- Tasting Room Attendant

function mod:CindrewbrewToss(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
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

	function mod:ChefChewieDeath(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(434998) -- High Steaks
		self:StopBar(463206) -- Tenderize
	end
end

-- Flavor Scientist

function mod:RejuvenatingHoney(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:FailedBatch(args)
	self:Message(args.spellId, "yellow", CL.spawning:format(args.spellName))
	self:PlaySound(args.spellId, "info")
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

-- Careless Hopgoblin

function mod:RecklessDelivery(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
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
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
	end
end

-- Venture Co. Honey Harvester

function mod:Beeswax(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

function mod:SwarmingSurprise(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

-- Royal Jelly Purveyor

do
	local prev = 0
	function mod:HoneyVolley(args)
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:RainOfHoney(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
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
	end
end
