-------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Zuraal", 1753, 1979)
if not mod then return end
mod:RegisterEnableMob(122313) -- Zuraal the Ascended
mod:SetEncounterID(2065)
mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{244588, sound = "underyou"}, -- Void Sludge
	{244599, sound = "warning"}, -- Dark Expulsion
})

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
	self:Log("SPELL_DAMAGE", "UmbraShift", 244433) -- No debuff or targeted events
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

--------------------------------------------------------------------------------
-- Midnight Initialization
--

if mod:Retail() then -- Midnight+
	function mod:GetOptions()
		return {
			{244588, "PRIVATE"}, -- Void Sludge
			{244599, "PRIVATE"}, -- Dark Expulsion
		}
	end

	function mod:OnBossEnable()
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:NullPalm(args)
	self:Message(args.spellId, "red")
	self:CDBar(args.spellId, 55)
	self:PlaySound(args.spellId, "alarm")
end

function mod:Decimate(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 12.5)
	self:PlaySound(args.spellId, "warning")
end

function mod:CoalescedVoid()
	self:Message(244602, "yellow")
	self:CDBar(244602, 55)
	self:PlaySound(244602, "alert")
end

function mod:UmbraShift(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:CDBar(args.spellId, 55)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "warning")
	end
end

function mod:Fixate(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Fixate")
		self:PlaySound(args.spellId, "warning")
	end
end

function mod:VoidTear(args)
	self:StopBar(246134) -- Null Palm
	self:StopBar(244579) -- Decimate
	self:StopBar(244602) -- Coalesced Void
	self:StopBar(244433) -- Umbra Shift
	self:Message(args.spellId, "green", args.spellName)
	self:Bar(args.spellId, 20)
	self:PlaySound(args.spellId, "long")
end

function mod:VoidTearRemoved(args)
	self:Message(args.spellId, "cyan", CL.removed:format(args.spellName))
	self:CDBar(246134, 10.5) -- Null Palm _start
	self:CDBar(244579, 18) -- Decimate _start
	self:CDBar(244602, 20) -- Coalesced Void _success
	self:CDBar(244433, 41) -- Umbra Shift _success
	self:PlaySound(args.spellId, "info")
end
