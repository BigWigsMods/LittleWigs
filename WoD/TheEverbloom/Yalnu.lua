--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Yalnu", 1279, 1210)
if not mod then return end
mod:RegisterEnableMob(
	85496, -- Undermage Kesalon
	83846  -- Yalnu
)
mod:SetEncounterID(1756)
--mod:SetRespawnTime(0) -- wiping teleports you out, then you can retry immediately

--------------------------------------------------------------------------------
-- Locals
--

local colossalBlowCount = 1
local verdantEruptionCount = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.warmup_icon = "inv_enchant_shaperessence"
end

--------------------------------------------------------------------------------
-- Initialization
--

local flourishingAncientMarker = mod:AddMarkerOption(true, "npc", 8, -10537, 8) -- Flourishing Ancient
function mod:GetOptions()
	return {
		"warmup",
		-- Yalnu
		169179, -- Colossal Blow
		428823, -- Verdant Eruption
		flourishingAncientMarker,
		{169613, "CASTBAR"}, -- Genesis
		-- Flourishing Ancient
		{169929, "OFF"}, -- Lumbering Swipe
	}, {
		[169179] = self.displayName, -- Yalnu
		[169929] = -10537, -- Flourishing Ancient
	}
end

function mod:OnBossEnable()
	-- Yalnu
	self:Log("SPELL_CAST_START", "ColossalBlow", 169179)
	self:Log("SPELL_CAST_START", "VerdantEruption", 428823)
	self:Log("SPELL_CAST_SUCCESS", "EncounterSpawn", 181113)
	self:Log("SPELL_CAST_START", "Genesis", 169613)

	-- Flourishing Ancient
	self:Log("SPELL_CAST_START", "LumberingSwipe", 169929)
end

function mod:OnEngage()
	colossalBlowCount = 1
	verdantEruptionCount = 1
	self:StopBar(CL.active) -- Warmup
	self:CDBar(169179, 2.4, CL.count:format(self:SpellName(169179), colossalBlowCount)) -- Colossal Blow
	self:CDBar(428823, 23.0, CL.count:format(self:SpellName(428823), verdantEruptionCount)) -- Verdant Eruption
	self:CDBar(169613, 40.1) -- Genesis
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Warmup

function mod:Warmup() -- called from trash module
	self:Bar("warmup", 8.0, CL.active, L.warmup_icon)
end

-- Yalnu

function mod:ColossalBlow(args)
	self:StopBar(CL.count:format(args.spellName, colossalBlowCount))
	self:Message(args.spellId, "orange", CL.count:format(args.spellName, colossalBlowCount))
	self:PlaySound(args.spellId, "alarm")
	colossalBlowCount = colossalBlowCount + 1
	if colossalBlowCount % 3 ~= 1 then -- 2, 3, 5, 6...
		self:CDBar(args.spellId, 15.8, CL.count:format(args.spellName, colossalBlowCount))
	else -- 4, 7 ...
		self:CDBar(args.spellId, 23.0, CL.count:format(args.spellName, colossalBlowCount))
	end
end

function mod:VerdantEruption(args)
	self:StopBar(CL.count:format(args.spellName, verdantEruptionCount))
	self:Message(args.spellId, "cyan", CL.count:format(args.spellName, verdantEruptionCount))
	self:PlaySound(args.spellId, "info")
	verdantEruptionCount = verdantEruptionCount + 1
	self:CDBar(args.spellId, 54.5, CL.count:format(args.spellName, verdantEruptionCount))
end

do
	local flourishingAncientGUID = nil

	function mod:EncounterSpawn(args)
		-- register events to auto-mark the add
		if self:GetOption(flourishingAncientMarker) then
			flourishingAncientGUID = args.sourceGUID
			self:RegisterTargetEvents("MarkFlourishingAncient")
		end
	end

	function mod:MarkFlourishingAncient(_, unit, guid)
		if flourishingAncientGUID == guid then
			flourishingAncientGUID = nil
			self:CustomIcon(flourishingAncientMarker, unit, 8)
			self:UnregisterTargetEvents()
		end
	end
end

function mod:Genesis(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:CastBar(args.spellId, 14) -- 2s cast + 12s channel
	self:CDBar(args.spellId, 54.6)
end

-- Flourishing Ancient

function mod:LumberingSwipe(args)
	-- this AOE will hit a small area around Lady Baihu
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	--self:CDBar(args.spellId, 13.3) -- probably not useful
end
