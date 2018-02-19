-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Bloodlord Mandokir", 859, 176)
if not mod then return end
mod:RegisterEnableMob(52151, 52157)

--------------------------------------------------------------------------------
--  Locals

local rebirthcount = 8

-------------------------------------------------------------------------------
--  Localization

local L = mod:GetLocale()
if L then
	L.rebirth = "Ghost rebirth"
	L.rebirth_desc = "Warn for Ghost rebirth remaining."
	L.rebirth_message = "Ghost rebirth - %d left"
	L.ohgan_message = "Ohgan rebirth!"
end

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		"rebirth",
		96740, -- Devastating Slam
		96684, -- Decapitate
		96776, -- Bloodletting
		96800, -- Frenzy
		96724, -- Reanimate Ohgan
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Rebirth", 96484)
	self:Log("SPELL_CAST_START", "DevastatingSlam", 96740)
	self:Log("SPELL_CAST_SUCCESS", "Decapitate", 96684)
	self:Log("SPELL_AURA_APPLIED", "Bloodletting", 96776)
	self:Log("SPELL_AURA_APPLIED", "Frenzy", 96800)
	self:Log("SPELL_HEAL", "OhganRebirth", 96724)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Death("Deaths", 52151, 52156)
end

function mod:OnEngage()
	rebirthcount = 8
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Rebirth()
	rebirthcount = rebirthcount - 1
	self:Message("rebirth", "Attention", "Alarm", L.rebirth_message:format(rebirthcount))
end

function mod:DevastatingSlam(args)
	self:Message(args.spellId, "Important", "Info")
end

function mod:Decapitate(args)
	self:TargetMessage(args.spellId, args.destName, "Attention", "Alert")
	self:CDBar(args.spellId, 30)
end

function mod:Bloodletting(args)
	self:Message(args.spellId, "Attention", "Alert")
	self:TargetBar(args.spellId, 10, args.destName)
	self:CDBar(args.spellId, 25)
end

function mod:Frenzy(args)
	self:Message(args.spellId, "Important", "Long")
end

function mod:OhganRebirth(args)
	self:Message(args.spellId, "Attention", "Info", L.ohgan_message)
end

function mod:Deaths(args)
	if args.destGUID == 52156 then -- Chained Spirit
		rebirthcount = rebirthcount - 1
		self:Message("rebirth", "Attention", "Alarm", L.rebirth_message:format(rebirthcount))
	elseif args.destGUID == 52151 then
		self:Win()
	end
end
