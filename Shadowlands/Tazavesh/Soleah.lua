--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("So'leah", 2441, 2455)
if not mod then return end
mod:RegisterEnableMob(177269) -- So'leah
mod:SetEncounterID(2442)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.group = "GROUP"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		-- Stage One: Final Preparations
		{350796, "HEALER"}, -- Hyperlight Spark
		353635, -- Collapsing Star
		350804, -- Collapsing Energy
		351124, -- Summon Assassins
		{351119, "NAMEPLATE"}, -- Shuriken Blitz
		-- Stage Two: Power Overwhelming
		351086, -- Power Overwhelming
		350875, -- Hyperlight Jolt
		351096, -- Energy Fragmentation
		351646, -- Hyperlight Nova
		-- Hard Mode
		{357190, "ME_ONLY"}, -- Star Vulnerability
	}, {
		[350796] = -23344, -- Stage One: Final Preparations
		[351086] = -23340, -- Stage Two: Power Overwhelming
		[357190] = CL.hard,
	}
end

function mod:OnBossEnable()
	-- Staging
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1") -- Phase Transition

	-- Stage One: Final Preparations
	self:Log("SPELL_CAST_START", "HyperlightSpark", 350796)
	self:Log("SPELL_CAST_START", "CollapsingStar", 353635)
	self:Log("SPELL_AURA_APPLIED", "CollapsingEnergyApplied", 350804)
	self:Log("SPELL_AURA_APPLIED_DOSE", "CollapsingEnergyApplied", 350804)
	self:Log("SPELL_MISSED", "CollapsingEnergyApplied", 350804)
	self:Log("SPELL_AURA_REMOVED", "CollapsingEnergyRemoved", 350804)
	self:Log("SPELL_CAST_START", "SummonAssassins", 351124)
	self:RegisterEngageMob("SoCartelAssassinEngaged", 177716)
	self:Log("SPELL_CAST_START", "ShurikenBlitz", 351119)
	self:Death("SoCartelAssassinDeath", 177716)

	-- Stage Two: Power Overwhelming
	self:Log("SPELL_CAST_SUCCESS", "PowerOverwhelming", 351086)
	self:Log("SPELL_CAST_START", "HyperlightJolt", 350875)
	self:Log("SPELL_AURA_REMOVED", "PowerOverwhelmingRemoved", 351086)
	self:Log("SPELL_CAST_START", "EnergyFragmentation", 351096)
	self:Log("SPELL_CAST_START", "HyperlightNova", 351646)

	-- Hard Mode
	self:Log("SPELL_AURA_APPLIED", "StarVulnerabilityApplied", 357190)
	self:Log("SPELL_AURA_APPLIED_DOSE", "StarVulnerabilityApplied", 357190)
end

function mod:OnEngage()
	self:SetStage(1)
	self:CDBar(351124, 5.9) -- Summon Assassins
	self:CDBar(350796, 12.0) -- Hyperlight Spark
	self:CDBar(353635, 20.5) -- Collapsing Star
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Staging

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 351104 then -- Phase Transition
		self:SetStage(2)
		self:Message("stages", "cyan", CL.percent:format(40, CL.stage:format(2)), false)
		self:StopBar(350796) -- Hyperlight Spark
		self:StopBar(353635) -- Collapsing Star
		self:StopBar(351124) -- Summon Assassins
		self:PlaySound("stages", "long")
	end
end

-- Stage One: Final Preparations

function mod:HyperlightSpark(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 15.8)
	self:PlaySound(args.spellId, "alert")
end

