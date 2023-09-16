--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Rezan", 1763, 2083)
if not mod then return end
mod:RegisterEnableMob(122963)
mod:SetEncounterID(2086)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local pursuitCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{255371, "CASTBAR", "CASTBAR_COUNTDOWN"}, -- Terrifying Visage
		{257407, "SAY", "ME_ONLY_EMPHASIZE"}, -- Pursuit
		255421, -- Devour
		{255434, "TANK_HEALER"}, -- Serrated Teeth
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "TerrifyingVisage", 255371)
	--self:Log("SPELL_CAST_SUCCESS", "Tail", 255372)
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE", "CHAT_MSG_RAID_BOSS_WHISPER") -- XXX pre 10.2 compat
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_WHISPER") -- Pursuit
	self:Log("SPELL_AURA_APPLIED", "DevourApplied", 255421)
	self:Log("SPELL_AURA_REMOVED", "PursuitRemoved", 257407)
	self:Log("SPELL_CAST_SUCCESS", "SerratedTeeth", 255434)
end

function mod:OnEngage()
	pursuitCount = 1
	self:CDBar(255371, 12.5) -- Terrifying Visage
	self:CDBar(257407, 22.0) -- Pursuit
	self:CDBar(255434, 5.8) -- Serrated Teeth
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:TerrifyingVisage(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning", "lineofsight")
	self:CastBar(args.spellId, 5)
	self:CDBar(args.spellId, 35.2)
	-- 9.9s to pursuit
	if pursuitCount == 1 then
		self:CDBar(257407, {9.9, 22.0}) -- Pursuit
	else
		self:CDBar(257407, {9.9, 35.2}) -- Pursuit
	end
end

function mod:CHAT_MSG_RAID_BOSS_WHISPER(_, msg, _, _, _, destName) -- Pursuit
	-- the whisper for Pursuit happens sooner than the SPELL_CAST_START and it has target info
	if msg:find("255421") then -- Devour
		self:TargetMessage(257407, "orange", destName)
		if self:Me(self:UnitGUID(destName)) then
			self:PlaySound(257407, "alarm", "runaway", destName)
			self:Say(257407)
		else
			self:PlaySound(257407, "alert", nil, destName)
		end
		pursuitCount = pursuitCount + 1
		self:CDBar(257407, 35.2)
	end
end

do
	local prev = 0

	function mod:DevourApplied(args)
		prev = args.time -- applied to both Rezan and the player, use the first one for throttling PursuitRemoved
		if self:Player(args.destFlags) then -- also applied to Rezan
			self:TargetMessage(args.spellId, "yellow", args.destName)
			self:PlaySound(args.spellId, "long", nil, args.destName)
			-- TODO lasts 8 seconds where nothing else can happen
			-- but what happens if an immunity is used during devour?
			-- 20.3, 20.7, 20.9 to terrifying visage (or should be -8 from devour removed?)
		end
	end

	function mod:PursuitRemoved(args)
		-- throttle against Devour being applied (player was caught)
		if args.time - prev > 1 then
			self:Message(args.spellId, "green", CL.over:format(args.spellName))
			self:PlaySound(args.spellId, "info")
			-- TODO 23.45, 22.8, 31.39 (feigned/etc) to pursuit (so not reliable to start any timers here)
		end
	end
end

function mod:SerratedTeeth(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert", "defensive")
	-- true cooldown is 15.8s, but very often delayed
	self:CDBar(args.spellId, 34.0)
end
