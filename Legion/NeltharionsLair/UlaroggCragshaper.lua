
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

local totemsAlive = 0

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
	self:CDBar(198564, self:Mythic() and 26.8 or 36.4) -- Stance of the Mountain
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 198509 then -- Stance of the Mountain
		totemsAlive = self:Normal() and 3 or 5
		self:StopBar(198496) -- Sunder
		self:StopBar(198428) -- Strike of the Mountain
		self:StopBar(198564) -- Stance of the Mountain
		self:MessageOld(198564, "yellow", "long")
	end
end

function mod:StrikeOfTheMountain(args)
	self:MessageOld(args.spellId, "red", "alarm")
	self:Bar(args.spellId, 15.5)
end

function mod:BellowOfTheDeeps(args)
	self:MessageOld("bellow", "orange", "info", CL.incoming:format(L.totems), args.spellId)
	--self:CDBar(args.spellId, 29) -- pull:20.6, 44.9, 31.5, 31.5
end

function mod:Sunder(args)
	self:MessageOld(args.spellId, "yellow", "alert", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 9.3)
end

function mod:IntermissionTotemsDeath()
	totemsAlive = totemsAlive - 1
	if totemsAlive == 0 then -- all of them fire UNIT_DIED
		self:CDBar(198564, self:Mythic() and 50.6 or 70.7) -- Stance of the Mountain
	end
end
