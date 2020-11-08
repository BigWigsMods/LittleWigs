
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Viz'aduum the Watcher", 1651, 1838)
if not mod then return end
mod:RegisterEnableMob(114790)
mod.engageId = 2017
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Locals
--

local stage = 1
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
		{230066, "PROXIMITY"}, -- Shadow Phlegm
	}, {
		["stages"] = "general",
		[229248] = CL.stage:format(1),
		[229905] = CL.stage:format(2),
		[230084] = CL.stage:format(3),
	}
end

function mod:OnBossEnable()
	-- [[ General ]] --
	self:Log("SPELL_CAST_START", "Disintegrate", 229151)
	self:Log("SPELL_AURA_APPLIED", "ChaoticShadows", 229159)
	self:Log("SPELL_CAST_SUCCESS", "ChaoticShadowsCast", 229159)
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
end

function mod:OnEngage()
	stage = 1
	longDisintegratesLeft = 0
	self:MessageOld("stages", "green", "info", CL.stage:format(1), false)
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
	self:MessageOld(args.spellId, "yellow", "alarm", CL.casting:format(args.spellName))
	if (stage ~= 1.5) then
		self:CDBar(args.spellId, 12.1)
	end
	if longDisintegratesLeft > 0 then
		longDisintegratesLeft = longDisintegratesLeft - 1
		self:CastBar(args.spellId, 4)
	else
		self:CastBar(args.spellId, 2.5)
	end
end

do
	local list = mod:NewTargetList()
	function mod:ChaoticShadows(args)
		list[#list+1] = args.destName
		if #list == 1 then
			self:ScheduleTimer("TargetMessageOld", 0.5, args.spellId, list, "red", "warning", nil, nil, self:Dispeller("magic"))
		end
		if self:Me(args.destGUID) then
			self:Say(args.spellId)
		end
	end

	function mod:ChaoticShadowsCast(args) -- debuff applications are delayed
		self:CDBar(args.spellId, 35.2) -- 35.2 - 38.9
	end
end

function mod:BurningBlast(args)
	self:MessageOld(args.spellId, "yellow", self:Interrupter() and "alert", CL.casting:format(args.spellName))
end

function mod:BurningBlastApplied(args)
	if self:Dispeller("magic") then
		self:StackMessage(args.spellId, args.destName, args.amount, "red", "info")
	end
end

function mod:DemonicPortal()
	self:MessageOld("stages", "green", "info", CL.stage:format(stage + 1), false)
	self:StopBar(229151) -- Disintegrate
	self:StopBar(229159) -- Chaotic Shadows
	self:StopBar(229284) -- Command: Bombardment
	if (stage == 1) then
		stage = 1.5 -- Stage 2 before anyone gets to melee range
		longDisintegratesLeft = 3
		self:StopBar(229248) -- Fel Beam

		self:Log("SWING_DAMAGE", "BossSwing", "*") -- I can't find a better way to find out when he stops spamming Disintegrate
		self:Log("SWING_MISSED", "BossSwing", "*")
	else
		stage = 3
		self:OpenProximity(230066, 6) -- Shadow Phlegm
	end
end

function mod:BossSwing(args)
	if self:MobId(args.sourceGUID) == 114790 then
		stage = 2

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
		self:MessageOld(spellId, "orange", nil, CL.incoming:format(self:SpellName(229287))) -- 229287 = Bombardment
		self:CDBar(spellId, stage == 1 and 40.1 or 25.5)
	end
end

-- [[ Stage 1 ]] --
function mod:AcquiringTarget(args)
	self:TargetMessageOld(229248, args.destName, "orange", "alarm")
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
				self:MessageOld(args.spellId, "blue", "alert", CL.near:format(args.sourceName)) -- args.sourceName = Soul Harvester
			end
		end
	end
end

-- [[ Stage 3 ]] --
function mod:StabilizeRift(args)
	self:MessageOld(args.spellId, "orange", "alarm", CL.casting:format(args.spellName))
	self:CastBar(args.spellId, 30)
end

function mod:StabilizeRiftInterrupted(args)
	if args.extraSpellId == 230084 then -- Stabilize Rift
		self:MessageOld(230084, "green", nil, CL.interrupted_by:format(args.extraSpellName, self:ColorName(args.sourceName)))
		self:StopBar(CL.cast:format(args.extraSpellName))
		self:CDBar(229159, 6.15) -- Chaotic Shadows
	end
end
