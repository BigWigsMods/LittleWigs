if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Lord and Lady Waycrest", 1862, 2128)
if not mod then return end
mod:RegisterEnableMob(135357, 132656) -- Lady Waycrest, Lord Waycrest
mod.engageId = 2116

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		--[[ Lady Waycrest ]]--
		261417, -- Reality Tear
		261446, -- Vitality Transfer
		--[[ Lord Waycrest ]]--
		{261438, "TANK_HEALER"}, -- Wasting Strike
		{261440, "SAY"}, -- Virulent Pathogen
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "RealityTear", 261417)
	self:Log("SPELL_CAST_START", "VitalityTransfer", 261446)
	self:Log("SPELL_CAST_SUCCESS", "WastingStrike", 261438)
	self:Log("SPELL_CAST_SUCCESS", "VirulentPathogen", 261440)
	self:Log("SPELL_AURA_APPLIED", "VirulentPathogenApplied", 261440)
	self:Log("SPELL_AURA_REMOVED", "VirulentPathogenRemoved", 261440)
end

function mod:OnEngage()
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:RealityTear(args)
	self:Message(args.spellId, "orange", "Alarm")
end

function mod:VitalityTransfer(args)
	self:Message(args.spellId, "cyan", "Long")
end

function mod:WastingStrike(args)
	self:Message(args.spellId, "yellow", "Alert")
end

function mod:VirulentPathogen(args)
	self:TargetMessage(args.spellId, args.destName, "red", "Warning", nil, nil, true)
end

function mod:VirulentPathogenApplied(args) -- XXX Proximity ?
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
		self:SayCountdown(args.spellId, 5)
	end
end

function mod:VirulentPathogenRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
end
