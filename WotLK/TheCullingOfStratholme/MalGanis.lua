-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Mal'Ganis", 521, 614)
if not mod then return end
--mod.otherMenu = "Caverns of Time"
mod:RegisterEnableMob(26533)
mod.engageId = 2005

-------------------------------------------------------------------------------
--  Localization

local L = mod:GetLocale()
if L then
	L.warmup_trigger = "We're going to finish this right now, Mal'Ganis."
end

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		"warmup",
		52721, -- Sleep
		52723, -- Vampiric Touch
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_SAY", "Warmup")
	self:Log("SPELL_AURA_APPLIED", "Sleep", 52721, 58849)
	self:Log("SPELL_AURA_REMOVED", "SleepRemoved", 52721, 58849)
	self:Log("SPELL_AURA_APPLIED", "VampiricTouch", 52723)
	self:Log("SPELL_AURA_REMOVED", "VampiricTouchRemoved", 52723)

	--self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Warmup(event, msg)
	if msg:find(L.warmup_trigger, nil, true) then
		self:Bar("warmup", 3.9, CL.active, "inv_sword_01")
		self:UnregisterEvent(event)
	end
end

function mod:Sleep(args)
	self:TargetMessage(52721, args.destName, "Important")
	self:TargetBar(52721, args.spellId == 52721 and 10 or 8, args.destName)
end

function mod:SleepRemoved(args)
	self:StopBar(52721, args.destName)
end

function mod:VampiricTouch(args)
	if self:MobId(args.destGUID) ~= 26533 then return end
	self:Message(args.spellId, "Important", nil, CL.onboss:format(args.spellName))
	self:Bar(args.spellId, 30)
end

function mod:VampiricTouchRemoved(args)
	if self:MobId(args.destGUID) ~= 26533 then return end
	self:StopBar(args.spellId)
end

--[[function mod:CHAT_MSG_MONSTER_YELL(_, msg)
	if msg:find(L.defeat_trigger, nil, true) then -- FIXME: there must be a better way
		self:Win()
	end
end]]
