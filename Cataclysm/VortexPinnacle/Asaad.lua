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

local skyfallNovaCount = 1

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
	skyfallNovaCount = 1
	self:CDBar(87622, 10.6) -- Chain Lightning
	self:Bar(-2434, 15.5, nil, 413263) -- Skyfall Nova
	if not self:Normal() then
		self:Bar(87618, 25.5) -- Static Cling
	end
	self:Bar(86911, 30.5) -- Unstable Grounding Field
	self:CDBar(86930, 40.5) -- Supremacy of the Storm
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
			self:Bar(args.spellId, 64.4)
			self:StopBar(87622) -- Chain Lightning
			self:CDBar(86930, 10) -- Supremacy of the Storm
		end
	end
end

function mod:SupremacyOfTheStorm(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 63.2)
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
		self:StopBar(args.spellId)
	end
end

function mod:ChainLightningSuccess(args)
	-- have to start the timer on success because the boss can interrupt his own cast
	-- TODO pattern?
	-- pull:13.7, 37.7, 19.5, 23.1, 37.7, 19.4, 36.5, 19.4
	-- pull:13.7, 38.9, 19.4, 23.1, 37.6, 19.9, 37.3, 19.5
	-- pull:13.3, 38.1, 19.0, 23.5, 37.6, 19.5, 37.7, 19.5
	-- pull:13.8, 36.5, 19.4, 23.1, 38.9, 19.4, 36.4, 19.5, 37.7, 19.0, 19.4, 38.9, 22.3, 37.7, 19.4, 37.3, 19.4, 19.4, 39.3
	-- 19.0s CD - 2.75s cast
	self:CDBar(args.spellId, 16.3)
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 96260 then -- Summon Skyfall Star
		self:Message(-2434, "cyan", CL.spawned:format(self:SpellName(413263)), 413263) -- Skyfall Nova
		self:PlaySound(-2434, "alert")
		-- pull:16.0, 47.4, 30.4, 49.8, 47.4, 30.4, 48.2, 49.8, 30.4, 49.0, 49.8, 31.1
		skyfallNovaCount = skyfallNovaCount + 1
		if skyfallNovaCount % 3 == 0 then
			self:CDBar(-2434, 30.4, nil, 413263)
		else
			self:CDBar(-2434, 47.4, nil, 413263)
		end
	end
end

do
	local playerList = {}

	function mod:StaticCling(args)
		playerList = {}
		self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "warning")
		-- TODO pattern?
		-- pull:25.5, 63.2, 64.8, 61.6
		-- pull:25.6, 61.9, 64.4, 62.0
		-- pull:28.5, 62.0, 64.4, 60.7
		-- pull:25.3, 61.2, 65.6, 60.8, 61.6, 63.6, 64.4, 61.5
		self:CDBar(args.spellId, 60.7)
	end

	function mod:StaticClingApplied(args)
		if self:Me(args.destGUID) or self:Dispeller("magic") or self:Dispeller("movement") then
			playerList[#playerList + 1] = args.destName
			self:TargetsMessage(args.spellId, "red", playerList, 5)
			self:PlaySound(args.spellId, "alert", nil, playerList)
		end
	end
end
