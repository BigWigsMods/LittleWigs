--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Witch Doctor Zum'rah", 209, 486)
if not mod then return end
mod:RegisterEnableMob(7271) -- Witch Doctor Zum'rah
mod:SetEncounterID(597)
--mod:SetRespawnTime(0) -- resets, doesn't respawn

--------------------------------------------------------------------------------
-- Initialization
--

local wardOfZumrahMarker = mod:AddMarkerOption(true, "npc", 8, 11086, 8) -- Ward of Zum'rah
function mod:GetOptions()
	return {
		11086, -- Ward of Zum'rah
		wardOfZumrahMarker,
		15982, -- Healing Wave
		17228, -- Shadow Bolt Volley
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "WardOfZumrah", 11086)
	self:Log("SPELL_SUMMON", "WardOfZumrahSummon", 11086)
	self:Log("SPELL_CAST_START", "HealingWave", 15982)
	self:Log("SPELL_INTERRUPT", "HealingWaveInterrupt", 15982)
	self:Log("SPELL_CAST_SUCCESS", "HealingWaveSuccess", 15982)
	self:Log("SPELL_CAST_START", "ShadowBoltVolley", 17228)
	if self:Heroic() then -- no encounter events in Timewalking
		self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
		self:Death("Win", 7271)
	end
end

function mod:OnEngage()
	self:CDBar(17228, 6.9) -- Shadow Bolt Volley
	self:CDBar(11086, 14.2) -- Ward of Zum'rah
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:WardOfZumrah(args)
	self:Message(args.spellId, "cyan", CL.spawning:format(args.spellName))
	self:CDBar(args.spellId, 10.9)
	self:PlaySound(args.spellId, "info")
end

do
	local wardOfZumrahGUID = nil

	function mod:WardOfZumrahSummon(args)
		-- register events to auto-mark Ward of Zum'rah
		if self:GetOption(wardOfZumrahMarker) then
			wardOfZumrahGUID = args.destGUID
			self:RegisterTargetEvents("MarkWardOfZumrah")
		end
	end

	function mod:MarkWardOfZumrah(_, unit, guid)
		if wardOfZumrahGUID == guid then
			wardOfZumrahGUID = nil
			self:CustomIcon(wardOfZumrahMarker, unit, 8)
			self:UnregisterTargetEvents()
		end
	end
end

function mod:HealingWave(args)
	if self:MobId(args.sourceGUID) == 7271 then -- Witch Doctor Zum'rah
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:HealingWaveInterrupt(args)
	if self:MobId(args.destGUID) == 7271 then -- Witch Doctor Zum'rah
		self:CDBar(15982, 10.4)
	end
end

function mod:HealingWaveSuccess(args)
	if self:MobId(args.sourceGUID) == 7271 then -- Witch Doctor Zum'rah
		self:CDBar(args.spellId, 10.4)
	end
end

function mod:ShadowBoltVolley(args)
	if self:MobId(args.sourceGUID) == 7271 then -- Witch Doctor Zum'rah
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:CDBar(args.spellId, 18.2)
		self:PlaySound(args.spellId, "alert")
	end
end
