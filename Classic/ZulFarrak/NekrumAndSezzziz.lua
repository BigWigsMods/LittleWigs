--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Nekrum & Sezz'ziz", 209, 487)
if not mod then return end
mod:RegisterEnableMob(7796, 7275) -- Nekrum Gutchewer, Shadowpriest Sezz'ziz
mod:SetEncounterID(598)
--mod:SetRespawnTime(0) -- resets, doesn't respawn

--------------------------------------------------------------------------------
-- Locals
--

local deaths = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Nekrum Gutchewer
		{8600, "DISPEL"}, -- Fevered Plague
		-- Shadow Priest Sezz'ziz
		13704, -- Psychic Scream
		{8362, "DISPEL"}, -- Renew
		12039, -- Heal
	}, {
		[8600] = -5019, -- Nekrum Gutchewer
		[13704] = -5020, -- Shadow Priest Sezz'ziz
	}
end

function mod:OnBossEnable()
	-- Nekrum Gutchewer
	self:Log("SPELL_CAST_START", "FeveredPlague", 8600)
	self:Log("SPELL_AURA_APPLIED", "FeveredPlagueApplied", 8600)

	-- Shadow Priest Sezz'ziz
	self:Log("SPELL_CAST_START", "PsychicScream", 13704)
	self:Log("SPELL_CAST_START", "Renew", 8362)
	self:Log("SPELL_INTERRUPT", "RenewInterrupt", 8362)
	self:Log("SPELL_CAST_SUCCESS", "RenewSuccess", 8362)
	self:Log("SPELL_AURA_APPLIED", "RenewApplied", 8362)
	self:Log("SPELL_CAST_START", "Heal", 12039)
	self:Log("SPELL_INTERRUPT", "HealInterrupt", 12039)
	self:Log("SPELL_CAST_SUCCESS", "HealSuccess", 12039)

	if self:Heroic() then -- no encounter events in Timewalking
		self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	end
	self:Death("BossDeath", 7796, 7275)
end

function mod:OnEngage()
	deaths = 0
	self:CDBar(8600, 6.1) -- Fevered Plague
	self:CDBar(13704, 17.0) -- Psychic Scream
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Nekrum Gutchewer

function mod:FeveredPlague(args)
	if self:MobId(args.sourceGUID) == 7796 then -- Nekrum Gutchewer
		self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
		self:CDBar(args.spellId, 13.4)
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:FeveredPlagueApplied(args)
	if (self:Me(args.destGUID) or self:Dispeller("disease", nil, args.spellId)) and self:MobId(args.sourceGUID) == 7796 then -- Nekrum Gutchewer
		self:TargetMessage(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
	end
end

-- Shadow Priest Sezz'ziz

function mod:PsychicScream(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 27.9)
	self:PlaySound(args.spellId, "info")
end

function mod:Renew(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:RenewInterrupt()
	self:CDBar(8362, 19.9)
end

function mod:RenewSuccess(args)
	self:CDBar(args.spellId, 19.9)
end

function mod:RenewApplied(args)
	if self:Dispeller("magic", true, args.spellId) and self:Hostile(args.destFlags) then
		self:Message(args.spellId, "yellow", CL.on:format(args.spellName, args.destName))
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
	end
end

function mod:Heal(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:HealInterrupt()
	self:CDBar(12039, 10.3)
end

function mod:HealSuccess(args)
	self:CDBar(args.spellId, 10.3)
end

function mod:BossDeath(args)
	deaths = deaths + 1
	if self:Heroic() and deaths == 2 then -- no encounter events in Timewalking
		deaths = 0
		self:Win()
	elseif args.mobId == 7796 then -- Nekrum Gutchewer
		self:StopBar(8600) -- Fevered Plague
	else -- 7275, Shadowpriest Sezz'ziz
		self:StopBar(13704) -- Psychic Scream
		self:StopBar(8362) -- Renew
		self:StopBar(12039) -- Heal
	end
end
