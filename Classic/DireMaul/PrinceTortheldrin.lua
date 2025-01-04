--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Prince Tortheldrin", 429, 410)
if not mod then return end
mod:RegisterEnableMob(11486) -- Prince Tortheldrin
mod:SetEncounterID(361)
--mod:SetRespawnTime(0) resets, doesn't respawn

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		22995, -- Summon
		67037, -- Whirling Strike
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Summon", 22995)
	if self:Retail() then
		self:Log("SPELL_CAST_START", "WhirlingStrike", 67037)
	end
	if self:Heroic() or (self:Classic() and not self:Vanilla()) then -- no encounter events in Timewalking or Cataclysm Classic
		self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
		self:Death("Win", 11486)
	end
end

function mod:OnEngage()
	-- Summon is cast immediately on pull
	self:CDBar(67037, 6.1) -- Whirling Strike
end

--------------------------------------------------------------------------------
-- Classic Initialization
--

if mod:Classic() then
	function mod:GetOptions()
		return {
			22995, -- Summon
		}
	end

	function mod:OnEngage()
		-- Summon is cast immediately on pull
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Summon(args)
	self:TargetMessage(args.spellId, "cyan", args.destName)
	self:CDBar(args.spellId, 10.9)
	self:PlaySound(args.spellId, "info", nil, args.destName)
end

function mod:WhirlingStrike(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 9.7)
	self:PlaySound(args.spellId, "alarm")
end
