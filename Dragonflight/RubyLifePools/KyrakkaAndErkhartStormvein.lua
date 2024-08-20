--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Kyrakka and Erkhart Stormvein", 2521, 2503)
if not mod then return end
mod:RegisterEnableMob(
	190484, -- Kyrakka
	190485  -- Erkhart Stormvein
)
mod:SetEncounterID(2623)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.winds = "Winds"
	L.warmup_icon = "achievement_dungeon_lifepools"
end

--------------------------------------------------------------------------------
-- Locals
--

local windsOfChangeCount = 0
local stageTwoFlamespitCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		"stages",
		-- Kyrakka
		{381862, "SAY", "SAY_COUNTDOWN"}, -- Infernocore
		381525, -- Roaring Firebreath
		381602, -- Flamespit
		-- Erkhart Stormvein
		381517, -- Winds of Change
		381516, -- Interrupting Cloudburst
		{381512, "DISPEL"}, -- Stormslam
	}, {
		[381862] = -25365, -- Kyrakka
		[381517] = -25369, -- Erkhart Stormvein
	},{
		[381517] = L.winds, -- Winds of Change (Winds)
	}
end

function mod:OnBossEnable()
	-- Stages
	self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1", "boss2")
	self:Log("SPELL_AURA_APPLIED", "EncounterEvent", 181089)
	self:Death("BossDeath", 190484, 190485)

	-- Kyrakka
	self:Log("SPELL_AURA_APPLIED", "InfernocoreApplied", 381862)
	self:Log("SPELL_AURA_APPLIED_DOSE", "InfernocoreApplied", 381862)
	self:Log("SPELL_AURA_REMOVED", "InfernocoreRemoved", 381862)
	self:Log("SPELL_CAST_START", "RoaringFirebreath", 381525)
	self:Log("SPELL_CAST_START", "Flamespit", 381602, 381605) -- P1, P2

	-- Erkhart Stormvein
	self:Log("SPELL_CAST_START", "WindsOfChange", 381517)
	self:Log("SPELL_CAST_START", "InterruptingCloudburst", 381516)
	self:Log("SPELL_CAST_START", "Stormslam", 381512)
	self:Log("SPELL_AURA_APPLIED", "StormslamApplied", 381515)
	self:Log("SPELL_AURA_APPLIED_DOSE", "StormslamApplied", 381515)
end

function mod:OnEngage()
	windsOfChangeCount = 0
	stageTwoFlamespitCount = 0
	self:StopBar(CL.active)
	self:SetStage(1)
	self:CDBar(381525, 1.6) -- Roaring Firebreath
	if self:Tank() or self:Dispeller("magic", nil, 381512) then
		self:CDBar(381512, 6.1) -- Stormslam
	end
	self:CDBar(381602, 15.7) -- Flamespit
	if self:Mythic() then
		self:CDBar(381516, 9.7) -- Interrupting Cloudburst
	end
	if not self:Normal() then
		self:CDBar(381517, 17.0, CL.other:format(L.winds, CL.north_west), "misc_arrowlup") -- Winds of Change
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Warmup

function mod:Warmup() -- called from trash module
	self:Bar("warmup", 10.7, CL.active, L.warmup_icon)
end

-- Stages

function mod:UNIT_HEALTH(event, unit)
	-- stage 2 trigger is either boss hitting 50%, but it takes some time for the bosses to get in position
	if self:GetHealth(unit) <= 50 then
		self:UnregisterUnitEvent(event, "boss1")
		self:UnregisterUnitEvent(event, "boss2")
		self:Message("stages", "cyan", CL.percent:format(50, CL.soon:format(CL.stage:format(2))), false)
		self:PlaySound("stages", "info")
	end
end

function mod:EncounterEvent()
	-- when either boss reaches 50%, Kyrakka lands so Erkhart can remount
	self:SetStage(2)
	self:Message("stages", "cyan", CL.stage:format(2), false)
	self:PlaySound("stages", "long")
end

