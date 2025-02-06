local isElevenDotOne = select(4, GetBuildInfo()) >= 110100 -- XXX remove when 11.1 is live
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Kyrioss", 2648, 2566)
if not mod then return end
mod:RegisterEnableMob(209230) -- Kyrioss
mod:SetEncounterID(2816)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local chainLightningCount = 1 -- XXX remove when 11.1 is live
local chainLightningTimerCount = 1 -- XXX remove when 11.1 is live
local lightningTorrentCount = 1
local crashingThunderCount = 1
local wildLightningCount = 1
local lightningDashCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

if isElevenDotOne then -- XXX remove this check when 11.1 is live
	function mod:GetOptions()
		return {
			{444123, "DISPEL", "CASTBAR"}, -- Lightning Torrent
			1214325, -- Crashing Thunder
			474018, -- Wild Lightning
			419870, -- Lightning Dash
			-- Mythic
			1214320, -- Grounding Bolt
		}, {
			[1214320] = CL.mythic,
		}
	end
else -- XXX remove the block below when 11.1 is live
	function mod:GetOptions()
		return {
			{444123, "DISPEL"}, -- Lightning Torrent
			419870, -- Lightning Dash
			{424148, "SAY"}, -- Chain Lightning
		}
	end
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "LightningTorrent", 444034)
	if isElevenDotOne then -- XXX remove this check when 11.1 is live
		self:Log("SPELL_CAST_START", "LightningTorrentStart", 1214315)
		self:Log("SPELL_AURA_REMOVED", "LightningTorrentRemoved", 1214315)
	end
	self:Log("SPELL_AURA_APPLIED", "LightningTorrentApplied", 444250)
	if isElevenDotOne then -- XXX remove this check when 11.1 is live
		self:Log("SPELL_CAST_START", "CrashingThunder", 1214325)
		self:Log("SPELL_CAST_START", "WildLightning", 474018)
	else -- XXX remove the block below when 11.1 is live
		self:Log("SPELL_CAST_START", "ChainLightning", 424148)
	end
	self:Log("SPELL_CAST_START", "LightningDash", 419870)

	-- Mythic
	if isElevenDotOne then -- XXX remove this check when 11.1 is live
		-- TODO has this been this removed?
		self:Log("SPELL_PERIODIC_DAMAGE", "GroundingBoltDamage", 1214320)
		self:Log("SPELL_PERIODIC_MISSED", "GroundingBoltDamage", 1214320)
	end
end

function mod:OnEngage()
	chainLightningCount = 1
	chainLightningTimerCount = 1
	lightningTorrentCount = 1
	crashingThunderCount = 1
	wildLightningCount = 1
	lightningDashCount = 1
	self:SetStage(1)
	if isElevenDotOne then -- XXX remove this check when 11.1 is live
		self:CDBar(1214325, 5.1) -- Crashing Thunder
		self:CDBar(474018, 9.5) -- Wild Lightning
		self:CDBar(444123, 16.0, CL.count:format(self:SpellName(444123), lightningTorrentCount)) -- Lightning Torrent
		self:CDBar(419870, 38.5, CL.count:format(self:SpellName(419870), lightningDashCount)) -- Lightning Dash
	else -- XXX remove the block below when 11.1 is live
		self:CDBar(419870, 3.0, CL.count:format(self:SpellName(419870), lightningDashCount)) -- Lightning Dash
		self:CDBar(424148, 7.0, CL.count:format(self:SpellName(424148), chainLightningCount)) -- Chain Lightning
		self:CDBar(444123, 30.0, CL.count:format(self:SpellName(444123), lightningTorrentCount)) -- Lightning Torrent
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:LightningTorrent(args)
	self:SetStage(2)
	self:StopBar(CL.count:format(args.spellName, lightningTorrentCount))
	self:Message(444123, "cyan", CL.count:format(args.spellName, lightningTorrentCount))
	lightningTorrentCount = lightningTorrentCount + 1
	if isElevenDotOne then -- XXX remove this check when 11.1 is live
		self:CDBar(419870, {22.5, 55.9}, CL.count:format(self:SpellName(419870), lightningDashCount)) -- Lightning Dash
		self:CDBar(444123, 55.9, CL.count:format(args.spellName, lightningTorrentCount))
	else -- XXX remove the block below when 11.1 is live
		self:CDBar(419870, {14.4, 41.2}, CL.count:format(self:SpellName(419870), lightningDashCount)) -- Lightning Dash
		self:CDBar(444123, 60.0, CL.count:format(args.spellName, lightningTorrentCount))
	end
	self:PlaySound(444123, "long")
end

function mod:LightningTorrentStart()
	if isElevenDotOne then
		-- 4s cast, 15s channel
		self:CastBar(444123, 19) -- Lightning Torrent
	else -- XXX remove in 11.1
		-- 2s cast, 15s channel
		self:CastBar(444123, 17) -- Lightning Torrent
	end
end

function mod:LightningTorrentRemoved()
	self:SetStage(1)
end

function mod:LightningTorrentApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("magic", nil, 444123) then
		self:TargetMessage(444123, "yellow", args.destName)
		self:PlaySound(444123, "alert", nil, args.destName)
	end
end

