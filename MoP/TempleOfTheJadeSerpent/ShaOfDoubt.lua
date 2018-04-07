
-- GLOBALS: tContains, tDeleteItem

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Sha of Doubt", 960, 335)
if not mod then return end
mod:RegisterEnableMob(56439)
mod.engageId = 1439
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Locals
--

local playersWithTouch = {} -- can have multiple players affected if dispellers aren't doing their job
local addsAlive = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{106113, "SAY", "PROXIMITY"}, -- Touch of Nothingness
		117665, -- Bounds of Reality
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "TouchOfNothingness", 106113)
	self:Log("SPELL_AURA_REFRESH", "TouchOfNothingnessRefresh", 106113)
	self:Log("SPELL_AURA_REMOVED", "TouchOfNothingnessRemoved", 106113)

	self:Log("SPELL_AURA_APPLIED", "BoundsOfReality", 117665)
	self:Log("SPELL_AURA_REMOVED", "BoundsOfRealityOver", 117665)

	self:Log("SPELL_AURA_APPLIED", "GatheringDoubt", 117570)
	self:Death("AddDeath", 56792) -- Figment of Doubt
end

function mod:OnEngage()
	addsAlive = 0
	wipe(playersWithTouch)
	self:CDBar(117665, 24.4) -- Bounds of Reality
end

function mod:OnBossDisable()
	wipe(playersWithTouch)
end


--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:TouchOfNothingness(args)
	playersWithTouch[#playersWithTouch+1] = args.destName
	if self:Me(args.destGUID) then
		self:OpenProximity(args.spellId, 10) -- 10 is a guesstimate, there's no info in the EJ
		self:Say(args.spellId)
	elseif not tContains(playersWithTouch, self:UnitName("player")) then
		self:OpenProximity(args.spellId, 10, playersWithTouch)
	end

	local canDispel = self:Dispeller("magic")
	self:TargetMessage(args.spellId, args.destName, "Attention", "Alarm", nil, nil, canDispel)
	if canDispel then
		self:TargetBar(args.spellId, 30, args.destName)
	end
end


function mod:TouchOfNothingnessRefresh(args)
	if self:Dispeller("magic") then
		self:TargetBar(args.spellId, 30, args.destName)
	end
end

function mod:TouchOfNothingnessRemoved(args)
	tDeleteItem(playersWithTouch, args.destName)
	self:StopBar(args.spellName, args.destName)

	if #playersWithTouch == 0 then
		self:CloseProximity(args.spellId)
	elseif not tContains(playersWithTouch, self:UnitName("player")) then
		self:OpenProximity(args.spellId, 10, playersWithTouch)
	end
end

function mod:BoundsOfReality(args)
	self:Message(args.spellId, "Urgent", "Long")
	self:CastBar(args.spellId, 30)
	self:CDBar(args.spellId, 60.3)
end

function mod:BoundsOfRealityOver(args)
	self:Message(args.spellId, "Positive", "Info", CL.over:format(args.spellName))
	self:StopBar(CL.cast:format(args.spellName))
end

function mod:GatheringDoubt(args)
	addsAlive = addsAlive + 1
end

function mod:AddDeath()
	addsAlive = addsAlive - 1
	if addsAlive > 0 then
		self:Message(117665, "Positive", "Info", CL.add_remaining:format(addsAlive), false)
	end
end
