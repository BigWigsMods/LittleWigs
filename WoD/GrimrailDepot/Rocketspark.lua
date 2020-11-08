
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Rocketspark and Borka", 1208, 1138)
if not mod then return end
mod:RegisterEnableMob(77816, 77803) -- Borka, Rocketspark
mod.engageId = 1715
mod.respawnTime = 8

--------------------------------------------------------------------------------
-- Locals
--

local deathCount = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.enrage = "Enrage"
	L.enrage_desc = "When Rocketspark or Borka is killed, the other will enrage."
	L.enrage_icon = 26662
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		161090, -- Mad Dash
		162617, -- Slam
		"enrage",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "MadDash", 161090)
	self:Log("SPELL_CAST_START", "Slam", 161087, 162617)

	self:Death("Deaths", 77816, 77803) -- Borka, Rocketspark
end

function mod:OnEngage()
	deathCount = 0
	self:CDBar(161090, 29.5) -- Mad Dash
	self:CDBar(162617, 6.5) -- Slam
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:MadDash(args)
	self:MessageOld(args.spellId, "red", "warning")
	self:CDBar(args.spellId, 43)
	self:Bar(args.spellId, 3, CL.cast:format(args.spellName))
end

function mod:Slam(args)
	self:MessageOld(162617, "orange", not self:Normal() and "alert", CL.incoming:format(args.spellName))
	if not self:Normal() then
		self:CDBar(162617, 16) -- 16-19, will delay to ~24 if just about to expire after Mad Dash
	end
end

function mod:Deaths(args)
	deathCount = deathCount + 1
	if deathCount < 2 then
		if args.mobId == 77816 then -- Borka
			self:StopBar(161090) -- Mad Dash
			self:StopBar(162617) -- Slam
			self:MessageOld("enrage", "yellow", "info", CL.other:format(self:SpellName(26662), self:SpellName(-9430)), 26662) -- Enrage: Railmaster Rocketspark
		else -- Rocketspark
			self:MessageOld("enrage", "yellow", "info", CL.other:format(self:SpellName(26662), self:SpellName(-9433)), 26662) -- Enrage: Borka the Brute
		end
	end
end
