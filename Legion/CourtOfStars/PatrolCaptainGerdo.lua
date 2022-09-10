--TO DO
--Timers for ArcaneLockdown and SignalBeacon

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Patrol Captain Gerdo", 1571, 1718)
if not mod then return end
mod:RegisterEnableMob(104215)
mod.engageId = 1868

--------------------------------------------------------------------------------
-- Initialization
--
local slashCount = 0

function mod:GetOptions()
	return {
		207261, -- Resonant Slash
		219488, -- Streetsweeper
		207278, -- Arcane Lockdown
		207806, -- Signal Beacon
		207815, -- Flask of the Solemn Night
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ResonantSlash", 207261)
	self:Log("SPELL_CAST_SUCCESS", "Streetsweeper", 219488)
	self:Log("SPELL_CAST_START", "ArcaneLockdown", 207278)
	self:Log("SPELL_CAST_START", "SignalBeacon", 207806)
	self:Log("SPELL_CAST_START", "FlaskoftheSolemnNight", 207815)
end

function mod:OnEngage()
	slashCount = 0
	self:CDBar(219488, 11) -- Streetsweeper
	self:CDBar(207261, 7) -- Resonant Slash
	self:CDBar(207278, 15.5) -- Arcane Lockdown
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ResonantSlash(args)
	self:MessageOld(args.spellId, "orange", "alarm")
	self:Bar(args.spellId, slashCount % 2 == 0 and 16 or 12)
	slashCount = slashCount + 1
end

function mod:Streetsweeper(args)
	self:MessageOld(args.spellId, "red", "info")
	self:CDBar(args.spellId, 7)
end

function mod:ArcaneLockdown(args)
	self:MessageOld(args.spellId, "yellow", "long", CL.incoming:format(args.spellName))
	self:CDBar(args.spellId, 28)
end

function mod:SignalBeacon(args)
	self:MessageOld(args.spellId, "yellow", "alert")
end

function mod:FlaskoftheSolemnNight(args)
	self:MessageOld(args.spellId, "yellow", "info")
end
