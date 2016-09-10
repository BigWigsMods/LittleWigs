
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Shade of Xavius", 1067, 1657)
if not mod then return end
mod:RegisterEnableMob(99192)
mod.engageId = 1839

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{200289, "ICON", "SAY"}, -- Growing Paranoia
		{212834, "ICON", "SAY"}, -- Nightmare Bolt
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "GrowingParanoia", 200289)
	self:Log("SPELL_AURA_APPLIED", "GrowingParanoiaApplied", 200289)
	self:Log("SPELL_AURA_REMOVED", "GrowingParanoiaRemoved", 200289)
	self:Log("SPELL_CAST_START", "NightmareBolt", 212834)
end

function mod:OnEngage()
	self:CDBar(200289, 28) -- Growing Paranoia
	self:CDBar(212834, 8) -- Nightmare Bolt
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:GrowingParanoia(args)
	self:TargetMessage(args.spellId, args.destName, "Attention", "Alarm")
	self:CDBar(args.spellId, 20) -- pull:28.4, 20.6, 21.9
end

function mod:GrowingParanoiaApplied(args)
	self:PrimaryIcon(args.spellId, args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
	end
end

function mod:GrowingParanoiaRemoved(args)
	self:PrimaryIcon(args.spellId)
end

do
	local function printTarget(self, player, guid)
		self:TargetMessage(212834, player, "Urgent", "Alert", nil, nil, true)

		if self:Normal() then return end
		if self:Me(guid) then
			self:Say(args.spellId)
		end
		-- XXX icon?
	end
	function mod:NightmareBolt(args)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
		self:CDBar(args.spellId, 23) -- pull:8.9, 23.0, 23.1
	end
end

