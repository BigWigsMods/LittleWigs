
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Naraxas", 1065, 1673)
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
	self:Log("SPELL_CAST_SUCCESS", "RancidMawEnd", 205549)
	self:Log("SPELL_CAST_SUCCESS", "ToxicRetch", 210150)

	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
end

function mod:OnEngage()
	self:CDBar(199178, 50) -- Spiked Tongue
	self:CDBar(205549, 7) -- Rancid Maw
	self:CDBar(210150, 15) -- Toxic Retch
	self:CDBar(-12527, 10) -- Wormspeaker Devout
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Frenzy(args)
	self:Message(args.spellId, "yellow", "Long")
end

function mod:SpikedTongue(args)
	self:Message(199178, "orange", self:Tank() and "Warning", CL.casting:format(args.spellName))
	for unit in module:IterateGroup() do
		if self:Tank(unit) then
			self:PrimaryIcon(199178, unit)
			break
		end
	end
end

function mod:SpikedTongueApplied(args)
	if self:MobId(args.destGUID) ~= 91005 then -- Naraxas
		self:TargetMessage(args.spellId, args.destName, "green", "Alarm", nil, nil, true)
		self:TargetBar(args.spellId, 10, args.destName)
		self:PrimaryIcon(args.spellId, args.destName)
	end
end

function mod:SpikedTongueRemoved(args)
	if self:MobId(args.destGUID) ~= 91005 then -- Naraxas
		self:Message(args.spellId, "green", nil, CL.over:format(args.spellName))
		self:StopBar(args.spellName, args.destName)
		self:PrimaryIcon(args.spellId)
	end
end

function mod:RancidMaw(args)
	self:Message(args.spellId, "red", "Alert")
	self:CDBar(args.spellId, 18)
end

function mod:ToxicRetch(args)
	self:CDBar(args.spellId, 15)
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, _, spellId)
	if spellId == 199817 then -- Call Minions
		self:ScheduleTimer("Message", 4, -12527, "yellow", "Info", CL.incoming:format(self:SpellName(-12527)))
		self:ScheduleTimer("Bar", 4, -12527, 65, -12527, 209906) -- spell_shadow_ritualofsacrifice / Fanatic's Sacrifice / icon 136189
	end
end

