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

local borkaDefeated = false
local rocketsparkBelow20 = false
local firstBetterPosition = true
local firstVX18BTargetEliminator = true

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		162407, -- X21-01A Missile Barrage
		163947, -- Recovering
		162171, -- Better Position
		{162500, "CASTBAR"}, -- VX18-B Target Eliminator
		161091, -- New Plan!
		{161090, "CASTBAR"}, -- Mad Dash
		162617, -- Slam
		161092, -- Unmanaged Aggression
	}, {
		[162407] = -9430, -- Railmaster Rocketspark
		[161090] = -9433, -- Borka the Brute
	}
end

function mod:OnBossEnable()
	-- Railmaster Rocketspark
	self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1", "boss2")
	self:Log("SPELL_CAST_START", "X2101AMissileBarrage", 162407)
	self:Log("SPELL_AURA_APPLIED", "RecoveringApplied", 163947)
	self:Log("SPELL_CAST_START", "BetterPosition", 162171)
	self:Log("SPELL_CAST_START", "VX18BTargetEliminator", 162500)
	self:Log("SPELL_CAST_SUCCESS", "VX18BTargetEliminatorSuccess", 162500)
	self:Log("SPELL_AURA_APPLIED", "NewPlan", 161091)

	-- Borka the Brute
	self:Log("SPELL_CAST_START", "MadDash", 161090)
	self:Log("SPELL_CAST_START", "Slam", 161087, 162617)
	self:Log("SPELL_AURA_APPLIED", "UnmanagedAggression", 161092)
end

function mod:OnEngage()
	borkaDefeated = false
	rocketsparkBelow20 = false
	firstBetterPosition = true
	firstVX18BTargetEliminator = true
	self:Bar(161090, 28) -- Mad Dash
	self:CDBar(162617, 7) -- Slam
	self:CDBar(162500, 3) -- VX18-B Target Eliminator
	self:Bar(162407, 19) -- X21-01A Missile Barrage
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Railmaster Rocketspark

function mod:UNIT_HEALTH(event, unit)
	-- have to register both boss1 and boss2 because boss1 is whichever is aggro'd first
	if self:MobId(self:UnitGUID(unit)) == 77803 then -- Railmaster Rocketspark
		-- Rocketspark stops casting Missile Barrage below 20% HP
		if self:GetHealth(unit) < 20 then
			rocketsparkBelow20 = true
			self:StopBar(162407) -- X21-01A Missile Barrage
			self:StopBar(161090) -- Mad Dash
			self:UnregisterUnitEvent(event, unit)
		end
	else
		-- don't need to watch Borka's health
		self:UnregisterUnitEvent(event, unit)
	end
end

function mod:X2101AMissileBarrage(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "long")
end

function mod:RecoveringApplied(args)
	self:Message(args.spellId, "green")
	self:PlaySound(args.spellId, "info")
	self:Bar(args.spellId, 8)
	self:Bar(162171, 8) -- Better Position
	self:CDBar(162500, 10.9) -- VX18-B Target Eliminator
	if not rocketsparkBelow20 then
		self:CDBar(161090, 35.2) -- Mad Dash
		self:Bar(162407, 26.2) -- X21-01A Missile Barrage
	end
	firstBetterPosition = true
	firstVX18BTargetEliminator = true
end

function mod:BetterPosition(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	if borkaDefeated then
		self:Bar(args.spellId, 13.4)
	elseif rocketsparkBelow20 then
		self:Bar(args.spellId, 8.5)
	elseif firstBetterPosition then
		self:Bar(args.spellId, 9)
		firstBetterPosition = false
	end
end

function mod:VX18BTargetEliminator(args)
	self:StopBar(args.spellId)
	self:CastBar(args.spellId, 3)
end

function mod:VX18BTargetEliminatorSuccess(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	if rocketsparkBelow20 or firstVX18BTargetEliminator then
		self:CDBar(args.spellId, 5.3)
		firstVX18BTargetEliminator = false
	end
end

function mod:NewPlan(args)
	borkaDefeated = true
	self:StopBar(161090) -- Mad Dash
	self:StopBar(CL.cast:format(self:SpellName(161090))) -- Casting: Mad Dash
	self:StopBar(162617) -- Slam
	self:StopBar(162407) -- X21-01A Missile Barrage
	self:StopBar(162500) -- VX18-B Target Eliminator
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
end

-- Borka the Brute

function mod:MadDash(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	self:CastBar(args.spellId, 2.5)
end

function mod:Slam(args)
	self:Message(162617, "orange", CL.incoming:format(args.spellName))
	if not self:Normal() then
		self:PlaySound(162617, "alert")
		self:CDBar(162617, 15.8) -- 16-19, will delay to ~24 if just about to expire after Mad Dash
	end
end

function mod:UnmanagedAggression(args)
	self:StopBar(161090) -- Mad Dash
	self:StopBar(162407) -- X21-01A Missile Barrage
	self:StopBar(163947) -- Recovering
	self:StopBar(162171) -- Better Position
	self:StopBar(162500) -- VX18-B Target Eliminator
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
end
