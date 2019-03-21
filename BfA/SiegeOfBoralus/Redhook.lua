if UnitFactionGroup("player") ~= "Alliance" then return end

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Chopper Redhook", 1822, 2132)
if not mod then return end
mod:RegisterEnableMob(128650) -- Chopper Redhook
mod.engageId = 2098

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
		{257459, "FLASH"}, -- On the Hook
		{257348, "SAY"}, -- Meat Hook
		257326, -- Gore Crash
		257585, -- Cannon Barrage
		273721, -- Heavy Ordnance
		257288, -- Heavy Slash
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_START", nil, "boss2", "boss3", "boss4", "boss5")
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")

	self:Log("SPELL_AURA_APPLIED", "OnTheHook", 257459)
	self:Log("SPELL_AURA_REMOVED", "OnTheHookRemoved", 257459)
	self:Log("SPELL_CAST_START", "MeatHook", 257348)
	self:Log("SPELL_CAST_START", "GoreCrash", 257326)
	self:Log("SPELL_DAMAGE", "HeavyOrdnance", 273720)
	self:Log("SPELL_AURA_APPLIED", "HeavyOrdnanceApplied", 273721)
end

function mod:OnEngage()
	bombsRemaining = 0
	self:Bar(257585, 11) -- Cannon Barrage
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_START(_, _, _, spellId)
	if spellId == 257288 then -- Heavy Slash
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
	elseif spellId == 274002 and not UnitExists("boss5") then -- Call Adds
		self:Message2("adds", "yellow", CL.incoming:format(CL.adds), false)
		self:PlaySound("adds", "long")
	end
end

function mod:OnTheHook(args)
	self:TargetMessage2(args.spellId, "yellow", args.destName)
	self:TargetBar(args.spellId, 20, args.destName)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "warning")
		self:Flash(args.spellId)
	end
end

function mod:OnTheHookRemoved(args)
	self:StopBar(args.spellId, args.destName)
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage2(257348, "red", name)
		self:PlaySound(257348, "alert", nil, name)
		if self:Me(guid) then
			self:Say(257348)
		end
	end
	function mod:MeatHook(args)
		self:GetUnitTarget(printTarget, 0.1, args.sourceGUID)
	end
end

function mod:GoreCrash(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

function mod:HeavyOrdnance(args)
	bombsRemaining = bombsRemaining - 1
	self:Message2(277965, "orange", L.used_remaining:format(args.spellName, bombsRemaining))
	self:PlaySound(277965, "info")
end

function mod:HeavyOrdnanceApplied(args)
	bombsRemaining = bombsRemaining - 1
	self:Message2(args.spellId, "green", L.remaining:format(CL.onboss:format(args.spellName), bombsRemaining))
	self:PlaySound(args.spellId, "alert")
	self:TargetBar(args.spellId, 6, args.destName)
end
