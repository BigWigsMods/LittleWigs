
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Xeri'tac", 1008, 1209)
if not mod then return end
mod:RegisterEnableMob(84550)

--------------------------------------------------------------------------------
-- Locals
--

local deaths = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.spider_adds = 155139 -- Spiders
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Pale One
		-10502,
		169248, -- Consume
		169233, -- Inhale
		-- Spiderlings
		-10492,
		173080, -- Fixate
		"stages",
	}
end

function mod:OnRegister()
	local enable_zone = { -- from LibBabble-SubZone-3.0
		deDE = "Xeri'tacs Grube",
		esES = "Escondrijo de Xeri'tac",
		esMX = "Madriguera de Xeri'tac",
		frFR = "Terrier de Xeri’tac",
		itIT = "Tana di Xeri'tac",
		koKR = "제리타크의 동굴",
		ptBR = "Toca de Xeri'tac",
		ruRU = "Логово Зери'так",
		zhCN = "艾里塔克地穴",
		zhTW = "榭里塔克地穴",
	}
	enable_zone = enable_zone[GetLocale()] or "Xeri'tac's Burrow"
	local f = CreateFrame("Frame")
	local func = function()
		if not mod:IsEnabled() and GetSubZoneText() == enable_zone then
			mod:Enable()
		end
	end
	f:SetScript("OnEvent", func)
	f:RegisterEvent("ZONE_CHANGED_INDOORS")
	func()
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_CAST_START", "Consume", 169248)
	self:Log("SPELL_CAST_START", "Inhale", 169233)
	self:Log("SPELL_AURA_APPLIED", "Fixate", 173080)

	self:RegisterUnitEvent("UNIT_TARGETABLE_CHANGED", nil, "boss1")
	self:Death("SpiderlingDeath", 84552)
	self:Death("Win", 84550)
end

function mod:OnEngage()
	deaths = 0
	self:Bar(-10502, 20, CL.next_add, "spell_festergutgas")
	self:ScheduleTimer("AddSpawn", 20)
	self:Bar(-10492, 30, L.spider_adds, "spell_yorsahj_bloodboil_green")
	self:ScheduleTimer("SpidersSpawn", 30)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SpiderlingDeath(args)
	deaths = deaths + 1
	if deaths < 9 then
		self:Message("stages", "Neutral", nil, CL.add_killed:format(deaths, 8), false)
	end
end

function mod:SpidersSpawn()
	--self:Message(-10492, "Attention", nil, L.spider_adds, false)
	self:Bar(-10492, 30, L.spider_adds, "spell_yorsahj_bloodboil_green")
	self:ScheduleTimer("SpidersSpawn", 30)
end

function mod:Fixate(args)
	if self:Me(args.destGUID) then
		self:Message(173080, "Personal", "Alarm", CL.you:format(args.spellName))
	end
end

function mod:AddSpawn()
	self:Message(-10502, "Attention", "Info", CL.add_spawned, false)
	self:Bar(-10502, 30, CL.next_add, "spell_festergutgas")
	self:ScheduleTimer("AddSpawn", 30)
end

function mod:Consume(args)
	self:Message(args.spellId, "Urgent", "Warning")
	self:Bar(args.spellId, 10)
end

function mod:Inhale(args)
	self:Message(args.spellId, "Important", "Info")
end

function mod:UNIT_TARGETABLE_CHANGED(_, unit)
	if UnitCanAttack("player", unit) then
		self:Message("stages", "Important", "Info", CL.incoming:format(self.displayName), "inv_misc_monsterspidercarapace_01")
	end
end
