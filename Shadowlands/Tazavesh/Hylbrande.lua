--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Hylbrande", 2441, 2448)
if not mod then return end
mod:RegisterEnableMob(175663) -- Hylbrande
mod:SetEncounterID(2426)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local nextSanitizingCycle = 0

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
		{346957, "SAY", "ME_ONLY_EMPHASIZE"}, -- Purged by Fire
		346766, -- Sanitizing Cycle
		"vault_purifier", -- Vault Purifier (Adds)
		-- Hard Mode
		358131, -- Lightning Nova
	}, {
		[358131] = CL.hard,
	}, {
		["vault_purifier"] = CL.adds,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "PurifyingBurst", 353312)
	self:Log("SPELL_CAST_SUCCESS", "ShearingSwings", 346116)
	self:Log("SPELL_CAST_START", "TitanicCrash", 347094)
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_WHISPER") -- Purged By Fire
	self:Log("SPELL_CAST_START", "PurgedByFire", 346957)
	self:Log("SPELL_DAMAGE", "PurgedByFireDamage", 346960)
	self:Log("SPELL_MISSED", "PurgedByFireDamage", 346960)
	self:Log("SPELL_CAST_START", "SanitizingCycle", 346766)
	self:Log("SPELL_CAST_SUCCESS", "SanitizingCycleSuccess", 346766)
	self:Log("SPELL_AURA_REMOVED", "SanitizingCycleRemoved", 346766)
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1") -- Vault Purifier

	-- Hard Mode
	self:Log("SPELL_CAST_START", "LightningNova", 358131)
end

function mod:OnEngage()
	nextSanitizingCycle = GetTime() + 38.0
	self:CDBar(353312, 5.6) -- Purifying Burst
	self:CDBar(346116, 8.1) -- Shearing Swings
	self:CDBar(346957, 10.5) -- Purged by Fire
	self:CDBar(347094, 15.4) -- Titanic Crash
	self:CDBar("vault_purifier", 19, CL.adds, L.vault_purifier_icon) -- Vault Purifier
	self:CDBar(346766, 40.0) -- Sanitizing Cycle
end

function mod:OnWin()
	local trashMod = BigWigs:GetBossModule("Tazavesh Trash", true)
	if trashMod then
		trashMod:Enable()
		trashMod:HylbrandeDefeated()
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:PurifyingBurst(args)
	self:Message(args.spellId, "yellow")
	if nextSanitizingCycle - GetTime() > 25.0 then
		self:CDBar(args.spellId, 23.0)
	else
		self:StopBar(args.spellId)
	end
	self:PlaySound(args.spellId, "info")
end

function mod:ShearingSwings(args)
	self:Message(args.spellId, "purple")
	if nextSanitizingCycle - GetTime() > 12.9 then
		self:CDBar(args.spellId, 10.9)
	else
		self:StopBar(args.spellId)
	end
	self:PlaySound(args.spellId, "alert")
end

function mod:TitanicCrash(args)
	self:Message(args.spellId, "red")
	if nextSanitizingCycle - GetTime() > 25.0 then
		self:CDBar(args.spellId, 23.0)
	else
		self:StopBar(args.spellId)
	end
	self:PlaySound(args.spellId, "alarm")
end

function mod:CHAT_MSG_RAID_BOSS_WHISPER(_, msg)
	-- |TInterface\\ICONS\\Ability_Priest_Flashoflight.blp:20|t %s targets you with |cFFFF0000|Hspell:346959|h[Purged by Fire]|h|r!#Titanic Defense Turret###playerName
	if msg:find("346959", nil, true) then -- Purged by Fire
		self:PersonalMessage(346957)
		self:Say(346957, nil, nil, "Purged by Fire")
		self:PlaySound(346957, "warning")
	end
end

function mod:PurgedByFire(args)
	self:Message(args.spellId, "orange", CL.incoming:format(args.spellName))
	if nextSanitizingCycle - GetTime() > 19 then
		self:CDBar(args.spellId, 17)
	else
		self:StopBar(args.spellId)
	end
end

do
	local prev = 0
	function mod:PurgedByFireDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 2 then
			prev = args.time
			self:PersonalMessage(346957, "underyou")
			self:PlaySound(346957, "underyou")
		end
	end
end

function mod:SanitizingCycle()
	self:StopBar(353312) -- Purifying Burst
	self:StopBar(346116) -- Shearing Swings
	self:StopBar(346957) -- Purged by Fire
	self:StopBar(CL.adds) -- Vault Purifier
	self:StopBar(347094) -- Titanic Crash
end

do
	local sanitizingCycleStart = 0

	function mod:SanitizingCycleSuccess(args)
		sanitizingCycleStart = args.time
		nextSanitizingCycle = 0
		self:SetStage(2)
		self:StopBar(args.spellId)
		self:Message(args.spellId, "cyan")
		self:PlaySound(args.spellId, "long")
	end

	function mod:SanitizingCycleRemoved(args)
		nextSanitizingCycle = GetTime() + 69.4
		self:SetStage(1)
		if sanitizingCycleStart ~= 0 then
			self:Message(args.spellId, "green", CL.removed_after:format(args.spellName, args.time - sanitizingCycleStart))
		else
			self:Message(args.spellId, "green", CL.removed:format(args.spellName))
		end
		self:CDBar(353312, 13.3) -- Purifying Burst
		self:CDBar(346116, 15.9) -- Shearing Swings
		self:CDBar(346957, 19.2) -- Purged by Fire
		self:CDBar("vault_purifier", 19.5, CL.adds, L.vault_purifier_icon) -- Vault Purifier
		self:CDBar(347094, 22.8) -- Titanic Crash
		self:CDBar(args.spellId, 69.4)
		self:PlaySound(args.spellId, "long")
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 346971 then -- [DNT] Summon Vault Defender
		self:Message("vault_purifier", "yellow", CL.adds_spawning, L.vault_purifier_icon)
		if nextSanitizingCycle - GetTime() > 29.8 then
			self:CDBar("vault_purifier", 27.8, CL.adds, L.vault_purifier_icon)
		else
			self:StopBar(CL.adds)
		end
		self:PlaySound("vault_purifier", "info")
	end
end

-- Hard Mode

function mod:LightningNova(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end
