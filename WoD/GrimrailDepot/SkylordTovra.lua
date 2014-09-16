
--------------------------------------------------------------------------------
-- Module Declaration
--

if not BigWigs.isWOD then return end -- XXX compat
local mod, CL = BigWigs:NewBoss("Skylord Tovra", 993, 1133)
if not mod then return end
mod:RegisterEnableMob(80005)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.rakun = "Rakun"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		161801, 162058, 161588, {162066, "SAY", "FLASH"}, "bosskill",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_CAST_START", "SpinningSpear", 162058)
	self:Log("SPELL_CAST_START", "FreezingSnare", 162066)

	self:Log("SPELL_AURA_APPLIED", "DiffusedEnergy", 161588)
	self:Log("SPELL_AURA_APPLIED_DOSE", "DiffusedEnergy", 161588)

	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "Thunder")

	self:Death("Win", 80005)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Thunder(_, _, _, _, _, target)
	if target == L.rakun then
		self:Message(161801, "Important", "Alert", CL.incoming:format(self:SpellName(161801)))
		self:Bar(161801, 17.3)
	end
end

function mod:SpinningSpear(args)
	self:Message(args.spellId, "Attention")
	self:CDBar(args.spellId, 16.5) -- 16.4-16.9
end

function mod:DiffusedEnergy(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "Personal", "Alarm", CL.underyou:format(args.spellName))
	end
end

do
	local function printTarget(self, player, guid)
		if self:Me(guid) then
			self:Say(162066)
			self:Flash(162066)
		end
		self:TargetMessage(162066, player, "Urgent", "Info")
	end
	function mod:FreezingSnare(args)
		self:CDBar(args.spellId, 16.5) -- 16.5-17
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
	end
end

