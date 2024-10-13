--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Fangs of the Queen", 2669, 2595)
if not mod then return end
mod:RegisterEnableMob(
	216648, -- Nx
	216649 -- Vx
)
mod:SetEncounterID(2908)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.warmup_icon = "inv_achievement_dungeon_cityofthreads"
	L.ice_sickles_trigger = "...and the frost bites!"
end

--------------------------------------------------------------------------------
-- Locals
--

local synergicStepCount = 1
local shadeSlashCount = 1
local duskbringerCount = 1
local iceSicklesCount = 1
local rimeDaggerCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		-- Stages
		441384, -- Synergic Step
		-- Stage One: Nx, the Shrouded Fang
		439621, -- Shade Slash (Nx)
		439692, -- Duskbringer (Nx)
		{440218, "DISPEL"}, -- Ice Sickles (Vx)
		-- Stage Two: Vx, the Frosted Fang
		440468, -- Rime Dagger (Vx)
		{441298, "SAY"}, -- Freezing Blood (Vx)
		458741, -- Frozen Solid (Vx)
	}, {
		[439621] = -29960, -- Stage One: Nx, the Shrouded Fang
		[440468] = -29961, -- Stage Two: Vx, the Frosted Fang
	}
end

function mod:OnBossEnable()
	-- Stages
	self:Log("SPELL_CAST_START", "SynergicStep", 441384)

	-- Stage One: Nx, the Shrouded Fang
	self:Log("SPELL_CAST_START", "ShadeSlash", 439621)
	self:Log("SPELL_CAST_START", "Duskbringer", 439692)
	self:Log("SPELL_CAST_START", "IceSickles", 440218)
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL") -- Ice Sickles backup
	self:Log("SPELL_AURA_APPLIED", "IceSicklesApplied", 440238)

	-- Stage Two: Vx, the Frosted Fang
	self:Log("SPELL_CAST_START", "RimeDagger", 440468)
	self:Log("SPELL_AURA_APPLIED", "FreezingBloodApplied", 441298)
	self:Log("SPELL_AURA_APPLIED", "FrozenSolidApplied", 458741)
end

function mod:OnEngage()
	synergicStepCount = 1
	shadeSlashCount = 1
	duskbringerCount = 1
	iceSicklesCount = 1
	rimeDaggerCount = 1
	self:StopBar(CL.active)
	self:SetStage(1)
	self:CDBar(439621, 4.8, CL.count:format(self:SpellName(439621), shadeSlashCount)) -- Shade Slash
	self:CDBar(439692, 20.1, CL.count:format(self:SpellName(439692), duskbringerCount)) -- Duskbringer
	self:CDBar(440218, 21.6, CL.count:format(self:SpellName(440218), iceSicklesCount)) -- Ice Sickles
	self:CDBar(441384, 28.2, CL.count:format(self:SpellName(441384), synergicStepCount)) -- Synergic Step
	self:CDBar(440468, 54.6, CL.count:format(self:SpellName(440468), rimeDaggerCount)) -- Rime Dagger
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Warmup

function mod:Warmup() -- called from trash module
	-- 7.94 [CHAT_MSG_MONSTER_SAY] The Transformatory was once the home of our sacred evolution.#Executor Nizrek
	-- 31.81 [NAME_PLATE_UNIT_ADDED] Nx
	self:Bar("warmup", 25.7, CL.active, L.warmup_icon)
end

-- Stages

function mod:SynergicStep(args)
	self:StopBar(CL.count:format(args.spellName, synergicStepCount))
	self:Message(args.spellId, "cyan", CL.count:format(args.spellName, synergicStepCount))
	synergicStepCount = synergicStepCount + 1
	if self:GetStage() == 1 then -- entering stage 2
		self:SetStage(2)
		self:CDBar(args.spellId, 47.9, CL.count:format(args.spellName, synergicStepCount))
	else -- entering stage 1
		self:SetStage(1)
		self:CDBar(args.spellId, 47.6, CL.count:format(args.spellName, synergicStepCount))
	end
	self:PlaySound(args.spellId, "long")
end

-- Stage One: Nx, the Shrouded Fang

