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
	L.northwest = "NW"
	L.northeast = "NE"
	L.southeast = "SE"
	L.southwest = "SW"
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
		"stages",
		-- Kyrakka
		381862, -- Infernocore
		381525, -- Roaring Firebreath
		381602, -- Flamespit
		-- Erkhart Stormvein
		381517, -- Winds of Change
		381516, -- Interrupting Cloudburst
		{381512, "TANK_HEALER"}, -- Stormslam
	}, {
		[381862] = -25365, -- Kyrakka
		[381517] = -25369, -- Erkhart Stormvein
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
	self:SetStage(1)
	self:Bar(381525, 1.6) -- Roaring Firebreath
	self:Bar(381512, 6.1) -- Stormslam
	self:CDBar(381602, 15.7) -- Flamespit
	if self:Mythic() then
		self:Bar(381516, 9.7) -- Interrupting Cloudburst
	end
	self:Bar(381517, 17, CL.other:format(self:SpellName(381517), L.northwest), "misc_arrowlup") -- Winds of Change
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Stages

function mod:UNIT_HEALTH(event, unit)
	-- stage 2 trigger is either boss hitting 50%, but it takes some time for the bosses to get in position
	if self:GetHealth(unit) <= 50 then
		self:UnregisterUnitEvent(event, "boss1")
		self:UnregisterUnitEvent(event, "boss2")
		self:Message("stages", "cyan", CL.soon:format(CL.stage:format(2)), false)
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
				nextDirection = L.southwest
			elseif windsOfChangeCount % 4 == 2 then
				nextDirection = L.southeast
			elseif windsOfChangeCount % 4 == 3 then
				nextDirection = L.northeast
			elseif windsOfChangeCount % 4 == 0 then
				nextDirection = L.northwest
			end
			self:StopBar(CL.other:format(self:SpellName(381517), nextDirection)) -- Winds of Change
			self:StopBar(381516) -- Interrupting Cloudburst
			self:StopBar(381512) -- Stormslam
		end
	end
end

-- Kyrakka

do
	local prev = 0

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
			self:TargetBar(args.spellId, 3, args.destName)
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
			self:Bar(381602, 15.8)
		else
			self:Bar(381602, 18.2)
		end
	end
end

-- Erkhart Stormvein

function mod:WindsOfChange(args)
	windsOfChangeCount = windsOfChangeCount + 1
	local direction, nextDirection, icon, nextIcon
	if windsOfChangeCount % 4 == 1 then
		direction = L.northwest
		nextDirection = L.southwest
		icon = "misc_arrowlup"
		nextIcon = "misc_arrowleft"
	elseif windsOfChangeCount % 4 == 2 then
		direction = L.southwest
		nextDirection = L.southeast
		icon = "misc_arrowleft"
		nextIcon = "misc_arrowdown"
	elseif windsOfChangeCount % 4 == 3 then
		direction = L.southeast
		nextDirection = L.northeast
		icon = "misc_arrowdown"
		nextIcon = "misc_arrowright"
	elseif windsOfChangeCount % 4 == 0 then
		direction = L.northeast
		nextDirection = L.northwest
		icon = "misc_arrowright"
		nextIcon = "misc_arrowlup"
	end
	self:Message(args.spellId, "yellow", CL.other:format(args.spellName, direction), icon)
	self:PlaySound(args.spellId, "alert")
	self:StopBar(CL.other:format(args.spellName, direction))
	self:CDBar(args.spellId, 19.4, CL.other:format(args.spellName, nextDirection), nextIcon)
end

function mod:InterruptingCloudburst(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	self:Bar(args.spellId, 19.4)
end

function mod:Stormslam(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 17)
end

function mod:StormslamApplied(args)
	self:StackMessage(381512, "purple", args.destName, args.amount, 2)
	self:PlaySound(381512, "alert")
end
