
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Viq'Goth", 1822, 2140)
if not mod then return end
mod:RegisterEnableMob(128652) -- Viq'Goth
mod.engageId = 2100

--------------------------------------------------------------------------------
-- Locals
--

local stage = 1
local markCount = 1
local playersWithPutridWaters = {}

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
		{275014, "PROXIMITY", "FLASH", "SAY", "SAY_COUNTDOWN"}, -- Putrid Waters
		putridWatersMarker,
		270185, -- Call of the Deep
		"demolishing", -- Demolishing Terror
		269266, -- Slam
		269366, -- Repair
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")

	self:Log("SPELL_AURA_APPLIED", "PutridWatersApplied", 275014)
	self:Log("SPELL_AURA_REMOVED", "PutridWatersRemoved", 275014)
	self:Log("SPELL_CAST_START", "Slam", 269266)
	self:Log("SPELL_CAST_START", "RepairStart", 269366)
end

function mod:OnEngage()
	stage = 1
	markCount = 1
	playersWithPutridWaters = {}
	self:CDBar(275014, 5) -- Putrid Waters
	self:CDBar(270185, 6) -- Call of the Deep
	self:CDBar("demolishing", 20, L.demolishing, L.demolishing_icon) -- Summon Demolisher
end

function mod:OnBossDisable()
	playersWithPutridWaters = {}
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 270183 then -- Call of the Deep
		self:Message2(270185, "orange")
		self:PlaySound(270185, "alarm")

		local timer = stage == 1 and 15 or stage == 2 and 12 or 7
		self:CDBar(270185, timer)
	elseif spellId == 269984 then -- Damage Boss 35%
		stage = stage + 1
		if stage < 4 then
			self:Message2("stages", "green", CL.stage:format(stage), false)
			self:PlaySound("stages", "long")

			self:CDBar("demolishing", stage == 2 and 39.5 or 55.5, L.demolishing, L.demolishing_icon) -- Summon Demolisher
		end
	elseif spellId == 270605 then -- Summon Demolisher
		self:Message2("demolishing", "yellow", CL.spawned:format(self:SpellName(L.demolishing)), L.demolishing_icon)
		self:PlaySound("demolishing", "alert")
		self:CDBar("demolishing", 20, L.demolishing, L.demolishing_icon) -- XXX Need to Check
	end
end

do
	local isOnMe = false
	local playerList = mod:NewTargetList()
	function mod:PutridWatersApplied(args)
		playerList[#playerList+1] = args.destName
		playersWithPutridWaters[#playersWithPutridWaters + 1] = args.destName

		if self:GetOption(putridWatersMarker) then
			SetRaidTarget(args.destName, markCount)
			if markCount == 4 then
				markCount = 1
			else
				markCount = markCount + 1
			end
		end

		if #playerList == 1 then
			self:CDBar(args.spellId, 20)
		end
		if self:Me(args.destGUID) then
			isOnMe = true
			self:OpenProximity(args.spellId, 10)
			self:PlaySound(args.spellId, "warning")
			self:Say(args.spellId)
			self:Flash(args.spellId)
			self:SayCountdown(args.spellId, 30)
		elseif not isOnMe then
			self:OpenProximity(args.spellId, 10, playersWithPutridWaters)
		end
		self:TargetsMessage(args.spellId, "yellow", playerList, 2)
	end

	function mod:PutridWatersRemoved(args)
		tDeleteItem(playersWithPutridWaters, args.destName)

		if self:GetOption(putridWatersMarker) then
			SetRaidTarget(args.destName, 0)
		end

		if self:Me(args.destGUID) then
			isOnMe = false
			self:CancelSayCountdown(args.spellId)
		end

		if #playersWithPutridWaters == 0 then
			self:CloseProximity(args.spellId)
		elseif not isOnMe then
			self:OpenProximity(args.spellId, 10, playersWithPutridWaters)
		end
	end
end

function mod:Slam(args)
	self:Message2(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 8)
end

function mod:RepairStart(args)
	self:Message2(args.spellId, "cyan", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "info")
end
