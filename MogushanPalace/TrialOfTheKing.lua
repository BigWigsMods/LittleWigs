
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Trial of the King", 885, 708)
-- Xin the Weaponmaster, Haiyan the Unstoppable, Ming the Cunning, Kuai the Brute, Mu'Shiba
mod:RegisterEnableMob(61884, 61445, 61444, 61442, 61453)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	--A Saurok runs down a hidden set of stairs with some of the treasure!
	L.win_emote = "treasure"

	L.blow = EJ_GetSectionInfo(6026) .. " " .. INLINE_HEALER_ICON
	L.blow_desc = CL["healer"].. select(2, EJ_GetSectionInfo(6026))
	L.blow_icon = 123655
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
	119922, {"ej:6017", "ICON"},
	{"ej:6024", "ICON"}, {"ej:6025", "ICON", "SAY", "FLASHSHAKE"}, "blow",
	"bosskill",
	}, {
	[119922] = "ej:6015", --Kuai
	["ej:6024"] = "ej:6023", --Haiyan
	bosskill = "general",
	}
end

function mod:VerifyEnable(unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp > 15 then
		return true
	end
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "TraumaticBlow", 123655)

	self:Log("SPELL_AURA_APPLIED", "Ravage", 119946)
	self:Log("SPELL_AURA_REMOVED", "RavageOver", 119946)

	self:Log("SPELL_AURA_APPLIED", "Conflag", 120160)
	self:Log("SPELL_AURA_REMOVED", "ConflagOver", 120160)

	self:Log("SPELL_CAST_START", "Shockwave", 119922)

	--|TInterface\\Icons\\spell_fire_meteorstorm.blp:20|tHaiyan the Unstoppable targets |cFFFF0000PLAYER|r with a |cFFFF0000|Hspell:120195|h[Meteor]|h|r!
	self:Emote("Meteor", "meteorstorm")
	self:Log("SPELL_DAMAGE", "MeteorHit", 120196)
	self:Log("SPELL_MISSED", "MeteorHit", 120196)

	self:Emote("Win", L["win_emote"])
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:TraumaticBlow(args)
	if self:Healer() then
		self:TargetMessage("blow", args.spellName, args.destName, "Positive", args.spellId)
		self:TargetBar("blow", args.spellName, args.destName, 5, args.spellId)
	end
end

function mod:Ravage(args)
	self:TargetMessage("ej:6017", args.spellName, args.destName, "Attention", args.spellId)
	self:TargetBar("ej:6017", args.spellName, args.destName, 11, args.spellId)
	self:PrimaryIcon("ej:6017", args.destName)
end

function mod:RavageOver()
	self:PrimaryIcon("ej:6017")
end

function mod:Conflag(args)
	self:TargetMessage("ej:6024", args.spellName, args.destName, "Attention", args.spellId)
	self:TargetBar("ej:6024", args.spellName, args.destName, 5, args.spellId)
	self:SecondaryIcon("ej:6024", args.destName)
end

function mod:ConflagOver()
	self:SecondaryIcon("ej:6024")
end

function mod:Shockwave(args)
	self:Message(args.spellId, CL["cast"]:format(args.spellName), "Urgent", args.spellId, "Alert")
	self:Bar(args.spellId, CL["cast"]:format(args.spellName), 2, args.spellId)
end

function mod:Meteor(_, msg, _, _, _, player)
	local meteor = self:SpellName(120195)
	self:TargetMessage("ej:6025", meteor, player, "Important", 120195, "Alarm")
	self:TargetBar("ej:6025", meteor, player, 5, 120195)
	self:PrimaryIcon("ej:6025", player)
	if UnitIsUnit(player, "player") then
		self:FlashShake("ej:6025")
		self:Say("ej:6025", meteor)
	end
end

function mod:MeteorHit()
	self:PrimaryIcon("ej:6025")
end

