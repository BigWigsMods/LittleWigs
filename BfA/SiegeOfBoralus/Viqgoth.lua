--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Viq'Goth", 1822, 2140)
if not mod then return end
mod:RegisterEnableMob(128652) -- Viq'Goth
mod:SetEncounterID(2100)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local stage = 1
local markCount = 1
local engagedGripping = true
local demolisherCount = 1

--------------------------------------------------------------------------------
-- Localization
--

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
		{275014, "FLASH", "SAY", "SAY_COUNTDOWN"}, -- Putrid Waters
		putridWatersMarker,
		270185, -- Call of the Deep
		{269366, "CASTBAR"}, -- Repair
		"demolishing", -- Demolishing Terror
		269266, -- Slam
		270590, -- Hull Cracker
	}, {
		[275014] = "general",
		["demolishing"] = -18340, -- Demolishing Terror
	}
end

function mod:OnBossEnable()
	-- The Gripping Terror can be any boss besides boss1, which is Viq'goth
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1", "boss2", "boss3", "boss4", "boss5")

	self:Log("SPELL_AURA_APPLIED", "PutridWatersApplied", 275014)
	self:Log("SPELL_AURA_REMOVED", "PutridWatersRemoved", 275014)
	self:Log("SPELL_CAST_START", "Slam", 269266)
	self:Log("SPELL_CAST_START", "RepairStart", 269366)
	self:Log("SPELL_CAST_START", "HullCracker", 270590)

	self:Death("GrippingTerrorDeath", 137405) -- Gripping Terror
end

function mod:OnEngage()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
	stage = 1
	markCount = 1
	demolisherCount = 1
	engagedGripping = true
	self:CDBar(275014, 5) -- Putrid Waters
	self:CDBar(270185, 6) -- Call of the Deep
	self:Bar("demolishing", 20, CL.count:format(self:SpellName(L.demolishing), 2), L.demolishing_icon) -- Summon Demolisher
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 270183 then -- Call of the Deep
		self:Message(270185, "orange")
		self:PlaySound(270185, "alarm")

		local timer = stage == 1 and 15 or stage == 2 and 12 or 7
		self:CDBar(270185, timer)
	elseif spellId == 269984 then -- Damage Boss 35%
		stage = stage + 1
		if stage < 4 then
			engagedGripping = false
			demolisherCount = 1
			self:Message("stages", "green", CL.stage:format(stage), false)
			self:PlaySound("stages", "long")
		end
	elseif spellId == 270605 then -- Summon Demolisher
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

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	if not engagedGripping and self:GetBossId(137405) then -- Check if Gripping Terror is up
		engagedGripping = true
		self:Bar("demolishing", 20, CL.count:format(self:SpellName(L.demolishing), 2), L.demolishing_icon) -- Summon Demolisher
	end
end

do
	local isOnMe = false
	local playerList, playerIcons = mod:NewTargetList(), {}
	function mod:PutridWatersApplied(args)
		local playerListCount = #playerList+1
		playerList[playerListCount] = args.destName
		playerIcons[playerListCount] = markCount
		self:CustomIcon(putridWatersMarker, args.destName, markCount)
		if markCount == 4 then
			markCount = 1
		else
			markCount = markCount + 1
		end
		if #playerList == 1 then
			self:CDBar(args.spellId, 20)
		end
		if self:Me(args.destGUID) then
			isOnMe = true
			self:PlaySound(args.spellId, "warning")
			self:Say(args.spellId, nil, nil, "Putrid Waters")
			self:Flash(args.spellId)
			self:SayCountdown(args.spellId, 30)
		end
		self:TargetsMessageOld(args.spellId, "yellow", playerList, 2, nil, nil, 0.6, playerIcons)
	end

	function mod:PutridWatersRemoved(args)
		self:CustomIcon(putridWatersMarker, args.destName)
		if self:Me(args.destGUID) then
			isOnMe = false
			self:CancelSayCountdown(args.spellId)
		end
	end
end

function mod:Slam(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 8)
end

function mod:RepairStart(args)
	self:Message(args.spellId, "cyan", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "info")
	self:CastBar(args.spellId, 3.5)
end

function mod:HullCracker(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
end

function mod:GrippingTerrorDeath(args)
	self:StopBar(CL.count:format(self:SpellName(L.demolishing), demolisherCount+1))
end
