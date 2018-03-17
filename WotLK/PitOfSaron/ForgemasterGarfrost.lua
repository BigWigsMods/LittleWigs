
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Forgemaster Garfrost", 658, 608)
if not mod then return end
mod:RegisterEnableMob(36494)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		70381, -- Deep Freeze
		{68789, "FLASH"}, -- Throw Saronite
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "DeepFreeze", 70381)
	self:Log("SPELL_AURA_REMOVED", "DeepFreezeRemoved", 70381)
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_WHISPER")
	self:Death("Win", 36494)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DeepFreeze(args)
	self:TargetMessage(args.spellId, args.destName, "Attention", "Alert")
	self:TargetBar(args.spellId, 14, args.destName)
	self:PrimaryIcon(args.spellId, args.destName)
end

function mod:DeepFreezeRemoved(args)
	self:PrimaryIcon(args.spellId)
end

function mod:CHAT_MSG_RAID_BOSS_WHISPER(event, msg)
	self:Message(68789, "Personal", "Alarm", CL.incoming:format(self:SpellName(68789)))
	self:Flash(68789)
end

