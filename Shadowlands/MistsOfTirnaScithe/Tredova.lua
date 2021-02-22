
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Tred'ova", 2290, 2405)
if not mod then return end
mod:RegisterEnableMob(164517) -- Tred'ova
mod.engageId = 2393
--mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Locals
--

local consumptionHp = 100

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.parasite = "Parasite"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		322651, -- Acid Expulsion
		322450, -- Consumption
		322550, -- Accelerated Incubation
		{322563, "ICON", "ME_ONLY_EMPHASIZE"}, -- Marked Prey
		326309, -- Decomposing Acid
		322614, -- Mind Link
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

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")

	self:Log("SPELL_CAST_SUCCESS", "Consumption", 322450)
	self:Log("SPELL_CAST_START", "AcceleratedIncubation", 322550)
	self:Log("SPELL_AURA_APPLIED", "MarkedPreyApplied", 322563)
	self:Log("SPELL_AURA_REMOVED", "MarkedPreyRemoved", 322563)
	self:Log("SPELL_AURA_APPLIED", "DecomposingAcidDamage", 326309)
	self:Log("SPELL_PERIODIC_DAMAGE", "DecomposingAcidDamage", 326309)
	self:Log("SPELL_PERIODIC_MISSED", "DecomposingAcidDamage", 326309)
	self:Log("SPELL_CAST_SUCCESS", "MindLink", 322614)
	self:Log("SPELL_CAST_START", "Parasite", 337235, 337249, 337255) -- Parasitic Pacification, Parasitic Incapacitation, Parasitic Domination
	self:Log("SPELL_CAST_SUCCESS", "ParasiteSuccess", 337235, 337249, 337255) -- Parasitic Pacification, Parasitic Incapacitation, Parasitic Domination
end

function mod:OnEngage()
	consumptionHp = 100
	self:CDBar(322651, 7.9) -- Acid Expulsion
	self:CDBar(322614, 52) -- Mind Link
	self:CDBar(322550, 55.9, CL.adds) -- Accelerated Incubation
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 322651 then -- Acid Expulsion
		self:Message(322651, "yellow")
		self:PlaySound(322651, "alert")
		self:Bar(322651, 19)
	end
end

function mod:Consumption(args)
	consumptionHp = consumptionHp - 30
	self:Message(args.spellId, "red", CL.percent:format(consumptionHp, args.spellName))
	self:PlaySound(args.spellId, "long")
end

function mod:AcceleratedIncubation(args)
	self:Message(args.spellId, "yellow", CL.incoming:format(CL.adds))
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 36.5, CL.adds)
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
		if self:Me(args.destGUID) then
			local t = args.time
			if t-prev > 2 then
				prev = t
				self:PlaySound(args.spellId, "underyou")
				self:PersonalMessage(args.spellId, "underyou")
			end
		end
	end
end

function mod:MindLink(args)
	self:TargetMessage(args.spellId, "orange", args.destName)
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 17)
end

function mod:Parasite(args)
	self:Message(args.spellId, "red", CL.casting:format(L.parasite))
	self:CDBar(args.spellId, 22, L.parasite)
	local _, ready = self:Interrupter()
	if ready then
		self:PlaySound(args.spellId, "warning")
	end
end

function mod:ParasiteSuccess(args)
	self:TargetMessage(args.spellId, "red", args.destName, L.parasite)
	self:PlaySound(args.spellId, "warning")
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
	end
end
