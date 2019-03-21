if UnitFactionGroup("player") ~= "Horde" then return end

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Sergeant Bainbridge", 1822, 2133)
if not mod then return end
mod:RegisterEnableMob(128649) -- Sergeant Bainbridge
mod.engageId = 2097

--------------------------------------------------------------------------------
-- Locals
--

local bombsRemaining = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.adds = 274002
	L.adds_icon = "inv_misc_groupneedmore"
	L.remaining = "%s, %d remaining"
	L.used_remaining = "%s used, %d remaining"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"adds",
		{260954, "FLASH"}, -- Iron Gaze
		261428, -- Hangman's Noose
		260924, -- Steel Tempest
		257585, -- Cannon Barrage
		277965, -- Heavy Ordnance
		279761, -- Heavy Slash
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_START", nil, "boss2", "boss3", "boss4", "boss5")
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")

	self:Log("SPELL_AURA_APPLIED", "IronGaze", 260954)
	self:Log("SPELL_AURA_REMOVED", "IronGazeRemoved", 260954)
	self:Log("SPELL_AURA_APPLIED", "HangmansNoose", 261428)
	self:Log("SPELL_CAST_START", "SteelTempest", 260924)
	self:Log("SPELL_DAMAGE", "HeavyOrdnance", 273720)
	self:Log("SPELL_AURA_APPLIED", "HeavyOrdnanceApplied", 277965)
end

function mod:OnEngage()
	bombsRemaining = 0
	self:Bar(257585, 11) -- Cannon Barrage
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_START(_, _, _, spellId)
	if spellId == 279761 then -- Heavy Slash
		self:Message2(spellId, "orange")
		self:PlaySound(spellId, "alert")
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, unit, _, spellId)
	if spellId == 257540 then -- Cannon Barrage
		bombsRemaining = 3
		self:Message2(257585, "orange")
		self:PlaySound(257585, "warning")
		self:Bar(257585, 60)
		self:Bar(277965, 45, CL.count:format(self:SpellName(277965), bombsRemaining)) -- Heavy Ordnance
	elseif spellId == 274002 and not UnitExists("boss5") then -- Call Adds
		self:Message2("adds", "yellow", CL.incoming:format(CL.adds), false)
		self:PlaySound("adds", "long")
	end
end

function mod:IronGaze(args)
	self:TargetMessage2(args.spellId, "yellow", args.destName)
	self:TargetBar(args.spellId, 20, args.destName)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "warning")
		self:Flash(args.spellId)
	end
end

function mod:IronGazeRemoved(args)
	self:StopBar(args.spellId, args.destName)
end

function mod:HangmansNoose(args)
	self:TargetMessage2(args.spellId, "red", args.destName)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:SteelTempest(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

function mod:HeavyOrdnance(args)
	local barText = CL.count:format(args.spellName, bombsRemaining)
	bombsRemaining = bombsRemaining - 1
	local timer = self:BarTimeLeft(barText)
	if timer then
		self:StopBar(barText)
		self:Bar(277965, timer, CL.count:format(args.spellName, bombsRemaining))
	end
	self:Message2(277965, "orange", L.used_remaining:format(args.spellName, bombsRemaining))
	self:PlaySound(277965, "info")
end

function mod:HeavyOrdnanceApplied(args)
	local barText = CL.count:format(args.spellName, bombsRemaining)
	bombsRemaining = bombsRemaining - 1
	local timer = self:BarTimeLeft(barText)
	if timer then
		self:StopBar(barText)
		self:Bar(args.spellId, timer, CL.count:format(args.spellName, bombsRemaining))
	end
	self:Message2(args.spellId, "green", L.remaining:format(CL.onboss:format(args.spellName), bombsRemaining))
	self:PlaySound(args.spellId, "alert")
	self:TargetBar(args.spellId, 6, args.destName)
end
