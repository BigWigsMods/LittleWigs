
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Shade of Xavius", 1466, 1657)
if not mod then return end
mod:RegisterEnableMob(99192)
mod.engageId = 1839

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		200050, -- Apocalyptic Nightmare
		{200289, "ICON", "SAY"}, -- Growing Paranoia
		{200185, "ICON", "SAY"}, -- Nightmare Bolt
		200238, -- Feed on the Weak
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "GrowingParanoia", 200289)
	self:Log("SPELL_AURA_REMOVED", "GrowingParanoiaRemoved", 200289)
	self:Log("SPELL_CAST_START", "NightmareBolt", 212834, 200185) -- Normal, Heroic+
	self:Log("SPELL_AURA_REMOVED", "WakingNightmareOver", 200243)
	self:Log("SPELL_AURA_APPLIED", "FeedOnTheWeakApplied", 200238)
end

function mod:OnEngage()
	self:CDBar(200289, 25.5) -- Growing Paranoia
	self:CDBar(200185, 7) -- Nightmare Bolt
	self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_HEALTH(event, unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp <= 50 then
		self:UnregisterUnitEvent(event, unit)

		-- Bars might show less time than you
		-- actually have, but never show more.
		local _, _, _, _, endTime = UnitCastingInfo(unit) -- Nightmare Bolt, Growing Paranoia
		if endTime then
			local timeLeft = endTime / 1000 - GetTime()
			self:ScheduleTimer("MessageOld", timeLeft, 200050, "yellow", "info", CL.incoming:format(self:SpellName(200050)))
			self:ScheduleTimer("CDBar", timeLeft, 200050, 5)
		else
			self:MessageOld(200050, "yellow", "info", CL.incoming:format(self:SpellName(200050)))
			self:CDBar(200050, 5)
		end
	end
end

do
	local function printTarget(self, player, guid)
		self:TargetMessageOld(200289, player, "yellow", "alarm", nil, nil, true)
		self:PrimaryIcon(200289, player)
		if self:Me(guid) then
			self:Say(200289)
		end
	end
	function mod:GrowingParanoia(args)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
		--self:CDBar(args.spellId, 26) -- pull:25.5, 26.8, 28.0, 19.5 / hc pull:27.1, 32.8, 26.7, 27.9 / m pull:25.5, 37.6, 47.3
	end
	function mod:GrowingParanoiaRemoved(args)
		self:PrimaryIcon(args.spellId)
	end
end

function mod:FeedOnTheWeakApplied(args)
	if self:Me(args.destGUID) or self:Healer() then
		self:TargetMessageOld(args.spellId, args.destName, "red", "warning", nil, nil, true)
	end
end

do
	local function printTarget(self, player, guid)
		self:TargetMessageOld(200185, player, "orange", "alert", nil, nil, true)

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

