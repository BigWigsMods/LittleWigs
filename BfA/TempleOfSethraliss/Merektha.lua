
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Merektha", 1877, 2143)
if not mod then return end
mod:RegisterEnableMob(133384, 134487) -- Creature and Vehicle
mod.engageId = 2125
mod.respawnTime = 20

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		263912, -- Noxious Breath
		263927, -- Toxic Pool
		{263914, "CASTBAR"}, -- Blinding Sand
		264239, -- Hatch
		264206, -- Burrow
		{263958, "SAY", "ICON"}, -- A Knot of Snakes
	}, {
		[263912] = "general",
		[263958] = "heroic",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "NoxiousBreath", 263912)
	self:Log("SPELL_AURA_APPLIED", "ToxicPool", 263927)
	self:Log("SPELL_PERIODIC_DAMAGE", "ToxicPool", 263927)
	self:Log("SPELL_PERIODIC_MISSED", "ToxicPool", 263927)
	self:Log("SPELL_CAST_START", "BlindingSand", 263914)
	self:Log("SPELL_CAST_START", "Hatch", 264239, 264233) -- different sides
	self:Log("SPELL_AURA_APPLIED", "AKnotOfSnakes", 263958)
	self:Log("SPELL_AURA_REMOVED", "AKnotOfSnakesRemoved", 263958)

	self:RegisterUnitEvent("UNIT_TARGETABLE_CHANGED", nil, "boss1")
end

function mod:OnEngage()
	self:Bar(263912, 6) -- Noxious Breath
	self:Bar(263958, 12) -- A Knot of Snakes
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:NoxiousBreath(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 9)
end

do
	local prev = 0
	function mod:ToxicPool(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t-prev > 2 then
				prev = t
				self:PersonalMessage(args.spellId, "underyou")
				self:PlaySound(args.spellId, "alarm")
			end
		end
	end
end

function mod:BlindingSand(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
	self:CastBar(args.spellId, 2.5)
end

do
	local prev = 0
	function mod:Hatch(args)
		local t = args.time
		if t-prev > 2 then
			prev = t
			self:Bar(264239, 35)
		end
	end
end

function mod:UNIT_TARGETABLE_CHANGED(_, unit)
	-- Burrow
	if UnitCanAttack("player", unit) then
		self:Message(264206, "green", CL.over:format(self:SpellName(264206))) -- Burrow
		self:PlaySound(264206, "info") -- Burrow
		self:CDBar(263914, 6) -- Blinding Sand
		self:CDBar(263958, 8) -- A Knot of Snakes
	else
		self:Message(264206, "cyan") -- Burrow
		self:PlaySound(264206, "long") -- Burrow
		self:Bar(264206, 29) -- Burrow
		self:StopBar(264239) -- Hatch
		self:StopBar(263912) -- Noxious Breath
	end
end

function mod:AKnotOfSnakes(args)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "A Knot of Snakes")
	end
	self:TargetMessage(args.spellId, "red", args.destName)
	self:PlaySound(args.spellId, "warning", nil, args.destName)
	self:TargetBar(args.spellId, 15, args.destName)
	self:PrimaryIcon(args.spellId, args.destName)
end

function mod:AKnotOfSnakesRemoved(args)
	self:PrimaryIcon(args.spellId)
	self:StopBar(args.spellName, args.destName)
end
