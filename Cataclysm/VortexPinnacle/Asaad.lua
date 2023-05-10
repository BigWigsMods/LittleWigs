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
	-- pull:13.1, 35.3, 19.5, 18.2, 29.1, 19.4, 18.2, 25.7, 19.5
	-- 18.2s CD - 2.75s cast
	self:CDBar(args.spellId, 15.5)
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 96260 then -- Summon Skyfall Star
		self:Message(-2434, "cyan", CL.spawned:format(self:SpellName(413263)), 413263) -- Skyfall Nova
		self:PlaySound(-2434, "alert")
		-- pull:18.0, 38.9, 25.5, 41.2, 25.6, 37.8
		-- pull:18.2, 39.0, 25.6, 37.7, 25.5, 41.3, 25.5, 41.3, 26.0, 41.3
		skyfallNovaCount = skyfallNovaCount + 1
		if skyfallNovaCount == 2 then
			self:CDBar(-2434, 38.9, nil, 413263)
		elseif skyfallNovaCount % 2 == 0 then
			self:CDBar(-2434, 37.7, nil, 413263)
		else
			self:CDBar(-2434, 25.5, nil, 413263)
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
		-- pull:25.3, 38.9, 29.2, 37.6, 63.4
		-- pull:25.5, 39.0, 63.2, 29.2, 37.7, 28.3, 37.7, 29.2, 38.9
		self:CDBar(args.spellId, 28.3)
	end

	function mod:StaticClingApplied(args)
		if self:Me(args.destGUID) or self:Dispeller("magic") or self:Dispeller("movement") then
			playerList[#playerList + 1] = args.destName
			self:TargetsMessage(args.spellId, "red", playerList, 5)
			self:PlaySound(args.spellId, "alert", nil, playerList)
		end
	end
end
