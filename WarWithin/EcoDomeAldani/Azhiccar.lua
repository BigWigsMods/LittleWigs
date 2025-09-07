--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Azhiccar", 2830, 2675)
if not mod then return end
mod:RegisterEnableMob(234893) -- Azhiccar
mod:SetEncounterID(3107)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local castingDevour = false
local devourCount = 1
local invadingShriekCount = 1
local toxicRegurgitationCount = 1
local frenziedMiteCount = 0
local frenziedMiteCollector = {}

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{1217232, "CASTBAR"}, -- Devour
		1217247, -- Feast
		1217327, -- Invading Shriek
		1231811, -- Uncontrolled
		{1227745, "SAY", "SAY_COUNTDOWN"}, -- Toxic Regurgitation
		1217446, -- Digestive Spittle
		1217664, -- Thrash
	}, nil, {
		[1231811] = CL.adds, -- Uncontrolled (Adds)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Devour", 1217232)
	self:Log("SPELL_CAST_SUCCESS", "DevourSuccess", 1217232)
	self:Log("SPELL_AURA_REMOVED", "DevourRemoved", 1217232)
	self:Log("SPELL_AURA_APPLIED", "FeastAppliedBoss", 1217247)
	self:Log("SPELL_AURA_APPLIED_DOSE", "FeastAppliedBoss", 1217247)
	self:Log("SPELL_AURA_APPLIED", "FeastAppliedPlayer", 1217241)
	self:Log("SPELL_CAST_START", "InvadingShriek", 1217327)
	self:Log("SPELL_AURA_APPLIED", "UncontrolledApplied", 1231811)
	self:Death("FrenziedMiteDeath", 236190)
	self:Log("SPELL_CAST_START", "ToxicRegurgitation", 1227745)
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_WHISPER") -- Toxic Regurgitation
	self:Log("SPELL_PERIODIC_DAMAGE", "DigestiveSpittleDamage", 1217446)
	self:Log("SPELL_PERIODIC_MISSED", "DigestiveSpittleDamage", 1217446)
	self:Log("SPELL_CAST_START", "Thrash", 1217664)
end

function mod:OnEngage()
	castingDevour = false
	devourCount = 1
	invadingShriekCount = 1
	toxicRegurgitationCount = 1
	frenziedMiteCount = 0
	frenziedMiteCollector = {}
	self:CDBar(1217327, 5.2, CL.count:format(self:SpellName(1217327), invadingShriekCount)) -- Invading Shriek
	self:CDBar(1227745, 15.4, CL.count:format(self:SpellName(1227745), toxicRegurgitationCount)) -- Toxic Regurgitation
	-- cast at 100 energy, 60s energy gain + delay
	self:CDBar(1217232, 60.3, CL.count:format(self:SpellName(1217232), devourCount)) -- Devour
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Devour(args)
	castingDevour = true
	self:StopBar(CL.count:format(args.spellName, devourCount))
	self:Message(args.spellId, "cyan", CL.count:format(args.spellName, devourCount))
	devourCount = devourCount + 1
	-- cast at 100 energy, 5s cast + 18s channel + 3s delay + 60s energy gain
	self:CDBar(args.spellId, 86.2, CL.count:format(args.spellName, devourCount))
	self:PlaySound(args.spellId, "long")
end

function mod:DevourSuccess(args)
	self:CastBar(args.spellId, 18) -- 18s channel
end

function mod:DevourRemoved()
	castingDevour = false
end

function mod:FeastAppliedBoss(args)
	local amount = args.amount or 1
	self:Message(args.spellId, "red", CL.stackboss:format(amount, args.spellName))
	self:PlaySound(args.spellId, "info")
end

function mod:FeastAppliedPlayer(args)
	if self:Me(args.destGUID) then
		-- stunned for 3s
		self:PersonalMessage(1217247)
		self:PlaySound(1217247, "alarm")
	end
end

function mod:InvadingShriek(args)
	self:StopBar(CL.count:format(args.spellName, invadingShriekCount))
	self:Message(args.spellId, "yellow", CL.count:format(args.spellName, invadingShriekCount))
	invadingShriekCount = invadingShriekCount + 1
	if invadingShriekCount % 2 == 0 then
		self:CDBar(args.spellId, 37.2, CL.count:format(args.spellName, invadingShriekCount))
	else
		self:CDBar(args.spellId, 48.5, CL.count:format(args.spellName, invadingShriekCount))
	end
	self:PlaySound(args.spellId, "alert")
end

function mod:UncontrolledApplied(args)
	-- this is applied on spawn, we only track Frenzied Mites that spawn during Devour.
	-- Frenzied Mites only spawn during Devour on Mythic.
	if castingDevour and not frenziedMiteCollector[args.destGUID] then
		frenziedMiteCount = frenziedMiteCount + 1
		frenziedMiteCollector[args.destGUID] = true
	end
end

function mod:FrenziedMiteDeath(args)
	if frenziedMiteCollector[args.destGUID] then
		frenziedMiteCount = frenziedMiteCount - 1
		frenziedMiteCollector[args.destGUID] = nil
		if frenziedMiteCount == 0 then
			-- show a message when the last Devour add is killed
			self:Message(1231811, "green", CL.killed:format(CL.adds))
			self:PlaySound(1231811, "info")
		end
	end
end

do
	local castStartTime = nil

	function mod:ToxicRegurgitation(args)
		castStartTime = GetTime()
		self:StopBar(CL.count:format(args.spellName, toxicRegurgitationCount))
		self:Message(args.spellId, "orange", CL.count:format(args.spellName, toxicRegurgitationCount))
		toxicRegurgitationCount = toxicRegurgitationCount + 1
		if toxicRegurgitationCount % 2 == 0 then -- 2, 4, 6...
			self:CDBar(args.spellId, 18.2, CL.count:format(args.spellName, toxicRegurgitationCount))
		else -- 3, 5, 7...
			self:CDBar(args.spellId, 67.5, CL.count:format(args.spellName, toxicRegurgitationCount))
		end
		self:PlaySound(args.spellId, "alarm")
	end

	function mod:CHAT_MSG_RAID_BOSS_WHISPER(_, msg)
		-- target's aura 1227748 is hidden
		if msg:find("1227748", nil, true) then -- Toxic Regurgitation
			-- [CHAT_MSG_RAID_BOSS_WHISPER] |TInterface\\ICONS\\Spell_Fire_BluePyroblast.blp:20|t You have been targeted for |cFFFF0000|Hspell:1227748|h[Toxic Regurgitation]|h|r!
			self:PersonalMessage(1227745)
			self:Say(1227745, nil, nil, "Toxic Regurgitation")
			if castStartTime then
				local delay = GetTime() - castStartTime
				castStartTime = nil
				self:SayCountdown(1227745, 5 - delay)
			end
		end
	end
end

do
	local prev = 0
	function mod:DigestiveSpittleDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 2 then -- 1.5s tick rate
			prev = args.time
			self:PersonalMessage(args.spellId, "underyou")
			self:PlaySound(args.spellId, "underyou")
		end
	end
end

function mod:Thrash(args)
	-- only cast when no players are in melee range
	self:Message(args.spellId, "purple")
	if self:Tank() then
		self:PlaySound(args.spellId, "warning")
	end
end
