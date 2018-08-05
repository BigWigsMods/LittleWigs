
-- GLOBALS: tContains

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Overseer Korgus", 1771, 2096)
if not mod then return end
mod:RegisterEnableMob(127503) -- Overseer Korgus
mod.engageId = 2104

--------------------------------------------------------------------------------
-- Locals
--

local crossIgnitionCount = 0 -- XXX If we track which Azerite Rounds are used we can better timers if a player disconnects
local explosiveBurstCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		256198, -- Azerite Rounds: Incendiary
		256199, -- Azerite Rounds: Blast
		256083, -- Cross Ignition
		{256101, "SAY", "PROXIMITY"}, -- Explosive Burst
		256038, -- Deadeye
		263345, -- Massive Blast
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "AzeriteRoundsIncendiary", 256198)
	self:Log("SPELL_CAST_START", "AzeriteRoundsBlast", 256199)
	self:Log("SPELL_CAST_START", "CrossIgnition", 256083)
	self:Log("SPELL_CAST_SUCCESS", "ExplosiveBurst", 256101)
	self:Log("SPELL_AURA_APPLIED", "ExplosiveBurstApplied", 256105)
	self:Log("SPELL_AURA_REMOVED", "ExplosiveBurstRemoved", 256105)
	self:Log("SPELL_CAST_SUCCESS", "Deadeye", 256038)
	self:Log("SPELL_CAST_START", "MassiveBlast", 263345)
end

function mod:OnEngage()
	crossIgnitionCount = 1
	explosiveBurstCount = 1

	self:CDBar(256198, 6) -- Azerite Rounds: Incendiary
	self:CDBar(256101, 13) -- Explosive Burst
	self:CDBar(256083, 18) -- Cross Ignition
	self:CDBar(256038, 28) -- Deadeye
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:AzeriteRoundsIncendiary(args)
	self:Message(args.spellId, "cyan", "Info")
	self:CDBar(256199, 27.5) -- Azerite Rounds: Blast
end

function mod:AzeriteRoundsBlast(args)
	self:Message(args.spellId, "cyan", "Info")
	self:Bar(256198, 27.5) -- Azerite Rounds: Incendiary
end

function mod:CrossIgnition(args)
	self:Message(args.spellId, "yellow", "Alert")
	crossIgnitionCount = crossIgnitionCount + 1
	self:Bar(args.spellId, crossIgnitionCount % 2 == 0 and 21 or 34)
	self:CastBar(args.spellId, 5.5)
end

function mod:ExplosiveBurst(args)
	self:PlaySound(args.spellId, "alarm")
	explosiveBurstCount = explosiveBurstCount + 1
	self:Bar(args.spellId, explosiveBurstCount % 2 == 0 and 38 or 17)
end

do
	local playerList = mod:NewTargetList()
	function mod:ExplosiveBurstApplied(args)
		playerList[#playerList+1] = args.destName
		if self:Me(args.destGUID) then
			self:Say(256101)
			self:SayCountdown(256101, 4)
			self:OpenProximity(256101, 5)
		elseif not tContains(playerList, self:UnitName("player")) then
			self:OpenProximity(256101, 5, playerList)
		end
		self:TargetsMessage(256101, "orange", playerList, 3)
	end
end

function mod:ExplosiveBurstRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(256101)
	end
	self:CloseProximity(256101)
end

function mod:Deadeye(args)
	self:TargetMessage(args.spellId, args.destName, "red", "Warning", nil, nil, true)
	self:Bar(args.spellId, 27.5)
	self:CastBar(args.spellId, 5)
end

function mod:MassiveBlast(args)
	self:Message(args.spellId, "yellow", "Alert")
	self:Bar(args.spellId, 27.5)
	self:CastBar(args.spellId, 4)
end
