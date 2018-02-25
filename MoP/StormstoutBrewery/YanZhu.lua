
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Yan-Zhu the Uncasked", 876, 670)
if not mod then return end
mod:RegisterEnableMob(59479)
mod.engageId = 1414
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Locals
--

local nextBubbleShield = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{114548, "TANK"}, -- Brew Bolt
		{106546, "SAY"}, -- Bloat
		106851, -- Blackout Brew
		106563, -- Bubble Shield
		114451, -- Ferment
		115003, -- Carbonation
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "BrewBolt", 114548)
	self:Log("SPELL_AURA_APPLIED_DOSE", "BrewBolt", 114548)
	self:Log("SPELL_CAST_SUCCESS", "Bloat", 106546) -- the debuff has travel time, so this is more reliable for CDBars
	self:Log("SPELL_AURA_APPLIED", "BloatApplied", 106546)
	self:Log("SPELL_AURA_REMOVED", "BloatRemoved", 106546)
	self:Log("SPELL_CAST_SUCCESS", "BlackoutBrew", 106851) -- the debuff has travel time, so this is more reliable for CDBars
	self:Log("SPELL_AURA_APPLIED", "BlackoutBrewApplied", 106851)
	self:Log("SPELL_AURA_APPLIED_DOSE", "BlackoutBrewApplied", 106851)
	self:Log("SPELL_HEAL", "Ferment", 114451)
	self:Log("SPELL_AURA_APPLIED", "BubbleShield", 106563)
	self:Log("SPELL_AURA_REMOVED", "BubbleShieldRemoved", 106563)
	self:Log("SPELL_CAST_START", "Carbonation", 115003)
end

function mod:OnEngage()
	-- There are 3 pairs of abilities
	-- Yan-Zhu can have only one from each pair
	if UnitBuff("boss1", self:SpellName(114929)) then -- Bloating Brew (Can use Bloat)
		self:CDBar(106546, 7.2)
	elseif UnitBuff("boss1", self:SpellName(114930)) then -- Blackout Brew (Can use Blackout Brew)
		self:CDBar(106851, 6.8)
	end

	if UnitBuff("boss1", self:SpellName(114931)) then -- Bubbling Brew (Can use Bubble Shield)
		self:CDBar(106563, 22.3)
	--[[elseif UnitDebuff("boss1", self:SpellName(114932)) then -- Yeasty Brew (Can summon Yeasty Brew Alementals)
		self:CDBar(0, 0)]] -- no SPELL_SUMMON events
	end

	if UnitBuff("boss1", self:SpellName(114934)) then -- Fizzy Brew (Can use Carbonation)
		self:CDBar(115003, 46)
	--[[elseif UnitBuff("boss1", self:SpellName(114933)) then -- Sudsy Brew (Can use Walls of Suds)
		self:CDBar(114466, 0)]] -- no SPELL_CAST_ and USCS events
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:BrewBolt(args)
	local amount = args.amount or 1
	if amount % 2 == 1 then
		self:StackMessage(args.spellId, args.destName, amount, "Important", "Alert") -- casts when there's nobody nearby
	end
end

function mod:Bloat(args)
	self:CDBar(args.spellId, 32.5)
end

function mod:BloatApplied(args)
	self:TargetMessage(args.spellId, args.destName, "Attention", "Alarm", nil, nil, true)
	self:TargetBar(args.spellId, 30, args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
	end
end

function mod:BloatRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:BlackoutBrew(args)
	self:CDBar(args.spellId, 9.7)
end

function mod:BlackoutBrewApplied(args)
	local amount = args.amount or 3 -- 1 event for every 3 stacks
	if self:Me(args.destGUID) then
		self:StackMessage(args.spellId, args.destName, amount, "Attention", amount > 6 and "Warning" or "Alarm")
	end
end

do
	local prev = 0
	function mod:Ferment(args)
		if self:MobId(args.destGUID) == 59479 then -- players can be healed by this if they intercept the beams
			local t = GetTime()
			if t-prev > 2 then
				prev = t
				self:Message(args.spellId, "Urgent", not UnitDebuff("player", args.spellName) and "Warning", CL.onboss:format(args.spellName)) -- don't annoy with sounds those who are already intercepting some
			end
		end
	end
end

function mod:BubbleShield(args)
	nextBubbleShield = GetTime() + 43
	self:Message(args.spellId, "Urgent", "Alert", CL.onboss:format(args.spellName))
end

function mod:BubbleShieldRemoved(args)
	local remaining = nextBubbleShield - GetTime()
	self:Message(args.spellId, "Positive", "Info", CL.removed:format(args.spellName))
	self:CDBar(args.spellId, remaining > 2.5 and remaining or 2.5)
end

function mod:Carbonation(args)
	self:Message(args.spellId, "Important", "Long", CL.casting:format(args.spellName))
	self:CastBar(args.spellId, 3)
	self:CDBar(args.spellId, 63.3)
end
