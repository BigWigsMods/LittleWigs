--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Tirathon Saltheril", 1493, 1467)
if not mod then return end
mod:RegisterEnableMob(95885, 99013) -- Tirathon, Drelanim
mod.engageId = 1815

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.warmup_trigger = "I will serve MY people, the exiled and the reviled."
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		191941, -- Darkstrikes
		191853, -- Furious Flames
		191823, -- Furious Blast
		{190830, "CASTBAR"}, -- Hatred
		192504, -- Metamorphosis (Havoc)
		202740, -- Metamorphosis (Vengeance)
	}, {
		[192504] = 192504 -- Metamorphosis
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "Warmup")
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Log("SPELL_CAST_START", "DarkstrikesCast", 191941, 204151)
	self:Log("SPELL_AURA_APPLIED", "DarkstrikesApplied", 191941)
	self:Log("SPELL_AURA_APPLIED", "Vengeance", 202740)
	self:Log("SPELL_AURA_APPLIED", "Havoc", 192504)
	self:Log("SPELL_AURA_APPLIED", "FuriousFlamesApplied", 191853)
	self:Log("SPELL_CAST_START", "FuriousBlast", 191823)
end

function mod:OnEngage()
	self:CDBar(191941, 5.2) -- Darkstrikes
end

function mod:VerifyEnable(_, mobId)
	if mobId == 99013 then -- Drelanim is a friendly NPC
		local _, _, completed = C_Scenario.GetCriteriaInfo(1)
		return not completed
	end
	return true
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Warmup(event, msg)
	if msg == L.warmup_trigger then
		self:UnregisterEvent(event)
		self:Bar("warmup", 8, CL.active, "achievement_dungeon_vaultofthewardens")
	end
end

function mod:DarkstrikesCast(args)
	self:MessageOld(191941, "red", self:Tank() and "alarm", CL.casting:format(args.spellName))
	self:CDBar(191941, 31)
end

function mod:DarkstrikesApplied(args)
	self:TargetMessageOld(args.spellId, args.destName, "orange")
	self:Bar(args.spellId, 10, CL.onboss:format(args.spellName))
end

function mod:Havoc(args)
	self:MessageOld(args.spellId, "cyan", "info")
	self:CDBar(191941, 24) -- Darkstrikes
	self:CDBar(190830, 14.5) -- Hatred
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 190830 then -- Hatred
		self:MessageOld(spellId, "yellow", "warning")
		self:CastBar(spellId, 10)
		self:CDBar(spellId, 30)
	end
end

function mod:Vengeance(args)
	self:MessageOld(args.spellId, "cyan", "info")
	self:StopBar(191941) -- Darkstrikes
end

function mod:FuriousFlamesApplied(args)
	if self:Me(args.destGUID) then
		self:MessageOld(args.spellId, "blue", "alert", CL.underyou:format(args.spellName))
	end
end

function mod:FuriousBlast(args)
	self:MessageOld(args.spellId, "orange", "alarm", CL.casting:format(args.spellName))
end
