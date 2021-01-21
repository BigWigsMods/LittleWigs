
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Tred'ova", 2290, 2405)
if not mod then return end
mod:RegisterEnableMob(164517) -- Tred'ova
mod.engageId = 2393
--mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		322450, -- Consumption
		322550, -- Accelerated Incubation
		322614, -- Mind Link
		322563, -- Marked Prey
		322651, -- Acid Expulsion
		{337235, "SAY"}, -- Parasitic Pacification
		{337249, "SAY"}, -- Parasitic Incapacitation
		{337255, "SAY"}, -- Parasitic Domination
	},nil,{
		[337235] = self:SpellName(36469), -- Parasitic Pacification (Parasite)
		[337249] = self:SpellName(36469), -- Parasitic Incapacitation (Parasite)
		[337255] = self:SpellName(36469), -- Parasitic Domination (Parasite)
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")

	self:Log("SPELL_CAST_SUCCESS", "Consumption", 322450)
	self:Log("SPELL_CAST_SUCCESS", "AcceleratedIncubation", 322550)
	self:Log("SPELL_CAST_SUCCESS", "MindLink", 322614)
	self:Log("SPELL_AURA_APPLIED", "MarkedPreyApplied", 322563)
	self:Log("SPELL_CAST_START", "Parasite", 337235, 337249, 337255) -- Parasitic Pacification, Parasitic Incapacitation, Parasitic Domination
	self:Log("SPELL_CAST_SUCCESS", "ParasiteSuccess", 337235, 337249, 337255) -- Parasitic Pacification, Parasitic Incapacitation, Parasitic Domination
end

function mod:OnEngage()
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 322651 then -- Acid Expulsion
		self:Message(322651, "yellow")
		self:PlaySound(322651, "alert")
		self:Bar(322651, 14.5)
	end
end

function mod:Consumption(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "long")
	self:StopBar(322651) -- Acid Expulsion
	self:StopBar(322550) -- Accelerated Incubation
	self:StopBar(322614) -- Mind Link
end

function mod:AcceleratedIncubation(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 24)
end

function mod:MindLink(args)
	self:TargetMessage(args.spellId, "orange", args.destName)
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 17)
end

function mod:MarkedPreyApplied(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:CDBar(args.spellId, 24)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:Parasite(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
	self:CDBar(args.spellId, 22, 36469, args.spellId) -- 36469 = Parasite
end

function mod:ParasiteSuccess(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	self:PlaySound(args.spellId, "warning")
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
	end
end
