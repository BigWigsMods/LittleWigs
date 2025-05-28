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
		440087, -- Oozing Honey
	}, {
		[440087] = -28427, -- Brew Drop
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "SpoutingStout", 439365)
	self:Log("SPELL_AURA_APPLIED", "FillErUp", 440147) -- no way to alert when boss eats more than one add
	self:Log("SPELL_CAST_SUCCESS", "BurningFermentation", 439202)
	self:Log("SPELL_AURA_APPLIED", "BurningFermentationApplied", 439325)
	self:Log("SPELL_CAST_START", "BottomsUppercut", 439031)

	-- Brew Drop
	self:Log("SPELL_PERIODIC_DAMAGE", "OozingHoneyDamage", 440087, 441179) -- first puddle, second puddle
	self:Log("SPELL_PERIODIC_MISSED", "OozingHoneyDamage", 440087, 441179) -- first puddle, second puddle
end

function mod:OnEngage()
	spoutingStoutCount = 1
	self:CDBar(439365, 10.6, CL.count:format(self:SpellName(439365), spoutingStoutCount)) -- Spouting Stout
	self:CDBar(439031, 26.3) -- Bottoms Uppercut
	self:CDBar(439202, 35.0) -- Burning Fermentation
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SpoutingStout(args)
	self:StopBar(CL.count:format(args.spellName, spoutingStoutCount))
	self:Message(args.spellId, "yellow", CL.count:format(args.spellName, spoutingStoutCount))
	spoutingStoutCount = spoutingStoutCount + 1
	self:CDBar(args.spellId, 47.3, CL.count:format(args.spellName, spoutingStoutCount))
	self:PlaySound(args.spellId, "long")
end

function mod:FillErUp(args)
	self:Message(args.spellId, "cyan", CL.onboss:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

do
	local playerList = {}

	function mod:BurningFermentation(args)
		playerList = {}
		self:CDBar(args.spellId, 47.3)
	end

	function mod:BurningFermentationApplied(args)
		playerList[#playerList + 1] = args.destName
		self:TargetsMessage(439202, "orange", playerList, 2, nil, nil, .85) -- debuff has travel time
		self:PlaySound(439202, "alert", nil, playerList)
	end
end

function mod:BottomsUppercut(args)
	self:Message(args.spellId, "purple")
	self:CDBar(args.spellId, 47.3)
	self:PlaySound(args.spellId, "alert")
end

-- Brew Drop

do
	local prev = 0
	function mod:OozingHoneyDamage(args)
		if self:MobId(args.sourceGUID) == 219301 then -- Brew Drop, boss version
			if self:Me(args.destGUID) and args.time - prev > 2 then
				prev = args.time
				self:PersonalMessage(440087, "underyou")
				self:PlaySound(440087, "underyou")
			end
		end
	end
end
