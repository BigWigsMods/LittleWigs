-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Salramm the Fleshcrafter", 595, 612)
if not mod then return end
mod:RegisterEnableMob(26530)
mod.engageId = 2004
--mod.respawnTime = 0 -- resets instead of respawning

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
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:TwistedFlesh(args)
	self:TargetMessageOld(args.spellId, args.destName, "red")
	self:Bar(args.spellId, 30, args.destName)
end

function mod:TwistedFleshRemoved(args)
	self:StopBar(args.spellName, args.destName)
end
