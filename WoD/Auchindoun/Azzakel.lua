
--------------------------------------------------------------------------------
-- Module Declaration
--

if not BigWigs.isWOD then return end -- XXX compat
local mod, CL = BigWigs:NewBoss("Azzakel", 984, 1216)
if not mod then return end
mod:RegisterEnableMob(75927)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		153764, {153392, "FLASH", "ICON", "PROXIMITY"}, "bosskill",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_CAST_START", "ClawsOfArgus", 153764)
	self:Log("SPELL_AURA_APPLIED", "CurtainOfFlame", 153392)
	self:Log("SPELL_AURA_REMOVED", "CurtainOfFlameRemoved", 153392)

	self:Death("Win", 75927)
end

function mod:OnEngage()
	self:CDBar(153764, 28) -- Claws of Argus
	self:CDBar(153392, 15) -- Curtain of Flame
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ClawsOfArgus(args)
	self:Message(args.spellId, "Attention")
	self:Bar(args.spellId, 60)
	self:Bar(args.spellId, 17, CL.cast:format(args.spellName))
end

do
	local lastPlayer = nil
	function mod:CurtainOfFlame(args)
		lastPlayer = args.destName
		self:TargetMessage(args.spellId, lastPlayer, "Important", "Warning")
		self:TargetBar(args.spellId, 9, lastPlayer)
		self:PrimaryIcon(args.spellId, lastPlayer)
		if self:Me(args.destGUID) then
			self:Flash(args.spellId)
			self:OpenProximity(args.spellId, 5)
		else
			self:OpenProximity(args.spellId, 5, lastPlayer)
		end
	end

	function mod:CurtainOfFlameRemoved(args)
		-- It can spread, so only remove after it has wore off from the last person it affected.
		if args.destName == lastPlayer then
			self:PrimaryIcon(args.spellId)
			self:CloseProximity(args.spellId)
			lastPlayer = nil
		end
	end
end

