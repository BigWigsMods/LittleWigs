-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Salramm the Fleshcrafter", nil, 612, 595)
if not mod then return end
--mod.otherMenu = "Caverns of Time"
mod:RegisterEnableMob(26530)
mod.engageId = 2004

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		58845, -- Curse of Twisted Flesh
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "TwistedFlesh", 58845)
	self:Log("SPELL_AURA_REMOVED", "TwistedFleshRemoved", 58845)
	self:Death("Win", 26530)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:TwistedFlesh(args)
	self:TargetMessage(args.spellId, args.destName, "Important")
	self:Bar(args.spellId, 30, args.destName)
end

function mod:TwistedFleshRemoved(args)
	self:StopBar(args.spellId, args.destName)
end
