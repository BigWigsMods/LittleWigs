--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Gatewatcher Iron-Hand", 730)
if not mod then return end
mod:RegisterEnableMob(19710)
-- mod.engageId = 1934 -- no boss frames
-- mod.respawnTime = 0 -- resets, doesn't respawn

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.name = "Gatewatcher Iron-Hand"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		39193, -- Shadow Power
		39194, -- Jackhammer
	}
end

function mod:OnRegister()
	self.displayName = L.name -- no journal entry
end

function mod:OnBossEnable()
	-- no boss frames, so doing this manually
	self:RegisterEvent("ENCOUNTER_START")
	self:RegisterEvent("ENCOUNTER_END")

	self:Log("SPELL_CAST_START", "ShadowPower", 39193, 35322)
	self:Log("SPELL_AURA_APPLIED", "ShadowPowerApplied", 39193, 35322)
	self:Log("SPELL_AURA_REMOVED", "ShadowPowerRemoved", 39193, 35322)

	self:Log("SPELL_DAMAGE", "JackhammersDamage", 39195)
	self:Log("SPELL_MISSED", "JackhammersDamage", 39195)
end

function mod:OnEngage()
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ENCOUNTER_START(_, engageId)
	if engageId == 1934 then
		self:Engage()
	end
end

function mod:ENCOUNTER_END(_, engageId, _, _, _, status)
	if engageId == 1934 then
		if status == 0 then
			self:Wipe()
		else
			self:Win()
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, _, source)
	if source == self.displayName then
		self:Message(39194, "Important", nil, CL.casting:format(self:SpellName(39194)))
		self:CastBar(39194, 10) -- 3s cast + ~7s channel
	end
end

function mod:ShadowPower(args)
	self:Message(39193, "Important", nil, CL.casting:format(args.spellName))
end

function mod:ShadowPowerApplied(args)
	self:Bar(39193, 15)
end

function mod:ShadowPowerRemoved(args)
	self:StopBar(39193)
end

do
	local prev = 0
	function mod:JackhammersDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t - prev > (self:Melee() and 6 or 1.5) then
				prev = t
				self:Message(39194, "Personal", "Alert", CL.you:format(self:SpellName(39194))) -- args.spellName is "Jackhammer Effect"
			end
		end
	end
end
