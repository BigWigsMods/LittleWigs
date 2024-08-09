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
-- Localization
--

-- XXX remove locale when 11.0.2 is live everywhere
local L = mod:GetLocale()
if L then
	L.parasite = "Parasite"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		322654, -- Acid Expulsion
		{322450, "CASTBAR"}, -- Consumption
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

-- XXX remove this block when 11.0.2 is live everywhere
if not BigWigsLoader.isBeta then
	function mod:GetOptions()
		return {
			322654, -- Acid Expulsion
			322450, -- Consumption
			322527, -- Gorging Shield
			322550, -- Accelerated Incubation
			{322563, "ICON", "ME_ONLY_EMPHASIZE"}, -- Marked Prey
			326309, -- Decomposing Acid
			{322614, "SAY"}, -- Mind Link
			{337235, "SAY"}, -- Parasitic Pacification
			{337249, "SAY"}, -- Parasitic Incapacitation
			{337255, "SAY"}, -- Parasitic Domination
		},nil,{
			[322550] = CL.adds, -- Accelerated Incubation (Adds)
			[322563] = CL.fixate, -- Marked Prey (Fixate)
			[337235] = L.parasite, -- Parasitic Pacification (Parasite)
			[337249] = L.parasite, -- Parasitic Incapacitation (Parasite)
			[337255] = L.parasite, -- Parasitic Domination (Parasite)
		}
	end
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
	if BigWigsLoader.isBeta then
		self:Log("SPELL_CAST_START", "CoalescingPoison", 463602)
	else
		-- XXX remove these when 11.0.2 is live everywhere
		self:Log("SPELL_CAST_START", "Parasite", 337235, 337249, 337255) -- Parasitic Pacification, Parasitic Incapacitation, Parasitic Domination
		self:Log("SPELL_CAST_SUCCESS", "ParasiteSuccess", 337235, 337249, 337255) -- Parasitic Pacification, Parasitic Incapacitation, Parasitic Domination
	end
end

function mod:OnEngage()
	self:SetStage(1)
	if BigWigsLoader.isBeta and self:Mythic() then -- XXX remove isBeta when 11.0.2 is live
		self:CDBar(322654, 7.0) -- Acid Expulsion
		self:CDBar(322550, 11.0, CL.adds) -- Accelerated Incubation
		self:CDBar(322614, 25.0) -- Mind Link
		if self:Mythic() then
			self:CDBar(463602, 26.0) -- Coalescing Poison
		end
	else
		self:CDBar(322654, 7.7) -- Acid Expulsion
		if self:Mythic() then -- XXX remove this block when 11.0.2 is live
			self:CDBar(337235, 11.1, L.parasite) -- Parasitic Pacification
		end
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
	if BigWigsLoader.isBeta and self:Mythic() then -- XXX remove isBeta when 10.2 is live
		self:StopBar(322654) -- Acid Expulsion
		self:StopBar(CL.adds) -- Accelerated Incubation
		self:StopBar(322614) -- Mind Link
		self:StopBar(463602) -- Coalescing Poison
	end
	if self:GetStage() == 1 then -- first Consumption
		self:Message(args.spellId, "cyan", CL.percent:format(70, args.spellName))
	else -- second Consumption
		self:Message(args.spellId, "cyan", CL.percent:format(40, args.spellName))
	end
	self:SetStage(self:GetStage() + 1)
	self:CastBar(args.spellId, 14)
	self:PlaySound(args.spellId, "long")
end

function mod:GorgingShieldRemoved(args)
	self:Message(args.spellId, "green", CL.removed:format(args.spellName))
	self:PlaySound(args.spellId, "info")
end

function mod:ConsumptionRemoved(args)
	self:StopBar(CL.cast:format(args.spellName))
	if BigWigsLoader.isBeta and self:Mythic() then -- XXX remove isBeta when 10.2 is live
		self:CDBar(322654, 7.0) -- Acid Expulsion
		self:CDBar(322550, 11.0, CL.adds) -- Accelerated Incubation
		self:CDBar(322614, 25.0) -- Mind Link
		if self:Mythic() then
			self:CDBar(463602, 26.0) -- Coalescing Poison
		end
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
	self:PlaySound(args.spellId, "alert")
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Mind Link")
	end
end

-- XXX remove when 11.0.2 is live everywhere
function mod:Parasite(args)
	self:Message(args.spellId, "red", CL.casting:format(L.parasite))
	self:CDBar(args.spellId, 25.5, L.parasite)
	local _, ready = self:Interrupter()
	if ready then
		self:PlaySound(args.spellId, "warning")
	end
end

-- XXX remove when 11.0.2 is live everywhere
function mod:ParasiteSuccess(args)
	self:TargetMessage(args.spellId, "red", args.destName, L.parasite)
	self:PlaySound(args.spellId, "warning")
	if self:Me(args.destGUID) then
		self:Say(args.spellId, L.parasite, nil, "Parasite")
	end
end

-- Mythic

function mod:CoalescingPoison(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 35.0)
	self:PlaySound(args.spellId, "alarm")
end
