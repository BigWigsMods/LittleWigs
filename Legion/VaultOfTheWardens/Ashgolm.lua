
--------------------------------------------------------------------------------
-- TODO List:
-- - Check timers

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ashgolm", 1493, 1468)
if not mod then return end
mod:RegisterEnableMob(95886)
mod.engageId = 1816

--------------------------------------------------------------------------------
-- Locals
--

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		192522, -- Fissure
		192520, -- Volcano
		192517, -- Brittle
		192519, -- Lava
		-12727, -- Countermeasures
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_EMOTE")
	self:Log("SPELL_CAST_START", "Fissure", 192522)
	self:Log("SPELL_CREATE", "Volcano", 192520)
	self:Log("SPELL_AURA_APPLIED", "Brittle", 192517)
	self:Log("SPELL_AURA_APPLIED", "Lava", 192519)
end

function mod:OnEngage()
	self:CDBar(-12727, 6.8, nil, "ability_monk_counteractmagic") -- Countermeasures
	self:CDBar(192520, 10) -- Volcano inc
end

--------------------------------------------------------------------------------
-- Event Handlers
--
function mod:CHAT_MSG_MONSTER_EMOTE(_, _, sender)
	if sender == self:SpellName(-12727) then -- Countermeasures
		self:MessageOld(-12727, "green", "info", self:SpellName(-12727), false)
	end
end

function mod:Fissure(args)
	self:MessageOld(args.spellId, "yellow", "alarm")
	self:Bar(args.spellId, 42)
end

function mod:Volcano(args)
	self:MessageOld(args.spellId, "red", "long")
	self:Bar(args.spellId, 20)
end

function mod:Brittle(args)
	self:MessageOld(args.spellId, "green", "info")
	self:Bar(args.spellId, 20)
	local remainingVolcano = self:BarTimeLeft(192520)
	if remainingVolcano > 0 then
		self:Bar(192520, remainingVolcano+20) -- estimated
	end
	if self:MythicPlus() then
		self:CDBar(-12727, 66, nil, "ability_monk_counteractmagic") -- Countermeasures
	end
end

function mod:Lava(args)
	if self:Me(args.destGUID) then
		self:MessageOld(args.spellId, "blue", "alert", CL.underyou:format(args.spellName))
	end
end
