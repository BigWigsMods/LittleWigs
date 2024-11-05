--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Unforgiven", 329, 450)
if not mod then return end
mod:RegisterEnableMob(10516) -- The Unforgiven
mod:SetEncounterID(472)
--mod:SetRespawnTime(0) resets, doesn't respawn

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		122832, -- Unrelenting Anguish
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "UnrelentingAnguish", 122832)
	self:Log("SPELL_AURA_APPLIED", "UnrelentingAnguishApplied", 122832)
	if self:Heroic() then -- no encounter events in Timewalking
		self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
		self:Death("Win", 10516)
	end
end

function mod:OnEngage()
	self:CDBar(122832, 3.8) -- Unrelenting Anguish
end

--------------------------------------------------------------------------------
-- Classic Initialization
--

if mod:Classic() then
	function mod:GetOptions()
		return {
			14907, -- Frost Nova
		}
	end

	function mod:OnBossEnable()
		self:Log("SPELL_CAST_SUCCESS", "FrostNova", 14907)
	end

	function mod:OnEngage()
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UnrelentingAnguish(args)
	self:CDBar(args.spellId, 8.5)
end

function mod:UnrelentingAnguishApplied(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
end

--------------------------------------------------------------------------------
-- Classic Event Handlers
--

function mod:FrostNova(args)
	if self:MobId(args.sourceGUID) == 10516 then -- The Unforgiven
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "alert")
	end
end
