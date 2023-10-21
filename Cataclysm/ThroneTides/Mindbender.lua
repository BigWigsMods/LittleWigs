local isTenDotTwo = select(4, GetBuildInfo()) >= 100200 --- XXX delete when 10.2 is live everywhere
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Mindbender Ghur'sha", 643, 103)
if not mod then return end
mod:RegisterEnableMob(
	40825, -- Erunak Stonespeaker
	40788  -- Mindbender Ghur'sha
)
mod:SetEncounterID(1046)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Initialization
--

-- XXX remove isTenDotTwo check once 10.2 is live everywhere
local stormflurryTotemMarker = isTenDotTwo and mod:AddMarkerOption(true, "npc", 8, 429037, 8) -- Stormflurry Totem
function mod:GetOptions()
	return {
		"stages",
		-- Erunak Stonespeaker
		429051, -- Earthfury
		429037, -- Stormflurry Totem
		stormflurryTotemMarker,
		{429048, "DISPEL", "OFF"}, -- Flame Shock
		-- Mindbender Ghur'sha
		{429172, "CASTBAR", "CASTBAR_COUNTDOWN"}, -- Terrifying Vision
		-- XXX delete these option keys below when 10.2 is live everywhere
		not isTenDotTwo and {76207, "ICON"} or nil, -- Enslave
		not isTenDotTwo and 76307 or nil, -- Absorb Magic
		not isTenDotTwo and 76230 or nil, -- Mind Fog
	}, {
		[429051] = -2194, -- Erunak Stonespeaker
		[429172] = -2199, -- Mindbender Ghur'sha
	}
end

function mod:OnBossEnable()
	-- Stages
	self:Log("SPELL_CAST_SUCCESS", "EncounterEvent", 181089)

	-- Erunak Stonespeaker
	self:Log("SPELL_CAST_SUCCESS", "Earthfury", 429051)
	self:Log("SPELL_CAST_START", "StormflurryTotem", 429037)
	self:Log("SPELL_SUMMON", "StormflurryTotemSummon", 429036)
	self:Log("SPELL_CAST_SUCCESS", "FlameShock", 429048)
	self:Log("SPELL_AURA_APPLIED", "FlameShockApplied", 429048)

	-- Mindbender Ghur'sha
	self:Log("SPELL_CAST_START", "TerrifyingVision", 429172)
end

function mod:OnEngage()
	self:SetStage(1)
	self:CDBar(429048, 6.1) -- Flame Shock
	self:CDBar(429037, 12.0) -- Stormflurry Totem
	self:CDBar(429051, 22.9) -- Earthfury
end

-- XXX delete this entire block below when 10.2 is live everywhere
if not isTenDotTwo then
	function mod:GetOptions()
		return {
			{76207, "ICON"}, -- Enslave
			76307, -- Absorb Magic
			76230, -- Mind Fog
			"stages",
		}
	end
	function mod:OnBossEnable()
		self:Log("SPELL_CAST_SUCCESS", "Enslave", 76207)
		self:Log("SPELL_AURA_REMOVED", "EnslaveRemoved", 76207)
		self:Log("SPELL_CAST_START", "AbsorbMagic", 76307)
		self:Log("SPELL_AURA_APPLIED", "MindFog", 76230)
		self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1")
	end
	function mod:OnEngage()
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Stages

function mod:EncounterEvent()
	self:StopBar(429048) -- Flame Shock
	self:StopBar(429037) -- Stormflurry Totem
	self:StopBar(429051) -- Earthfury
	self:SetStage(2)
	self:Message("stages", "cyan", CL.stage:format(2), nil)
	self:PlaySound("stages", "long")
	self:CDBar(429172, 3.2) -- Terrifying Vision
end

-- Erunak Stonespeaker

function mod:Earthfury(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 32.7)
end

function mod:StormflurryTotem(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 26.7)
end

do
	local stormflurryTotemGUID = nil

	function mod:StormflurryTotemSummon(args)
		-- register events to auto-mark the totem
		if self:GetOption(stormflurryTotemMarker) then
			stormflurryTotemGUID = args.destGUID
			self:RegisterTargetEvents("MarkStormflurryTotem")
		end
	end

	function mod:MarkStormflurryTotem(_, unit, guid)
		if stormflurryTotemGUID == guid then
			stormflurryTotemGUID = nil
			self:CustomIcon(stormflurryTotemMarker, unit, 8)
			self:UnregisterTargetEvents()
		end
	end
end

function mod:FlameShock(args)
	self:CDBar(args.spellId, 6.1)
end

function mod:FlameShockApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("magic", nil, args.spellId) then
		self:TargetMessage(args.spellId, "red", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

-- Mindbender Ghur'sha

function mod:TerrifyingVision(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	self:CastBar(args.spellId, 5)
	self:CDBar(args.spellId, 23.0)
end

-- XXX delete everything below this comment when 10.2 is live everywhere

function mod:UNIT_HEALTH(event, unit)
	local hp = self:GetHealth(unit)
	if hp < 55 then
		self:UnregisterUnitEvent(event, unit)
		self:MessageOld("stages", "cyan", nil, CL.soon:format(CL.stage:format(2)), false)
	end
end

function mod:Enslave(args)
	self:TargetMessageOld(args.spellId, args.destName, "red", "alert")
	self:PrimaryIcon(args.spellId, args.destName)
end

function mod:EnslaveRemoved(args)
	self:PrimaryIcon(args.spellId)
end

function mod:AbsorbMagic(args)
	self:MessageOld(args.spellId, "orange", nil, CL.casting:format(args.spellName))
end

function mod:MindFog(args)
	if self:Me(args.destGUID) then
		self:TargetMessageOld(args.spellId, args.destName, "blue", "alarm")
	end
end
