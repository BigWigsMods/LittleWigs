if select(4, GetBuildInfo()) < 100105 then return end
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
		{416096, "ME_ONLY"}, -- Eon Overload
		{413013, "TANK_HEALER"}, -- Chronoshear
		401421, -- Sand Stomp
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "EonShatterApplied", 413142)
	self:Log("SPELL_AURA_REMOVED", "EonShatterRemoved", 413142)
	self:Log("SPELL_AURA_APPLIED", "EonOverloadApplied", 416096)
	self:Log("SPELL_CAST_START", "Chronoshear", 413013)
	self:Log("SPELL_AURA_REMOVED", "ChronoshearRemoved", 413013)
	self:Log("SPELL_CAST_START", "SandStomp", 401421)
end

function mod:OnEngage()
	sandStompCount = 1
	self:CDBar(401421, 4.7) -- Sand Stomp
	self:CDBar(413013, 11.0) -- Chronoshear
	-- cast at 100 energy
	self:CDBar(413105, 30.2) -- Eon Shatter
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:EonShatterApplied(args)
	-- this ability is always cast twice. this is the first cast will be wherever
	-- the boss is, but the second will be targeted on a player (with 413142 debuff).
	self:Message(413105, "yellow")
	self:PlaySound(413105, "long")
	if self:Me(args.destGUID) then
		-- this will be from the target of the second cast
		self:Say(413105) -- Eon Shatter
	end
	-- cast at 100 energy
	self:CDBar(413105, 44.9)
end

function mod:EonShatterRemoved(args)
	-- this is the second cast of Eon Shatter, cast when the debuff is removed
	-- from the targeted player.
	self:TargetMessage(413105, "yellow", args.destName)
	self:PlaySound(413105, "long", nil, args.destName)
end

function mod:EonOverloadApplied(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	self:PlaySound(args.spellId, "info", nil, args.destName)
end

function mod:Chronoshear(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 44.7)
end

function mod:ChronoshearRemoved(args)
	self:Message(args.spellId, "green", CL.removed:format(args.spellName))
	self:PlaySound(args.spellId, "info")
end

function mod:SandStomp(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	sandStompCount = sandStompCount + 1
	if sandStompCount % 2 == 0 then
		self:CDBar(args.spellId, 14.6)
	else
		self:CDBar(args.spellId, 30.3)
	end
end
