
--------------------------------------------------------------------------------
-- TODO:
-- -- Lucky Sevens positive buff message?

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Council o' Captains", 1754, 2093)
if not mod then return end
mod:RegisterEnableMob(126847, 126848, 126845) -- Captain Raoul, Captain Eudora, Captain Jolly
mod.engageId = 2094

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.crit_brew = "Crit Brew"
	L.haste_brew = "Haste Brew"
	L.bad_brew = "Bad Brew"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		258338, -- Blackout Barrel
		256589, -- Barrel Smash
		258381, -- Grape Shot
		--[[ Tending Bar ]]--
		265088, -- Confidence-Boosting Brew (Crit)
		264608, -- Invigorating Brew (Haste)
		265168, -- Caustic Brew
	},{
		[265088] = -18476, -- Rummy Mancomb
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "BlackoutBarrel", 258338)
	self:Log("SPELL_CAST_START", "BarrelSmash", 256589)
	self:Log("SPELL_CAST_SUCCESS", "GrapeShot", 258381)

	self:Log("SPELL_CAST_SUCCESS", "CritBrew", 265088)
	self:Log("SPELL_CAST_SUCCESS", "HasteBrew", 264608)
	self:Log("SPELL_CAST_SUCCESS", "CausticBrew", 265168)
	self:Log("SPELL_AURA_APPLIED", "CausticBrewDamage", 278467)
	self:Log("SPELL_PERIODIC_DAMAGE", "CausticBrewDamage", 278467)

	self:Death("Deaths", 126847, 126848, 126845)
end

function mod:OnEngage()
	self:Bar(256589, 6) -- Barrel Smash
	self:Bar(258381, 8.5) -- Grape Shot
	self:Bar(258338, 19.4) -- Blackout Barrel
end

function mod:VerifyEnable(unit)
	return UnitCanAttack("player", unit) -- one of the captains should be friendly
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Deaths(args)
	if args.mobId == 126847 then -- Captain Raoul
		self:StopBar(258338) -- Blackout Barrel
		self:StopBar(256589) -- Barrel Smash
	elseif args.mobId == 126848 then -- Captain Eudora
		self:StopBar(258381) -- Grape Shot
	end
end

function mod:BlackoutBarrel(args)
	self:Message2(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert", "killadd")
	self:CDBar(args.spellId, 47)
end

function mod:BarrelSmash(args)
	self:Message2(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "long", "watchaoe")
	self:CastBar(args.spellId, 7) -- 3s Cast, 4s Channel
	self:CDBar(args.spellId, 23)
end

function mod:GrapeShot(args)
	self:Message2(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning", "watchstep")
	self:CDBar(args.spellId, 30.4)
end

function mod:CritBrew(args)
	self:Message2(args.spellId, "green", L.crit_brew)
	self:PlaySound(args.spellId, "info")
end

function mod:HasteBrew(args)
	self:Message2(args.spellId, "green", L.haste_brew)
	self:PlaySound(args.spellId, "info")
end

function mod:CausticBrew(args)
	self:Message2(args.spellId, "red", L.bad_brew)
	self:PlaySound(args.spellId, "alarm")
end

do
	local prev = 0
	function mod:CausticBrewDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t-prev > 2 then
				prev = t
				self:PersonalMessage(265168, "underyou", L.bad_brew)
				self:PlaySound(265168, "alarm")
			end
		end
	end
end
