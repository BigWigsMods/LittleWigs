--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Drahga Shadowburner", 670, 133)
if not mod then return end
mod:RegisterEnableMob(
	40319, -- Drahga Shadowburner
	40320 -- Valiona
)
mod:SetEncounterID(1048)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		-- Drahga Shadowburner
		448013, -- Invocation of Shadowflame
		--{82850, "ME_ONLY", "ME_ONLY_EMPHASIZE"}, -- Flaming Fixate
		{450095, "DISPEL"}, -- Curse of Entropy
		-- Valiona
		456751, -- Twilight Buffet
		-- TODO Devouring Flame (Mythic)
	}, {
		[448013] = -29546, -- Drahga Shadowburner
		[456751] = -29551, -- Valiona
	}
end

function mod:OnBossEnable()
	-- Drahga Shadowburner
	self:Log("SPELL_CAST_START", "InvocationOfShadowflame", 448013)
	--self:Log("SPELL_AURA_APPLIED", "FlamingFixateApplied", 82850) -- aura is hidden
	self:Log("SPELL_AURA_APPLIED", "CurseOfEntropyApplied", 450095)

	-- Valiona
	self:Log("SPELL_CAST_START", "TwilightBuffet", 456751)
	-- TODO DevouringFlame
end

function mod:OnEngage()
	self:SetStage(1)
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT") -- Staging
	self:CDBar(448013, 8.0) -- Invocation of Shadowflame
	self:CDBar(450095, 19.0) -- Curse of Entropy
end

--------------------------------------------------------------------------------
-- Classic Initialization
--

if not BigWigsLoader.isBeta then
	function mod:GetOptions()
		return {
			75218, -- Invocation of Flame
			90950, -- Devouring Flames
		}
	end

	function mod:OnBossEnable()
		-- normal
		self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE", "InvocationOfFlame")
		-- heroic
		self:Log("SPELL_CAST_START", "DevouringFlames", 90950)
	end

	function mod:VerifyEnable()
		-- don't enable if the player is still flying around in a drake
		return not UnitInVehicle("player")
	end

	function mod:OnEngage()
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Stages

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT(event)
	if self:GetBossId(40320) then -- Valiona
		self:SetStage(2)
		self:Message("stages", "cyan", CL.stage:format(2), false)
		self:PlaySound("stages", "long")
		self:CDBar(456751, 14.7) -- Twilight Buffet
		-- TODO adjust other bars?
		self:UnregisterEvent(event)
	end
end

-- Drahga Shadowburner

function mod:InvocationOfShadowflame(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
	if self:GetStage() == 1 then
		self:CDBar(args.spellId, 26.0)
	else
		self:CDBar(args.spellId, 30.0)
	end
end

--function mod:FlamingFixateApplied(args)
	--self:TargetMessage(args.spellId, "red")
	--if self:Me(args.destGUID) then
		--self:PlaySound(args.spellId, "warning", nil, args.destName)
	--else
		--self:PlaySound(args.spellId, "alert", nil, args.destName)
	--end
--end

function mod:CurseOfEntropyApplied(args)
	if self:Dispeller("curse", nil, args.spellId) or self:Healer() or self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
	if self:GetStage() == 1 then
		self:CDBar(args.spellId, 26.0)
	else
		self:CDBar(args.spellId, 30.0)
	end
end

-- Valiona

function mod:TwilightBuffet(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 30.0) -- TODO delayed by something sometimes?
end

--------------------------------------------------------------------------------
-- Classic Event Handlers
--

function mod:InvocationOfFlame(_, msg)
	if msg:find(self:SpellName(75218)) then
		self:MessageOld(75218, "yellow", "alarm", CL.add_spawned)
	end
end

function mod:DevouringFlames(args)
	self:MessageOld(args.spellId, "red", "long")
end
