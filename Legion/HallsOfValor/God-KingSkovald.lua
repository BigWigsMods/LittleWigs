
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("God-King Skovald", 1041, 1488)
if not mod then return end
mod:RegisterEnableMob(95675)
mod.engageId = 1808

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		193668, -- Savage Blade
		193826, -- Ragnarok
		{193659, "SAY", "ICON"}, -- Felblaze Rush
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "SavageBlade", 193668)
	self:Log("SPELL_CAST_START", "Ragnarok", 193826)
	self:Log("SPELL_CAST_START", "FelblazeRush", 193659)
	self:Log("SPELL_CAST_SUCCESS", "FelblazeRushEnd", 193659)
end

function mod:OnEngage()
	self:Bar(193826, 11) -- Ragnarok
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SavageBlade(args)
	self:Message(args.spellId, "Attention", self:Tank() and "Warning")
	self:Bar(args.spellId, 23) -- pull:43.8, 23.0
end

function mod:Ragnarok(args)
	self:Message(args.spellId, "Urgent", "Long")
	self:Bar(args.spellId, 23) -- pull:43.8, 23.0
end

do
	local function printTarget(self, player, guid)
		if self:Me(guid) then
			self:Say(193659)
		end
		self:PrimaryIcon(193659, player)
		self:TargetMessage(193659, player, "Important", "Alarm")
	end
	function mod:FelblazeRush(args)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
		--self:CDBar(args.spellId, 10) -- pull:8.7, 14.6, 26.7, 12.1
	end
	function mod:FelblazeRushEnd(args)
		self:PrimaryIcon(args.spellId)
	end
end

