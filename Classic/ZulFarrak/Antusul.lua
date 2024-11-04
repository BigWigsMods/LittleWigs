--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Antu'sul", 209, 484)
if not mod then return end
mod:RegisterEnableMob(8127) -- Antu'sul
mod:SetEncounterID(595)
--mod:SetRespawnTime(0) -- resets, doesn't respawn

--------------------------------------------------------------------------------
-- Locals
--

local antusulsMinionCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

local earthgrabTotemMarker = mod:AddMarkerOption(true, "npc", 7, 8376, 7) -- Earthgrab Totem
local healingWardMarker = mod:AddMarkerOption(true, "npc", 8, 11899, 8) -- Healing Ward
function mod:GetOptions()
	return {
		15982, -- Healing Wave
		8376, -- Earthgrab Totem
		earthgrabTotemMarker,
		11899, -- Healing Ward
		healingWardMarker,
		15501, -- Earth Shock
		16006, -- Chain Lightning
		11895, -- Healing Wave of Antu'sul
		11894, -- Antu'sul's Minion
		{11020, "DISPEL"}, -- Petrify
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "HealingWave", 15982)
	self:Log("SPELL_CAST_START", "EarthgrabTotem", 8376)
	self:Log("SPELL_CAST_START", "HealingWard", 11899)
	self:Log("SPELL_SUMMON", "EarthgrabTotemSummon", 8376)
	self:Log("SPELL_SUMMON", "HealingWardSummon", 11899)
	self:Log("SPELL_CAST_SUCCESS", "EarthShock", 15501)
	self:Log("SPELL_CAST_START", "ChainLightning", 16006)
	self:Log("SPELL_CAST_START", "HealingWaveOfAntusul", 11895)
	self:Log("SPELL_CAST_SUCCESS", "AntusulsMinion", 11894)
	self:Log("SPELL_AURA_APPLIED", "PetrifyApplied", 11020)
	if self:Heroic() then -- no encounter events in Timewalking
		self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
		self:Death("Win", 8127)
	end
end

function mod:OnEngage()
	antusulsMinionCount = 1
	self:CDBar(8376, 9.7) -- Earthgrab Totem
	self:CDBar(16006, 11.9) -- Chain Lightning
	self:CDBar(11899, 12.3) -- Healing Ward
	self:CDBar(15501, 15.5) -- Earth Shock
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:HealingWave(args)
	if self:MobId(args.sourceGUID) == 8127 then -- Antu'sul
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:CDBar(args.spellId, 23.1)
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:EarthgrabTotem(args)
	self:Message(args.spellId, "cyan", CL.spawning:format(args.spellName))
	self:CDBar(args.spellId, 29.1)
	self:PlaySound(args.spellId, "info")
end

function mod:HealingWard(args)
	if self:MobId(args.sourceGUID) == 8127 then -- Antu'sul
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:CDBar(args.spellId, 34.0)
		self:PlaySound(args.spellId, "alert")
	end
end

do
	local earthgrabTotemGUID, healingWardGUID = nil, nil

	function mod:EarthgrabTotemSummon(args)
		-- register events to auto-mark Earthgrab Totem
		if self:GetOption(earthgrabTotemMarker) then
			earthgrabTotemGUID = args.destGUID
			self:RegisterTargetEvents("MarkTotemOrWard")
		end
	end

	function mod:HealingWardSummon(args)
		if self:MobId(args.sourceGUID) == 8127 then -- Antu'sul
			-- register events to auto-mark Healing Ward
			if self:GetOption(healingWardMarker) then
				healingWardGUID = args.destGUID
				self:RegisterTargetEvents("MarkTotemOrWard")
			end
		end
	end

	function mod:MarkTotemOrWard(_, unit, guid)
		if earthgrabTotemGUID == guid then
			earthgrabTotemGUID = nil
			self:CustomIcon(earthgrabTotemMarker, unit, 7)
		elseif healingWardGUID == guid then
			healingWardGUID = nil
			self:CustomIcon(healingWardMarker, unit, 8)
		end
		if earthgrabTotemGUID == nil and healingWardGUID == nil then
			self:UnregisterTargetEvents()
		end
	end
end

function mod:EarthShock(args)
	self:CDBar(args.spellId, 10.9)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId)
	end
end

function mod:ChainLightning(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 21.9)
	self:PlaySound(args.spellId, "alarm")
end

function mod:HealingWaveOfAntusul(args)
	self:Message(args.spellId, "red", CL.percent:format(25, CL.casting:format(args.spellName)))
	self:PlaySound(args.spellId, "alert")
end

function mod:AntusulsMinion(args)
	if antusulsMinionCount == 1 then
		self:Message(args.spellId, "cyan", CL.percent:format(75, args.spellName))
	else -- 2
		self:Message(args.spellId, "cyan", CL.percent:format(25, args.spellName))
	end
	antusulsMinionCount = antusulsMinionCount + 1
	self:PlaySound(args.spellId, "info")
end

function mod:PetrifyApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("magic", nil, args.spellId) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
	end
end
