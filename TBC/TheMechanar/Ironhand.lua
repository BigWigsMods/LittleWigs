--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Gatewatcher Iron-Hand", 730)
if not mod then return end
mod:RegisterEnableMob(19710)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.hammer_trigger = "raises his hammer menacingly"
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

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ShadowPower", 39193, 35322)
	self:Log("SPELL_AURA_APPLIED", "ShadowPowerApplied", 39193, 35322)
	self:Log("SPELL_AURA_REMOVED", "ShadowPowerRemoved", 39193, 35322)

	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
	self:Death("Win", 19710)
end

function mod:OnEngage()
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg)
	if msg:find(L.hammer_trigger) then
		self:Message(39194, "Important", nil, CL.casting:format(self:SpellName(39194)))
		self:CastBar(39194, 3)
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
