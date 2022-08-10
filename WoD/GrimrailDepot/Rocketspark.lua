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

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
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
	self:Log("SPELL_CAST_START", "VX18BTargetEliminator", 162500)
	self:Log("SPELL_AURA_APPLIED", "NewPlan", 161091)

	-- Borka the Brute
	self:Log("SPELL_CAST_START", "MadDash", 161090)
	self:Log("SPELL_CAST_START", "Slam", 161087, 162617)
	self:Log("SPELL_AURA_APPLIED", "UnmanagedAggression", 161092)
end

function mod:OnEngage()
	borkaDefeated = false
	self:CDBar(161090, 28) -- Mad Dash
	self:CDBar(162617, 7) -- Slam
	self:Bar(162500, 3) -- VX18-B Target Eliminator
	self:Bar(162407, 19) -- X21-01A Missile Barrage
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Railmaster Rocketspark

function mod:X2101AMissileBarrage(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "long")
	self:Bar(args.spellId, 40.4)
end

do
	local firstBetterPosition = true
	local firstVX18BTargetEliminator = true

	function mod:RecoveringApplied(args)
		self:Message(args.spellId, "green")
		self:PlaySound(args.spellId, "info")
		self:Bar(args.spellId, 8)
		self:Bar(162171, 8) -- Better Position
		self:Bar(162500, 12) -- VX18-B Target Eliminator
		firstBetterPosition = true
		firstVX18BTargetEliminator = true
	end

	function mod:BetterPosition(args)
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "alert")
		if borkaDefeated then
			self:Bar(args.spellId, 13.4)
		elseif firstBetterPosition then
			self:Bar(args.spellId, 9)
			firstBetterPosition = false
		end
	end

	function mod:VX18BTargetEliminator(args)
		self:Message(args.spellId, "red")
		self:PlaySound(args.spellId, "alarm")
		if firstVX18BTargetEliminator then
			self:Bar(args.spellId, 7.5)
			firstVX18BTargetEliminator = false
		end
	end
end

function mod:NewPlan(args)
	borkaDefeated = true
	self:StopBar(161090) -- Mad Dash
	self:StopBar(CL.cast:format(args.spellName)) -- Casting: Mad Dash
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
	self:StopBar(161090) -- Mad Dash
	self:StopBar(162407) -- X21-01A Missile Barrage
	self:StopBar(163947) -- Recovering
	self:StopBar(162171) -- Better Position
	self:StopBar(162500) -- VX18-B Target Eliminator
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
end
