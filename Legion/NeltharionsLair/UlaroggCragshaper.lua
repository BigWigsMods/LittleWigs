
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ularogg Cragshaper", 1065, 1665)
if not mod then return end
mod:RegisterEnableMob(91004)
mod.engageId = 1791

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
	self:Log("SPELL_CAST_START", "StanceOfTheMountain", 198564)
	self:Log("SPELL_CAST_START", "Sunder", 198496)
	self:Log("SPELL_CAST_START", "StrikeOfTheMountain", 198428)
	self:Log("SPELL_CAST_START", "BellowOfTheDeeps", 193375)
end

function mod:OnEngage()
	self:Bar(198428, 15) -- Strike of the Mountain
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:StanceOfTheMountain(args)
	self:Message(args.spellId, "Attention", "Long")
	self:CDBar(args.spellId, 97) -- pull:36.6, 97.7
	self:StopBar(198496) -- Sunder
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