function mod:BossDeath(args)
	if self:GetStage() ~= 3 then
		self:SetStage(3)
		self:Message("stages", "cyan", CL.stage:format(3), false)
		self:PlaySound("stages", "long")

		if args.mobId == 190484 then -- Kyrakka
			self:StopBar(381525) -- Roaring Firebreath
			self:StopBar(381602) -- Flamespit
		else -- Erkhart Stormvein
			local nextDirection
			if windsOfChangeCount % 4 == 1 then
				nextDirection = CL.south_west
			elseif windsOfChangeCount % 4 == 2 then
				nextDirection = CL.south_east
			elseif windsOfChangeCount % 4 == 3 then
				nextDirection = CL.north_east
			elseif windsOfChangeCount % 4 == 0 then
				nextDirection = CL.north_west
			end
			self:StopBar(CL.other:format(L.winds, nextDirection)) -- Winds of Change
			self:StopBar(381516) -- Interrupting Cloudburst
			self:StopBar(381512) -- Stormslam
		end
	end
end

-- Kyrakka

do
	local prev = 0
	local onMe = nil

	function mod:InfernocoreApplied(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 1 then
				prev = t
				if args.amount then
					self:StackMessage(args.spellId, "blue", args.destName, args.amount, 2)
				else
					self:PersonalMessage(args.spellId)
				end
				self:PlaySound(args.spellId, "alarm")
			end
			if not onMe then
				onMe = true
				self:Say(args.spellId, nil, nil, "Infernocore")
			else
				self:CancelSayCountdown(args.spellId)
			end
			self:SayCountdown(args.spellId, 4, nil, 2)
			self:TargetBar(args.spellId, 4, args.destName)
		end
	end

	function mod:InfernocoreRemoved(args)
		if self:Me(args.destGUID) then
			onMe = nil
			self:StopBar(args.spellId, args.destName)
			self:CancelSayCountdown(args.spellId)
		end
	end
end

function mod:RoaringFirebreath(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	if self:GetStage() == 1 then
		self:CDBar(args.spellId, 19.1)
	else
		self:CDBar(args.spellId, 18.2)
	end
end

function mod:Flamespit(args)
	self:Message(381602, "red")
	self:PlaySound(381602, "alert")
	if args.spellId == 381602 then -- stage 1 Flamespit
		self:CDBar(381602, 19.5)
	else -- 381605, stage 2/3 Flamespit
		stageTwoFlamespitCount = stageTwoFlamespitCount + 1
		if stageTwoFlamespitCount == 1 then
			self:CDBar(381602, 15.8)
		else
			self:CDBar(381602, 18.2)
		end
	end
end

-- Erkhart Stormvein

function mod:WindsOfChange(args)
	windsOfChangeCount = windsOfChangeCount + 1
	local direction, nextDirection, icon, nextIcon
	if windsOfChangeCount % 4 == 1 then
		direction = CL.north_west
		nextDirection = CL.south_west
		icon = "misc_arrowlup"
		nextIcon = "misc_arrowleft"
	elseif windsOfChangeCount % 4 == 2 then
		direction = CL.south_west
		nextDirection = CL.south_east
		icon = "misc_arrowleft"
		nextIcon = "misc_arrowdown"
	elseif windsOfChangeCount % 4 == 3 then
		direction = CL.south_east
		nextDirection = CL.north_east
		icon = "misc_arrowdown"
		nextIcon = "misc_arrowright"
	elseif windsOfChangeCount % 4 == 0 then
		direction = CL.north_east
		nextDirection = CL.north_west
		icon = "misc_arrowright"
		nextIcon = "misc_arrowlup"
	end
	self:Message(args.spellId, "yellow", CL.other:format(L.winds, direction), icon)
	self:PlaySound(args.spellId, "alert")
	self:StopBar(CL.other:format(L.winds, direction))
	self:CDBar(args.spellId, 19.4, CL.other:format(L.winds, nextDirection), nextIcon)
end

function mod:InterruptingCloudburst(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	self:CDBar(args.spellId, 19.4)
end

function mod:Stormslam(args)
	if self:Tank() then
		self:Message(args.spellId, "purple")
		self:PlaySound(args.spellId, "alarm")
		self:CDBar(args.spellId, 17.0)
	elseif self:Dispeller("magic", nil, args.spellId) then
		self:CDBar(args.spellId, 17.0)
	end
end

function mod:StormslamApplied(args)
	if self:Dispeller("magic", nil, 381512) then
		self:StackMessage(381512, "purple", args.destName, args.amount, 2)
		self:PlaySound(381512, "alert")
	end
end
