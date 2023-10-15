-------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Mal'Ganis", 595, 614)
if not mod then return end
mod:RegisterEnableMob(26533)
mod:SetEncounterID(mod:Classic() and 296 or 2005)
--mod:SetRespawnTime(0) -- couldn't wipe, Arthas refuses to die

-------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.warmup_trigger = "We're going to finish this right now, Mal'Ganis. Just you... and me."
end

-------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		52721, -- Sleep
		52723, -- Vampiric Touch
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_SAY", "Warmup")
	self:Log("SPELL_AURA_APPLIED", "Sleep", 52721, 58849) -- normal, heroic
	self:Log("SPELL_AURA_REMOVED", "SleepRemoved", 52721, 58849)
	self:Log("SPELL_AURA_APPLIED", "VampiricTouch", 52723)
	self:Log("SPELL_AURA_REMOVED", "VampiricTouchRemoved", 52723)
end

-------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Warmup(event, msg)
	if msg == L.warmup_trigger then
		self:UnregisterEvent(event)
		self:Bar("warmup", 3.9, CL.active, "inv_sword_01")
	end
end

function mod:Sleep(args)
	self:TargetMessage(52721, "red", args.destName)
	self:TargetBar(52721, args.spellId == 52721 and 10 or 8, args.destName)
end

function mod:SleepRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:VampiricTouch(args)
	if self:MobId(args.destGUID) ~= 26533 then return end -- mages can spellsteal it
	self:Message(args.spellId, "orange", CL.onboss:format(args.spellName))
	self:PlaySound(args.spellId, "info")
	self:Bar(args.spellId, 30)
end

function mod:VampiricTouchRemoved(args)
	if self:MobId(args.destGUID) ~= 26533 then return end -- mages can spellsteal it
	self:StopBar(args.spellName)
end
