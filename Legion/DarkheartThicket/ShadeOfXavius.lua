
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
	self:CDBar(200289, 27) -- Growing Paranoia
	self:CDBar(200185, 8) -- Nightmare Bolt
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:GrowingParanoia(args)
	self:TargetMessage(args.spellId, args.destName, "Attention", "Alarm")
	self:CDBar(args.spellId, self:Normal() and 20 or 27) -- pull:28.4, 20.6, 21.9 / hc pull:27.1, 32.8, 26.7, 27.9
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
		if args.spellId == 212834 then -- Normal
			self:CDBar(200185, 23) -- pull:8.9, 23.0, 23.1
		else
			self:CDBar(200185, 23) -- XXX hc pull:9.1, 23.1, 37.6, 21.8 -- hc pull:9.4, 23.5, 21.8
		end
	end
	function mod:WakingNightmareOver()
		self:SecondaryIcon(200185)
	end
end

