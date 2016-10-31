--TO DO
--Timers for ArcaneLockdown and SignalBeacon

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Patrol Captain Gerdo", 1087, 1718)
if not mod then return end
mod:RegisterEnableMob(104215)
mod.engageId = 1868

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
	self:Log("SPELL_CAST_START", "FlaskoftheSolemnNight", 207815)
end

function mod:OnEngage()
	self:CDBar(219488, 12) -- Streetsweeper
	self:CDBar(207261, 6) -- Resonant Slash
	self:CDBar(207278, 27) -- Arcane Lockdown
	self:CDBar(207806, 14) -- Signal Beacon

end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ResonantSlash(args)
	self:Message(args.spellId, "Urgent", "Alarm")
	self:CDBar(args.spellId, 12)
end

function mod:Streetsweeper(args)
	self:Message(args.spellId, "Important", "Info")
	self:CDBar(args.spellId, 8)
end

function mod:ArcaneLockdown(args)
	self:Message(args.spellId, "Attention", "Long", CL.incoming:format(args.spellName))
	--self:CDBar(args.spellId, ??)
end

function mod:SignalBeacon(args)
	self:Message(args.spellId, "Attention", "Alert")
	--self:CDBar(args.spellId, ??)
end

function mod:FlaskoftheSolemnNight(args)
	self:Message(args.spellId, "Attention", "Info")
end
