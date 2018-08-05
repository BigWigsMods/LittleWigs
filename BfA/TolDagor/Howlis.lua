
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Jes Howlis", 1771, 2098)
if not mod then return end
mod:RegisterEnableMob(127484) -- Jes Howlis
mod.engageId = 2102

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		257785, -- Flashing Daggers
		257777, -- Crippling Shiv
		257791, -- Howling Fear
		257793, -- Smoke Powder
		257827, -- Motivating Cry
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "FlashingDaggers", 257785)
	self:Log("SPELL_CAST_SUCCESS", "CripplingShiv", 257777)
	self:Log("SPELL_AURA_REMOVED", "CripplingShivRemoved", 257777)
	self:Log("SPELL_CAST_START", "HowlingFear", 257791)
	self:Log("SPELL_CAST_SUCCESS", "SmokePowder", 257793)
	self:Log("SPELL_CAST_SUCCESS", "MotivatingCry", 257827)
	self:Log("SPELL_AURA_APPLIED_DOSE", "Motivated", 257956)
	self:Log("SPELL_INTERRUPT", "MotivatingCryInterupted", "*")
end

function mod:OnEngage()
	self:CDBar(257777, 7) -- Crippling Shiv
	self:Bar(257791, 8.5) -- Howling Fear
	self:Bar(257785, 12) -- Flashing Daggers
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:FlashingDaggers(args)
	self:Message(args.spellId, "red", "Warning")
	self:Bar(args.spellId, 31.5)
	self:CastBar(args.spellId, 6)
end

function mod:CripplingShiv(args)
	if self:Me(args.destGUID) or self:Healer() or self:Dispeller("poison") then
		self:TargetMessage2(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "alarm")
		self:TargetBar(args.spellId, 12, args.destName)
	end
	self:CDBar(args.spellId, 17)
end

function mod:CripplingShivRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:HowlingFear(args)
	self:Message(args.spellId, "orange", "Alert", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 15)
end

function mod:SmokePowder(args)
	self:Message(args.spellId, "cyan", "Long")
	self:StopBar(257777) -- Crippling Shiv
	self:StopBar(257791) -- Howling Fear
	self:StopBar(257785) -- Flashing Daggers
end

function mod:MotivatingCry(args)
	self:Message(args.spellId, "orange", "Alert", CL.casting:format(args.spellName))
end

function mod:Motivated(args)
	if self:MobId(args.destGUID) ~= 127484 then return end -- also applies it to nearby adds
	if args.amount % 4 == 0 then -- every 8 seconds
		self:StackMessage(257827, args.destName, args.amount, "orange")
		self:PlaySound(257827, "alert")
	end
end

function mod:MotivatingCryInterupted(args)
	if args.extraSpellId == 257827 then
		self:Message(257827, "green", nil, CL.interrupted_by:format(args.extraSpellName, self:ColorName(args.sourceName)))
		self:PlaySound(257827, "info")
		self:CDBar(257777, 1.5) -- Crippling Shiv
		self:Bar(257791, 2) -- Howling Fear
		self:Bar(257785, 5.5) -- Flashing Daggers
	end
end
