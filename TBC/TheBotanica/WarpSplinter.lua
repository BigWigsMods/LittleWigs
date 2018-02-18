--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Warp Splinter", 729, 562)
if not mod then return end
--mod.otherMenu = "Tempest Keep"
mod:RegisterEnableMob(17977)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		34727, -- Summon Saplings
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_SUMMON", "Treants", 34727)

	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
	self:Death("Win", 17977)
end

function mod:OnEngage()
	self:DelayedMessage(34727, 10, "Attention", CL.soon:format(self:SpellName(34727)), nil, "Alarm")
	self:CDBar(34727, 15)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prev = 0
	function mod:Treants(args)
		local t = GetTime()
		if t - prev > 5 then
			prev = t
			self:Message(args.spellId, "Important")
			-- self:Bar(args.spellId, 20, L.treants) -- L.treants was equal to "Treants" on enUS
			self:DelayedMessage(34727, 40, "Attention", "Alarm", CL.soon:format(self:SpellName(34727)))
			self:CDBar(args.spellId, 45)
		end
	end
end
