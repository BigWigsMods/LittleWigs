--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Immol'thar", 429, 409)
if not mod then return end
mod:RegisterEnableMob(11496) -- Immol'thar
mod:SetEncounterID(349)
--mod:SetRespawnTime(0) resets, doesn't respawn

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		451127, -- Eyes of Immol'thar
		{452516, "HEALER"}, -- Trample
		22950, -- Portal of Immol'thar
	}
end

function mod:OnBossEnable()
	if self:Retail() then
		self:Log("SPELL_CAST_SUCCESS", "EyesOfImmolthar", 451127)
		self:Log("SPELL_CAST_SUCCESS", "Trample", 452516)
	else -- Classic
		self:Log("SPELL_CAST_SUCCESS", "EyesOfImmolthar", 22899) -- Eye of Immolthar
		self:Log("SPELL_CAST_SUCCESS", "Trample", 5568)
	end
	self:Log("SPELL_CAST_SUCCESS", "PortalOfImmolthar", 22950)
	if self:Heroic() or (self:Classic() and not self:Vanilla()) then -- no encounter events in Timewalking or Cataclysm Classic
		self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
		self:Death("Win", 11496)
	end
end

function mod:OnEngage()
	self:CDBar(451127, 6.1) -- Eyes of Immol'thar
	self:CDBar(452516, 7.0) -- Trample
	self:CDBar(22950, 13.7) -- Portal of Immol'thar
end

--------------------------------------------------------------------------------
-- Classic Initialization
--

if mod:Classic() then
	function mod:GetOptions()
		return {
			22899, -- Eye of Immol'thar
			{5568, "HEALER"}, -- Trample
			22950, -- Portal of Immol'thar
		}
	end

	function mod:OnEngage()
		self:CDBar(5568, 6.5) -- Trample
		self:CDBar(22899, 11.3) -- Eye of Immol'thar
		self:CDBar(22950, 12.9) -- Portal of Immol'thar
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:EyesOfImmolthar(args) -- Eye of Immol'thar on Classic
	self:Message(args.spellId, "cyan")
	if self:Retail() then
		self:CDBar(args.spellId, 20.7)
	else -- Classic
		self:CDBar(args.spellId, 9.7)
	end
	self:PlaySound(args.spellId, "info")
end

function mod:Trample(args)
	-- also cast by trash
	if self:MobId(args.sourceGUID) == 11496 then -- Immol'thar
		self:Message(args.spellId, "orange")
		self:CDBar(args.spellId, 7.3)
	end
end

function mod:PortalOfImmolthar(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:CDBar(args.spellId, 12.1)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
end
