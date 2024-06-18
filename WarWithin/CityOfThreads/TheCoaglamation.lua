if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Coaglamation", 2669, 2600)
if not mod then return end
mod:RegisterEnableMob(216320) -- The Coaglamation
mod:SetEncounterID(2905)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		441289, -- Viscous Darkness
		441395, -- Dark Pulse
		438658, -- Blood Surge
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("ENCOUNTER_START") --- XXX no boss frames
	-- TODO warmup triggered from trash module?
	self:Log("SPELL_CAST_START", "ViscousDarkness", 441289, 447146) -- odd casts, even casts
	self:Log("SPELL_CAST_SUCCESS", "DarkPulse", 441395)
	self:Log("SPELL_CAST_START", "BloodSurge", 438658)
end

function mod:OnEngage()
	self:CDBar(441289, 8.2) -- Viscous Darkness
	self:CDBar(438658, 20.5) -- Blood Surge
	self:CDBar(441395, 68.1) -- Dark Pulse
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- XXX no boss frames
function mod:ENCOUNTER_START(_, id)
	if id == self.engageId then
		self:Engage()
	end
end

function mod:ViscousDarkness(args)
	self:Message(441289, "red")
	self:PlaySound(441289, "long")
	self:CDBar(441289, 37.2)
end

function mod:DarkPulse(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 77.2)
end

function mod:BloodSurge(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 77.2)
end
