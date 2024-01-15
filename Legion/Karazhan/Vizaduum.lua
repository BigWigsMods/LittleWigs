--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Viz'aduum the Watcher", 1651, 1838)
if not mod then return end
mod:RegisterEnableMob(114790)
mod:SetEncounterID(2017)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local spammingDisintegrate = false

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- [[ General ]] --
		"stages",
		{229151, "CASTBAR"}, -- Disintegrate
		{229159, "SAY", "SAY_COUNTDOWN"}, -- Chaotic Shadows
		229083, -- Burning Blast

		-- [[ Stages 1 & 2 ]] --
		229284, -- Command: Bombardment

		-- [[ Stage 1 ]] --
		{229248, "SAY"}, -- Fel Beam

		-- [[ Stage 2 ]] --
		229905, -- Soul Harvest

		-- [[ Stage 3 ]] --
		{230084, "CASTBAR"}, -- Stabilize Rift
		230066, -- Shadow Phlegm
	}, {
		["stages"] = "general",
		[229248] = -14412, -- Stage One: Netherspace
		[229905] = -14418, -- Stage Two: Command Ship
		[230084] = -14424, -- Stage Three: The Rift!
	}
end

function mod:OnBossEnable()
	-- [[ General ]] --
	self:Log("SPELL_CAST_START", "Disintegrate", 229151)
	self:Log("SPELL_CAST_SUCCESS", "ChaoticShadows", 229159)
	self:Log("SPELL_AURA_APPLIED", "ChaoticShadowsApplied", 229159)
	self:Log("SPELL_AURA_REMOVED", "ChaoticShadowsRemoved", 229159)
	self:Log("SPELL_CAST_START", "BurningBlast", 229083)
	self:Log("SPELL_AURA_APPLIED", "BurningBlastApplied", 229083)
	self:Log("SPELL_AURA_APPLIED_DOSE", "BurningBlastApplied", 229083)
	self:Log("SPELL_CAST_SUCCESS", "DemonicPortal", 229610)
	self:Log("SWING_DAMAGE", "BossSwing", "*")
	self:Log("SWING_MISSED", "BossSwing", "*")

	-- [[ Stages 1 & 2 ]] --
	self:Log("SPELL_CAST_SUCCESS", "CommandBombardment", 229284)

	-- [[ Stage 1 ]] --
	self:Log("SPELL_AURA_APPLIED", "AcquiringTarget", 229241) -- Fel Beam

	-- [[ Stage 2 ]] --
	self:Log("SPELL_DAMAGE", "SoulHarvest", 229905)
	self:Log("SPELL_MISSED", "SoulHarvest", 229905)

	-- [[ Stage 3 ]] --
	self:Log("SPELL_AURA_APPLIED", "StabilizeRift", 230084)
	self:Log("SPELL_INTERRUPT", "StabilizeRiftInterrupted", "*")
	self:Log("SPELL_CAST_SUCCESS", "ShadowPhlegm", 230066)
end

