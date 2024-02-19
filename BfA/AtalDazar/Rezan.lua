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
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_WHISPER") -- Pursuit
	self:Log("SPELL_CAST_START", "PursuitStart", 257407)
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

do
	local prev = 0

	function mod:CHAT_MSG_RAID_BOSS_WHISPER(_, msg, _, _, _, destName) -- Pursuit
		if msg:find("255421") then -- Devour
			-- the whisper for Pursuit contains the target, but only the targeted
			-- player receives this event. throttle in case the boss target scan is faster
			-- than the whisper.
			local t = GetTime()
			if t - prev > 2 then
				prev = t
				self:PersonalMessage(257407)
				self:PlaySound(257407, "alarm", "runaway", destName)
				self:Say(257407, nil, nil, "Pursuit")
			end
		end
	end

	local function printTarget(self, name, guid)
		-- throttle in case the whisper is faster than the boss target scan.
		local t = GetTime()
		if t - prev > 2 then
			prev = t
			self:TargetMessage(257407, "orange", name)
			if self:Me(guid) then
				self:PlaySound(257407, "alarm", "runaway", name)
				self:Say(257407, nil, nil, "Pursuit")
			else
				self:PlaySound(257407, "alert", nil, name)
			end
		end
	end

	function mod:PursuitStart(args)
		self:GetUnitTarget(printTarget, 0.3, args.sourceGUID)
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
		end
	end

	function mod:PursuitRemoved(args)
		-- throttle against Devour being applied (player was caught)
		if args.time - prev > 1 then
			self:Message(args.spellId, "green", CL.over:format(args.spellName))
			self:PlaySound(args.spellId, "info")
		end
	end
end

function mod:SerratedTeeth(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert", "defensive")
	-- true cooldown is 15.8s, but very often delayed
	self:CDBar(args.spellId, 34.0)
end
