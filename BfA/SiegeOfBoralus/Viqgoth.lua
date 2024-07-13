local isTWWS1 = select(4, GetBuildInfo()) >= 110002 -- XXX remove when 11.0.2 is live
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Viq'Goth", 1822, 2140)
if not mod then return end
mod:RegisterEnableMob(128652) -- Viq'Goth
mod:SetEncounterID(2100)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local markCount = 1
local engagedGripping = true -- XXX remove when 11.0.2 is live
local demolisherCount = 1 -- XXX remove when 11.0.2 is live

--------------------------------------------------------------------------------
-- Localization
--

-- XXX remove locale when 11.0.2 is live
local L = mod:GetLocale()
if L then
	L.demolishing = -18340 -- Demolishing Terror
	L.demolishing_desc = "Warnings and timers for when the Demolishing Terror spawns."
	L.demolishing_icon = "achievement_boss_yoggsaron_01"
end

--------------------------------------------------------------------------------
-- Initialization
--

local putridWatersMarker = mod:AddMarkerOption(false, "player", 1, 275014, 1, 2, 3, 4)
function mod:GetOptions()
	return {
		"stages",
		{275014, "SAY"}, -- Putrid Waters
		putridWatersMarker,
		270185, -- Call of the Deep
		269456, -- Eradication
		-- Gripping Terror
		{269366, "CASTBAR"}, -- Repair
		-- Demolishing Terror
		269266, -- Slam
		270590, -- Hull Cracker
	}, {
		[269366] = -18334, -- Gripping Terror
		[269266] = -18340, -- Demolishing Terror
	}
end

-- XXX remove when 11.0.2 is live
if not isTWWS1 then
	function mod:GetOptions()
		return {
			"stages",
			{275014, "SAY"}, -- Putrid Waters
			putridWatersMarker,
			270185, -- Call of the Deep
			269456, -- Eradication
			{269366, "CASTBAR"}, -- Repair
			-- Demolishing Terror
			"demolishing", -- Demolishing Terror
			269266, -- Slam
			270590, -- Hull Cracker
		}, {
			[275014] = "general",
			["demolishing"] = -18340, -- Demolishing Terror
		}
	end
end

function mod:OnBossEnable()
	-- the tentacles can be any boss besides boss1, which is Viq'goth
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1", "boss2", "boss3", "boss4", "boss5")
	self:Log("SPELL_CAST_SUCCESS", "PutridWaters", 274991)
	self:Log("SPELL_AURA_APPLIED", "PutridWatersApplied", 275014)
	self:Log("SPELL_AURA_REMOVED", "PutridWatersRemoved", 275014)
	self:Log("SPELL_CAST_START", "Eradication", 269456)

	-- Gripping Terror
	self:Log("SPELL_CAST_START", "RepairStart", 269366)
	if not isTWWS1 then
		self:Death("GrippingTerrorDeath", 137405) -- XXX remove when 11.0.2 is live
	end

	-- Demolishing Terror
	self:Log("SPELL_CAST_START", "Slam", 269266)
	self:Log("SPELL_CAST_START", "HullCracker", 270590)
	self:Death("DemolishingTerrorDeath", 137614, 137625, 137626) -- Stage 1, Stage 2, Stage 3
end

function mod:OnEngage()
	self:SetStage(1)
	if not isTWWS1 then
		-- XXX remove this block when 11.0.2 is live
		self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
		self:Bar("demolishing", 20, CL.count:format(self:SpellName(L.demolishing), 2), L.demolishing_icon) -- Summon Demolisher
	end
	markCount = 1
	demolisherCount = 1
	engagedGripping = true
	self:CDBar(275014, 3.2) -- Putrid Waters
	self:CDBar(270185, 7.0) -- Call of the Deep
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 270183 then -- Call of the Deep
		self:Message(270185, "red")
		self:PlaySound(270185, "alarm")
		if self:GetStage() == 1 then
			self:CDBar(270185, 15.8)
		elseif self:GetStage() == 2 then
			self:CDBar(270185, 12.1)
		else -- Stage 3
			self:CDBar(270185, 7.3)
		end
	elseif spellId == 269984 then -- Damage Boss 35%
		self:SetStage(self:GetStage() + 1)
		engagedGripping = false
		demolisherCount = 1
		self:Message("stages", "green", CL.stage:format(self:GetStage()), false)
		self:PlaySound("stages", "long")
	elseif spellId == 270605 then -- Summon Demolisher
		-- XXX remove this block when 11.0.2 is live
		demolisherCount = demolisherCount + 1
		if demolisherCount <= 5 then -- Demolishers stop spawning after the fifth, but the spell is still cast
			self:Message("demolishing", "yellow", CL.count:format(CL.spawned:format(self:SpellName(L.demolishing)), demolisherCount), L.demolishing_icon)
			self:PlaySound("demolishing", "alert")
		end
		if demolisherCount <= 4 then
			self:Bar("demolishing", 20, CL.count:format(self:SpellName(L.demolishing), demolisherCount+1), L.demolishing_icon)
		end
	end
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT() -- XXX remove when 11.0.2 is live
	if not engagedGripping and self:GetBossId(137405) then -- Check if Gripping Terror is up
		engagedGripping = true
		self:Bar("demolishing", 20, CL.count:format(self:SpellName(L.demolishing), 2), L.demolishing_icon) -- Summon Demolisher
	end
end

function mod:PutridWaters(args)
	self:CDBar(275014, 20.6)
end

do
	local playerList, playerIcons = mod:NewTargetList(), {}
	function mod:PutridWatersApplied(args)
		local playerListCount = #playerList+1
		playerList[playerListCount] = args.destName
		playerIcons[playerListCount] = markCount
		self:CustomIcon(putridWatersMarker, args.destName, markCount)
		markCount = (markCount % 4) + 1
		if self:Me(args.destGUID) then
			self:PlaySound(args.spellId, "warning")
			self:Say(args.spellId, nil, nil, "Putrid Waters")
		end
		self:TargetsMessageOld(args.spellId, "yellow", playerList, 2, nil, nil, 0.6, playerIcons)
	end

	function mod:PutridWatersRemoved(args)
		self:CustomIcon(putridWatersMarker, args.destName)
	end
end

function mod:Eradication(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
end

-- Gripping Terror

function mod:RepairStart(args)
	self:Message(args.spellId, "cyan", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "info")
	self:CastBar(args.spellId, 3)
end

function mod:GrippingTerrorDeath(args) -- XXX remove when 11.0.2 is live
	self:StopBar(CL.count:format(self:SpellName(L.demolishing), demolisherCount+1))
end

-- Demolishing Terror

function mod:Slam(args)
	self:Message(args.spellId, "orange")
	local mobId = self:MobId(args.sourceGUID)
	if mobId == 137614 then -- Stage 1
		self:CDBar(args.spellId, 18.2)
	elseif mobId == 137625 then -- Stage 2
		self:CDBar(args.spellId, 13.4)
	else -- 137626, Stage 3
		self:CDBar(args.spellId, 10.9)
	end
	self:PlaySound(args.spellId, "alarm")
end

function mod:HullCracker(args)
	-- only cast when the tank is out of range
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "warning")
end

function mod:DemolishingTerrorDeath(args)
	self:StopBar(269266) -- Slam
end