function mod:CrashingThunder(args)
	self:Message(args.spellId, "red")
	crashingThunderCount = crashingThunderCount + 1
	if isElevenDotOne then
		if crashingThunderCount == 2 then
			self:CDBar(args.spellId, 42.5)
		elseif crashingThunderCount % 2 == 0 then
			self:CDBar(args.spellId, 40.1)
		else
			self:CDBar(args.spellId, 15.8)
		end
	else -- XXX remove in 11.1
		if crashingThunderCount == 2 then
			self:CDBar(args.spellId, 40.1)
		elseif crashingThunderCount % 2 == 0 then
			self:CDBar(args.spellId, 37.7)
		else
			self:CDBar(args.spellId, 15.8)
		end
	end
	self:PlaySound(args.spellId, "info")
end

function mod:WildLightning(args)
	-- this is also cast by the trash
	if self:MobId(args.sourceGUID) == 209230 then -- Kyrioss
		self:Message(args.spellId, "orange")
		wildLightningCount = wildLightningCount + 1
		if isElevenDotOne then
			if wildLightningCount == 2 then
				self:CDBar(args.spellId, 41.3)
			elseif wildLightningCount % 2 == 0 then
				self:CDBar(args.spellId, 40.1)
			else
				self:CDBar(args.spellId, 15.8)
			end
		else -- XXX remove in 11.1
			if wildLightningCount % 2 == 0 then
				self:CDBar(args.spellId, 37.7)
			else
				self:CDBar(args.spellId, 15.8)
			end
		end
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:LightningDash(args)
	self:StopBar(CL.count:format(args.spellName, lightningDashCount))
	self:Message(args.spellId, "yellow", CL.count:format(args.spellName, lightningDashCount))
	lightningDashCount = lightningDashCount + 1
	if isElevenDotOne then -- XXX remove this check when 11.1 is live
		self:CDBar(args.spellId, 55.9, CL.count:format(args.spellName, lightningDashCount))
	else -- XXX remove the block below when 11.1 is live
		if lightningDashCount % 2 == 0 then
			self:CDBar(args.spellId, 41.2, CL.count:format(args.spellName, lightningDashCount))
		else
			self:CDBar(args.spellId, 17.4, CL.count:format(args.spellName, lightningDashCount))
		end
	end
	self:PlaySound(args.spellId, "alarm")
end

do
	local timer

	local function printTarget(self, name, guid) -- XXX remove with 11.1
		self:TargetMessage(424148, "red", name, CL.count:format(self:SpellName(424148), chainLightningCount - 1))
		if self:Me(guid) then
			self:Say(424148, nil, nil, "Chain Lightning")
		end
		self:PlaySound(424148, "alert", nil, name)
	end

	function mod:ChainLightningSkipped() -- XXX remove with 11.1
		-- if this timer hasn't been canceled Chain Lightning it means the cast was skipped and we should move
		-- on to the next possible timer. note that timers are subtracted by 1s here since that's the extra
		-- time we waited before determining the cast was skipped.
		chainLightningTimerCount = chainLightningTimerCount + 1
		if chainLightningTimerCount % 4 == 2 then
			self:CDBar(424148, 12.0, CL.count:format(self:SpellName(424148), chainLightningCount))
			timer = self:ScheduleTimer("ChainLightningSkipped", 13.0)
		elseif chainLightningTimerCount % 4 == 3 then
			self:CDBar(424148, 27.0, CL.count:format(self:SpellName(424148), chainLightningCount))
			timer = self:ScheduleTimer("ChainLightningSkipped", 28.0)
		elseif chainLightningTimerCount % 4 == 0 then
			self:CDBar(424148, 9.0, CL.count:format(self:SpellName(424148), chainLightningCount))
			timer = self:ScheduleTimer("ChainLightningSkipped", 10.0)
		else
			self:CDBar(424148, 8.0, CL.count:format(self:SpellName(424148), chainLightningCount))
			timer = self:ScheduleTimer("ChainLightningSkipped", 9.0)
		end
	end

	function mod:ChainLightning(args) -- XXX remove with 11.1
		if timer then
			self:CancelTimer(timer)
		end
		self:StopBar(CL.count:format(args.spellName, chainLightningCount))
		chainLightningCount = chainLightningCount + 1
		chainLightningTimerCount = chainLightningTimerCount + 1
		self:GetUnitTarget(printTarget, 0.1, args.sourceGUID)
		-- this cast (especially the 28s CD one) is often skipped, check 1s after it should have happened
		if chainLightningTimerCount % 4 == 2 then
			self:CDBar(args.spellId, 13.0, CL.count:format(args.spellName, chainLightningCount))
			timer = self:ScheduleTimer("ChainLightningSkipped", 14.0)
		elseif chainLightningTimerCount % 4 == 3 then
			self:CDBar(args.spellId, 28.0, CL.count:format(args.spellName, chainLightningCount))
			timer = self:ScheduleTimer("ChainLightningSkipped", 29.0)
		elseif chainLightningTimerCount % 4 == 0 then
			self:CDBar(args.spellId, 10.0, CL.count:format(args.spellName, chainLightningCount))
			timer = self:ScheduleTimer("ChainLightningSkipped", 11.0)
		else
			self:CDBar(args.spellId, 9.0, CL.count:format(args.spellName, chainLightningCount))
			timer = self:ScheduleTimer("ChainLightningSkipped", 10.0)
		end
	end
end

-- Mythic

do
	local prev = 0
	function mod:GroundingBoltDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 1.5 then
			prev = args.time
			self:PersonalMessage(args.spellId, "underyou")
			self:PlaySound(args.spellId, "underyou")
		end
	end
end
