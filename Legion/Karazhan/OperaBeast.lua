--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Opera Hall: Beautiful Beast", 1651, 1827)
if not mod then return end
mod:RegisterEnableMob(
	114329, -- Luminore
	114522, -- Mrs. Cauldrons
	114330, -- Babblet
	114328  -- Coggleston
)
--mod:SetEncounterID(1957) -- Same for every opera event. So it's basically useless.
mod:SetStage(1)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		228025, -- Heat Wave
		228019, -- Leftovers
		{228221, "SAY"}, -- Severe Dusting
		{228225, "DISPEL"}, -- Sultry Heat
		{227985, "TANK_HEALER"}, -- Dent Armor
		227987, -- Dinner Bell!
		232153, -- Kara Kazham!
	}, {
		[228025] = -14145, -- Luminore
		[228019] = -14148, -- Mrs. Cauldrons
		[228221] = -14151, -- Babblet
		[227985] = -14142, -- Coggleston
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:RegisterEvent("ENCOUNTER_END")

	self:Log("SPELL_CAST_START", "HeatWave", 228025)
	self:Log("SPELL_CAST_START", "Leftovers", 228019)
	self:Log("SPELL_AURA_APPLIED", "SevereDustingApplied", 228221)
	self:Log("SPELL_AURA_REMOVED", "SevereDustingRemoved", 228221)
	self:Log("SPELL_AURA_APPLIED", "SultryHeat", 228225)
	self:Log("SPELL_AURA_REMOVED", "SpectralServiceRemoved", 232156)
	self:Log("SPELL_AURA_APPLIED", "DentArmor", 227985)
	self:Log("SPELL_AURA_REMOVED", "DentArmorRemoved", 227985)
	self:Log("SPELL_CAST_START", "DinnerBell", 227987)
	self:Log("SPELL_AURA_APPLIED", "DinnerBellApplied", 227987)
	self:Log("SPELL_CAST_START", "KaraKazham", 232153)

	self:Death("AddsKilled",
		114329, -- Luminore
		114522, -- Mrs. Cauldrons
		114330  -- Babblet
	)
end

function mod:OnEngage()
	self:SetStage(1)
	self:Bar(228019, 6.5) -- Leftovers
	self:Bar(228025, 30) -- Heat Wave
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ENCOUNTER_END(_, engageId, _, _, _, status)
	if engageId == 1957 then
		if status == 0 then
			-- force a respawn timer
			self:SendMessage("BigWigs_EncounterEnd", self, engageId, self.displayName, self:Difficulty(), 5, status)
		else
			self:Win()
		end
	end
end

function mod:HeatWave(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	self:CDBar(args.spellId, 26.7)
end

function mod:Leftovers(args)
	self:Message(args.spellId, "orange")
	if self:Interrupter() then
		self:PlaySound(args.spellId, "alert")
	end
	-- this won't be cast unless someone is in melee range
	self:CDBar(args.spellId, 18.2)
end

function mod:SevereDustingApplied(args)
	local onMe = self:Me(args.destGUID)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:TargetBar(args.spellId, 12, args.destName)
	if onMe then
		self:PlaySound(args.spellId, "warning", nil, args.destName)
		self:Say(args.spellId, nil, nil, "Severe Dusting")
	else
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

function mod:SevereDustingRemoved(args)
	self:StopBar(args.spellId, args.destName)
end

function mod:SultryHeat(args)
	if self:Dispeller("magic", true, args.spellId) then
		self:Message(args.spellId, "yellow", CL.buff_other:format(args.destName, args.spellName))
		self:PlaySound(args.spellId, "warning")
	end
end

function mod:AddsKilled(args)
	local stage = self:GetStage()
	self:Message("stages", "cyan", CL.mob_killed:format(args.destName, stage, 3), false)
	self:PlaySound("stages", "long")
	self:SetStage(stage + 1)

	if self:GetStage() == 4 then
		-- 5.9 seconds after the 3rd boss is killed, the 4th boss becomes active
		self:Bar("stages", 5.9, CL.active, 232156)
	end

	if args.mobId == 114329 then -- Luminore
		self:StopBar(228025) -- Heat Wave
	elseif args.mobId == 114522 then -- Mrs. Cauldrons
		self:StopBar(228019) -- Leftovers
	--elseif args.mobId == 114330 then -- Babblet
	end
end

function mod:SpectralServiceRemoved(args)
	-- Stage 4 begins
	self:StopBar(CL.active)
	self:Message("stages", "cyan", CL.removed:format(args.spellName), args.spellId)
	self:PlaySound("stages", "long")
	self:Bar(227987, 8.5) -- Dinner Bell
	self:Bar(227985, 15.8) -- Dent Armor
end

function mod:DentArmor(args)
	self:TargetMessage(args.spellId, "purple", args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
	self:TargetBar(args.spellId, 8, args.destName)
	self:CDBar(args.spellId, 21.8)
end

function mod:DentArmorRemoved(args)
	self:StopBar(args.spellId, args.destName)
end

function mod:DinnerBell(args)
	self:Message(args.spellId, "yellow")
	if self:Interrupter() then
		self:PlaySound(args.spellId, "alert")
	end
	self:Bar(args.spellId, 12.1)
end

function mod:DinnerBellApplied(args)
	if self:MobId(args.destGUID) == 114328 and self:Dispeller("magic", true) then
		self:Message(args.spellId, "red", CL.buff_other:format(args.destName, args.spellName))
		self:PlaySound(args.spellId, "warning")
	end
end

function mod:KaraKazham(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "info")
	self:Bar(args.spellId, 15.8)
end
