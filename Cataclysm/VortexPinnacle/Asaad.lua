--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Asaad", 657, 116)
if not mod then return end
mod:RegisterEnableMob(43875)
mod:SetEncounterID(1042)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local skyfallNovaRemaining = 2

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		86911, -- Unstable Grounding Field
		86930, -- Supremacy of the Storm
		{87622, "SAY"}, -- Chain Lightning
		-2434, -- Skyfall Nova
		87618, -- Static Cling
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "UnstableGroundingField", 86911)
	self:Log("SPELL_CAST_SUCCESS", "SupremacyOfTheStorm", 86930)
	self:Log("SPELL_CAST_START", "ChainLightning", 87622)
	self:Log("SPELL_CAST_SUCCESS", "ChainLightningSuccess", 87622)
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1") -- Summon Skyfall Star
	self:Log("SPELL_CAST_START", "StaticCling", 87618)
	self:Log("SPELL_AURA_APPLIED", "StaticClingApplied", 87618)
end

function mod:OnEngage()
	skyfallNovaRemaining = 1
	self:CDBar(87622, 12.1) -- Chain Lightning
	self:CDBar(-2434, 18.0, nil, 413263) -- Skyfall Nova
	if not self:Normal() then
		self:CDBar(87618, 25.2) -- Static Cling
	end
	self:CDBar(86911, 30.1) -- Unstable Grounding Field
	self:CDBar(86930, 40.2) -- Supremacy of the Storm
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prev = 0
	function mod:UnstableGroundingField(args)
		-- throttle because boss applies this twice sometimes
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "green")
			self:PlaySound(args.spellId, "info")
			self:CDBar(args.spellId, 63.2)
			self:CDBar(86930, 10) -- Supremacy of the Storm
			if self:Mythic() then
				-- this starts a 17s sequence, restart timers
				-- scoped to Mythic because in other difficulties you can interrupt the boss
				self:CDBar(87622, 17.0) -- Chain Lightning
				-- puts Skyfall Nova and Static Cling on CD
				self:CDBar(-2434, {25.5, 37.7}, nil, 413263) -- Skyfall Nova
				self:CDBar(87618, 32.7) -- Static Cling
			end
		end
	end
end

function mod:SupremacyOfTheStorm(args)
	skyfallNovaRemaining = 2
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 63.2)
	-- start timers, (in Mythic these are initially started in UnstableGroundingField)
	if self:Mythic() then
		self:CDBar(-2434, {15.8, 37.7}, nil, 413263) -- Skyfall Nova
		self:CDBar(87618, {23.0, 32.7}) -- Static Cling
	else
		self:CDBar(-2434, 15.8, nil, 413263) -- Skyfall Nova
		self:CDBar(87618, 23.0) -- Static Cling
	end
end

do
	local function printTarget(self, player, guid)
		if self:Me(guid) then
			self:PersonalMessage(87622)
			self:PlaySound(87622, "alarm")
			self:Say(87622)
		else
			self:TargetMessage(87622, "orange", player)
			self:PlaySound(87622, "alarm", nil, player)
		end
	end

	function mod:ChainLightning(args)
		self:GetBossTarget(printTarget, 0.2, args.sourceGUID)
		if not self:Mythic() then
			-- this is interruptible in non-Mythic so need to restart bar here
			self:CDBar(args.spellId, 18.2)
		end
	end
end

function mod:ChainLightningSuccess(args)
	if self:Mythic() then
		-- start the timer on success because the boss can interrupt his own cast
		-- 18.2s CD - 2.75s cast
		self:CDBar(args.spellId, 15.5)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 96260 then -- Summon Skyfall Star
		self:Message(-2434, "cyan", CL.spawned:format(self:SpellName(413263)), 413263) -- Skyfall Nova
		self:PlaySound(-2434, "alert")
		-- pull:18.2, 39.0, 25.6, 37.7, 25.5, 41.3, 25.5, 41.3, 26.0, 41.3
		skyfallNovaRemaining = skyfallNovaRemaining - 1
		if skyfallNovaRemaining > 0 then
			self:CDBar(-2434, 25.5, nil, 413263)
		else -- delayed until after Supremacy of the Storm
			self:CDBar(-2434, 37.7, nil, 413263)
		end
	end
end

do
	local playerList = {}

	function mod:StaticCling(args)
		playerList = {}
		self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "warning")
		self:CDBar(args.spellId, 29.1)
	end

	function mod:StaticClingApplied(args)
		if self:Me(args.destGUID) or self:Dispeller("magic") or self:Dispeller("movement") then
			playerList[#playerList + 1] = args.destName
			self:TargetsMessage(args.spellId, "red", playerList, 5)
			self:PlaySound(args.spellId, "alert", nil, playerList)
		end
	end
end
