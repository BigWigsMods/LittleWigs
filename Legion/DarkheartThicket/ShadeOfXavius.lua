
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
		200359, -- Induced Paranoia
		212834, -- Nightmare Bolt
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "InducedParanoia", 200359)
	self:Log("SPELL_CAST_START", "NightmareBolt", 212834)
end

function mod:OnEngage()
	self:CDBar(200359, 23) -- Induced Paranoia
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:InducedParanoia(args)
	self:Message(args.spellId, "Personal")
	self:CDBar(args.spellId, 28) -- 28-30
end

do
	local function printTarget(self, player)
		self:TargetMessage(212834, player, "Urgent", "Alert", nil, nil, true)
	end
	function mod:NightmareBolt(args)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
		self:CDBar(args.spellId, 17) -- 17-22
	end
end

