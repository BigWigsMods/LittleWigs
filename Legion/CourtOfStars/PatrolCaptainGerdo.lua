--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Patrol Captain Gerdo", 1571, 1718)
if not mod then return end
mod:RegisterEnableMob(104215) -- Patrol Captain Gerdo
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
		215204, -- Hinder
	}, {
		[207261] = self.displayName, -- Patrol Captain Gerdo
		[215204] = -13070, -- Vigilant Duskwatch
	}
end

function mod:OnBossEnable()
	-- Patrol Captain Gerdo
	self:Log("SPELL_CAST_START", "ResonantSlash", 207261)
	self:Log("SPELL_CAST_SUCCESS", "Streetsweeper", 219488)
	self:Log("SPELL_CAST_SUCCESS", "ArcaneLockdown", 207278)
	self:Log("SPELL_CAST_START", "SignalBeacon", 207806)
	self:Log("SPELL_CAST_START", "FlaskOfTheSolemnNight", 207815)

	-- Vigilant Duskwatch
	self:Log("SPELL_CAST_START", "Hinder", 215204)
	self:Log("SPELL_AURA_APPLIED", "HinderApplied", 215204)
end

function mod:OnEngage()
	slashCount = 0
	self:CDBar(219488, 11) -- Streetsweeper
	self:CDBar(207261, 6.1) -- Resonant Slash
	self:CDBar(207278, 16.6) -- Arcane Lockdown
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Patrol Captain Gerdo

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
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:Bar(args.spellId, 27.9)
end

function mod:SignalBeacon(args)
	self:Message(args.spellId, "yellow", CL.percent:format(75, args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:FlaskOfTheSolemnNight(args)
	self:Message(args.spellId, "cyan", CL.percent:format(25, args.spellName))
	self:PlaySound(args.spellId, "info")
end

-- Vigilant Duskwatch

do
	local prev = 0
	function mod:Hinder(args)
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "warning")
		end
	end
end

function mod:HinderApplied(args)
	if self:Dispeller("magic") or self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, "red", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end
