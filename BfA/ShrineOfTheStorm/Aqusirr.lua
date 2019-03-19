
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Aqu'sirr", 1864, 2153)
if not mod then return end
mod:RegisterEnableMob(134056, 139737) -- Aqu'sirr, Stormsong (for warmup timer)
mod.engageId = 2130

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
	self:Bar(264560, 9.5) -- Choking Brine _success
	self:Bar(264101, 15.5) -- Surging Rush _start
	self:Bar(264526, 24) -- Grasp from the Depths _success
	self:Bar(264166, 32) -- Undertow _success
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
			self:Message2(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

do
	local prev = 0
	function mod:ChokingBrine(args)
		local t = args.time
		if t-prev > 2 then
			prev = t
			self:Bar(args.spellId, 32)
		end
	end
end

function mod:ChokingBrineApplied(args)
	if self:Dispeller("magic", nil, 264560) or self:Me(args.destGUID) then
		self:TargetMessage2(264560, "yellow", args.destName)
		self:PlaySound(264560, "alarm")
	end
end

do
	local prev = 0
	function mod:SurgingRush(args)
		local t = args.time
		if t-prev > 2 then
			prev = t
			self:Message2(args.spellId, "yellow")
			self:PlaySound(args.spellId, "alert")
			self:Bar(args.spellId, 32)
		end
	end
end

do
	local prev = 0
	function mod:Undertow(args)
		local t = args.time
		if t-prev > 10 then
			prev = t
			self:Bar(264166, 32)
		end
		self:TargetMessage2(264166, "orange", args.destName)
		if self:Me(args.destGUID) then
			self:PlaySound(264166, "warning")
		end
	end
end

function mod:GraspFromTheDepths(args)
	self:TargetMessage2(args.spellId, "orange", args.destName)
	self:PlaySound(args.spellId, "info")
	self:Bar(args.spellId, 32)
end

function mod:EruptingWaters(args)
	self:Message2("stages", "cyan", CL.intermission)
	self:PlaySound("stages", "long", "intermission")
	self:Bar(264560, 13.5) -- Choking Brine _success
	self:Bar(264101, 18.5) -- Surging Rush _start
	self:Bar(264166, 28.5) -- Undertow _success
	self:Bar(264526, 32) -- Grasp from the Depths _applied
end

function mod:EruptingWatersRemoved(args)
	self:Message2("stages", "cyan", CL.over:format(CL.intermission))
	self:PlaySound("stages", "long")
	self:Bar(264560, 9.5) -- Choking Brine _success
	self:Bar(264101, 15.5) -- Surging Rush _start
	self:Bar(264526, 24) -- Grasp from the Depths _success
	self:Bar(264166, 32) -- Undertow _success
end
