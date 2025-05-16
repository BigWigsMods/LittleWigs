--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Magister Kalendris", 429, 408)
if not mod then return end
mod:RegisterEnableMob(11487) -- Magister Kalendris
mod:SetEncounterID(348)
--mod:SetRespawnTime(0) resets, doesn't respawn

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		22917, -- Shadowform
		7645, -- Dominate Mind
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Shadowform", 22917)
	self:Log("SPELL_CAST_SUCCESS", "DominateMind", 7645)
	if self:Classic() and not self:Vanilla() then -- no encounter events in Cataclysm Classic
		self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
		self:Death("Win", 11487)
	end
end

function mod:OnEngage()
	if not self:Solo() then
		self:CDBar(7645, 10.2) -- Dominate Mind
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Shadowform(args)
	self:Message(args.spellId, "cyan", CL.percent:format(50, args.spellName))
	self:PlaySound(args.spellId, "info")
end

function mod:DominateMind(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:CDBar(args.spellId, 19.4)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
end
