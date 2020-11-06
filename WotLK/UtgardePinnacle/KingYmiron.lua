
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("King Ymiron", 575, 644)
if not mod then return end
mod:RegisterEnableMob(26861)

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
	self:Log("SPELL_CAST_START", "BaneCast", 48294, 59301) -- normal, heroic
	self:Log("SPELL_AURA_APPLIED", "BaneApplied", 48294, 59301)
	self:Log("SPELL_AURA_REMOVED", "BaneRemoved", 48294, 59301)
	self:Log("SPELL_AURA_APPLIED", "FetidRot", 48291, 59300) -- normal, heroic
	self:Log("SPELL_AURA_REMOVED", "FetidRotRemoved", 48291, 59300)

	self:Death("Win", 26861)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:BaneCast(args)
	self:MessageOld(59301, "orange", nil, CL.casting:format(args.spellName))
end

function mod:BaneApplied(args)
	if self:MobId(args.destGUID) == 26861 then -- Boss only
		self:Bar(59301, 5)
	end
end

function mod:BaneRemoved(args)
	if self:MobId(args.destGUID) == 26861 then -- Boss only
		self:MessageOld(59301, "green", nil, CL.over:format(args.spellName))
		self:StopBar(args.spellName)
	end
end

function mod:FetidRot(args)
	self:TargetMessageOld(59300, args.destName, "orange")
	self:TargetBar(59300, 9, args.destName)
end

function mod:FetidRotRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

