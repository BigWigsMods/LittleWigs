-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Marwyn", 603, 602)
if not mod then return end
mod:RegisterEnableMob(38113)
-- Sometimes he resets and then respawns few seconds after instead of
-- respawning immediately, when that happens he doesn't fire ENCOUNTER_END
-- mod.engageId = 1993
-- mod.respawnTime = 30 -- you have to actually walk towards the altar, nothing will respawn on its own

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		"warmup",
		72363, -- Corrupted Flesh
		{72368, "ICON"}, -- Shared Suffering
		{72383, "ICON"}, -- Corrupted Touch
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "CorruptedFlesh", 72363)
	self:Log("SPELL_AURA_APPLIED", "DebuffApplied", 72368, 72383) -- Shared Suffering, Corrupted Touch
	self:Log("SPELL_AURA_REMOVED", "DebuffRemoved", 72368, 72383)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Death("Win", 38113)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:CorruptedFlesh(args)
	self:Message(args.spellId, "Urgent")
end

function mod:DebuffApplied(args)
	local time = 10
	if args.spellId == 72363 then -- Corrupted Flesh
		self:PrimaryIcon(args.spellId, args.destName)
	elseif args.spellId == 72368 then -- Shared Suffering
		time = 12
		self:SecondaryIcon(args.spellId, args.destName)
	end
	self:TargetMessage(args.spellId, args.destName, "Urgent")
	self:TargetBar(args.spellId, time, args.destName)
end

function mod:DebuffRemoved(args)
	self:StopBar(args.spellId, args.destName)
	if args.spellId == 72363 then -- Corrupted Flesh
		self:PrimaryIcon(args.spellId)
	elseif args.spellId == 72368 then -- Shared Suffering
		self:SecondaryIcon(args.spellId)
	end
end
