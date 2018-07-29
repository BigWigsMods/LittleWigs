
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Merektha", 1877, 2143)
if not mod then return end
mod:RegisterEnableMob(133384, 134487) -- Creature and Vehicle
mod.engageId = 2125

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
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "NoxiousBreath", 263912)
	self:Log("SPELL_AURA_APPLIED", "ToxicPool", 263927)
	self:Log("SPELL_PERIODIC_DAMAGE", "ToxicPool", 263927)
	self:Log("SPELL_PERIODIC_MISSED", "ToxicPool", 263927)
	 self:Log("SPELL_CAST_START", "BlindingSand", 263914)
	self:Log("SPELL_CAST_START", "Hatch", 264239)
	-- self:Log("SPELL_CAST_SUCCESS", "Burrow", 264194)

	self:RegisterUnitEvent("UNIT_TARGETABLE_CHANGED", nil, "boss1")
end

function mod:OnEngage()
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:NoxiousBreath(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 83)
end

do
	local prev = 0
	function mod:ToxicPool(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 2 then
				prev = t
				self:Message(args.spellId, "blue", nil, CL.underyou:format(args.spellName))
				self:PlaySound(args.spellId, "alarm")
			end
		end
	end
end

function mod:BlindingSand(args)
	self:Message(args.spellId, "red", "Warning")
	self:CastBar(args.spellId, 2.5)
end

do
	local prev = 0
	function mod:Hatch(args)
		local t = GetTime()
		if t-prev > 2 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
			self:CDBar(args.spellId, 40)
		end
	end
end

function mod:UNIT_TARGETABLE_CHANGED(_, unit)
	-- Burrow
	if UnitCanAttack("player", unit) then
		self:Message(264206, "green", nil, CL.over:format(self:SpellName(264206)))
		self:PlaySound(264206, "info")
	else
		self:Message(264206, "cyan")
		self:PlaySound(264206, "long")
		self:Bar(264206, 40)
	end
end
