--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ularogg Cragshaper", 1458, 1665)
if not mod then return end
mod:RegisterEnableMob(91004)
mod:SetEncounterID(1791)
mod:SetRespawnTime(15)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local totemsAlive = 0
local stanceOfTheMountainCount = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.hands = "Hands" -- Short for "Stone Hands"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		198564, -- Stance of the Mountain
		193375, -- Bellow of the Deeps
		198428, -- Strike of the Mountain
		{198496, "TANK_HEALER"}, -- Sunder
	}, nil, {
		[198564] = CL.intermission, -- Stance of the Mountain (Intermission)
		[193375] = CL.totems, -- Bellow of the Deeps (Totems)
		[198428] = L.hands, -- Strike of the Mountain (Hands)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "StanceOfTheMountain", 198509)
	self:Death("IntermissionTotemsDeath", 100818)
	self:Log("SPELL_CAST_START", "BellowOfTheDeeps", 193375)
	self:Log("SPELL_CAST_START", "StrikeOfTheMountain", 198428)
	self:Log("SPELL_CAST_START", "Sunder", 198496)
end

function mod:OnEngage()
	totemsAlive = 0
	stanceOfTheMountainCount = 1
	self:SetStage(1)
	self:CDBar(198496, 7.1) -- Sunder
	self:CDBar(198428, 15.5, L.hands) -- Strike of the Mountain
	self:CDBar(193375, 20.4, CL.totems) -- Bellow of the Deeps
	if self:Mythic() then
		-- 50s energy gain + .2s to ~10s delay
		self:CDBar(198564, 50.2, CL.count:format(CL.intermission, stanceOfTheMountainCount)) -- Stance of the Mountain
	else
		-- 70s energy gain + delay
		self:CDBar(198564, 70.3, CL.count:format(CL.intermission, stanceOfTheMountainCount)) -- Stance of the Mountain
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:StanceOfTheMountain(args)
	self:SetStage(2)
	totemsAlive = self:Normal() and 3 or 5
	self:StopBar(CL.totems) -- Bellow of the Deeps
	self:StopBar(L.hands) -- Strike of the Mountain
	self:StopBar(198496) -- Sunder
	self:StopBar(CL.count:format(CL.intermission, stanceOfTheMountainCount)) -- Stance of the Mountain
	self:Message(198564, "cyan", CL.count:format(CL.intermission, stanceOfTheMountainCount))
	self:PlaySound(198564, "long")
end

function mod:IntermissionTotemsDeath()
	totemsAlive = totemsAlive - 1
	if totemsAlive == 0 then -- all of them fire UNIT_DIED
		self:SetStage(1)
		self:Message(198564, "green", CL.over:format(CL.intermission)) -- Stance of the Mountain
		self:PlaySound(198564, "info")
		stanceOfTheMountainCount = stanceOfTheMountainCount + 1
		if self:Mythic() then
			-- 50s energy gain + delay
			self:CDBar(198564, 50.6, CL.count:format(CL.intermission, stanceOfTheMountainCount)) -- Stance of the Mountain
		else
			-- 70s energy gain + delay
			self:CDBar(198564, 70.7, CL.count:format(CL.intermission, stanceOfTheMountainCount)) -- Stance of the Mountain
		end
		-- all abilities available
		self:CDBar(193375, .1, CL.totems) -- Bellow of the Deeps
		self:CDBar(198428, .1, L.hands) -- Strike of the Mountain
		self:CDBar(198496, .1) -- Sunder
	end
end

function mod:BellowOfTheDeeps(args)
	self:Message(args.spellId, "orange", CL.incoming:format(CL.totems))
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 33.6, CL.totems)
	-- soonest another ability can be is 6.06s
	if self:BarTimeLeft(L.hands) < 6.06 then -- Strike of the Mountain
		self:CDBar(198428, {6.06, 15.7}, L.hands)
	end
	if self:BarTimeLeft(198496) < 6.06 then -- Sunder
		self:CDBar(198496, {6.06, 8.1})
	end
end

function mod:StrikeOfTheMountain(args)
	self:Message(args.spellId, "red", L.hands)
	self:PlaySound(args.spellId, "warning")
	self:CDBar(args.spellId, 15.7, L.hands)
	-- soonest another ability can be is 4.82s
	if self:BarTimeLeft(CL.totems) < 4.82 then -- Bellow of the Deeps
		self:CDBar(193375, {4.82, 33.6}, CL.totems)
	end
	if self:BarTimeLeft(198496) < 4.82 then -- Sunder
		self:CDBar(198496, {4.82, 8.1})
	end
end

function mod:Sunder(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 8.1)
	-- soonest another ability can be is 4.82s
	if self:BarTimeLeft(CL.totems) < 4.82 then -- Bellow of the Deeps
		self:CDBar(193375, {4.82, 33.6}, CL.totems)
	end
	if self:BarTimeLeft(L.hands) < 4.82 then -- Strike of the Mountain
		self:CDBar(198428, {4.82, 15.7}, L.hands)
	end
end
