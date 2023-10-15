-------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Chrono-Lord Epoch", 595, 613)
if not mod then return end
mod:RegisterEnableMob(26532)
mod:SetEncounterID(mod:Classic() and 295 or 2003)
--mod:SetRespawnTime(0) -- couldn't wipe, Arthas refuses to die

-------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	-- Prince Arthas Menethil, on this day, a powerful darkness has taken hold of your soul. The death you are destined to visit upon others will this day be your own.
	L.warmup_trigger = "on this day"
end

-------------------------------------------------------------------------------
-- Initialization
--

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
-- Event Handlers
--

function mod:Warmup(event, msg)
	if msg:find(L.warmup_trigger, nil, true) then
		self:UnregisterEvent(event)
		self:Bar("warmup", 19.2, CL.active, "inv_sword_01")
	end
end

function mod:CurseOfExertion(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	self:Bar(args.spellId, 10, args.destName)
end

function mod:CurseOfExertionRemoved(args)
	self:StopBar(args.spellName, args.destName)
end
