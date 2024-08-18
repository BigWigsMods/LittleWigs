--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("I'pa", 2661, 2587)
if not mod then return end
mod:RegisterEnableMob(210267) -- I'pa
mod:SetEncounterID(2929)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local spoutingStoutCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		439365, -- Spouting Stout
		440147, -- Fill 'Er Up
		439202, -- Burning Fermentation
		{439031, "TANK_HEALER"}, -- Bottoms Uppercut
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "SpoutingStout", 439365)
	self:Log("SPELL_AURA_APPLIED", "FillErUp", 440147)
	self:Log("SPELL_CAST_SUCCESS", "BurningFermentation", 439202)
	self:Log("SPELL_AURA_APPLIED", "BurningFermentationApplied", 439325)
	self:Log("SPELL_CAST_START", "BottomsUppercut", 439031)
end

function mod:OnEngage()
	spoutingStoutCount = 1
	self:CDBar(439365, 10.6, CL.count:format(self:SpellName(439365), spoutingStoutCount)) -- Spouting Stout
	self:CDBar(439031, 26.4) -- Bottoms Uppercut
	self:CDBar(439202, 35.0) -- Burning Fermentation
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SpoutingStout(args)
	self:StopBar(CL.count:format(args.spellName, spoutingStoutCount))
	self:Message(args.spellId, "yellow", CL.count:format(args.spellName, spoutingStoutCount))
	self:PlaySound(args.spellId, "long")
	spoutingStoutCount = spoutingStoutCount + 1
	self:CDBar(args.spellId, 47.3, CL.count:format(args.spellName, spoutingStoutCount))
end

function mod:FillErUp(args)
	self:Message(args.spellId, "yellow", CL.onboss:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
end

do
	local playerList = {}

	function mod:BurningFermentation(args)
		playerList = {}
		self:CDBar(args.spellId, 47.3)
	end

	function mod:BurningFermentationApplied(args)
		playerList[#playerList + 1] = args.destName
		self:PlaySound(439202, "long", nil, playerList)
		self:TargetsMessage(439202, "yellow", playerList, 2, nil, nil, .85) -- debuff has travel time
	end
end

function mod:BottomsUppercut(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 47.3)
end
