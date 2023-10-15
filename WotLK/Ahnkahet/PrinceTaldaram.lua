--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Prince Taldaram", 619, 581)
if not mod then return end
mod:RegisterEnableMob(29308)
mod:SetEncounterID(mod:Classic() and 213 or 1966)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		59513, -- Embrace of the Vampyr
		55931, -- Conjure Flame Sphere
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "EmbraceOfTheVampyr", 55959, 59513)
	self:Log("SPELL_AURA_REMOVED", "EmbraceOfTheVampyrRemoved", 55959, 59513)
	self:Log("SPELL_CAST_START", "ConjureFlameSphere", 55931)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:EmbraceOfTheVampyr(args)
	self:TargetMessage(59513, "red", args.destName)
	self:PlaySound(59513, "warning")
	self:Bar(59513, 20)
end

function mod:EmbraceOfTheVampyrRemoved(args)
	self:Message(59513, "green", CL.over:format(args.spellName))
	self:StopBar(args.spellName)
end

function mod:ConjureFlameSphere(args)
	self:Message(args.spellId, "red")
	self:Bar(args.spellId, 10)
end
