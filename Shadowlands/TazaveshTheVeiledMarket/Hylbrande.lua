--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Hylbrande", 2441, 2448)
if not mod then return end
mod:RegisterEnableMob(175663) -- Hylbrande
mod:SetEncounterID(2426)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local sanitizingCycleTime = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		346971, -- [DNT] Summon Vault Defender
		353312, -- Purifying Burst
		{346116, "TANK"}, -- Shearing Swings
		347094, -- Titanic Crash
		{346957, "SAY"}, -- Purged by Fire
		346766, -- Sanitizing Cycle
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_WHISPER")
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Log("SPELL_CAST_START", "PurifyingBurst", 353312)
	self:Log("SPELL_CAST_SUCCESS", "ShearingSwings", 346116)
	self:Log("SPELL_CAST_START", "TitanicCrash", 347094)
	self:Log("SPELL_CAST_START", "PurgedByFire", 346957)
	self:Log("SPELL_DAMAGE", "PurgedByFireDamage", 346960)
	self:Log("SPELL_CAST_START", "SanitizingCycle", 346766)
	self:Log("SPELL_AURA_REMOVED", "SanitizingCycleRemoved", 346766)
end

function mod:OnEngage()
	sanitizingCycleTime = GetTime() + 38.8
	self:Bar(353312, 5.6) -- Purifying Burst
	self:Bar(346116, 8.1) -- Shearing Swings
	self:Bar(346957, 10.5) -- Purged by Fire
	self:Bar(347094, 15.4) -- Titanic Crash
	self:Bar(346971, 19, CL.adds) -- [DNT] Summon Vault Defender
	self:Bar(346766, 38.8) -- Sanitizing Cycle
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 346971 then -- [DNT] Summon Vault Defender
		self:Message(spellId, "yellow", CL.add_spawned)
		self:PlaySound(spellId, "info")
		if sanitizingCycleTime - GetTime() > 29.1 then -- Sanitizing Cycle
			self:Bar(spellId, 29.1, CL.adds)
		end
	end
end

function mod:PurifyingBurst(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
	if sanitizingCycleTime - GetTime() > 21.8 then -- Sanitizing Cycle
		self:CDBar(args.spellId, 21.8)
	end
end

function mod:ShearingSwings(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	if sanitizingCycleTime - GetTime() > 10.9 then -- Sanitizing Cycle
		self:CDBar(args.spellId, 10.9)
	end
end

function mod:TitanicCrash(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	if sanitizingCycleTime - GetTime() > 23.1 then -- Sanitizing Cycle
		self:Bar(args.spellId, 23.1)
	end
end

do
	local prev = 0
	function mod:CHAT_MSG_RAID_BOSS_WHISPER(_, _, _, _, _, playerName)
		-- "Titanic Defense Turret acquires a new target."
		prev = GetTime()
		self:TargetMessage(346957, "blue", playerName) -- Purged By Fire
		self:PlaySound(346957, "warning") -- Purged By Fire
		self:Say(346957) -- Purged By Fire
	end
	local function warnPurgedByFire()
		if GetTime() - prev > 1 then
			mod:Message(346957, "orange") -- Purged By Fire
			mod:PlaySound(346957, "alert") -- Purged By Fire
		end
	end
	function mod:PurgedByFire(args)
		self:SimpleTimer(warnPurgedByFire, 0.1)
		if sanitizingCycleTime - GetTime() > 17 then -- Sanitizing Cycle
			self:Bar(args.spellId, 17)
		end
	end
end

do
	local prev = 0
	function mod:PurgedByFireDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 1 then
				prev = t
				self:PersonalMessage(346957, "underyou")
				self:PlaySound(346957, "underyou")
			end
		end
	end
end

do
	local prev = 0
	function mod:SanitizingCycle(args)
		-- SPELL_CAST_START fires twice for this spell at the exact same time
		local t = args.time
		if t-prev > 1.5 then
			prev = t
			sanitizingCycleTime = 0
			self:Message(args.spellId, "cyan")
			self:PlaySound(args.spellId, "long")
			self:StopBar(args.spellId)
			self:StopBar(353312) -- Purifying Burst
			self:StopBar(346116) -- Shearing Swings
			self:StopBar(346957) -- Purged by Fire
			self:StopBar(CL.adds) -- [DNT] Summon Vault Defender
			self:StopBar(347094) -- Titanic Crash
		end
	end
end

function mod:SanitizingCycleRemoved(args)
	sanitizingCycleTime = GetTime() + 70
	self:Message(args.spellId, "cyan", CL.over:format(args.spellName))
	self:PlaySound(args.spellId, "long")
	self:Bar(args.spellId, 70)
	self:Bar(353312, 13.3) -- Purifying Burst
	self:Bar(346116, 16.6) -- Shearing Swings
	self:Bar(346957, 19.2) -- Purged by Fire
	self:Bar(346971, 20.3, CL.adds) -- [DNT] Summon Vault Defender
	self:Bar(347094, 22.8) -- Titanic Crash
end
