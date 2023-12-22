--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Chronikar", 2579, 2521)
if not mod then return end
mod:RegisterEnableMob(198995) -- Chronikar
mod:SetEncounterID(2666)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local sandStompCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{413142, "SAY", "SAY_COUNTDOWN", "ME_ONLY_EMPHASIZE"}, -- Eon Shatter
		{413013, "TANK_HEALER"}, -- Chronoshear
		401421, -- Sand Stomp
	},nil,{
		[413142] = CL.leap, -- Eon Shatter (Leap)
		[401421] = CL.pools, -- Sand Stomp (Pools)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "EonShatterApplied", 413142)
	self:Log("SPELL_AURA_REMOVED", "EonShatterRemoved", 413142)
	self:Log("SPELL_CAST_START", "Chronoshear", 413013)
	self:Log("SPELL_AURA_REMOVED", "ChronoshearRemoved", 413013)
	self:Log("SPELL_CAST_START", "SandStomp", 401421)
end

function mod:OnEngage()
	sandStompCount = 1
	self:CDBar(401421, 7.2, CL.pools) -- Sand Stomp
	-- cast at 100 energy
	self:CDBar(413142, 19.3, CL.leap) -- Eon Shatter
	self:CDBar(413013, 43.8) -- Chronoshear
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prev = 0
	function mod:EonShatterApplied(args)
		-- this ability is always cast 2 times in a row
		-- first cast is on the floor near the boss, but the second cast will target players, and can be positioned
		local t = args.time
		if t - prev > 15 then
			prev = t
			-- alert here for the first cast (the one that cannot be positioned)
			self:Message(args.spellId, "yellow", CL.leap)
			self:PlaySound(args.spellId, "alarm")
			-- cast at 100 energy: 3s cast + 2s delay + 3s cast + 1s delay + 2s delay + 36s gain + .4 delay
			self:CDBar(args.spellId, 47.4, CL.leap)
		end
		if self:Me(args.destGUID) then
			-- The circle is applied on you and you can run away and position it
			self:Say(args.spellId, CL.leap, nil, "Leap") -- Eon Shatter
			self:SayCountdown(args.spellId, 5)
		end
	end
end

function mod:EonShatterRemoved(args)
	-- When the debuff is removed is when you drop the circle and need to run out, as he will begin his leap on the player
	self:TargetMessage(args.spellId, "yellow", args.destName, CL.leap)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
end

function mod:Chronoshear(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 47.4)
end

function mod:ChronoshearRemoved(args)
	self:Message(args.spellId, "green", CL.removed:format(args.spellName))
	self:PlaySound(args.spellId, "info")
end

function mod:SandStomp(args)
	self:Message(args.spellId, "orange", CL.pools)
	self:PlaySound(args.spellId, "alert")
	sandStompCount = sandStompCount + 1
	-- pull:7.2, 30.4, 17.0, 30.4, 17.0, 30.4, 18.2, 29.2
	if sandStompCount % 2 == 0 then
		self:CDBar(args.spellId, 29.2, CL.pools)
	else
		self:CDBar(args.spellId, 17.0, CL.pools)
	end
end
