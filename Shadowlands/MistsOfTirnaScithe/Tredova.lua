
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Tred'ova", 2290, 2405)
if not mod then return end
mod:RegisterEnableMob(164517) -- Tred'ova
mod.engageId = 2393
--mod.respawnTime = 30

local L = mod:GetLocale()
if L then
	L.parasitic = mod:SpellName(278431)
	L.parasitic_desc = "Show warnings and timers for Parasitic Pacification, Incapacitation and Domination"
	L.parasitic_icon = 337235
end

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
		{"parasitic", "SAY"}, -- Parasitic Pacification, Incapacitation and Domination
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")

	self:Log("SPELL_CAST_SUCCESS", "Consumption", 322450)
	self:Log("SPELL_CAST_SUCCESS", "AcceleratedIncubation", 322550)
	self:Log("SPELL_CAST_SUCCESS", "MindLink", 322614)
	self:Log("SPELL_AURA_APPLIED", "MarkedPreyApplied", 322563)
	self:Log("SPELL_CAST_START", "Parasitic", 337235, 337249, 337255) -- Parasitic Pacification, Incapacitation and Domination
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

do
	local function printTarget(self, name, guid)
		self:TargetMessage("parasitic", "red", name, 278431, 278431) -- Parasitic
		if self:Me(guid) then
			self:PlaySound("parasitic", "warning")
			self:Say("parasitic", 278431) -- Parasitic
		end
	end

	function mod:Parasitic(args)
		self:GetBossTarget(printTarget, 0.3, args.sourceGUID, args.spellId)
		self:CDBar("parasitic", 22, L.parasitic, L.parasitic_icon)
	end
end
