
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ularogg Cragshaper", 1458, 1665)
if not mod then return end
mod:RegisterEnableMob(91004)
mod.engageId = 1791

--------------------------------------------------------------------------------
-- Locals
--

local totemsDead = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.totems = "Totems"
	L.bellow = "{193375} (Totems)" -- Bellow of the Deeps (Totems)
	L.bellow_desc = 193375
	L.bellow_icon = 193375
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		198564, -- Stance of the Mountain
		198496, -- Sunder
		198428, -- Strike of the Mountain
		"bellow",
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Log("SPELL_CAST_START", "Sunder", 198496)
	self:Log("SPELL_CAST_START", "StrikeOfTheMountain", 198428)
	self:Log("SPELL_CAST_START", "BellowOfTheDeeps", 193375)
	self:Death("IntermissionTotemsDeath", 100818)
end

function mod:OnEngage()
	self:Bar(198428, 15) -- Strike of the Mountain
	self:CDBar(198496, 7.4) -- Sunder
	self:CDBar(198564, (self:Normal() or self:Heroic()) and 36.4 or 26.8) -- Stance of the Mountain
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, _, spellId)
	if spellId == 198509 then -- Stance of the Mountain
		totemsDead = 0
		self:StopBar(198496) -- Sunder
		self:StopBar(198428) -- Strike of the Mountain
		self:StopBar(198564) -- Stance of the Mountain
		self:Message(198564, "Attention", "Long")
	end
end

function mod:StrikeOfTheMountain(args)
	self:Message(args.spellId, "Important", "Alarm")
	self:Bar(args.spellId, 15.5)
end

function mod:BellowOfTheDeeps(args)
	self:Message("bellow", "Urgent", "Info", CL.incoming:format(L.totems), args.spellId)
	--self:CDBar(args.spellId, 29) -- pull:20.6, 44.9, 31.5, 31.5
end

function mod:Sunder(args)
	self:Message(args.spellId, "Attention", "Alert", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 9.3)
end

function mod:IntermissionTotemsDeath()
	totemsDead = totemsDead + 1
	if self:Normal() and totemsDead == 3 or totemsDead == 5 then -- all of them fire UNIT_DIED
		self:CDBar(198564, (self:Normal() or self:Heroic()) and 70.7 or 50.6) -- Stance of the Mountain
	end
end
