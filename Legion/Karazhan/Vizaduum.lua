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
local longDisintegratesLeft = 0 -- first 3 Disintegrates during stage 2 take longer to cast

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- [[ General ]] --
		"stages",
		229151, -- Disintegrate
		{229159, "SAY"}, -- Chaotic Shadows
		229083, -- Burning Blast

		-- [[ Stages 1 & 2 ]] --
		229284, -- Command: Bombardment

		-- [[ Stage 1 ]] --
		{229248, "SAY"}, -- Fel Beam

		-- [[ Stage 2 ]] --
		229905, -- Soul Harvest

		-- [[ Stage 3 ]] --
		230084, -- Stabilize Rift
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
	self:Log("SPELL_CAST_SUCCESS", "ChaoticShadowsCast", 229159)
	self:Log("SPELL_AURA_APPLIED", "ChaoticShadowsApplied", 229159)
	self:Log("SPELL_CAST_START", "BurningBlast", 229083)
	self:Log("SPELL_AURA_APPLIED", "BurningBlastApplied", 229083)
	self:Log("SPELL_AURA_APPLIED_DOSE", "BurningBlastApplied", 229083)
	self:Log("SPELL_CAST_SUCCESS", "DemonicPortal", 229610)

	-- [[ Stages 1 & 2 ]] --
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1") -- Command: Bombardment

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
	longDisintegratesLeft = 0
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
		-- TODO confirm this stuff
		if longDisintegratesLeft > 0 then
			longDisintegratesLeft = longDisintegratesLeft - 1
			self:CastBar(args.spellId, 10)
		else
			self:CastBar(args.spellId, 2.5)
		end
	end
end

do
	local playerList = {}

	function mod:ChaoticShadowsCast(args) -- debuff applications are delayed
		playerList = {}
		self:CDBar(args.spellId, 35.2) -- 35.2 - 38.9
	end

	function mod:ChaoticShadowsApplied(args)
		-- targets 1 players in stage 1, 2 players in stage 2, 3 players in stage 3
		local expectedTargets = self:GetStage()
		playerList[#playerList+1] = args.destName
		self:NewTargetsMessage(args.spellId, "red", playerList, expectedTargets)
		self:PlaySound(args.spellId, "warning", playerList)
		if self:Me(args.destGUID) then
			self:Say(args.spellId)
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
		self:NewStackMessage(args.spellId, "red", args.destName, args.amount)
		self:PlaySound(args.spellId, "info")
	end
end

function mod:DemonicPortal()
	self:Message("stages", "cyan", CL.stage:format(self:GetStage() + 1), false)
	self:PlaySound("stages", "long")
	self:StopBar(229151) -- Disintegrate
	self:StopBar(229159) -- Chaotic Shadows
	self:StopBar(229284) -- Command: Bombardment
	if self:GetStage() == 1 then
		spammingDisintegrate = true
		longDisintegratesLeft = 3
		self:StopBar(229248) -- Fel Beam

		self:Log("SWING_DAMAGE", "BossSwing", "*") -- I can't find a better way to find out when he stops spamming Disintegrate
		self:Log("SWING_MISSED", "BossSwing", "*")
	else
		self:SetStage(3)
	end
end

function mod:BossSwing(args)
	if self:MobId(args.sourceGUID) == 114790 then
		spammingDisintegrate = false
		self:SetStage(2)

		self:RemoveLog("SWING_DAMAGE", "*")
		self:RemoveLog("SWING_MISSED", "*")

		self:CDBar(229151, 8.5) -- Disintegrate
		self:CDBar(229284, 13.3) -- Command: Bombardment
		self:CDBar(229159, 18.2) -- Chaotic Shadows
	end
end

-- [[ Stages 1 & 2 ]] --
function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 229284 then -- Command: Bombardment
		self:Message(spellId, "orange", CL.incoming:format(self:SpellName(229287))) -- 229287 = Bombardment
		self:CDBar(spellId, self:GetStage() == 1 and 40.1 or 25.5)
	end
end

-- [[ Stage 1 ]] --
function mod:AcquiringTarget(args)
	self:TargetMessage(229248, "orange", args.destName)
	self:PlaySound(229248, "alarm", args.destName)
	self:CDBar(229248, 41.2)
	if self:Me(args.destGUID) then
		self:Say(229248)
	end
end

-- [[ Stage 2 ]] --
do
	local prev = 0
	function mod:SoulHarvest(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
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
		local t = GetTime()
		if t - prev > 1.5 then
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "alarm")
			self:Bar(args.spellId, 10)
		end
	end
end
