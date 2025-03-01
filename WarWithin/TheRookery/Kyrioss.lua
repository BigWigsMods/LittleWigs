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

local lightningTorrentCount = 1
local crashingThunderCount = 1
local wildLightningCount = 1
local lightningDashCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{444123, "DISPEL", "CASTBAR"}, -- Lightning Torrent
		1214325, -- Crashing Thunder
		474018, -- Wild Lightning
		419870, -- Lightning Dash
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "LightningTorrent", 444034)
	self:Log("SPELL_CAST_START", "LightningTorrentStart", 1214315)
	self:Log("SPELL_AURA_REMOVED", "LightningTorrentRemoved", 1214315)
	self:Log("SPELL_AURA_APPLIED", "LightningTorrentApplied", 444250)
	self:Log("SPELL_CAST_START", "CrashingThunder", 1214325)
	self:Log("SPELL_CAST_START", "WildLightning", 474018)
	self:Log("SPELL_CAST_START", "LightningDash", 419870)
end

function mod:OnEngage()
	lightningTorrentCount = 1
	crashingThunderCount = 1
	wildLightningCount = 1
	lightningDashCount = 1
	self:SetStage(1)
	self:CDBar(1214325, 5.1) -- Crashing Thunder
	self:CDBar(474018, 9.4) -- Wild Lightning
	self:CDBar(444123, 16.0, CL.count:format(self:SpellName(444123), lightningTorrentCount)) -- Lightning Torrent
	self:CDBar(419870, 38.5, CL.count:format(self:SpellName(419870), lightningDashCount)) -- Lightning Dash
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:LightningTorrent(args)
	self:SetStage(2)
	self:StopBar(CL.count:format(args.spellName, lightningTorrentCount))
	self:Message(444123, "cyan", CL.count:format(args.spellName, lightningTorrentCount))
	lightningTorrentCount = lightningTorrentCount + 1
	self:CDBar(419870, {22.5, 55.9}, CL.count:format(self:SpellName(419870), lightningDashCount)) -- Lightning Dash
	self:CDBar(444123, 55.9, CL.count:format(args.spellName, lightningTorrentCount))
	self:PlaySound(444123, "long")
end

function mod:LightningTorrentStart()
	-- 4s cast, 15s channel
	self:CastBar(444123, 19) -- Lightning Torrent
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
	if crashingThunderCount == 2 then
		self:CDBar(args.spellId, 42.5)
	elseif crashingThunderCount % 2 == 0 then
		self:CDBar(args.spellId, 40.0)
	else
		self:CDBar(args.spellId, 15.8)
	end
	self:PlaySound(args.spellId, "info")
end

function mod:WildLightning(args)
	-- this is also cast by the trash
	if self:MobId(args.sourceGUID) == 209230 then -- Kyrioss
		self:Message(args.spellId, "orange")
		wildLightningCount = wildLightningCount + 1
		if wildLightningCount == 2 then
			self:CDBar(args.spellId, 41.3)
		elseif wildLightningCount % 2 == 0 then
			self:CDBar(args.spellId, 40.0)
		else
			self:CDBar(args.spellId, 15.8)
		end
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:LightningDash(args)
	self:StopBar(CL.count:format(args.spellName, lightningDashCount))
	self:Message(args.spellId, "yellow", CL.count:format(args.spellName, lightningDashCount))
	lightningDashCount = lightningDashCount + 1
	self:CDBar(args.spellId, 55.9, CL.count:format(args.spellName, lightningDashCount))
	self:PlaySound(args.spellId, "alarm")
end
