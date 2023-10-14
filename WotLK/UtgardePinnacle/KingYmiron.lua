--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("King Ymiron", 575, 644)
if not mod then return end
mod:RegisterEnableMob(26861)
mod:SetEncounterID(mod:Classic() and 583 or 2028)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		59301, -- Bane
		59300, -- Fetid Rot
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Bane", 48294, 59301) -- normal, heroic
	self:Log("SPELL_AURA_APPLIED", "BaneApplied", 48294, 59301)
	self:Log("SPELL_AURA_REMOVED", "BaneRemoved", 48294, 59301)
	self:Log("SPELL_AURA_APPLIED", "FetidRot", 48291, 59300) -- normal, heroic
	self:Log("SPELL_AURA_REMOVED", "FetidRotRemoved", 48291, 59300)
end

function mod:OnEngage()
	self:CDBar(59301, 16.0) -- Bane
	self:CDBar(59300, 10.7) -- Fetid Rot
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Bane(args)
	self:Message(59301, "orange", CL.casting:format(args.spellName))
	self:PlaySound(59301, "alert")
	self:CDBar(59301, 19.4)
end

function mod:BaneApplied(args)
	if self:MobId(args.destGUID) == 26861 then -- Boss only
		self:Bar(59301, 5, CL.onboss:format(args.spellName))
	end
end

function mod:BaneRemoved(args)
	if self:MobId(args.destGUID) == 26861 then -- Boss only
		self:Message(59301, "green", CL.over:format(args.spellName))
		self:PlaySound(59301, "info")
		self:StopBar(CL.onboss:format(args.spellName))
	end
end

function mod:FetidRot(args)
	self:TargetMessage(59300, "orange", args.destName)
	self:TargetBar(59300, 9, args.destName)
	self:CDBar(59300, 15.7)
end

function mod:FetidRotRemoved(args)
	self:StopBar(args.spellName, args.destName)
end
