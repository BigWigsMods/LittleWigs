-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Chrono-Lord Epoch", 595, 613)
if not mod then return end
--mod.otherMenu = "Caverns of Time"
mod:RegisterEnableMob(26532)
mod.engageId = 2003

-------------------------------------------------------------------------------
--  Localization

local L = mod:GetLocale()
if L then
	L.warmup_trigger = "Prince Arthas Menethil, on this day, a powerful darkness has taken hold of your soul."
end

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		"warmup",
		52772, -- Curse of Exertion
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "Warmup")
	self:Log("SPELL_AURA_APPLIED", "CurseOfExertion", 52772)
	self:Log("SPELL_AURA_REMOVED", "CurseOfExertionRemoved", 52772)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Warmup(event, msg)
	if msg:find(L.warmup_trigger, nil, true) then
		self:Bar("warmup", 19.2, CL.active, "inv_sword_01")
		self:UnregisterEvent(event)
	end
end

function mod:CurseOfExertion(args)
	self:TargetMessage(args.spellId, args.destName, "Important")
	self:Bar(args.spellId, 10, args.destName)
end

function mod:CurseOfExertionRemoved(args)
	self:StopBar(args.spellId, args.destName)
end
