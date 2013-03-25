
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Kanrethad Ebonlocke", 919)
mod:RegisterEnableMob(69964)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.summons = "Summons"
	L.debuffs = "Debuffs"
	L.win_say = "Jubeka" -- Jubeka?! What are you...?!
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		138789, 138685, 138751, 138755,
		138561, 138560, 138558,
		138559, 138564, {139060, "FLASH"}, "bosskill",
	},
	{
		[138789] = L.summons,
		[138561] = L.debuffs,
		[138559] = "general",
	}
end

function mod:VerifyEnable(unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp > 8 and UnitCanAttack("player", unit) then
		return true
	end
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Curse", 138558)

	self:Log("SPELL_CAST_SUCCESS", "PitLord", 138789)
	self:Log("SPELL_CAST_SUCCESS", "Imps", 138685)
	self:Log("SPELL_CAST_SUCCESS", "Felhunters", 138751)
	self:Log("SPELL_CAST_SUCCESS", "DoomLord", 138755)
	self:Log("SPELL_CAST_SUCCESS", "DevourEnslavement", 139060)

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
	self:Message(args.spellId, "Attention")
	self:Bar(args.spellId, 10)
	self:CDBar(138685, 66) -- Imps
	self:CDBar(138559, 30) -- Chaos Bolt
end

function mod:Imps(args)
	self:Message(args.spellId, "Attention")
	self:Bar(args.spellId, 10)
	self:CDBar(138751, 57) -- Felhunters
end

function mod:Felhunters(args)
	self:Message(args.spellId, "Attention")
	self:Bar(args.spellId, 9)
	self:CDBar(138755, 59) -- Doom Lord
end

function mod:DoomLord(args)
	self:Message(args.spellId, "Attention")
	self:Bar(args.spellId, 10)
	self:CDBar(138685, 60) -- Imps
end

function mod:DevourEnslavement(args)
	self:Message(args.spellId, "Urgent", "Warning", CL["removed"]:format(self:SpellName(1098))) -- Enslave Demon
	self:Flash(args.spellId)
end

do
	local t = 0
	function mod:Cataclysm(args)
		self:Message(args.spellId, "Important", "Warning", CL["cast"]:format(args.spellName))
		self:Bar(args.spellId, 6, CL["cast"]:format(args.spellName))
		self:CDBar(args.spellId, 60)
		t = GetTime()
	end
	function mod:CataclysmInterrupted(args)
		if (GetTime() - t) < 5.5 then
			self:StopBar(CL["cast"]:format(args.spellName))
			self:Message(args.spellId, "Positive", nil, CL["interrupted"]:format(args.spellName))
		end
	end
end

function mod:Agony(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "Personal", "Alarm", CL["you"]:format(args.spellName))
	end
end

function mod:AgonyRemoved(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "Positive", nil, CL["removed"]:format(args.spellName))
	end
end

function mod:RainOfFire(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "Personal", "Alert", CL["you"]:format(args.spellName))
	end
end

function mod:ChaosBolt(args)
	self:Message(args.spellId, "Urgent", "Long", CL["cast"]:format(args.spellName))
	self:Bar(args.spellId, 6, CL["cast"]:format(args.spellName))
	self:Bar(args.spellId, 60)
end

function mod:WinCheck(_, msg)
	if msg:find(L["win_say"], nil, true) then
		self:Win()
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

