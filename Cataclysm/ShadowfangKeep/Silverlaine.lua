-------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Baron Silverlaine", {33, 2849}, 97)
if not mod then return end
mod:RegisterEnableMob(3887)
mod:SetEncounterID(1070)
mod:SetRespawnTime(30)

-------------------------------------------------------------------------------
-- Locals
--

local nextWorgenSpiritWarning = 75

-------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		23224, -- Veil of Shadow
		93857, -- Summon Worgen Spirit
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "VeilOfShadow", 23224)
	self:Log("SPELL_CAST_START", "SummonWorgenSpirit", 93857)

	if self:Difficulty() == 232 then -- Dastardly Duos
		-- no encounter events in Dastardly Duos
		self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
		self:Death("Win", 3887)
	else -- Normal, Heroic
		-- Summon Worgen Spirit is not cast in Dastardly Duos
		self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1") -- Summon Worgen Spirit
	end
end

function mod:OnEngage()
	nextWorgenSpiritWarning = self:Normal() and 75 or 95 -- normal: 70% and 35%; heroic: 90, 60% and 30%
end

-------------------------------------------------------------------------------
-- Event Handlers
--

function mod:VeilOfShadow(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 17.0)
	self:PlaySound(args.spellId, "alert")
end

function mod:SummonWorgenSpirit(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
end

function mod:UNIT_HEALTH(event, unit)
	local hp = self:GetHealth(unit)
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