do
	local starCount = 4
	local explosionTime = 0

	function mod:CollapsingStar(args)
		starCount = 4
		explosionTime = args.time + 30
		self:Message(args.spellId, "red")
		self:Bar(350804, 30, CL.count:format(CL.explosion, starCount))
		if self:GetStage() == 1 then
			self:CDBar(args.spellId, 60.6)
		else
			self:StopBar(args.spellId)
		end
		self:PlaySound(args.spellId, "alarm")
	end

	function mod:CollapsingEnergyApplied(args)
		if self:Me(args.destGUID) then
			-- use :GetPlayerAura to get the correct stack count. more than one stack can be applied at once if the Collapsing Star expires.
			local info = self:GetPlayerAura(args.spellId)
			local stacks = (info and info.applications) or args.amount or 1
			self:Message(args.spellId, "blue", CL.stack:format(stacks, args.spellName, L.group))
			self:StopBar(CL.count:format(CL.explosion, starCount))
			starCount = starCount - 1
			if starCount > 0 and explosionTime - args.time > 0.2 then
				self:Bar(args.spellId, {explosionTime - args.time, 30}, CL.count:format(CL.explosion, starCount))
			end
			self:PlaySound(args.spellId, "alert")
		end
	end

	function mod:CollapsingEnergyRemoved(args)
		if starCount > 0 and self:Me(args.destGUID) then
			self:Message(args.spellId, "green", CL.removed:format(args.spellName))
			self:PlaySound(args.spellId, "info")
		end
	end
end

function mod:SummonAssassins(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 41.2)
	self:PlaySound(args.spellId, "alert")
end

function mod:SoCartelAssassinEngaged(guid) -- no summon event
	self:Nameplate(351119, 5.6, guid) -- Shuriken Blitz
end

function mod:ShurikenBlitz(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:Nameplate(args.spellId, 18.2, args.sourceGUID)
	self:PlaySound(args.spellId, "warning")
end

function mod:SoCartelAssassinDeath(args)
	self:ClearNameplate(args.destGUID)
end

-- Stage Two: Power Overwhelming

do
	local hyperlightJoltCount = 1
	local timer = nil

	function mod:PowerOverwhelming(args)
		if self:GetStage() ~= 2 then -- reload protection
			self:SetStage(2)
		end
		hyperlightJoltCount = 1
		self:Message(args.spellId, "cyan")
		self:StopBar(args.spellId)
		self:PlaySound(args.spellId, "long")
	end

	do
		local function warnHyperlightJolt()
			timer = nil
			mod:Message(350875, "red", CL.count:format(mod:SpellName(350875), hyperlightJoltCount))
			hyperlightJoltCount = hyperlightJoltCount + 1
			mod:PlaySound(350875, "info")
		end

		function mod:HyperlightJolt(args)
			-- if the previous Hyperlight Jolt cleared the last Relic, this cast will be immediately canceled
			-- as Power Overwhelming is removed.
			timer = self:ScheduleTimer(warnHyperlightJolt, 0.2)
		end
	end

	function mod:PowerOverwhelmingRemoved(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:Message(args.spellId, "green", CL.over:format(args.spellName))
		-- TODO min 8.36 to next cast
		-- TODO self:CDBar(351096, 100) -- Energy Fragmentation
		-- TODO self:CDBar(351646, 100) -- Hyperlight Nova
		self:CDBar(353635, 25.4) -- Collapsing Star
		self:CDBar(args.spellId, 65.5)
		self:PlaySound(args.spellId, "long")
	end
end

function mod:EnergyFragmentation(args)
	if self:GetStage() ~= 2 then -- reload protection
		self:SetStage(2)
	end
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 38.9)
	self:PlaySound(args.spellId, "alert")
end

function mod:HyperlightNova(args)
	if self:MobId(args.sourceGUID) == 177269 then -- So'leah
		if self:GetStage() ~= 2 then -- reload protection
			self:SetStage(2)
		end
		self:Message(args.spellId, "orange")
		self:CDBar(args.spellId, 38.9)
		self:PlaySound(args.spellId, "alarm")
	end
end

-- Hard Mode

function mod:StarVulnerabilityApplied(args)
	self:StackMessage(args.spellId, "orange", args.destName, args.amount, 1)
	-- sound covered by :CollapsingEnergyApplied
end
