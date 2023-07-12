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
		{413105, "SAY"}, -- Eon Shatter
		{413013, "TANK_HEALER"}, -- Chronoshear
		401421, -- Sand Stomp
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
	self:CDBar(401421, 7.2) -- Sand Stomp
	-- cast at 100 energy
	self:CDBar(413105, 19.3) -- Eon Shatter
	self:CDBar(413013, 48.4) -- Chronoshear
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prev = 0
	function mod:EonShatterApplied(args)
		-- this ability is always cast multiple times in a row.
		-- first cast is on the boss, but the rest will be targeted on a player (with 413142 debuff).
		local t = args.time
		if t - prev > 15 then
			prev = t
			-- alert here for the first cast in a cycle
			self:Message(413105, "yellow")
			self:PlaySound(413105, "alert")
			-- cast at 100 energy: 3s cast + 2s delay + 3s cast + 2s delay + 3s cast + 1s delay + 1.7s delay + 36.1s gain + .3 delay
			self:CDBar(413105, 52.1)
		end
		if self:Me(args.destGUID) then
			-- this will be from the target of the next cast
			self:Say(413105) -- Eon Shatter
		end
	end
end

function mod:EonShatterRemoved(args)
	-- this is the second cast of Eon Shatter, cast when the debuff is removed
	-- from the targeted player.
	self:TargetMessage(413105, "yellow", args.destName)
	self:PlaySound(413105, "long", nil, args.destName)
end

function mod:Chronoshear(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 52.1)
end

function mod:ChronoshearRemoved(args)
	self:Message(args.spellId, "green", CL.removed:format(args.spellName))
	self:PlaySound(args.spellId, "info")
end

function mod:SandStomp(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	sandStompCount = sandStompCount + 1
	-- pull:7.2, 35.2, 18.2, 34.0, 18.2
	if sandStompCount % 2 == 0 then
		self:CDBar(args.spellId, 34.0)
	else
		self:CDBar(args.spellId, 18.2)
	end
end
