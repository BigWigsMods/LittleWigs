-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Infinite Corruptor", 595)
if not mod then return end
mod:RegisterEnableMob(32273)
-- mod.engageId = 0 -- doesn't fire ENCOUNTER_* events, IEEU, doesn't even exist in the dungeon journal

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.name = "Infinite Corruptor"
end

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		60588, -- Corrupting Blight
	}
end

function mod:OnRegister()
	self.displayName = L.name
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "CorruptingBlight", 60588)
	self:Log("SPELL_AURA_REMOVED", "CorruptingBlightRemoved", 60588)
	self:Death("Win", 32273)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:CorruptingBlight(args)
	self:TargetMessageOld(args.spellId, args.destName, "red")
	self:TargetBar(args.spellId, 120, args.destName)
end

function mod:CorruptingBlightRemoved(args)
	self:StopBar(args.spellName, args.destName)
end