function mod:ShadeSlash(args)
	self:StopBar(CL.count:format(args.spellName, shadeSlashCount))
	self:Message(args.spellId, "red", CL.count:format(args.spellName, shadeSlashCount))
	shadeSlashCount = shadeSlashCount + 1
	if shadeSlashCount % 2 == 0 then
		self:CDBar(args.spellId, 9.4, CL.count:format(args.spellName, shadeSlashCount))
	else
		self:CDBar(args.spellId, 87.9, CL.count:format(args.spellName, shadeSlashCount))
	end
	self:PlaySound(args.spellId, "alarm")
end

function mod:Duskbringer(args)
	self:StopBar(CL.count:format(args.spellName, duskbringerCount))
	self:Message(args.spellId, "orange", CL.count:format(args.spellName, duskbringerCount))
	duskbringerCount = duskbringerCount + 1
	-- TODO the Stage 2 Duskbringer casts can be skipped if Nx is busy casting his filler
	if self:GetStage() == 1 then
		self:CDBar(args.spellId, 44.4, CL.count:format(args.spellName, duskbringerCount))
	else -- Stage 2
		self:CDBar(args.spellId, 50.8, CL.count:format(args.spellName, duskbringerCount))
	end
	self:PlaySound(args.spellId, "alarm")
end

do
	local prev = 0
	local playerList = {}

	function mod:IceSickles(args)
		prev = GetTime()
		playerList = {}
		self:StopBar(CL.count:format(args.spellName, iceSicklesCount))
		self:Message(args.spellId, "yellow", CL.count:format(args.spellName, iceSicklesCount))
		iceSicklesCount = iceSicklesCount + 1
		self:CDBar(args.spellId, 96.2, CL.count:format(args.spellName, iceSicklesCount))
		self:PlaySound(args.spellId, "alert")
	end

	function mod:CHAT_MSG_MONSTER_YELL(_, msg)
		if msg == L.ice_sickles_trigger then
			local t = GetTime()
			if t - prev > 10 then
				-- the cast event is unreliable, show the alert a bite late using the yell if it didn't log
				prev = t
				playerList = {}
				self:StopBar(CL.count:format(self:SpellName(440218), iceSicklesCount))
				self:Message(440218, "yellow", CL.count:format(self:SpellName(440218), iceSicklesCount))
				iceSicklesCount = iceSicklesCount + 1
				-- yell is ~1.5s after cast start
				self:CDBar(440218, 94.7, CL.count:format(self:SpellName(440218), iceSicklesCount))
				self:PlaySound(440218, "alert")
			end
		end
	end

	function mod:IceSicklesApplied(args)
		local t = GetTime()
		if t - prev > 10 then
			-- the cast event is unreliable, take care of playerList and timers if it didn't log
			-- and we don't have the yell translated
			prev = t
			playerList = {}
			self:StopBar(CL.count:format(args.spellName, iceSicklesCount))
			iceSicklesCount = iceSicklesCount + 1
			-- debuff applied ~4s after cast start
			self:CDBar(440218, 92.2, CL.count:format(args.spellName, iceSicklesCount))
		end
		-- this slows but cannot be dispelled by movement-dispelling effects
		if self:Dispeller("magic", nil, 440218) then
			self:TargetsMessage(440218, "yellow", playerList, 5)
			self:PlaySound(440218, "alert", nil, playerList)
		end
	end
end

-- Stage Two: Vx, the Frosted Fang

function mod:RimeDagger(args)
	self:StopBar(CL.count:format(args.spellName, rimeDaggerCount))
	self:Message(args.spellId, "purple", CL.count:format(args.spellName, rimeDaggerCount))
	rimeDaggerCount = rimeDaggerCount + 1
	if rimeDaggerCount % 2 == 0 then
		self:CDBar(args.spellId, 9.4, CL.count:format(args.spellName, rimeDaggerCount))
	else
		self:CDBar(args.spellId, 88.0, CL.count:format(args.spellName, rimeDaggerCount))
	end
	self:PlaySound(args.spellId, "alarm")
end

function mod:FreezingBloodApplied(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	if self:Me(args.destGUID) then
		self:Yell(args.spellId, nil, nil, "Freezing Blood")
	end
	self:PlaySound(args.spellId, "info", nil, args.destName)
end

function mod:FrozenSolidApplied(args)
	-- this only happens if Rime Dagger is cast again without the tank removing Freezing Blood
	self:TargetMessage(args.spellId, "purple", args.destName)
	self:PlaySound(args.spellId, "warning", nil, args.destName)
end
