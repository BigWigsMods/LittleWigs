local isTenDotTwo = select(4, GetBuildInfo()) >= 100200 --- XXX delete when 10.2 is live everywhere
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Yalnu", 1279, 1210)
if not mod then return end
mod:RegisterEnableMob(83846) -- Yalnu
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
	L.warmup_trigger = "The portal is lost! We must stop this beast before it can escape!"
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
		169929, -- Lumbering Swipe
		-- XXX delete these when 10.2 is live everywhere
		not isTenDotTwo and 169120 or nil, -- Font of Life
		not isTenDotTwo and 169240 or nil, -- Entanglement (Player)
		not isTenDotTwo and 170132 or nil, -- Entanglement (Kirin Tor)
		not isTenDotTwo and 169878 or nil, -- Noxious Breath
	}, {
		[169179] = self.displayName, -- Yalnu
		[169929] = -10537, -- Flourishing Ancient
	}
end

-- XXX delete this entire block below when 10.2 is live everywhere
if not isTenDotTwo then
	-- before 10.2
	function mod:GetOptions()
		return {
			"warmup",
			-- Yalnu
			169179, -- Colossal Blow
			169120, -- Font of Life
			{169613, "CASTBAR"}, -- Genesis
			169240, -- Entanglement (Kirin Tor)
			170132, -- Entanglement (Player)
			-- Vicious Mandragora
			169878, -- Noxious Breath
			-- Flourishing Ancient
			169929, -- Lumbering Swipe
		}, {
			[169179] = self.displayName, -- Yalnu
			[169878] = -10535, -- Vicious Mandragora
			[169929] = -10537, -- Flourishing Ancient
		}
	end
end

function mod:OnBossEnable()
	-- Warmup
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "Warmup")

	-- Yalnu
	self:Log("SPELL_CAST_START", "ColossalBlow", 169179)
	-- XXX bring these listeners outside the if block when 10.2 is live everywhere
	if isTenDotTwo then
		self:Log("SPELL_CAST_START", "VerdantEruption", 428823)
		self:Log("SPELL_CAST_SUCCESS", "EncounterSpawn", 181113)
	else
		-- XXX delete these listeners when 10.2 is live everywhere
		self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1") -- Font of Life
		self:Log("SPELL_CAST_SUCCESS", "EntanglementKirinTor", 169251) -- aura is 169240
		self:Log("SPELL_AURA_APPLIED", "EntanglementPlayer", 170132) -- cast is 170124
		self:Log("SPELL_CAST_START", "NoxiousBreath", 169878)
	end
	self:Log("SPELL_CAST_START", "Genesis", 169613)

	-- Flourishing Ancient
	self:Log("SPELL_CAST_START", "LumberingSwipe", 169929)
end

function mod:OnEngage()
	colossalBlowCount = 1
	verdantEruptionCount = 1
	self:CDBar(169179, 2.4, CL.count:format(self:SpellName(169179), colossalBlowCount)) -- Colossal Blow
	-- XXX bring this bar outside the if block when 10.2 is live everywhere
	if isTenDotTwo then
		self:CDBar(428823, 23.0, CL.count:format(self:SpellName(428823), verdantEruptionCount)) -- Verdant Eruption
	end
	self:CDBar(169613, 40.1) -- Genesis
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Warmup

function mod:Warmup(event, msg)
	-- [CHAT_MSG_MONSTER_YELL] The portal is lost! We must stop this beast before it can escape!#Lady Baihu
	if msg == L.warmup_trigger then
		self:Bar("warmup", 8.0, CL.active, "inv_enchant_shaperessence")
		self:UnregisterEvent(event)
	end
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

-- XXX pre 10.2, delete everything below this comment when 10.2 is live everywhere

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 169120 then -- Font of Life
		-- this summons either 1 Flourishing Ancient, 2 Vicious Mandragoras, or 8 Swift Sproutlings
		self:Message(spellId, "cyan")
		self:PlaySound(spellId, "alert")
		self:CDBar(spellId, 15.0)
	end
end

function mod:EntanglementKirinTor(args)
	self:Message(169240, "red")
	self:PlaySound(169240, "info")
end

function mod:EntanglementPlayer(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	self:PlaySound(args.spellId, "info", nil, args.destName)
end

-- Vicious Mandragora

do
	local prev = 0
	function mod:NoxiousBreath(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end
