--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Maiden of Virtue", 1651, 1825)
if not mod then return end
mod:RegisterEnableMob(113971)
mod:SetEncounterID(1954)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local sacredGroundOnMe = false

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		227823, -- Holy Wrath
		227800, -- Holy Shock
		227809, -- Holy Bolt
		227508, -- Mass Repentance
		{227789, "SAY", "FLASH"}, -- Sacred Ground
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_REMOVED", "HolyBulwarkRemoved", 227817)
	self:Log("SPELL_CAST_START", "HolyShock", 227800)
	self:Log("SPELL_CAST_START", "HolyWrath", 227823)
	self:Log("SPELL_CAST_START", "HolyBolt", 227809)
	self:Log("SPELL_CAST_START", "MassRepentance", 227508)
	self:Log("SPELL_CAST_SUCCESS", "MassRepentanceSuccess", 227508)
	self:Log("SPELL_CAST_START", "SacredGround", 227789)
	self:Log("SPELL_AURA_APPLIED", "SacredGroundApplied", 227848)
	self:Log("SPELL_AURA_REMOVED", "SacredGroundRemoved", 227848)
end

function mod:OnEngage()
	sacredGroundOnMe = false
	self:Bar(227809, 8.5) -- Holy Bolt
	self:Bar(227789, 10) -- Sacred Ground
	self:Bar(227800, 14.9) -- Holy Shock
	self:Bar(227508, 45.2) -- Mass Repentance
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local function printTarget(self, player, guid)
		self:TargetMessage(227789, "red", player)
		self:PlaySound(227789, "alarm", nil, player)
		if self:Me(guid) then
			self:Say(227789, nil, nil, "Sacred Ground")
			self:Flash(227789)
		end
	end

	function mod:SacredGround(args)
		self:CDBar(args.spellId, 19.4)
		self:GetUnitTarget(printTarget, 0.3, args.sourceGUID)
	end
end

function mod:HolyShock(args)
	self:CDBar(args.spellId, 13.3)
	if self:Interrupter(args.sourceGUID) then
		self:Message(args.spellId, "yellow", CL.incoming:format(args.spellName))
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:HolyWrath(args)
	self:Message(args.spellId, "red", CL.incoming:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
end

do
	local sacredGroundCheck = nil

	local function checkForSacredGround()
		if not sacredGroundOnMe then
			mod:Message(227789, "blue", CL.no:format(mod:SpellName(227848)))
			mod:PlaySound(227789, "warning")
			sacredGroundCheck = mod:ScheduleTimer(checkForSacredGround, 1.5)
		else
			mod:Message(227789, "green", CL.you:format(mod:SpellName(227848)))
			mod:PlaySound(227789, "info")
			sacredGroundCheck = nil
		end
	end

	function mod:MassRepentance(args)
		self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "warning")
		self:Bar(args.spellId, 5, CL.cast:format(args.spellName))
		self:Bar(args.spellId, 51)
		checkForSacredGround()
	end

	function mod:SacredGroundApplied(args)
		if self:Me(args.destGUID) then
			sacredGroundOnMe = true
			if sacredGroundCheck then
				self:CancelTimer(sacredGroundCheck)
				checkForSacredGround() -- immediately check and give the positive message
			end
		end
	end

	function mod:SacredGroundRemoved(args)
		if self:Me(args.destGUID) then
			sacredGroundOnMe = false
		end
	end

	function mod:MassRepentanceSuccess()
		if sacredGroundCheck then
			self:CancelTimer(sacredGroundCheck)
			sacredGroundCheck = nil
		end
	end
end

function mod:HolyBulwarkRemoved(args)
	self:Message(227823, "orange", CL.casting:format(self:SpellName(227823)))
	if self:Interrupter() then
		self:PlaySound(227823, "alert")
	end
end

do
	local function printTarget(self, player)
		self:TargetMessage(227809, "red", player)
	end

	function mod:HolyBolt(args)
		self:CDBar(args.spellId, 9.7)
		self:GetUnitTarget(printTarget, 0.3, args.sourceGUID)
	end
end
