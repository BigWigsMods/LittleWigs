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
-- Locals
--

local invocationOfShadowflameCount = 1
local twilightBuffetCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		-- Drahga Shadowburner
		448013, -- Invocation of Shadowflame (Add)
		--{82850, "ME_ONLY", "ME_ONLY_EMPHASIZE"}, -- Flaming Fixate
		{450095, "DISPEL"}, -- Curse of Entropy
		-- Valiona
		456751, -- Twilight Buffet
		448105, -- Devouring Flame (Mythic)
	}, {
		[448013] = -29546, -- Drahga Shadowburner
		[456751] = -29551, -- Valiona
	}, {
		[448013] = CL.add, -- Invocation of Shadowflame (Add)
		[448105] = CL.mythic, -- Devouring Flame (Mythic)
	}
end

function mod:OnBossEnable()
	-- Stages
	self:Log("SPELL_CAST_SUCCESS", "TwilightProtection", 76303)

	-- Drahga Shadowburner
	self:Log("SPELL_CAST_START", "InvocationOfShadowflame", 448013)
	--self:Log("SPELL_AURA_APPLIED", "FlamingFixateApplied", 82850) -- aura is hidden
	self:Log("SPELL_CAST_SUCCESS", "CurseOfEntropy", 450095)
	self:Log("SPELL_AURA_APPLIED", "CurseOfEntropyApplied", 450095)

	-- Valiona
	self:Log("SPELL_CAST_START", "TwilightBuffet", 456751)
	self:Log("SPELL_CAST_START", "DevouringFlame", 448105)
end

function mod:OnEngage()
	invocationOfShadowflameCount = 1
	twilightBuffetCount = 1
	self:SetStage(1)
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT") -- Staging
	self:CDBar(448013, 8.0, CL.count:format(CL.add, invocationOfShadowflameCount)) -- Invocation of Shadowflame
	self:CDBar(450095, 19.0) -- Curse of Entropy
end

--------------------------------------------------------------------------------
-- Classic Initialization
--

if mod:Classic() then
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

function mod:TwilightProtection(args)
	self:StopBar(CL.count:format(CL.add, invocationOfShadowflameCount)) -- Invocation of Shadowflame
	self:StopBar(450095) -- Curse of Entropy
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT(event)
	if self:GetBossId(40320) then -- Valiona
		self:UnregisterEvent(event)
		self:SetStage(2)
		self:Message("stages", "cyan", CL.stage:format(2), false)
		self:PlaySound("stages", "long")
		self:CDBar(448013, 6.6, CL.count:format(CL.add, invocationOfShadowflameCount)) -- Invocation of Shadowflame
		self:CDBar(456751, 14.6, CL.count:format(self:SpellName(456751), twilightBuffetCount)) -- Twilight Buffet
		self:CDBar(450095, 18.6) -- Curse of Entropy
		if self:Mythic() then
			self:CDBar(448105, 21.7) -- Devouring Flame
		end
	end
end

-- Drahga Shadowburner

function mod:InvocationOfShadowflame(args)
	self:StopBar(CL.count:format(CL.add, invocationOfShadowflameCount))
	self:Message(args.spellId, "yellow", CL.count:format(CL.add_spawning, invocationOfShadowflameCount))
	self:PlaySound(args.spellId, "info")
	invocationOfShadowflameCount = invocationOfShadowflameCount + 1
	if self:GetStage() == 1 then
		self:CDBar(args.spellId, 26.0, CL.count:format(CL.add, invocationOfShadowflameCount))
	else
		self:CDBar(args.spellId, 30.0, CL.count:format(CL.add, invocationOfShadowflameCount))
	end
end

--function mod:FlamingFixateApplied(args)
	--self:TargetMessage(args.spellId, "red", args.destName)
	--if self:Me(args.destGUID) then
		--self:PlaySound(args.spellId, "warning", nil, args.destName)
	--else
		--self:PlaySound(args.spellId, "alert", nil, args.destName)
	--end
--end

do
	local playerList = {}

	function mod:CurseOfEntropy(args)
		playerList = {}
		if self:GetStage() == 1 then
			self:CDBar(args.spellId, 26.0)
		else
			self:CDBar(args.spellId, 30.0)
		end
	end

	function mod:CurseOfEntropyApplied(args)
		-- TODO this slows but is not dispelled by movement-dispelling effects
		if self:Dispeller("curse", nil, args.spellId) or self:Healer() or self:Me(args.destGUID) then
			playerList[#playerList + 1] = args.destName
			self:PlaySound(args.spellId, "alert", nil, playerList)
			self:TargetsMessage(args.spellId, "red", playerList, 3)
		end
	end
end

-- Valiona

function mod:TwilightBuffet(args)
	self:StopBar(CL.count:format(args.spellName, twilightBuffetCount))
	self:Message(args.spellId, "orange", CL.count:format(args.spellName, twilightBuffetCount))
	self:PlaySound(args.spellId, "alarm")
	twilightBuffetCount = twilightBuffetCount + 1
	self:CDBar(args.spellId, 30.0, CL.count:format(args.spellName, twilightBuffetCount))
end

function mod:DevouringFlame(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 30.0)
end

--------------------------------------------------------------------------------
-- Classic Event Handlers
--

function mod:InvocationOfFlame(_, msg)
	if msg:find(self:SpellName(75218)) then
		self:Message(75218, "yellow", CL.add_spawned)
		self:PlaySound(75218, "info")
	end
end

function mod:DevouringFlames(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end
