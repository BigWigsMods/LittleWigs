
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Zereketh the Unbound", 552, 548)
if not mod then return end
mod:RegisterEnableMob(20870)
mod.engageId = 1916
-- mod.respawnTime = 0 -- resets, doesn't respawn

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
	self:Log("SPELL_CAST_START", "ShadowNova", 36127, 39005) -- normal, heroic
	self:Log("SPELL_DAMAGE", "VoidZone", 36121, 39004) -- normal, heroic
	self:Log("SPELL_MISSED", "VoidZone", 36121, 39004)
	self:Log("SPELL_AURA_APPLIED", "SeedOfCorruption", 36123, 39367) -- normal, heroic
	self:Log("SPELL_AURA_REMOVED", "SeedOfCorruptionRemoved", 36123, 39367)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ShadowNova()
	self:MessageOld(39005, "red")
end

do
	local prev = 0
	function mod:VoidZone(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t - prev > 1.5 then
				prev = t
				self:MessageOld(36119, "blue", "alert", CL.underyou:format(self:SpellName(36119))) -- args.spellName is "Consumption"
			end
		end
	end
end

function mod:SeedOfCorruption(args)
	self:TargetMessageOld(36123, args.destName, "orange")
	self:TargetBar(36123, 18, args.destName)
	self:PrimaryIcon(36123, args.destName)
	if self:Me(args.destGUID) then
		self:OpenProximity(36123, 10)
	else
		self:OpenProximity(36123, 10, args.destName)
	end
end

function mod:SeedOfCorruptionRemoved(args)
	self:StopBar(args.spellName, args.destName)
	self:PrimaryIcon(36123)
	self:CloseProximity(36123)
end
