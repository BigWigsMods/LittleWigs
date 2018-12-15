
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Merektha", 1877, 2143)
if not mod then return end
mod:RegisterEnableMob(133384, 134487) -- Creature and Vehicle
mod.engageId = 2125
mod.respawnTime = 21

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		263912, -- Noxious Breath
		263927, -- Toxic Pool
		263914, -- Blinding Sand
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
	-- self:Log("SPELL_CAST_SUCCESS", "Burrow", 264194)
	self:Log("SPELL_AURA_APPLIED", "KnotOfSnakes", 263958)
	self:Log("SPELL_AURA_REMOVED", "KnotOfSnakesRemoved", 263958)

	self:RegisterUnitEvent("UNIT_TARGETABLE_CHANGED", nil, "boss1")
end

function mod:OnEngage()
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:NoxiousBreath(args)
	self:Message2(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 83)
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
	self:Message2(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
	self:CastBar(args.spellId, 2.5)
end

do
	local prev = 0
	function mod:Hatch(args)
		local t = args.time
		if t-prev > 2 then
			prev = t
			self:Message2(264239, "orange")
			self:PlaySound(264239, "alarm")
			self:CDBar(264239, 40)
		end
	end
end

function mod:UNIT_TARGETABLE_CHANGED(_, unit)
	-- Burrow
	if UnitCanAttack("player", unit) then
		self:Message2(264206, "green", CL.over:format(self:SpellName(264206)))
		self:PlaySound(264206, "info")
	else
		self:Message2(264206, "cyan")
		self:PlaySound(264206, "long")
		self:Bar(264206, 28)
	end
end

function mod:KnotOfSnakes(args)
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
	end
	self:TargetMessage2(args.spellId, "red", args.destName)
	self:PlaySound(args.spellId, "warning", nil, args.destName)
	self:TargetBar(args.spellId, 15, args.destName)
	self:PrimaryIcon(args.spellId, args.destName)
end

function mod:KnotOfSnakesRemoved(args)
	self:PrimaryIcon(args.spellId)
	self:StopBar(args.spellName, args.destName)
end
