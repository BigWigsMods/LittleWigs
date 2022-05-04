
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Zo'phex the Sentinel", 2441, 2437)
if not mod then return end
mod:RegisterEnableMob(
	179334, -- Portalmancer Zo'honn
	175616  -- Zo'phex the Sentinel
)
mod:SetEncounterID(2425)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.zophex_warmup_trigger = "Surrender... all... contraband..."
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		347949, -- Interrogation
		345990, -- Containment Cell
		345770, -- Impound Contraband
		346204, -- Armed Security
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	self:Log("SPELL_AURA_APPLIED", "InterrogationApplied", 347949)
	self:Log("SPELL_AURA_APPLIED", "ContainmentCellApplied", 345990)
	self:Death("ContainmentCellDeath", 175576)
	self:Log("SPELL_AURA_APPLIED", "ImpoundContrabandApplied", 345770)
	self:Log("SPELL_AURA_REMOVED", "ImpoundContrabandRemoved", 345770)
	self:Log("SPELL_CAST_SUCCESS", "ArmedSecurity", 346204)
	self:Log("SPELL_PERIODIC_DAMAGE", "ArmedSecurityDamage", 348366)
end

function mod:OnEngage()
	self:Bar(347949, 34.1) -- Interrogation
	self:Bar(345770, 19.3) -- Impound Contraband
	self:Bar(346204, 8.7) -- Armed Security
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CHAT_MSG_MONSTER_YELL(event, msg)
	if msg == L.zophex_warmup_trigger then
		self:Bar("warmup", 10, CL.active, "achievement_dungeon_brokerdungeon")
	end
end

function mod:InterrogationApplied(args)
	self:TargetMessage(args.spellId, "orange", args.destName)
	self:PlaySound(args.spellId, self:Me(args.destGUID) and "warning" or "alert", nil, args.destName)
	self:CDBar(args.spellId, 46)
	self:CastBar(args.spellId, 5)
end

function mod:ContainmentCellApplied(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	self:PlaySound(args.spellId, self:Me(args.destGUID) and "alert" or "warning")
end

function mod:ContainmentCellDeath(args)
	self:Message(345990, "green", CL.removed:format(args.destName))
	self:PlaySound(345990, "info")
end

function mod:ImpoundContrabandApplied(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId)
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:ImpoundContrabandRemoved(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId, "removed")
		self:PlaySound(args.spellId, "info")
	end
end

function mod:ArmedSecurity(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 47)
end

do
	local prev = 0
	function mod:ArmedSecurityDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:PersonalMessage(346204, "underyou")
				self:PlaySound(346204, "underyou")
			end
		end
	end
end
