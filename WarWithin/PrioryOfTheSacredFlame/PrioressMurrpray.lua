if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Prioress Murrpray", 2649, 2573)
if not mod then return end
mod:RegisterEnableMob(207940) -- Prioress Murrpray
mod:SetEncounterID(2848)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		423588, -- Barrier of Light
		444546, -- Purifying Light
		{444608, "HEALER"}, -- Inner Light
		451605, -- Holy Flame
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("ENCOUNTER_START") --- XXX no boss frames
	self:Log("SPELL_CAST_SUCCESS", "BarrierOfLight", 423588)
	self:Log("SPELL_AURA_REMOVED", "BarrierOfLightRemoved", 423588)
	self:Log("SPELL_AURA_REMOVED", "EmbraceTheLightRemoved", 423664)
	self:Log("SPELL_CAST_START", "PurifyingLight", 444546)
	self:Log("SPELL_CAST_START", "InnerLight", 444608)
	self:Log("SPELL_CAST_START", "HolyFlame", 451605)
end

function mod:OnEngage()
	self:SetStage(1)
	self:CDBar(451605, 7.1) -- Holy Flame
	self:CDBar(444546, 12.0) -- Purifying Light
	self:CDBar(444608, 15.7) -- Inner Light
end

function mod:VerifyEnable(unit)
	-- the boss shows up halfway through the dungeon for some RP
	return UnitCanAttack("player", unit)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- XXX no boss frames
function mod:ENCOUNTER_START(_, id)
	if id == self.engageId then
		self:Engage()
	end
end

do
	local barrierOfLightStart = 0

	function mod:BarrierOfLight(args)
		barrierOfLightStart = args.time
		self:StopBar(444546) -- Purifying Light
		self:StopBar(444608) -- Inner Light
		self:StopBar(451605) -- Holy Flame
		self:SetStage(2)
		self:Message(args.spellId, "cyan", CL.percent:format(50, args.spellName))
		self:PlaySound(args.spellId, "long")
	end

	function mod:BarrierOfLightRemoved(args)
		local barrierOfLightDuration = args.time - barrierOfLightStart
		self:Message(args.spellId, "green", CL.removed_after:format(args.spellName, barrierOfLightDuration))
		self:PlaySound(args.spellId, "info")
	end
end

function mod:EmbraceTheLightRemoved(args)
	self:SetStage(1)
	self:CDBar(444608, 6.4) -- Inner Light
	self:CDBar(444546, 8.8) -- Purifying Light
	self:CDBar(451605, 12.5) -- Holy Flame
end

function mod:PurifyingLight(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 23.0)
end

function mod:InnerLight(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 23.0)
end

function mod:HolyFlame(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 9.7)
end
