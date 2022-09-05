
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Naraxas", 1458, 1673)
if not mod then return end
mod:RegisterEnableMob(91005)
mod.engageId = 1792

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		199775, -- Frenzy
		{199178, "ICON"}, -- Spiked Tongue
		205549, -- Rancid Maw
		210150, -- Toxic Retch
		-12527, -- Wormspeaker Devout
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Frenzy", 199775)
	self:Log("SPELL_CAST_START", "SpikedTongue", 199176)
	self:Log("SPELL_AURA_APPLIED", "SpikedTongueApplied", 199178)
	self:Log("SPELL_AURA_REMOVED", "SpikedTongueRemoved", 199178)
	self:Log("SPELL_CAST_START", "RancidMaw", 205549)
	self:Log("SPELL_CAST_START", "ToxicRetchStart", 210150)
	self:Log("SPELL_CAST_SUCCESS", "ToxicRetch", 210150)

	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
end

function mod:OnEngage()
	self:CDBar(199178, 50) -- Spiked Tongue
	self:CDBar(205549, 7) -- Rancid Maw
	self:CDBar(210150, 12) -- Toxic Retch
	self:CDBar(-12527, 10, -12527, 209906) -- Wormspeaker Devout: spell_shadow_ritualofsacrifice / Fanatic's Sacrifice / icon 136189
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Frenzy(args)
	self:MessageOld(args.spellId, "yellow", "long", CL.percent:format(20, args.spellName))
end

function mod:SpikedTongue(args)
	self:MessageOld(199178, "orange", self:Tank() and "warning", CL.casting:format(args.spellName))
	self:CDBar(199178, 6, CL.cast:format(args.spellName))
	--self:CDBar(199178, 18)
	for unit in self:IterateGroup() do
		if self:Tank(unit) then
			self:PrimaryIcon(199178, unit)
			break
		end
	end
end

function mod:SpikedTongueApplied(args)
	if self:MobId(args.destGUID) ~= 91005 then -- Naraxas
		self:TargetMessageOld(args.spellId, args.destName, "green", "alarm", nil, nil, true)
		self:TargetBar(args.spellId, 10, args.destName)
		self:PrimaryIcon(args.spellId, args.destName)
	end
end

function mod:SpikedTongueRemoved(args)
	if self:MobId(args.destGUID) ~= 91005 then -- Naraxas
		self:MessageOld(args.spellId, "green", nil, CL.over:format(args.spellName))
		self:StopBar(args.spellName, args.destName)
		self:PrimaryIcon(args.spellId)
	end
end

function mod:RancidMaw(args)
	self:MessageOld(args.spellId, "red", "alert", CL.incoming:format(args.spellName))
	self:CDBar(args.spellId, 18) -- pull:7.2, 18.2, 20.6, 24.3, 18.2
end

function mod:ToxicRetchStart(args)
	self:MessageOld(args.spellId, "orange", "alert", CL.casting:format(args.spellName))
end

function mod:ToxicRetch(args)
	self:CDBar(args.spellId, 15) -- pull:12.1, 17.0, 14.6, 24.3, 14.5, 14.6
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 199817 then -- Call Minions
		self:ScheduleTimer("MessageOld", 4, -12527, "yellow", "info", CL.incoming:format(self:SpellName(-12527)), 209906)
		self:ScheduleTimer("Bar", 4, -12527, 65, -12527, 209906) -- spell_shadow_ritualofsacrifice / Fanatic's Sacrifice / icon 136189
	end
end

