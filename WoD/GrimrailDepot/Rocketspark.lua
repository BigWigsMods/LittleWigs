--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Rocketspark and Borka", 1208, 1138)
if not mod then return end
mod:RegisterEnableMob(
	77803, -- Railmaster Rocketspark
	77816  -- Borka the Brute
)
mod:SetEncounterID(1715)
mod:SetRespawnTime(8)

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
		"enrage",
		161091, -- New Plan!
		161090, -- Mad Dash
		162617, -- Slam
	}, {
		[161091] = -9430, -- Railmaster Rocketspark
		[161090] = -9433, -- Borka the Brute
	}
end

function mod:OnBossEnable()
	-- Railmaster Rocketspark
	self:Log("SPELL_CAST_START", "NewPlan", 161091) -- TODO replace the deaths enrage thing with this? (and one more on borka)
	-- TODO missile barrage (interrupt this with mad dash)
	-- TODO recovering 163947 debuff extra damage phase - also alert for removed?
	-- TODO acquiring targets debuff, alert that player to move for the targeted rocket blast thing

	-- Borka the Brute
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

-- Railmaster Rocketspark

function mod:NewPlan(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
end

-- Borka the Brute

function mod:MadDash(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	self:CDBar(args.spellId, 43)
	self:Bar(args.spellId, 3, CL.cast:format(args.spellName))
end

function mod:Slam(args)
	self:Message(162617, "orange", CL.incoming:format(args.spellName))
	if not self:Normal() then
		self:PlaySound(162617, "alert")
		self:CDBar(162617, 16) -- 16-19, will delay to ~24 if just about to expire after Mad Dash
	end
end

-- Enrage

function mod:Deaths(args)
	deathCount = deathCount + 1
	if deathCount < 2 then
		if args.mobId == 77816 then -- Borka
			self:StopBar(161090) -- Mad Dash
			self:StopBar(162617) -- Slam
			self:Message("enrage", "yellow", CL.other:format(self:SpellName(26662), self:SpellName(-9430)), 26662) -- Enrage: Railmaster Rocketspark
			self:PlaySound("enrage", "info")
		else -- Rocketspark
			self:Message("enrage", "yellow", CL.other:format(self:SpellName(26662), self:SpellName(-9430)), 26662) -- Enrage: Borka the Brute
			self:PlaySound("enrage", "info")
		end
	end
end
