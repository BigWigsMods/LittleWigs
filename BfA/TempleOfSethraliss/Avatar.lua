
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Avatar of Sethraliss", 1877, 2145)
if not mod then return end
mod:RegisterEnableMob(133392, 137204) -- Avatar of Sethraliss, Hoodoo Hexer (boss add)
mod.engageId = 2127
mod.respawnTime = 20

--------------------------------------------------------------------------------
-- Locals
--

local stage = 0
local hexerCount = 4

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.adds = CL.adds
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		"adds",
		268024, -- Pulse
		274149, -- Life Force
		269688, -- Rain of Toads
		{269686, "DISPEL"}, -- Plague
		{268008, "DISPEL"}, -- Snake Charm
		{268007, "TANK"}, -- Heart Attack
	}, {
		["stages"] = "general",
		[268008] = -18295, -- Plague Doctor
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")

	self:Log("SPELL_CAST_SUCCESS", "Taint", 273677)
	self:Log("SPELL_AURA_APPLIED", "Pulse", 268024)
	self:Log("SPELL_AURA_APPLIED", "Plague", 269686)
	self:Log("SPELL_AURA_REMOVED", "PlagueRemoved", 269686)
	self:Log("SPELL_CAST_START", "SnakeCharm", 268008)
	self:Log("SPELL_AURA_APPLIED", "SnakeCharmApplied", 268008)
	self:Log("SPELL_AURA_APPLIED", "LifeForceApplied", 274149)
	self:Log("SPELL_AURA_APPLIED", "HeartAttack", 268007)

	self:Death("HexerDeath", 137204)
end

function mod:OnEngage()
	stage = 0
	hexerCount = 4
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg)
	if msg:find("269688", nil, true) then -- Rain of Toads
		self:Message2(269688, "orange")
		self:PlaySound(269688, "info")
	end
end

do
	local function warnHeartGuardian()
		mod:Message2("adds", "orange", CL.spawned:format(mod:SpellName(-18205)), false) -- Heart Guardian
		mod:PlaySound("adds", "warning")
	end

	local function warnPlagueDoctor()
		mod:Message2("adds", "orange", CL.spawned:format(mod:SpellName(-18295)), false) -- Plague Doctor
		mod:PlaySound("adds", "warning")
	end

	local prev = 0
	function mod:Taint(args)
		local t = args.time
		if t-prev > 2 then
			prev = t
			stage = stage + 1
			hexerCount = 4
			self:Bar("adds", 3.5, CL.spawning:format(self:SpellName(-18205)), 268007) -- Heart Guardian, Heart Attack
			self:SimpleTimer(warnHeartGuardian, 3.5)
			self:Bar("adds", 16.5, CL.spawning:format(self:SpellName(-18295)), 268008) -- Plague Doctor, Snake Charm
			self:SimpleTimer(warnPlagueDoctor, 16.5)
			if stage ~= 1 then -- Don't show on pull
				self:Message2("stages", "cyan", CL.over:format(CL.intermission), false)
				self:PlaySound("stages", "long")
			end
		end
	end
end

do
	local prev = 0
	function mod:Pulse(args)
		local t = args.time
		if t - prev > 2 then
			prev = t
			if self:Healer() then
				self:Message2(args.spellId, "yellow")
				self:PlaySound(args.spellId, "alert")
			end
			self:Bar(args.spellId, 15)
		end
	end
end

function mod:Plague(args)
	if self:Me(args.destGUID) or self:Dispeller("disease", nil, args.spellId) then
		self:TargetMessage2(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
		self:TargetBar(args.spellId, 12, args.destName)
	end
end

function mod:PlagueRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:SnakeCharm(args)
	if not self.isEngaged then return end -- Trash before the boss casts the same spell
	if self:Interrupter() then
		self:Message2(args.spellId, "orange", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:SnakeCharmApplied(args)
	if self:Me(args.destName) or self:Dispeller("magic", nil, args.spellId) then
		self:TargetMessage2(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

function mod:LifeForceApplied(args)
	self:TargetMessage2(args.spellId, "green", args.destName)
	self:PlaySound(args.spellId, "info")
end

function mod:HeartAttack(args)
	if not self.isEngaged then return end -- Trash before the boss casts the same spell
	self:StackMessage(args.spellId, args.destName, args.amount, "purple")
	self:PlaySound(args.spellId, "alert")
end

function mod:HexerDeath(args)
	hexerCount = hexerCount - 1
	if hexerCount > 0 then
		self:Message2("stages", "cyan", CL.add_remaining:format(hexerCount), false)
		self:PlaySound("stages", "info")
	elseif stage ~= 3 then -- 3 is the last phase
		self:Message2("stages", "cyan", CL.intermission, false)
		self:PlaySound("stages", "long")
		self:StopBar(268024) -- Pulse
	end
end
