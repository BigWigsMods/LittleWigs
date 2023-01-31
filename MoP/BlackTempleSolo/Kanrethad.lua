
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Kanrethad Ebonlocke", 1112)
if not mod then return end
mod:RegisterEnableMob(69964, 70052) -- Kanrethad Ebonlocke, Demonic Soulwell

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.name = "Kanrethad Ebonlocke"

	L.summons = "Summons"
	L.debuffs = "Debuffs"

	L.start_say = "BEHOLD" -- BEHOLD! I have truly mastered the fel energies of this world! The demonic power I now command... It is indescribable, unlimited, OMNIPOTENT!
	L.win_say = "Jubeka" -- Jubeka?! What are you...?!
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		138789, 138685, 138751, 138755,
		138561, 138560, 138558,
		138559, 138564, {139060, "FLASH"}, 1098, "stages"
	},{
		[138789] = L.summons,
		[138561] = L.debuffs,
		[138559] = "general",
	}
end

function mod:OnRegister()
	self.displayName = L.name
end

function mod:VerifyEnable(unit, mobId)
	if mobId == 70052 then -- Always enable on Soulwell
		return true
	else
		local hp = self:GetHealth(unit)
		if hp > 8 and UnitCanAttack("player", unit) then
			return true
		end
	end
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Curse", 138558)

	self:Log("SPELL_CAST_SUCCESS", "PitLord", 138789)
	self:Log("SPELL_CAST_SUCCESS", "Imps", 138685)
	self:Log("SPELL_CAST_SUCCESS", "Felhunters", 138751)
	self:Log("SPELL_CAST_SUCCESS", "DoomLord", 138755)
	self:Log("SPELL_CAST_SUCCESS", "DevourEnslavement", 139060)

	self:Log("SPELL_AURA_APPLIED", "EnslaveDemon", 1098)

	self:Log("SPELL_AURA_APPLIED", "Cataclysm", 138564)
	self:Log("SPELL_AURA_REMOVED", "CataclysmInterrupted", 138564)

	self:Log("SPELL_CAST_START", "ChaosBolt", 138559)

	self:Log("SPELL_AURA_APPLIED", "Agony", 138560)
	self:Log("SPELL_AURA_REMOVED", "AgonyRemoved", 138560)

	self:Log("SPELL_AURA_APPLIED", "RainOfFire", 138561)
	self:Log("SPELL_PERIODIC_DAMAGE", "RainOfFire", 138561)

	self:RegisterEvent("CHAT_MSG_MONSTER_SAY", "WinCheck")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "WipeTimer")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Curse(args)
	self:Berserk(720, true, nil, args.spellId, args.spellName)
end

function mod:PitLord(args)
	self:MessageOld(args.spellId, "yellow")
	self:Bar(args.spellId, 10, "<"..args.spellName..">")
	self:CDBar(138685, 66) -- Imps
	self:CDBar(138559, 30) -- Chaos Bolt
end

function mod:Imps(args)
	self:MessageOld(args.spellId, "yellow")
	self:StopBar(args.spellId)
	self:Bar(args.spellId, 10, "<"..args.spellName..">")
	self:CDBar(138751, 57) -- Felhunters
end

function mod:Felhunters(args)
	self:MessageOld(args.spellId, "yellow")
	self:StopBar(args.spellId)
	self:Bar(args.spellId, 9, "<"..args.spellName..">")
	self:CDBar(138755, 59) -- Doom Lord
end

function mod:DoomLord(args)
	self:MessageOld(args.spellId, "yellow")
	self:StopBar(args.spellId)
	self:Bar(args.spellId, 10, "<"..args.spellName..">")
	self:CDBar(138685, 60) -- Imps
end

function mod:DevourEnslavement(args)
	self:MessageOld(args.spellId, "orange", "warning", CL["removed"]:format(self:SpellName(1098))) -- Enslave Demon
	self:Flash(args.spellId)
	self:StopBar(1098)
	self:CancelDelayedMessage(CL["custom_sec"]:format(CL["over"]:format(args.spellName), 60))
	self:CancelDelayedMessage(CL["custom_sec"]:format(CL["over"]:format(args.spellName), 30))
	self:CancelDelayedMessage(CL["custom_sec"]:format(CL["over"]:format(args.spellName), 10))
	self:CancelDelayedMessage(CL["custom_sec"]:format(CL["over"]:format(args.spellName), 5))
end

function mod:EnslaveDemon(args)
	if self:Me(args.sourceGUID) and self:MobId(args.destGUID) == 70075 then
		self:Bar(args.spellId, 300)
		self:DelayedMessage(args.spellId, 240, "cyan", CL["custom_sec"]:format(CL["over"]:format(args.spellName), 60))
		self:DelayedMessage(args.spellId, 270, "cyan", CL["custom_sec"]:format(CL["over"]:format(args.spellName), 30))
		self:DelayedMessage(args.spellId, 290, "cyan", CL["custom_sec"]:format(CL["over"]:format(args.spellName), 10))
		self:DelayedMessage(args.spellId, 295, "cyan", CL["custom_sec"]:format(CL["over"]:format(args.spellName), 5))
	end
end

do
	local t = 0
	function mod:Cataclysm(args)
		self:MessageOld(args.spellId, "red", "warning")
		self:Bar(args.spellId, 6, "<"..args.spellName..">")
		self:CDBar(args.spellId, 60)
		t = GetTime()
	end
	function mod:CataclysmInterrupted(args)
		if (GetTime() - t) < 5.5 then
			self:StopBar("<"..args.spellName..">")
			self:MessageOld(args.spellId, "green", nil, CL["interrupted"]:format(args.spellName))
		end
	end
end

function mod:Agony(args)
	if self:Me(args.destGUID) then
		self:MessageOld(args.spellId, "blue", "alarm", CL["you"]:format(args.spellName))
	end
end

function mod:AgonyRemoved(args)
	if self:Me(args.destGUID) then
		self:MessageOld(args.spellId, "green", nil, CL["removed"]:format(args.spellName))
	end
end

function mod:RainOfFire(args)
	if self:Me(args.destGUID) then
		self:MessageOld(args.spellId, "blue", "alert", CL["you"]:format(args.spellName))
	end
end

function mod:ChaosBolt(args)
	self:MessageOld(args.spellId, "orange", "long")
	self:Bar(args.spellId, 6, "<"..args.spellName..">")
	self:Bar(args.spellId, 60)
end

function mod:WinCheck(_, msg)
	if msg:find(L["win_say"], nil, true) then
		self:Win()
	elseif msg:find(L["start_say"], nil, true) then
		self:Bar("stages", 15, COMBAT) -- Global "Combat" string
		self:CDBar(138789, 29) -- Pit Lord
	end
end

do
	local function wipeCheck()
		if not InCombatLockdown() and not UnitAffectingCombat("player") then
			mod:Reboot()
		end
	end
	function mod:WipeTimer()
		self:ScheduleTimer(wipeCheck, 4)
	end
end
