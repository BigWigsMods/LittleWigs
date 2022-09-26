-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Watchkeeper Gargolmar", 543, 527)
if not mod then return end
mod:RegisterEnableMob(17306)
-- mod.engageId = 1893 -- no boss frames
-- mod.respawnTime = 0 -- resets, doesn't respawn

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		{36814, "TANK_HEALER"}, -- Mortal Wound
		12039, -- Heal
		8362, -- Renew
		14032, -- Shadow Word: Pain
	}, {
		[36814] = "general",
		[12039] = -5053, -- Hellfire Watcher
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "MortalWound", 36814)
	self:Log("SPELL_AURA_APPLIED_DOSE", "MortalWound", 36814)

	self:Log("SPELL_CAST_START", "Heal", 12039)
	self:Log("SPELL_CAST_START", "Renew", 8362)
	self:Log("SPELL_AURA_APPLIED", "RenewApplied", 8362)
	self:Log("SPELL_AURA_APPLIED", "ShadowWordPain", 14032)
	self:Log("SPELL_AURA_REMOVED", "ShadowWordPainRemoved", 14032)

	self:Death("Win", 17306)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:MortalWound(args)
	self:StackMessageOld(args.spellId, args.destName, args.amount, "cyan")
end

-- There are 2 Hellfire Watchers on pull, so throttling everything
do
	local prev = 0
	function mod:Heal(args)
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:MessageOld(args.spellId, "red", self:Interrupter() and "warning", CL.casting:format(args.spellName))
		end
	end
end

do
	local prev = 0
	function mod:Renew(args)
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:MessageOld(args.spellId, "yellow", self:Interrupter() and "warning", CL.casting:format(args.spellName))
		end
	end
end

do
	local prev, prevGUID = 0, nil
	function mod:RenewApplied(args)
		if not self:Dispeller("magic", true) then return end

		local t = args.time
		local isANewPairOfCasts = t - prev > 1
		if isANewPairOfCasts or (prevGUID ~= args.destGUID) then
			prev = t
			self:TargetMessageOld(args.spellId, args.destName, "yellow")
			if isANewPairOfCasts then
				self:PlaySound(args.spellId, "alarm") -- don't play 2 sounds if 2 different targets get Renew at the same time
			end
		end
		prevGUID = args.destGUID
	end
end

function mod:ShadowWordPain(args)
	if self:Me(args.destGUID) or self:Dispeller("magic") then
		self:TargetMessageOld(args.spellId, args.destName, "orange")
		self:TargetBar(args.spellId, 15, args.destName)
	end
end

function mod:ShadowWordPainRemoved(args)
	self:StopBar(args.spellName, args.destName)
end
