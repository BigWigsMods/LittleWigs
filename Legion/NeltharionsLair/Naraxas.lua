--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Naraxas", 1458, 1673)
if not mod then return end
mod:RegisterEnableMob(91005)
mod:SetEncounterID(1792)
mod:SetRespawnTime(15)

--------------------------------------------------------------------------------
-- Locals
--

local toxicRetchCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		205549, -- Rancid Maw
		210150, -- Toxic Retch
		{199178, "ICON"}, -- Spiked Tongue
		199775, -- Frenzy
		199817, -- Call Minions
		199246, -- Ravenous
		198963, -- Putrid Skies
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "RancidMaw", 205549)
	self:Log("SPELL_CAST_START", "ToxicRetch", 210150)
	self:Log("SPELL_CAST_START", "SpikedTongue", 199176)
	self:Log("SPELL_AURA_APPLIED", "SpikedTongueApplied", 199178)
	self:Log("SPELL_AURA_REMOVED", "SpikedTongueRemoved", 199178)
	self:Log("SPELL_CAST_SUCCESS", "Frenzy", 199775)
	self:Log("SPELL_CAST_SUCCESS", "CallMinions", 199817)
	self:Log("SPELL_AURA_APPLIED", "RavenousApplied", 199246)
	self:Log("SPELL_AURA_APPLIED_DOSE", "RavenousApplied", 199246)
	self:Log("SPELL_CAST_START", "PutridSkies", 198963)
end

function mod:OnEngage()
	toxicRetchCount = 1
	self:CDBar(199817, 5.1) -- Call Minions
	self:CDBar(205549, 7.0) -- Rancid Maw
	self:CDBar(210150, 12.1, CL.count:format(self:SpellName(210150), toxicRetchCount)) -- Toxic Retch
	self:CDBar(199178, 50.7) -- Spiked Tongue
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
	self:StopBar(CL.count:format(args.spellName, toxicRetchCount))
	self:Message(args.spellId, "orange", CL.count:format(args.spellName, toxicRetchCount))
	self:PlaySound(args.spellId, "alert")
	toxicRetchCount = toxicRetchCount + 1
	self:CDBar(args.spellId, 14.6, CL.count:format(args.spellName, toxicRetchCount)) -- pull:12.1, 17.0, 14.6, 24.3, 14.5, 14.6
end

function mod:SpikedTongue(args)
	self:Message(199178, "purple", CL.casting:format(args.spellName))
	if self:Tank() then
		self:PlaySound(199178, "warning")
	else
		self:PlaySound(199178, "alert")
	end
	self:Bar(199178, 6, CL.cast:format(args.spellName))
	self:CDBar(199178, 56.0)
	for unit in self:IterateGroup() do
		if self:Tank(unit) then
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

function mod:CallMinions(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 65.3)
end

function mod:RavenousApplied(args)
	self:StackMessage(args.spellId, "red", args.destName, args.amount, 1)
	self:PlaySound(args.spellId, "long")
end

function mod:PutridSkies(args)
	-- only cast when no one is in melee range
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "warning")
end
