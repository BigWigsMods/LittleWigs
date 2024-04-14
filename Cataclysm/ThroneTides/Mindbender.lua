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
-- Locals
--

local stormflurryTotemCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

local stormflurryTotemMarker = mod:Retail() and mod:AddMarkerOption(true, "npc", 8, 429037, 8) or nil -- Stormflurry Totem
function mod:GetOptions()
	return {
		-- Erunak Stonespeaker
		429051, -- Earthfury
		429037, -- Stormflurry Totem
		stormflurryTotemMarker,
		{429048, "DISPEL", "OFF"}, -- Flame Shock
		429878, -- Shake It Off
		-- Mindbender Ghur'sha
		{429172, "CASTBAR", "CASTBAR_COUNTDOWN"}, -- Terrifying Vision
	}, {
		[429051] = -2194, -- Erunak Stonespeaker
		[429172] = -2199, -- Mindbender Ghur'sha
	}
end

function mod:OnBossEnable()
	-- Erunak Stonespeaker
	self:Log("SPELL_CAST_SUCCESS", "Earthfury", 429051)
	self:Log("SPELL_CAST_START", "StormflurryTotem", 429037)
	self:Log("SPELL_SUMMON", "StormflurryTotemSummon", 429036)
	self:Log("SPELL_CAST_SUCCESS", "FlameShock", 429048)
	self:Log("SPELL_AURA_APPLIED", "FlameShockApplied", 429048)
	self:Log("SPELL_CAST_SUCCESS", "ShakeItOff", 429878)

	-- Mindbender Ghur'sha
	self:Log("SPELL_CAST_START", "TerrifyingVision", 429172)
end

function mod:OnEngage()
	stormflurryTotemCount = 1
	self:SetStage(1)
	self:CDBar(429048, 6.1) -- Flame Shock
	self:CDBar(429037, 12.0, CL.count:format(self:SpellName(429037), stormflurryTotemCount)) -- Stormflurry Totem
	self:CDBar(429051, 22.9) -- Earthfury
end

--------------------------------------------------------------------------------
-- Classic Initialization
--

if mod:Classic() then
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

-- Erunak Stonespeaker

function mod:Earthfury(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 32.7)
end

function mod:StormflurryTotem(args)
	self:StopBar(CL.count:format(args.spellName, stormflurryTotemCount))
	self:Message(args.spellId, "yellow", CL.count:format(args.spellName, stormflurryTotemCount))
	self:PlaySound(args.spellId, "info")
	stormflurryTotemCount = stormflurryTotemCount + 1
	self:CDBar(args.spellId, 26.7, CL.count:format(args.spellName, stormflurryTotemCount))
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

function mod:ShakeItOff(args)
	self:StopBar(429048) -- Flame Shock
	self:StopBar(CL.count:format(self:SpellName(429037), stormflurryTotemCount)) -- Stormflurry Totem
	self:StopBar(429051) -- Earthfury
	self:SetStage(2)
	self:Message(args.spellId, "cyan", CL.percent:format(25, args.spellName))
	self:PlaySound(args.spellId, "long")
	self:CDBar(429172, 3.2) -- Terrifying Vision
end

-- Mindbender Ghur'sha

function mod:TerrifyingVision(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	self:CastBar(args.spellId, 5)
	self:CDBar(args.spellId, 23.0)
end

--------------------------------------------------------------------------------
-- Classic Event Handlers
--

function mod:UNIT_HEALTH(event, unit)
	local hp = self:GetHealth(unit)
	if hp < 55 then
		self:UnregisterUnitEvent(event, unit)
		self:Message("stages", "cyan", CL.soon:format(CL.stage:format(2)), false)
	end
end

function mod:Enslave(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
	self:PrimaryIcon(args.spellId, args.destName)
end

function mod:EnslaveRemoved(args)
	self:PrimaryIcon(args.spellId)
end

function mod:AbsorbMagic(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
end

function mod:MindFog(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId)
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
	end
end
