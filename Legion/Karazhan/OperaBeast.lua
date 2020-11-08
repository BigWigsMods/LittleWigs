
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Opera Hall: Beautiful Beast", 1651, 1827)
if not mod then return end
mod:RegisterEnableMob(
	114328, -- Coogleston
	114329, -- Luminore
	114522, -- Mrs. Cauldrons
	114330  -- Babblet
)
--mod.engageId = 1957 -- Same for every opera event. So it's basically useless.

--------------------------------------------------------------------------------
-- Locals
--

local addsKilled = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		228025, -- Heat Wave
		228019, -- Leftovers
		{228221, "SAY"}, -- Severe Dusting
		{227985, "TANK_HEALER"}, -- Dent Armor
		227987, -- Dinner Bell!
		232153, -- Kara Kazham!
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_CAST_START", "HeatWave", 228025)
	self:Log("SPELL_CAST_START", "Leftovers", 228019)
	self:Log("SPELL_CAST_SUCCESS", "SevereDusting", 228221)
	self:Log("SPELL_AURA_REMOVED", "SpectralService", 232156)
	self:Log("SPELL_AURA_APPLIED", "DentArmor", 227985)
	self:Log("SPELL_AURA_REMOVED", "DentArmorRemoved", 227985)
	self:Log("SPELL_CAST_START", "DinnerBell", 227987)
	self:Log("SPELL_CAST_START", "KaraKazham", 232153)

	self:RegisterEvent("BOSS_KILL")

	self:Death("AddsKilled",
		114329, -- Luminore
		114522, -- Mrs. Cauldrons
		114330  -- Babblet
	)
end

function mod:OnEngage()
	addsKilled = 0
	self:Bar(228019, 7) -- Leftovers
	self:Bar(228025, 30) -- Heat Wave
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:HeatWave(args)
	self:MessageOld(args.spellId, "red", "info")
end

function mod:Leftovers(args)
	self:MessageOld(args.spellId, "red", self:Interrupter() and "alert")
	self:CDBar(args.spellId, 18)
end

function mod:SevereDusting(args)
	self:TargetMessageOld(args.spellId, args.destName, "orange", "warning")
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
	end
end

function mod:SpectralService(args)
	self:MessageOld("stages", "green", "long", CL.removed:format(args.spellName), args.spellId)
	self:Bar(227987, 8.5) -- Dinner Bell
	self:Bar(227985, 15.8) -- Dent Armor
end

function mod:DentArmor(args)
	self:TargetMessageOld(args.spellId, args.destName, "orange", "alarm", nil, nil, true)
	self:TargetBar(args.spellId, 8, args.destName)
end

function mod:DentArmorRemoved(args)
	self:StopBar(args.spellId, args.destName)
end

function mod:DinnerBell(args)
	self:MessageOld(args.spellId, "yellow", self:Interrupter() and "alert")
	self:Bar(args.spellId, 12)
end

function mod:KaraKazham(args)
	self:MessageOld(args.spellId, "orange", "info")
	self:Bar(args.spellId, 17)
end

function mod:AddsKilled(args)
	addsKilled = addsKilled + 1
	self:MessageOld("stages", "cyan", "long", CL.mob_killed:format(args.destName, addsKilled, 3), false)

	if args.mobId == 114329 then -- Luminore
		self:StopBar(228025) -- Heat Wave
	elseif args.mobId == 114522 then -- Mrs. Cauldrons
		self:StopBar(228019) -- Leftovers
	--elseif args.mobId == 114330 then -- Babblet
	end
end

function mod:BOSS_KILL(_, id)
	if id == 1957 then
		self:Win()
	end
end
