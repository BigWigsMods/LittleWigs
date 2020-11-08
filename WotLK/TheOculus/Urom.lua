-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Mage-Lord Urom", 578, 624)
if not mod then return end
mod:RegisterEnableMob(27655)
mod.engageId = 2014
-- mod.respawnTime = 0 -- resets, doesn't respawn

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		51103, -- Frostbomb
		{51121, "ICON", "SAY", "SAY_COUNTDOWN"}, -- Time Bomb
		51110, -- Empowered Arcane Explosion
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "TimeBomb", 51121, 59376) -- normal, heroic
	self:Log("SPELL_AURA_REMOVED", "TimeBomb", 51121, 59376)
	self:Log("SPELL_CAST_START", "EmpoweredArcaneExplosion", 51110, 59377) -- normal, heroic


	self:Log("SPELL_AURA_APPLIED", "Frostbomb", 51103)
	self:Log("SPELL_PERIODIC_DAMAGE", "Frostbomb", 51103)
	self:Log("SPELL_PERIODIC_MISSED", "Frostbomb", 51103)
end

function mod:OnEngage()
	-- This boss is pulled 4 times throughout the dungeon,
	-- the first 3 times he starts casting a spell called "Summon Menagerie"
	-- (each time with a different spell ID) which spawns trash, then teleports away.
	-- Two issues:
	-- - He fires ENCOUNTER_START each time;
	-- - SPELL_CAST_START fires *before* ENCOUNTER_START.

	local spell = UnitCastingInfo("boss1")
	if spell == self:SpellName(50476) then -- Summon Menagerie, first 3 pulls
		self:ScheduleTimer("Reboot", 0.5) -- prevent the module from reporting a wipe
	else -- normal pull
		self:CDBar(51110, 31.5) -- Empowered Arcane Explosion
	end
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:TimeBomb(args)
	if self:Me(args.destGUID) then
		self:Say(51121)
		self:SayCountdown(51121, 6)
	end
	self:TargetMessageOld(51121, args.destName, "orange", "alert", nil, nil, self:Healer()) -- damage is based on missing health
	self:TargetBar(51121, 6, args.destName)
	self:PrimaryIcon(51121, args.destName)
end

function mod:TimeBombRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(51121)
	end
	self:StopBar(args.spellName, args.destName)
	self:PrimaryIcon(51121)
end

function mod:EmpoweredArcaneExplosion(args)
	self:MessageOld(51110, "yellow", nil, CL.casting:format(args.spellName))
	self:CastBar(51110, self:Normal() and 8 or 6, 1449) -- 1449 = Arcane Explosion, to prevent the bar's text overlapping with its timer
	self:CDBar(51110, 38.9)
end


do
	local prev = 0
	function mod:Frostbomb(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t - prev > 1.5 then
				prev = t
				self:MessageOld(args.spellId, "blue", "alert", CL.underyou:format(args.spellName))
			end
		end
	end
end
