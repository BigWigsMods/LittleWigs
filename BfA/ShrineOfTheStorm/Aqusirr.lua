
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Aqu'sirr", 1864, 2153)
if not mod then return end
-- Enable on trash before the boss to be sure the module is enabled for the warmup RP.
mod:RegisterEnableMob(134056, 139737, 134173) -- Aqu'sirr, Stormsong (for warmup timer), Animated Droplet (for warmup tiemr)
mod.engageId = 2130
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Locals
--

local stage = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.warmup_trigger = "How dare you sully this holy place with your presence!"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		"stages",
		265001, -- Sea Blast
		{264560, "DISPEL"}, -- Choking Brine
		264101, -- Surging Rush
		264166, -- Undertow
		264526, -- Grasp from the Depths
	}, {
		[265001] = "general",
		[264526] = "heroic",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "Warmup")

	self:Log("SPELL_CAST_START", "SeaBlast", 265001)
	self:Log("SPELL_CAST_SUCCESS", "ChokingBrine", 264560)
	self:Log("SPELL_AURA_APPLIED", "ChokingBrineApplied", 264560, 264773) -- Initial, Ground Pickup
	self:Log("SPELL_CAST_START", "SurgingRush", 264101)
	self:Log("SPELL_CAST_SUCCESS", "Undertow", 264166, 264144, 265366)
	self:Log("SPELL_CAST_START", "EruptingWaters", 264903)
	self:Log("SPELL_AURA_REMOVED", "EruptingWatersRemoved", 264903)
	self:Log("SPELL_AURA_APPLIED", "GraspFromTheDepths", 264526)
end

function mod:OnEngage()
	stage = 1
	self:Bar(264560, 10.2) -- Choking Brine _success
	self:Bar(264101, 15.5) -- Surging Rush _start
	self:Bar(264166, 32) -- Undertow _success
	if not self:Normal() then
		self:Bar(264526, 24) -- Grasp from the Depths _success
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Warmup(event, msg)
	if msg == L.warmup_trigger then
		self:UnregisterEvent(event)
		self:Bar("warmup", 18.8, CL.active, "achievement_dungeon_shrineofthestorm")
	end
end

do
	local prev = 0
	function mod:SeaBlast(args)
		local t = args.time
		if t-prev > 2 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

do
	local prev = 0
	function mod:ChokingBrine(args)
		local t = args.time
		if t-prev > 6 then
			prev = t
			self:CDBar(args.spellId, 32)
		end
	end
end

do
	local playerList = mod:NewTargetList()
	function mod:ChokingBrineApplied(args)
		if self:Dispeller("magic", nil, 264560) then
			playerList[#playerList+1] = args.destName
			self:TargetsMessage(264560, "yellow", playerList, 5)
			self:PlaySound(264560, "alarm", nil, playerList)
		elseif self:Me(args.destGUID) then
			self:PersonalMessage(264560)
			self:PlaySound(264560, "alarm")
		end
	end
end

do
	local prev = 0
	function mod:SurgingRush(args)
		local t = args.time
		if t-prev > 6 then
			prev = t
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "alert")
			self:CDBar(args.spellId, 30)
		end
	end
end

do
	local prev = 0
	local playerList = mod:NewTargetList()
	function mod:Undertow(args)
		local t = args.time
		if t-prev > 6 then
			prev = t
			self:Bar(264166, 32)
		end
		if stage == 1 then
			self:TargetMessage(264166, "orange", args.destName)
			if self:Healer() or self:Me(args.destGUID) then
				self:PlaySound(264166, "warning", nil, args.destName)
			end
		else
			playerList[#playerList+1] = args.destName
			self:TargetsMessage(264166, "orange", playerList, 3)
			if self:Healer() then
				self:PlaySound(264166, "warning", nil, playerList)
			elseif self:Me(args.destGUID) then
				self:PlaySound(264166, "warning")
			end
		end
	end
end

do
	local prev = 0
	local playerList = mod:NewTargetList()
	function mod:GraspFromTheDepths(args)
		local t = args.time
		if t-prev > 6 then
			prev = t
			self:Bar(args.spellId, 32)
		end
		if stage == 1 then
			self:TargetMessage(args.spellId, "orange", args.destName)
			self:PlaySound(args.spellId, "info", nil, args.destName)
		else
			playerList[#playerList+1] = args.destName
			self:TargetsMessage(args.spellId, "orange", playerList, 3)
			self:PlaySound(args.spellId, "info", nil, playerList)
		end
	end
end

function mod:EruptingWaters(args)
	stage = 2
	self:Message("stages", "cyan", CL.intermission, false)
	self:PlaySound("stages", "long", "intermission")
	self:Bar(264560, 13.5) -- Choking Brine _success
	self:Bar(264101, 18.5) -- Surging Rush _start
	self:Bar(264166, 28.5) -- Undertow _success
	if not self:Normal() then
		self:Bar(264526, 32) -- Grasp from the Depths _applied
	end
end

function mod:EruptingWatersRemoved(args)
	stage = 1
	self:Message("stages", "cyan", CL.over:format(CL.intermission), false)
	self:PlaySound("stages", "long")
	self:Bar(264560, 9.5) -- Choking Brine _success
	self:Bar(264101, 15.5) -- Surging Rush _start
	self:Bar(264166, 32) -- Undertow _success
	if not self:Normal() then
		self:Bar(264526, 24) -- Grasp from the Depths _success
	end
end
