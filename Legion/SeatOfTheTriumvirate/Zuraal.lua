
--------------------------------------------------------------------------------
-- TODO List:
-- -- Optimize timers (especially after a Void Tear Stun)
-- -- Improve Umbra Shift warnings: alt power tracking, updated way to detect who has been send in (blizzard plz)

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Zuraal", 1753, 1979)
if not mod then return end
mod:RegisterEnableMob(122313) -- Zuraal the Ascended
mod.engageId = 2065

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		246134, -- Null Palm
		244579, -- Decimate
		244602, -- Coalesced Void
		244433, -- Umbra Shift
		{244653, "SAY"}, -- Fixate
		244621, -- Void Tear
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "NullPalm", 246134)
	self:Log("SPELL_CAST_START", "Decimate", 244579)
	self:Log("SPELL_CAST_SUCCESS", "CoalescedVoid", 246139)
	self:Log("SPELL_DAMAGE", "UmbraShift", 244433) -- No debuff or targetted events
	self:Log("SPELL_AURA_APPLIED", "Fixate", 244653)
	self:Log("SPELL_AURA_APPLIED", "VoidTear", 244621)
	self:Log("SPELL_AURA_REMOVED", "VoidTearRemoved", 244621)
end

function mod:OnEngage()
	self:CDBar(246134, 10.5) -- Null Palm _start
	self:CDBar(244579, 18) -- Decimate _start
	self:CDBar(244602, 20) -- Coalesced Void _success
	self:CDBar(244433, 41) -- Umbra Shift _success
end

function mod:OnWin()
	local trashMod = BigWigs:GetBossModule("Seat of the Triumvirate Trash", true)
	if trashMod then
		trashMod:Enable() -- Making sure to pickup the Alleria yell to start the RP bar
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:NullPalm(args)
	self:MessageOld(args.spellId, "red", "alarm")
	self:CDBar(args.spellId, 55)
end

function mod:Decimate(args)
	self:MessageOld(args.spellId, "orange", "warning")
	self:CDBar(args.spellId, 12.5)
end

function mod:CoalescedVoid()
	self:MessageOld(244602, "yellow", "alert")
	self:CDBar(244602, 55)
end

function mod:UmbraShift(args)
	self:TargetMessageOld(args.spellId, args.destName, "blue", "warning")
	self:CDBar(args.spellId, 55)
end

function mod:Fixate(args)
	self:TargetMessageOld(args.spellId, args.destName, "blue", "warning")
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Fixate")
	end
end

function mod:VoidTear(args)
	self:StopBar(246134) -- Null Palm
	self:StopBar(244579) -- Decimate
	self:StopBar(244602) -- Coalesced Void
	self:StopBar(244433) -- Umbra Shift

	self:MessageOld(args.spellId, "green", "long", args.spellName)
	self:Bar(args.spellId, 20)
end

function mod:VoidTearRemoved(args)
	self:MessageOld(args.spellId, "cyan", "info", CL.removed:format(args.spellName))
	self:CDBar(246134, 10.5) -- Null Palm _start
	self:CDBar(244579, 18) -- Decimate _start
	self:CDBar(244602, 20) -- Coalesced Void _success
	self:CDBar(244433, 41) -- Umbra Shift _success
end
