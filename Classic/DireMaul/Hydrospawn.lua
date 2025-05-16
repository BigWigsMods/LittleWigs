--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Hydrospawn", 429, 403)
if not mod then return end
mod:RegisterEnableMob(13280) -- Hydrospawn
mod:SetEncounterID(344)
--mod:SetRespawnTime(0) resets, doesn't respawn

--------------------------------------------------------------------------------
-- Locals
--

local summonHydrolingCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		22419, -- Riptide
		22421, -- Massive Geyser
		22714, -- Summon Hydroling
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Riptide", 22419)
	self:Log("SPELL_CAST_START", "MassiveGeyser", 22421)
	self:Log("SPELL_CAST_SUCCESS", "SummonHydroling", 22714)
	if self:Classic() and not self:Vanilla() then -- no encounter events in Cataclysm Classic
		self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
		self:Death("Win", 13280)
	end
end

function mod:OnEngage()
	summonHydrolingCount = 1
	self:CDBar(22419, 6.9) -- Riptide
	self:CDBar(22421, 5.7) -- Massive Geyser
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Riptide(args)
	self:Message(args.spellId, "red")
	self:CDBar(args.spellId, 6.1)
	self:PlaySound(args.spellId, "alert")
end

function mod:MassiveGeyser(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 8.5)
	self:PlaySound(args.spellId, "alarm")
end

function mod:SummonHydroling(args)
	if self:Retail() then
		if summonHydrolingCount == 1 then
			self:Message(args.spellId, "cyan", CL.percent:format(66, args.spellName))
		else -- 2
			self:Message(args.spellId, "cyan", CL.percent:format(33, args.spellName))
		end
		summonHydrolingCount = summonHydrolingCount + 1
	else -- Classic
		self:Message(args.spellId, "cyan")
	end
	self:PlaySound(args.spellId, "info")
end