function mod:OnEngage()
	self:SetStage(1)
	spammingDisintegrate = false
	self:CDBar(229248, 5.9) -- Fel Beam
	self:CDBar(229151, 10.8) -- Disintegrate
	self:CDBar(229159, 15.76) -- Chaotic Shadows
	self:CDBar(229284, 27.9) -- Command: Bombardment
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- [[ General ]] --
function mod:Disintegrate(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
	if not spammingDisintegrate then
		self:CDBar(args.spellId, 10.1)
		self:CastBar(args.spellId, 6.25)
	else
		-- cast time is extra long for the first few casts of p2
		local bossId = self:GetBossId(args.sourceGUID)
		if bossId then
			local _, _, _, startTime, endTime = UnitCastingInfo(bossId)
			if startTime and endTime then
				self:CastBar(args.spellId, (endTime - startTime) / 1000)
			else
				self:CastBar(args.spellId, 6.25)
			end
		else
			self:CastBar(args.spellId, 6.25)
		end
	end
end

do
	local playerList = {}

	function mod:ChaoticShadows(args)
		playerList = {}
		self:CDBar(args.spellId, 32.7)
	end

	function mod:ChaoticShadowsApplied(args)
		-- targets 1 players in stage 1, 2 players in stage 2, 3 players in stage 3
		local expectedTargets = self:GetStage()
		playerList[#playerList+1] = args.destName
		self:TargetsMessage(args.spellId, "red", playerList, expectedTargets)
		self:PlaySound(args.spellId, "warning", nil, playerList)
		if self:Me(args.destGUID) then
			self:Say(args.spellId, nil, nil, "Chaotic Shadows")
			self:SayCountdown(args.spellId, 10)
		end
	end

	function mod:ChaoticShadowsRemoved(args)
		if self:Me(args.destGUID) then
			self:CancelSayCountdown(args.spellId)
		end
	end
end

function mod:BurningBlast(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	if self:Interrupter() then
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:BurningBlastApplied(args)
	if self:Dispeller("magic") then
		self:StackMessage(args.spellId, "red", args.destName, args.amount, 2)
		self:PlaySound(args.spellId, "info")
	end
end

function mod:DemonicPortal()
	if spammingDisintegrate then
		-- in case you skipped phase 2
		spammingDisintegrate = false
		self:SetStage(2)
	end
	self:Message("stages", "cyan", CL.stage:format(self:GetStage() + 1), false)
	self:PlaySound("stages", "long")
	self:StopBar(229151) -- Disintegrate
	self:StopBar(229159) -- Chaotic Shadows
	self:StopBar(229284) -- Command: Bombardment
	if self:GetStage() == 1 then
		spammingDisintegrate = true
		self:StopBar(229248) -- Fel Beam
	else
		self:SetStage(3)
	end
end

-- used to detect when stage 2 really starts, while you're running to the boss he just spams Disintegrate
function mod:BossSwing(args)
	if spammingDisintegrate and self:MobId(args.sourceGUID) == 114790 then
		spammingDisintegrate = false
		self:SetStage(2)

		self:CDBar(229151, 8.5) -- Disintegrate
		self:CDBar(229284, 13.3) -- Command: Bombardment
		self:CDBar(229159, 18.2) -- Chaotic Shadows
	end
end

-- [[ Stages 1 & 2 ]] --
function mod:CommandBombardment(args)
	self:Message(args.spellId, "orange", CL.incoming:format(args.spellName))
	self:CDBar(args.spellId, self:GetStage() == 1 and 40.1 or 25.5)
end

-- [[ Stage 1 ]] --
function mod:AcquiringTarget(args)
	self:TargetMessage(229248, "orange", args.destName) -- Fel Beam
	self:PlaySound(229248, "alarm", nil, args.destName)
	self:CDBar(229248, 41.2)
	if self:Me(args.destGUID) then
		self:Say(229248, nil, nil, "Fel Beam")
	end
end

-- [[ Stage 2 ]] --
do
	local prev = 0
	function mod:SoulHarvest(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 1.5 then
				prev = t
				self:Message(args.spellId, "blue", CL.near:format(args.sourceName)) -- args.sourceName = Soul Harvester
				self:PlaySound(args.spellId, "underyou")
			end
		end
	end
end

-- [[ Stage 3 ]] --
function mod:StabilizeRift(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "long")
	self:CastBar(args.spellId, 30)
end

function mod:StabilizeRiftInterrupted(args)
	if args.extraSpellId == 230084 then -- Stabilize Rift
		self:Message(230084, "green", CL.interrupted_by:format(args.extraSpellName, self:ColorName(args.sourceName)))
		self:PlaySound(230084, "info")
		self:StopBar(CL.cast:format(args.extraSpellName))
		self:CDBar(229159, 6.15) -- Chaotic Shadows
	end
end

do
	local prev = 0
	function mod:ShadowPhlegm(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "alarm")
			self:Bar(args.spellId, 10)
		end
	end
end
