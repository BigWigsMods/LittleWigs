
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Trial of the King", 885, 708)
if not mod then return end
-- Xin the Weaponmaster, Haiyan the Unstoppable, Ming the Cunning, Kuai the Brute, Mu'Shiba
mod:RegisterEnableMob(61884, 61445, 61444, 61442, 61453)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	--A Saurok runs down a hidden set of stairs with some of the treasure!
	L.win_emote = "treasure"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
	119922, {-6017, "ICON"},
	{-6024, "ICON"}, {-6025, "ICON", "SAY", "FLASH"}, {123655, "HEALER"},
	"bosskill",
	}, {
	[119922] = -6015, --Kuai
	[-6024] = -6023, --Haiyan
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
	self:TargetMessage(args.spellId, args.destName, "Positive")
	self:TargetBar(args.spellId, 5, args.destName)
end

function mod:Ravage(args)
	self:TargetMessage(-6017, args.destName, "Attention", nil, args.spellId)
	self:TargetBar(-6017, 11, args.destName, args.spellId)
	self:PrimaryIcon(-6017, args.destName)
end

function mod:RavageOver()
	self:PrimaryIcon(-6017)
end

function mod:Conflag(args)
	self:TargetMessage(-6024, args.destName, "Attention", nil, args.spellId)
	self:TargetBar(-6024, 5, args.destName, args.spellId)
	self:SecondaryIcon(-6024, args.destName)
end

function mod:ConflagOver()
	self:SecondaryIcon(-6024)
end

function mod:Shockwave(args)
	self:Message(args.spellId, "Urgent", "Alert", CL["casting"]:format(args.spellName), args.spellId)
	self:Bar(args.spellId, 2, CL["cast"]:format(args.spellName), args.spellId)
end

function mod:Meteor(msg, _, _, _, player)
	self:TargetMessage(-6025, player, "Important", "Alarm", 120195)
	self:TargetBar(-6025, 5, player, 120195)
	self:PrimaryIcon(-6025, player)
	if UnitIsUnit(player, "player") then
		self:Flash(-6025)
		self:Say(-6025, 120195)
	end
end

function mod:MeteorHit()
	self:PrimaryIcon(-6025)
end

