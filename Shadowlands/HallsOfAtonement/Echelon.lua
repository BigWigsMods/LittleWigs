--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Echelon", 2287, 2387)
if not mod then return end
mod:RegisterEnableMob(164185) -- Echelon
mod:SetEncounterID(2380)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local stoneCallCount = 1
local nextBloodTorrent = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		319733, -- Stone Call
		328206, -- Flesh to Stone
		{319941, "SAY", "SAY_COUNTDOWN"}, -- Stone Shattering Leap
		326389, -- Blood Torrent
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "StoneCall", 319733)
	self:Log("SPELL_CAST_START", "FleshToStone", 328206)
	self:Log("SPELL_CAST_START", "StoneShatteringLeap", 319941)
	self:Log("SPELL_CAST_START", "BloodTorrent", 326389)
	self:Log("SPELL_AURA_APPLIED", "BloodTorrentDamage", 319703)
	self:Log("SPELL_PERIODIC_DAMAGE", "BloodTorrentDamage", 319703)
	self:Log("SPELL_PERIODIC_MISSED", "BloodTorrentDamage", 319703)
end

function mod:OnEngage()
	stoneCallCount = 1
	nextBloodTorrent = GetTime() + 4.6
	self:CDBar(326389, 4.6) -- Blood Torrent
	self:CDBar(319733, 9.6) -- Stone Call
	self:CDBar(328206, 20.4) -- Flesh to Stone
	self:CDBar(319941, 23.4) -- Stone Shattering Leap
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:StoneCall(args)
	self:Message(args.spellId, "cyan")
	stoneCallCount = stoneCallCount + 1
	if stoneCallCount % 2 == 0 then
		self:CDBar(args.spellId, 48.5)
	else
		self:CDBar(args.spellId, 42.5)
	end
	self:PlaySound(args.spellId, "long")
end

function mod:FleshToStone(args)
	local t = GetTime()
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 29.1)
	-- 3s to Stone Shattering Leap
	self:CDBar(319941, {3.0, 29.1}) -- Stone Shattering Leap
	-- minimum 9.7s to Blood Torrent
	if nextBloodTorrent - t < 9.7 then
		nextBloodTorrent = t + 9.7
		self:CDBar(326389, {9.7, 17.0}) -- Blood Torrent
	end
	self:PlaySound(args.spellId, "info")
end

do
	local function printTarget(self, name, guid, elapsed)
		self:TargetMessage(319941, "orange", name)
		if self:Me(guid) then
			self:Say(319941, nil, nil, "Stone Shattering Leap")
			self:SayCountdown(319941, 5 - elapsed)
			self:PlaySound(319941, "warning", nil, name)
		else
			self:PlaySound(319941, "alarm", nil, name)
		end
	end

	function mod:StoneShatteringLeap(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
		self:CDBar(args.spellId, 29.1)
	end
end

function mod:BloodTorrent(args)
	self:Message(args.spellId, "orange")
	nextBloodTorrent = GetTime() + 17.0
	self:CDBar(args.spellId, 17.0)
	self:PlaySound(args.spellId, "alert")
end

do
	local prev = 0
	function mod:BloodTorrentDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 2 then
			prev = args.time
			self:PersonalMessage(326389, "underyou")
			self:PlaySound(326389, "underyou")
		end
	end
end
