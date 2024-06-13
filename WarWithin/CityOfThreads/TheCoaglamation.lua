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
		-- Mythic
		448185, -- Slime Propagation
	}, {
		[448185] = CL.mythic,
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("ENCOUNTER_START") --- XXX no boss frames
	-- TODO needs warmup triggered from trash module
	self:Log("SPELL_CAST_START", "ViscousDarkness", 441289, 447146) -- first cast, subsequent casts
	-- TODO Dark Pulse is presumably broken because it's supposed to cast when the boss reaches 100 energy, but the boss does not gain energy
	self:Log("SPELL_CAST_SUCCESS", "DarkPulse", 441395) -- TODO no idea if this is the right event or id, but it doesn't have a description
	self:Log("SPELL_CAST_START", "BloodSurge", 438658)

	-- Mythic
	self:Log("SPELL_CAST_START", "SlimePropagation", 448185) -- TODO verify spellId
end

function mod:OnEngage()
	self:CDBar(441289, 8.3) -- Viscous Darkness
	self:CDBar(438658, 20.5) -- Blood Surge
	--TODO self:CDBar(441395, 40) -- Dark Pulse
	--if self:Mythic() then
		--TODO self:CDBar(448185, 40) -- Slime Propagation
	--end
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
	self:CDBar(441289, 37.6)
end

function mod:DarkPulse(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 37.6) -- TODO guessed
end

function mod:BloodSurge(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 37.6) -- TODO guessed
end

function mod:SlimePropagation(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 37.6) -- TODO guessed
end
