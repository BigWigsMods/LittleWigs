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
		162407, -- X21-01A Missile Barrage
		163947, -- Recovering
		162171, -- Better Position
		162500, -- VX18-B Target Eliminator
		161091, -- New Plan!
		161090, -- Mad Dash
		162617, -- Slam
		161092, -- Unmanaged Aggression
	}, {
		[162407] = -9430, -- Railmaster Rocketspark
		[161090] = -9433, -- Borka the Brute
	}
end

function mod:OnBossEnable()
	-- Railmaster Rocketspark
	self:Log("SPELL_CAST_START", "X2101AMissileBarrage", 162407)
	self:Log("SPELL_AURA_APPLIED", "RecoveringApplied", 163947)
	self:Log("SPELL_CAST_START", "BetterPosition", 162171)
	self:Log("SPELL_AURA_APPLIED", "AcquiringTargets", 162507) -- Acquiring Targets debuff precedes VX18-B Target Eliminator
	self:Log("SPELL_CAST_START", "NewPlan", 161091) -- TODO replace the deaths enrage thing with this? (and one more on borka)

	-- Borka the Brute
	self:Log("SPELL_CAST_START", "MadDash", 161090)
	self:Log("SPELL_CAST_START", "Slam", 161087, 162617)
	self:Log("SPELL_CAST_START", "UnmanagedAggression", 161092) -- TODO untested

	self:Death("Deaths", 77816, 77803) -- Borka, Rocketspark
end

function mod:OnEngage()
	deathCount = 0
	self:CDBar(161090, 29.5) -- Mad Dash
	self:CDBar(162617, 6.5) -- Slam
	-- TODO initial timers for Rocketspark abilities
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Railmaster Rocketspark

function mod:X2101AMissileBarrage(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "long")
	self:Bar(args.spellId, 41.2)
end

do
	local firstBetterPosition = true
	local firstAcquiringTargets = true

	function mod:RecoveringApplied(args)
		self:Message(args.spellId, "green")
		self:PlaySound(args.spellId, "info")
		self:Bar(args.spellId, 8)
		self:Bar(162171, 8) -- Better Position
		self:Bar(162500, 12) -- VX18-B Target Eliminator
		firstBetterPosition = true
		firstAcquiringTargets = true
	end

	function mod:BetterPosition(args)
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "alert")
		if firstBetterPosition then
			self:Bar(args.spellId, 9)
			firstBetterPosition = false
		end
	end

	function mod:AcquiringTargets(args)
		-- this player will soon be targeted by a VX18-B Target Eliminator
		local onMe = self:Me(args.destGUID)
		self:TargetMessage(162500, "red", args.destName)
		self:PlaySound(162500, onMe and "warning" or "alert", nil, args.destName)
		if firstAcquiringTargets then
			self:Bar(162500, 9)
			firstAcquiringTargets = false
		end
	end
end

function mod:NewPlan(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
end

-- Borka the Brute

function mod:MadDash(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	self:CDBar(args.spellId, 41.2)
	self:Bar(args.spellId, 3, CL.cast:format(args.spellName))
end

function mod:Slam(args)
	self:Message(162617, "orange", CL.incoming:format(args.spellName))
	if not self:Normal() then
		self:PlaySound(162617, "alert")
		self:CDBar(162617, 15.8) -- 16-19, will delay to ~24 if just about to expire after Mad Dash
	end
end

function mod:UnmanagedAggression(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
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
			self:StopBar(162407) -- X21-01A Missile Barrage
			self:StopBar(163947) -- Recovering
			self:StopBar(162171) -- Better Position
			self:StopBar(162500) -- VX18-B Target Eliminator
			self:Message("enrage", "yellow", CL.other:format(self:SpellName(26662), self:SpellName(-9430)), 26662) -- Enrage: Borka the Brute
			self:PlaySound("enrage", "info")
		end
	end
end
