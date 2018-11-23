if UnitFactionGroup("player") ~= "Alliance" then return end

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Chopper Redhook", 1822, 2132)
if not mod then return end
mod:RegisterEnableMob(128650) -- Chopper Redhook
mod.engageId = 2098

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.adds = 274002
	L.adds_icon = "inv_misc_groupneedmore"
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
	self:Log("SPELL_AURA_APPLIED", "HeavyOrdnance", 273721)
end

function mod:OnEngage()
	self:CDBar("adds", 17, CL.adds, L.adds_icon)
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
		self:Message2(257585, "orange")
		self:PlaySound(257585, "warning")
		self:CDBar(257585, 60) -- XXX Double check
	elseif spellId == 274002 then -- Call Adds
		self:StopBar(CL.adds)
		local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
		if hp > 33 then -- Low CD under 33%
			self:Message2("adds", "yellow", CL.incoming:format(CL.adds), false)
			self:PlaySound("adds", "long")
			self:CDBar("adds", 17, CL.adds, L.adds_icon) -- XXX Double check
		end
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
		-- self:CastBar(257348, 2.7)
	end
end

function mod:GoreCrash(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

function mod:HeavyOrdnance(args)
	self:Message2(args.spellId, "green", CL.onboss:format(args.spellName)) -- XXX Check if this does not mean it's also on adds
	self:PlaySound(args.spellId, "alert")
	self:TargetBar(args.spellId, 6, args.destName)
end
