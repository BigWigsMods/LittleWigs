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
-- Localization
--

local L = mod:GetLocale()
if L then
	L.vault_purifier = -23004
	L.vault_purifier_icon = "achievement_dungeon_ulduarraid_titan_01"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		353312, -- Purifying Burst
		{346116, "TANK"}, -- Shearing Swings
		347094, -- Titanic Crash
		{346959, "SAY"}, -- Purged by Fire
		346766, -- Sanitizing Cycle
		"vault_purifier", -- Vault Purifier
	}, nil, {
		["vault_purifier"] = CL.adds,
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
	self:Bar(346959, 10.5) -- Purged by Fire
	self:Bar(347094, 15.4) -- Titanic Crash
	self:Bar("vault_purifier", 19, CL.adds, L.vault_purifier_icon) -- Vault Purifier
	self:Bar(346766, 38.8) -- Sanitizing Cycle
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 346971 then -- [DNT] Summon Vault Defender
		self:Message("vault_purifier", "yellow", CL.add_spawned, L.vault_purifier_icon)
		self:PlaySound("vault_purifier", "info")
		if sanitizingCycleTime - GetTime() > 29.1 then -- Sanitizing Cycle
			self:Bar("vault_purifier", 29.1, CL.adds, L.vault_purifier_icon)
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
		self:TargetMessage(346959, "blue", playerName) -- Purged by Fire
		self:PlaySound(346959, "warning") -- Purged by Fire
		self:Say(346959, nil, nil, "Purged by Fire") -- Purged by Fire
	end
	local function warnPurgedByFire()
		if GetTime() - prev > 1 then
			mod:Message(346959, "orange") -- Purged by Fire
			mod:PlaySound(346959, "alert") -- Purged by Fire
		end
	end
	function mod:PurgedByFire(args)
		self:SimpleTimer(warnPurgedByFire, 0.1)
		if sanitizingCycleTime - GetTime() > 17 then -- Sanitizing Cycle
			self:Bar(346959, 17) -- Purged by Fire
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
				self:PersonalMessage(346959, "underyou")
				self:PlaySound(346959, "underyou")
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
			self:StopBar(346959) -- Purged by Fire
			self:StopBar(CL.adds) -- Vault Purifier
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
	self:Bar(346959, 19.2) -- Purged by Fire
	self:Bar("vault_purifier", 20.3, CL.adds, L.vault_purifier_icon) -- Vault Purifier
	self:Bar(347094, 22.8) -- Titanic Crash
end
