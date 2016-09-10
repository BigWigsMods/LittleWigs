
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Odyn", 1041, 1489)
if not mod then return end
mod:RegisterEnableMob(95676)
mod.engageId = 1809

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L[197963] = "|cFF800080Top Right|r (|T1323037:15:15:0:0:64:64:4:60:4:60|t)" -- Boss_OdunRunes_Purple
	L[197964] = "|cFFFFA500Bottom Right|r (|T1323039:15:15:0:0:64:64:4:60:4:60|t)" -- Boss_OdunRunes_Orange
	L[197965] = "|cFFFFFF00Bottom Left|r (|T1323038:15:15:0:0:64:64:4:60:4:60|t)" -- Boss_OdunRunes_Yellow
	L[197966] = "|cFF0000FFTop Left|r (|T1323035:15:15:0:0:64:64:4:60:4:60|t)" -- Boss_OdunRunes_Blue
	L[197967] = "|cFF008000Top|r (|T1323036:15:15:0:0:64:64:4:60:4:60|t)" -- Boss_OdunRunes_Green
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		197961, -- Runic Brand
		198263, -- Radiant Tempest
		200988, -- Spear of Light
		198077, -- Shatter Spears
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "RunicBrand", 197961)
	self:Log("SPELL_AURA_APPLIED", "RunicBrandYou", 197963, 197964, 197965, 197966, 197967)
	self:Log("SPELL_CAST_START", "RadiantTempest", 198263)
	self:Log("SPELL_CAST_START", "ShatterSpears", 198077)

	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
end

function mod:OnEngage()
	self:Bar(198263, 24) -- Radiant Tempest
	self:Bar(198077, 40) -- Shatter Spears
	self:Bar(197961, 44) -- Runic Brand
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:RunicBrand(args)
	self:Message(args.spellId, "Attention", "Alarm", CL.casting:format(args.spellName))
end

function mod:RunicBrandYou(args)
	if self:Me(args.destGUID) then
		self:Message(197961, "Urgent", "Warning", L[args.spellId], args.spellId)
	end
end

function mod:RadiantTempest(args)
	self:Message(args.spellId, "Important", "Long")
	self:CDBar(args.spellId, 56)
end

function mod:ShatterSpears(args)
	self:Message(args.spellId, "Important", "Alert", CL.incoming:format(args.spellName))
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, _, spellId)
	if spellId == 198396 then -- Spear of Light
		self:Message(200988, "Urgent", "Alert")
	end
end
