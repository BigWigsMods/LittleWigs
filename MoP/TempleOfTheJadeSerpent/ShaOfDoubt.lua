
-- GLOBALS: tDeleteItem

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
	local isOnMe = self:Me(args.destGUID)

	playersWithTouch[#playersWithTouch+1] = args.destName
	if #playersWithTouch == 1 then
		self:OpenProximity(args.spellId, 10, playersWithTouch) -- 10 is a guesstimate, there's no info in the EJ
	elseif isOnMe then
		self:OpenProximity(args.spellId, 10)
		self:Say(args.spellId)
		self:PlaySound(args.spellId, "Alarm")
	end

	self:TargetMessage2(args.spellId, "yellow", args.destName)
	if self:Dispeller("magic") then
		self:TargetBar(args.spellId, 30, args.destName)
		if not isOnMe then
			self:PlaySound(args.spellId, "Alarm")
		end
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
	elseif self:Me(args.destGUID) then
		self:OpenProximity(args.spellId, 10, playersWithTouch)
	end
end

function mod:BoundsOfReality(args)
	self:PlaySound(args.spellId, "Long")
	self:Message(args.spellId, "orange")
	self:CastBar(args.spellId, 30)
	self:CDBar(args.spellId, 60.3)
end

function mod:BoundsOfRealityOver(args)
	self:PlaySound(args.spellId, "Info")
	self:Message(args.spellId, "green", nil, CL.over:format(args.spellName))
	self:StopBar(CL.cast:format(args.spellName))
end

function mod:GatheringDoubt(args)
	addsAlive = addsAlive + 1
end

function mod:AddDeath()
	addsAlive = addsAlive - 1
	if addsAlive > 0 then
		self:PlaySound(117665, "Info")
		self:Message(117665, "green", nil, CL.add_remaining:format(addsAlive), false)
	end
end
