
-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Baron Silverlaine", 33, 97)
if not mod then return end
mod:RegisterEnableMob(3887)
mod.engageId = 1070
mod.respawnTime = 30

-------------------------------------------------------------------------------
--  Locals
--

local nextWorgenSpiritWarning = 75

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		93857, --Summon Worgen Spirit
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "WorgenSpirit", 93857)
	self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1")
end

function mod:OnEngage()
	nextWorgenSpiritWarning = self:Normal() and 75 or 95 -- normal: 70% and 35%; heroic: 90, 60% and 30%
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:WorgenSpirit(args)
	self:MessageOld(args.spellId, "red")
end

function mod:UNIT_HEALTH(event, unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < nextWorgenSpiritWarning then
		self:MessageOld(93857, "yellow", nil, CL.soon:format(self:SpellName(93857)), false)
		if self:Normal() then
			nextWorgenSpiritWarning = nextWorgenSpiritWarning - 35
		else
			nextWorgenSpiritWarning = nextWorgenSpiritWarning - 30
		end
		if nextWorgenSpiritWarning < 30 then
			self:UnregisterUnitEvent(event, unit)
		end
	end
end
