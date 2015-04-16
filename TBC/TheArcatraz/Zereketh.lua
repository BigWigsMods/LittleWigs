
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Zereketh the Unbound", 731, 548)
if not mod then return end
mod:RegisterEnableMob(20870)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		39005, -- Shadow Nova
		36119, -- Void Zone
		{36123, "PROXIMITY", "ICON"}, -- Seed of Corruption
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ShadowNova", 36127, 39005)
	self:Log("SPELL_CAST_SUCCESS", "VoidZone", 36119)
	self:Log("SPELL_AURA_APPLIED", "SeedOfCorruption", 36123, 39367)
	self:Log("SPELL_AURA_REMOVED", "SeedOfCorruptionRemoved", 36123, 39367)

	self:Death("Win", 20870)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ShadowNova()
	self:Message(39005, "Important")
end

function mod:VoidZone()
	self:Message(36119, "Attention")
end

function mod:SeedOfCorruption(args)
	self:TargetMessage(36123, args.destName, "Urgent")
	self:TargetBar(36123, 18, args.destName)
	self:PrimaryIcon(36123, args.destName)
	if self:Me(args.destGUID) then
		self:OpenProximity(36123, 10)
	end
end

function mod:SeedOfCorruptionRemoved(args)
	self:StopBar(args.spellName, args.destName)
	self:PrimaryIcon(36123)
	if self:Me(args.destGUID) then
		self:CloseProximity(36123)
	end
end

