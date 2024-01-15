--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Sha of Doubt", 960, 335)
if not mod then return end
mod:RegisterEnableMob(56439) -- Sha of Doubt
mod:SetEncounterID(1439)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local mobCollector = {} -- adds from "Bonds of Reality" fire UNIT_DIED twice in a row (and the debuff they apply doesn't fire SPELL_AURA_REMOVED)
local addsAlive = 0
local touchOfNothingnessRemaining = 3

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{106113, "SAY"}, -- Touch of Nothingness
		117665, -- Bounds of Reality
		117570, -- Gathering Doubt
	}, {
		[106113] = self.displayName,
		[117570] = -4076, -- Figments of Doubt
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "TouchOfNothingness", 106113)
	self:Log("SPELL_AURA_APPLIED", "TouchOfNothingnessApplied", 106113)
	self:Log("SPELL_CAST_START", "BoundsOfRealityStart", 117665)
	self:Log("SPELL_AURA_APPLIED", "BoundsOfReality", 117665)
	self:Log("SPELL_AURA_REMOVED", "BoundsOfRealityOver", 117665)
	self:Log("SPELL_AURA_APPLIED", "GatheringDoubt", 117570)
	self:Death("AddDeath", 56792) -- Figment of Doubt
end

function mod:OnEngage()
	touchOfNothingnessRemaining = 1
	addsAlive = 0
	mobCollector = {}
	self:CDBar(106113, 10.6) -- Touch of Nothingness
	self:CDBar(117665, 20.3) -- Bounds of Reality
end

function mod:OnBossDisable()
	mobCollector = {}
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local playerList = {}

	function mod:TouchOfNothingness(args)
		touchOfNothingnessRemaining = touchOfNothingnessRemaining - 1
		playerList = {}
		if touchOfNothingnessRemaining > 0 then
			self:CDBar(args.spellId, 20.5)
		else
			self:StopBar(args.spellId)
		end
	end

	function mod:TouchOfNothingnessApplied(args)
		-- playerList contains players affected by the most recent cast
		playerList[#playerList + 1] = args.destName
		self:TargetsMessage(args.spellId, "yellow", playerList, 2, nil, nil, 1)
		self:PlaySound(args.spellId, "alarm", nil, playerList)
		if self:Me(args.destGUID) then
			self:Say(args.spellId, nil, nil, "Touch of Nothingness")
		end
	end
end

function mod:BoundsOfRealityStart(args)
	touchOfNothingnessRemaining = 3
	self:StopBar(106113) -- Touch of Nothingness
end

function mod:BoundsOfReality(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 69.2)
end

function mod:BoundsOfRealityOver(args)
	self:Message(args.spellId, "green", CL.over:format(args.spellName))
	self:PlaySound(args.spellId, "info")
	self:StopBar(117570) -- Gathering Doubt
end

do
	local prev = 0
	function mod:GatheringDoubt(args)
		addsAlive = addsAlive + 1
		mobCollector[args.sourceGUID] = true
		local t = args.time
		if t - prev > 3 then
			prev = t
			-- adds explode in 20s
			self:Bar(args.spellId, 20)
		end
	end
end

function mod:AddDeath(args)
	if mobCollector[args.destGUID] then
		mobCollector[args.destGUID] = nil
		addsAlive = addsAlive - 1
		if addsAlive > 0 then
			self:Message(117665, "cyan", CL.add_remaining:format(addsAlive), false)
		end
	end
end
