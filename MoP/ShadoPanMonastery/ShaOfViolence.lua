--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Sha of Violence", 959, 685)
if not mod then return end
mod:RegisterEnableMob(56719)
mod:SetEncounterID(1305)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{106872, "DISPEL"}, -- Disorienting Smash
		106826, -- Smoke Blades
		38166, -- Enrage
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "DisorientingSmash", 106872)
	self:Log("SPELL_AURA_APPLIED", "DisorientingSmashApplied", 106872)
	self:Log("SPELL_CAST_SUCCESS", "SmokeBlades", 106826)
	self:Log("SPELL_AURA_APPLIED", "Enrage", 38166)
end

function mod:OnEngage()
	self:CDBar(106826, 11.7) -- Smoke Blades
	self:CDBar(106872, 16.5) -- Disorienting Smash
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DisorientingSmash(args)
	self:CDBar(args.spellId, 17.0)
end

function mod:DisorientingSmashApplied(args)
	local onMe = self:Me(args.destGUID)
	if onMe or self:Dispeller("magic", nil, args.spellId) then
		self:TargetMessage(args.spellId, "purple", args.destName)
		if onMe then
			self:PlaySound(args.spellId, "info", nil, args.destName)
		else
			self:PlaySound(args.spellId, "warning", nil, args.destName)
		end
	end
end

function mod:SmokeBlades(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 18.2)
end

function mod:Enrage(args)
	self:Message(args.spellId, "red", CL.percent:format(20, args.spellName))
	self:PlaySound(args.spellId, "long")
end
