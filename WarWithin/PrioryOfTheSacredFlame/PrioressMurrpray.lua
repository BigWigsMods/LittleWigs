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
		423664, -- Embrace the Light
		444546, -- Purify
		{444608, "HEALER"}, -- Inner Fire
		451605, -- Holy Flame
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "BarrierOfLight", 423588)
	self:Log("SPELL_AURA_REMOVED", "BarrierOfLightRemoved", 423588)
	self:Log("SPELL_INTERRUPT", "EmbraceTheLightInterrupted", "*")
	self:Log("SPELL_CAST_START", "Purify", 444546) -- TODO should maybe change to SUCCESS, the beam doesn't appear until ~5.3 seconds after this?
	self:Log("SPELL_CAST_START", "InnerFire", 444608)
	self:Log("SPELL_CAST_START", "HolyFlame", 451605)
end

function mod:OnEngage()
	self:SetStage(1)
	self:CDBar(451605, 7.1) -- Holy Flame
	self:CDBar(444546, 12.0) -- Purify
	self:CDBar(444608, 15.7) -- Inner Fire
end

function mod:VerifyEnable(unit)
	-- the boss shows up halfway through the dungeon for some RP
	return UnitCanAttack("player", unit)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local barrierOfLightStart = 0

	function mod:BarrierOfLight(args)
		barrierOfLightStart = args.time
		self:StopBar(444546) -- Purify
		self:StopBar(444608) -- Inner Fire
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

function mod:EmbraceTheLightInterrupted(args)
	if args.extraSpellId == 423664 then -- Embrace the Light
		self:Message(423664, "green", CL.interrupted_by:format(args.extraSpellName, self:ColorName(args.sourceName)))
		self:PlaySound(423664, "info")
		self:SetStage(1)
		self:CDBar(444546, 6.3) -- Purify
		self:CDBar(444608, 9.9) -- Inner Fire
		self:CDBar(451605, 12.3) -- Holy Flame
	end
end

function mod:Purify(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 23.0)
end

function mod:InnerFire(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 23.0)
end

function mod:HolyFlame(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 9.7)
end
