--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Patrol Captain Gerdo", 1571, 1718)
if not mod then return end
mod:RegisterEnableMob(104215)
mod:SetEncounterID(1868)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local slashCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

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
	self:Log("SPELL_CAST_START", "FlaskOfTheSolemnNight", 207815)
end

function mod:OnEngage()
	slashCount = 0
	self:CDBar(219488, 11) -- Streetsweeper
	self:CDBar(207261, 6.1) -- Resonant Slash
	self:CDBar(207278, 14.6) -- Arcane Lockdown
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ResonantSlash(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, slashCount % 2 == 0 and 15.8 or 12.1)
	slashCount = slashCount + 1
end

function mod:Streetsweeper(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 6.1)
end

function mod:ArcaneLockdown(args)
	self:Message(args.spellId, "yellow", CL.incoming:format(args.spellName))
	self:PlaySound(args.spellId, "long")
	self:Bar(args.spellId, 27.9)
end

function mod:SignalBeacon(args)
	self:Message(args.spellId, "yellow", CL.percent:format(75, args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:FlaskOfTheSolemnNight(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
end
