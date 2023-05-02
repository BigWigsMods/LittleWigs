--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Naraxas", 1458, 1673)
if not mod then return end
mod:RegisterEnableMob(91005)
mod:SetEncounterID(1792)
mod:SetRespawnTime(15)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		205549, -- Rancid Maw
		210150, -- Toxic Retch
		{199178, "ICON"}, -- Spiked Tongue
		199775, -- Frenzy
		-12527, -- Wormspeaker Devout
		199246, -- Ravenous
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "RancidMaw", 205549)
	self:Log("SPELL_CAST_START", "ToxicRetch", 210150)
	self:Log("SPELL_CAST_START", "SpikedTongue", 199176)
	self:Log("SPELL_AURA_APPLIED", "SpikedTongueApplied", 199178)
	self:Log("SPELL_AURA_REMOVED", "SpikedTongueRemoved", 199178)
	self:Log("SPELL_CAST_SUCCESS", "Frenzy", 199775)
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Log("SPELL_AURA_APPLIED", "RavenousApplied", 199246)
	self:Log("SPELL_AURA_APPLIED_DOSE", "RavenousApplied", 199246)
end

function mod:OnEngage()
	self:CDBar(205549, 7.0) -- Rancid Maw
	self:CDBar(-12527, 9.8, -12527, 209906) -- Wormspeaker Devout: spell_shadow_ritualofsacrifice / Fanatic's Sacrifice / icon 136189
	self:CDBar(210150, 12.1) -- Toxic Retch
	self:Bar(199178, 50.7) -- Spiked Tongue
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:RancidMaw(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 18.2) -- pull:7.2, 18.2, 20.6, 24.3, 18.2
end

function mod:ToxicRetch(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 14.6) -- pull:12.1, 17.0, 14.6, 24.3, 14.5, 14.6
end

function mod:SpikedTongue(args)
	self:Message(199178, "orange", CL.casting:format(args.spellName))
	if self:Tank() then
		self:PlaySound(199178, "warning")
	else
		self:PlaySound(199178, "alert")
	end
	self:Bar(199178, 6, CL.cast:format(args.spellName))
	self:Bar(199178, 56.0)
	for unit in self:IterateGroup() do
		if self:Tank(unit) then -- TODO better way to detect target?
			self:PrimaryIcon(199178, unit)
			break
		end
	end
end

function mod:SpikedTongueApplied(args)
	if self:MobId(args.destGUID) ~= 91005 then -- Naraxas
		self:TargetMessage(args.spellId, "red", args.destName)
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
		self:TargetBar(args.spellId, 10, args.destName)
		self:PrimaryIcon(args.spellId, args.destName)
	end
end

function mod:SpikedTongueRemoved(args)
	if self:MobId(args.destGUID) ~= 91005 then -- Naraxas
		self:Message(args.spellId, "green", CL.over:format(args.spellName))
		self:PlaySound(args.spellId, "info")
		self:StopBar(args.spellId, args.destName)
		self:PrimaryIcon(args.spellId)
	end
end

function mod:Frenzy(args)
	self:Message(args.spellId, "yellow", CL.percent:format(20, args.spellName))
	self:PlaySound(args.spellId, "long")
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 199817 then -- Call Minions
		self:ScheduleTimer("MessageOld", 4, -12527, "yellow", "info", CL.incoming:format(self:SpellName(-12527)), 209906)
		self:ScheduleTimer("Bar", 4, -12527, 65, -12527, 209906) -- spell_shadow_ritualofsacrifice / Fanatic's Sacrifice / icon 136189
	end
end

function mod:RavenousApplied(args)
	self:StackMessage(args.spellId, "red", args.destName, args.amount, 1)
	self:PlaySound(args.spellId, "long")
end
