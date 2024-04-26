--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Asaad", 657, 116)
if not mod then return end
mod:RegisterEnableMob(43875) -- Asaad, Caliph of Zephyrs
mod:SetEncounterID(1042)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local skyfallNovaCount = 1
local skyfallNovaRemaining = 2

--------------------------------------------------------------------------------
-- Initialization
--

local skyfallNovaMarker = mod:AddMarkerOption(true, "npc", 8, mod:Retail() and 413264 or 96260, 8) -- Skyfall Nova or Skyfall Star
function mod:GetOptions()
	return {
		86911, -- Unstable Grounding Field
		86930, -- Supremacy of the Storm
		{87622, "SAY", "ME_ONLY_EMPHASIZE"}, -- Chain Lightning
		413264, -- Skyfall Nova
		skyfallNovaMarker,
		87618, -- Static Cling
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "UnstableGroundingField", 86911)
	self:Log("SPELL_CAST_SUCCESS", "SupremacyOfTheStorm", 86930)
	self:Log("SPELL_CAST_START", "ChainLightning", 87622)
	self:Log("SPELL_CAST_SUCCESS", "ChainLightningSuccess", 87622)
	if self:Retail() then
		self:Log("SPELL_SUMMON", "SummonSkyfallNova", 96260)
	else
		self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1") -- Summon Skyfall Star
	end
	self:Log("SPELL_CAST_START", "StaticCling", 87618)
	self:Log("SPELL_AURA_APPLIED", "StaticClingApplied", 87618)
end

function mod:OnEngage()
	skyfallNovaCount = 1
	skyfallNovaRemaining = 1
	self:CDBar(87622, 12.1) -- Chain Lightning
	self:CDBar(413264, 18.0, CL.count:format(self:SpellName(413264), skyfallNovaCount)) -- Skyfall Nova
	if not self:Normal() then
		self:CDBar(87618, 25.2) -- Static Cling
	end
	self:CDBar(86911, 30.1) -- Unstable Grounding Field
	self:CDBar(86930, 40.2) -- Supremacy of the Storm
end

--------------------------------------------------------------------------------
-- Classic Initialization
--

if mod:Classic() then
	function mod:GetOptions()
		return {
			86911, -- Unstable Grounding Field
			86930, -- Supremacy of the Storm
			{87622, "SAY", "ME_ONLY_EMPHASIZE"}, -- Chain Lightning
			96260, -- Skyfall Star
			87618, -- Static Cling
		}
	end

	function mod:OnEngage()
		if not self:Normal() then
			self:CDBar(87618, 10.7) -- Static Cling
		end
		self:CDBar(96260, 10.7) -- Skyfall Star
		self:CDBar(87622, 14.5) -- Chain Lightning
		self:CDBar(86911, 15.6) -- Unstable Grounding Field
		self:CDBar(86930, 25.2) -- Supremacy of the Storm
	end
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
				self:CDBar(413264, {25.5, 37.7}, CL.count:format(self:SpellName(413264), skyfallNovaCount)) -- Skyfall Nova
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
		self:CDBar(413264, {15.8, 37.7}, CL.count:format(self:SpellName(413264), skyfallNovaCount)) -- Skyfall Nova
		self:CDBar(87618, {23.0, 32.7}) -- Static Cling
	elseif self:Retail() then
		self:CDBar(413264, 15.8, CL.count:format(self:SpellName(413264), skyfallNovaCount)) -- Skyfall Nova
		self:CDBar(87618, 23.0) -- Static Cling
	end
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(87622, "orange", name)
		self:PlaySound(87622, "alarm", nil, name)
		if self:Me(guid) then
			self:Say(87622, nil, nil, "Chain Lightning")
		end
	end

	function mod:ChainLightning(args)
		self:GetUnitTarget(printTarget, 0.2, args.sourceGUID)
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

do
	local skyfallNovaGUID = nil

	function mod:SummonSkyfallNova(args)
		self:StopBar(CL.count:format(self:SpellName(413264), skyfallNovaCount)) -- Skyfall Nova
		self:Message(413264, "cyan", CL.count:format(self:SpellName(413264), skyfallNovaCount))
		self:PlaySound(413264, "alert")
		-- pull:18.2, 39.0, 25.6, 37.7, 25.5, 41.3, 25.5, 41.3, 26.0, 41.3
		skyfallNovaCount = skyfallNovaCount + 1
		skyfallNovaRemaining = skyfallNovaRemaining - 1
		if skyfallNovaRemaining > 0 then
			self:CDBar(413264, 25.5, CL.count:format(self:SpellName(413264), skyfallNovaCount)) -- Skyfall Nova
		else -- delayed until after Supremacy of the Storm
			self:CDBar(413264, 37.7, CL.count:format(self:SpellName(413264), skyfallNovaCount)) -- Skyfall Nova
		end
		-- register events to auto-mark Skyfall Nova
		if self:GetOption(skyfallNovaMarker) then
			skyfallNovaGUID = args.destGUID
			self:RegisterTargetEvents("MarkSkyfallNova")
		end
	end

	function mod:MarkSkyfallNova(_, unit, guid)
		if skyfallNovaGUID == guid then
			skyfallNovaGUID = nil
			self:CustomIcon(skyfallNovaMarker, unit, 8)
			self:UnregisterTargetEvents()
		end
	end
end

do
	local playerList = {}

	function mod:StaticCling(args)
		playerList = {}
		self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "warning")
		if self:Retail() then
			self:CDBar(args.spellId, 29.1)
		else -- Classic
			self:CDBar(args.spellId, 15.8)
		end
	end

	function mod:StaticClingApplied(args)
		if self:Me(args.destGUID) or self:Dispeller("magic") or self:Dispeller("movement") then
			playerList[#playerList + 1] = args.destName
			self:TargetsMessage(args.spellId, "red", playerList, 5)
			self:PlaySound(args.spellId, "alert", nil, playerList)
		end
	end
end

--------------------------------------------------------------------------------
-- Classic Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 96260 then -- Summon Skyfall Star
		self:Message(96260, "cyan")
		self:PlaySound(96260, "alert")
		self:CDBar(96260, 12.1)
	end
end
