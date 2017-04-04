
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
		{200185, "ICON", "SAY"}, -- Nightmare Bolt
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "GrowingParanoia", 200289)
	self:Log("SPELL_AURA_APPLIED", "GrowingParanoiaApplied", 200289)
	self:Log("SPELL_AURA_REMOVED", "GrowingParanoiaRemoved", 200289)
	self:Log("SPELL_CAST_START", "NightmareBolt", 212834, 200185) -- Normal, Heroic+
	self:Log("SPELL_AURA_REMOVED", "WakingNightmareOver", 200243)
end

function mod:OnEngage()
	self:CDBar(200289, 25.5) -- Growing Paranoia
	self:CDBar(200185, 7) -- Nightmare Bolt
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:GrowingParanoia(args)
	self:TargetMessage(args.spellId, args.destName, "Attention", "Alarm")
	--self:CDBar(args.spellId, 26) -- pull:25.5, 26.8, 28.0, 19.5 / hc pull:27.1, 32.8, 26.7, 27.9 / m pull:25.5, 37.6, 47.3
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
		self:TargetMessage(200185, player, "Urgent", "Alert", nil, nil, true)

		if not self:Normal() then
			if self:Me(guid) then
				self:Say(200185)
			end
			self:SecondaryIcon(200185, player)
		end
	end
	function mod:NightmareBolt(args)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
		--self:CDBar(200185, 23) -- pull:9.6, 19.5, 30.4, 24.3, 19.4 / hc pull:9.1, 23.1, 37.6, 21.8 / m pull:7.2, 21.9, 26.7, 21.9, 17.0
	end
	function mod:WakingNightmareOver()
		self:SecondaryIcon(200185)
	end
end

