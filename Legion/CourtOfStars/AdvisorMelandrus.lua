--------------------------------------------------------------------------------
-- To Do
-- Enveloping Winds timers are not 100% accurate

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Advisor Melandrus", 1571, 1720)
if not mod then return end
mod:RegisterEnableMob(104218)
mod.engageId = 1870

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.warmup_trigger = "Yet another failure, Melandrus. Consider this your chance to correct it. Dispose of these outsiders. I must return to the Nighthold."
end

--------------------------------------------------------------------------------
-- Locals
--

local bladeSurgeCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		209602, -- Blade Surge
		224333, -- Enveloping Winds
		209628, -- Piercing Gale
		209676, -- Slicing Maelstrom
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_SAY", "Warmup")
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Log("SPELL_CAST_START", "BladeSurge", 209602)
	self:Log("SPELL_CAST_START", "PiercingGale", 209628)
	self:Log("SPELL_CAST_START", "SlicingMaelstrom", 209676)
end

function mod:OnEngage()
	bladeSurgeCount = 1
	self:CDBar(209628, 11) -- Piercing Gale
	self:CDBar(224333, 8.4) -- Enveloping Winds
	self:CDBar(209602, 5.2, CL.count:format(self:SpellName(209602), bladeSurgeCount)) -- Blade Surge
	self:CDBar(209676, 23) -- Slicing Maelstrom
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Warmup(event, msg)
	if msg == L.warmup_trigger then
		self:UnregisterEvent(event)
		self:Bar("warmup", 11, CL.active, "inv_helm_mask_fittedalpha_b_01_nightborne_01")
	end
end

function mod:BladeSurge(args)
	self:MessageOld(args.spellId, "red", "info", CL.count:format(args.spellName, bladeSurgeCount))
	bladeSurgeCount = bladeSurgeCount + 1
	self:CDBar(args.spellId, 12, CL.count:format(args.spellName, bladeSurgeCount))
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 224327 then -- Enveloping Winds
		self:MessageOld(224333, "yellow", "info", spellId, 224333)
		self:CDBar(224333, 9.4) -- actual spellid has no icon/tooltip
	end
end

do
	local prev = 0
	function mod:PiercingGale(args)
		local t = GetTime()
		if t-prev > 2 then
			prev = t
			self:MessageOld(args.spellId, "orange", "alarm")
			self:CDBar(args.spellId, 24)
		end
	end
end

function mod:SlicingMaelstrom(args)
	self:MessageOld(args.spellId, "yellow", "warning", CL.incoming:format(args.spellName))
	self:CDBar(args.spellId, 24)
end
