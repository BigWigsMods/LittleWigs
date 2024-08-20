--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Tred'ova", 2290, 2405)
if not mod then return end
mod:RegisterEnableMob(164517) -- Tred'ova
mod:SetEncounterID(2393)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		322654, -- Acid Expulsion
		322450, -- Consumption
		322527, -- Gorging Shield
		322550, -- Accelerated Incubation
		{322563, "ICON", "ME_ONLY_EMPHASIZE"}, -- Marked Prey
		326309, -- Decomposing Acid
		{322614, "SAY"}, -- Mind Link
		-- Mythic
		463602, -- Coalescing Poison
	}, {
		[463602] = CL.mythic,
	}, {
		[322550] = CL.adds, -- Accelerated Incubation (Adds)
		[322563] = CL.fixate, -- Marked Prey (Fixate)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "AcidExpulsion", 322654)
	self:Log("SPELL_CAST_SUCCESS", "Consumption", 322450)
	self:Log("SPELL_AURA_REMOVED", "GorgingShieldRemoved", 322527)
	self:Log("SPELL_AURA_REMOVED", "ConsumptionRemoved", 322450)
	self:Log("SPELL_CAST_START", "AcceleratedIncubation", 322550)
	self:Log("SPELL_AURA_APPLIED", "MarkedPreyApplied", 322563)
	self:Log("SPELL_AURA_REMOVED", "MarkedPreyRemoved", 322563)
	self:Log("SPELL_AURA_APPLIED", "DecomposingAcidDamage", 326309)
	self:Log("SPELL_PERIODIC_DAMAGE", "DecomposingAcidDamage", 326309)
	self:Log("SPELL_PERIODIC_MISSED", "DecomposingAcidDamage", 326309)
	self:Log("SPELL_CAST_SUCCESS", "MindLink", 322614)

	-- Mythic
	self:Log("SPELL_CAST_START", "CoalescingPoison", 463602)
end

function mod:OnEngage()
	self:SetStage(1)
	if self:Mythic() then
		self:CDBar(322654, 7.0) -- Acid Expulsion
		self:CDBar(322550, 11.0, CL.adds) -- Accelerated Incubation
		self:CDBar(322614, 25.0) -- Mind Link
		self:CDBar(463602, 26.0) -- Coalescing Poison
	else -- Normal, Heroic
		self:CDBar(322654, 7.7) -- Acid Expulsion
		self:CDBar(322614, 17.8) -- Mind Link
		self:CDBar(322550, 21.5, CL.adds) -- Accelerated Incubation
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prev = 0
	function mod:AcidExpulsion(args)
		-- throttle, one event per player
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "yellow")
			if self:Mythic() then
				self:CDBar(args.spellId, 35.0)
			else
				self:CDBar(args.spellId, 19.4)
			end
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:Consumption(args)
	if self:Mythic() then
		self:StopBar(322654) -- Acid Expulsion
		self:StopBar(CL.adds) -- Accelerated Incubation
		self:StopBar(322614) -- Mind Link
		self:StopBar(463602) -- Coalescing Poison
	end
	if self:GetStage() == 1 then -- first Consumption
		self:SetStage(2)
		self:Message(args.spellId, "cyan", CL.percent:format(70, args.spellName))
	else -- second Consumption
		self:SetStage(3)
		self:Message(args.spellId, "cyan", CL.percent:format(40, args.spellName))
	end
	self:PlaySound(args.spellId, "long")
end

function mod:GorgingShieldRemoved(args)
	self:Message(args.spellId, "green", CL.removed:format(args.spellName))
	self:PlaySound(args.spellId, "info")
end

function mod:ConsumptionRemoved(args)
	if self:Mythic() then
		self:CDBar(322654, 7.0) -- Acid Expulsion
		self:CDBar(322550, 11.0, CL.adds) -- Accelerated Incubation
		self:CDBar(322614, 25.0) -- Mind Link
		self:CDBar(463602, 26.0) -- Coalescing Poison
	end
end

function mod:AcceleratedIncubation(args)
	self:Message(args.spellId, "yellow", CL.incoming:format(CL.adds))
	if self:Mythic() then
		self:CDBar(args.spellId, 35.0, CL.adds)
	else
		self:CDBar(args.spellId, 30.4, CL.adds)
	end
	self:PlaySound(args.spellId, "info")
end

function mod:MarkedPreyApplied(args)
	self:TargetMessage(args.spellId, "yellow", args.destName, CL.fixate)
	self:PrimaryIcon(args.spellId, args.destName)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "warning")
	end
end

function mod:MarkedPreyRemoved(args)
	self:PrimaryIcon(args.spellId)
end

do
	local prev = 0
	function mod:DecomposingAcidDamage(args)
		local t = args.time
		if self:Me(args.destGUID) and t - prev > 2 then
			prev = t
			self:PersonalMessage(args.spellId, "underyou")
			self:PlaySound(args.spellId, "underyou")
		end
	end
end

function mod:MindLink(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	if self:Mythic() then
		self:CDBar(args.spellId, 35.0)
	else
		self:CDBar(args.spellId, 15.8)
	end
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Mind Link")
	end
	self:PlaySound(args.spellId, "alert", nil, args.destName)
end

-- Mythic

function mod:CoalescingPoison(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 35.0)
	self:PlaySound(args.spellId, "alarm")
end
