--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Waycrest Manor Trash", 1862)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	131677, -- Heartsbane Runeweaver
	131587, -- Bewitched Captain
	135474, -- Thistle Acolyte
	135052, -- Blight Toad
	135049, -- Dreadwing Raven
	131670, -- Heartsbane Vinetwister
	131685, -- Runic Disciple
	131666, -- Coven Thornshaper
	131858, -- Thornguard
	135329, -- Matron Bryndle
	134024, -- Devouring Maggot
	137830, -- Pallid Gorger
	131586, -- Banquet Steward
	131849, -- Crazed Marksman
	131850, -- Maddened Survivalist
	131821, -- Faceless Maiden
	131818, -- Marked Sister
	135365, -- Matron Alma
	131812  -- Heartsbane Soulcharmer
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.heartsbane_runeweaver = "Heartsbane Runeweaver"
	L.bewitched_captain = "Bewitched Captain"
	L.thistle_acolyte = "Thistle Acolyte"
	L.blight_toad = "Blight Toad"
	L.dreadwing_raven = "Dreadwing Raven"
	L.heartsbane_vinetwister = "Heartsbane Vinetwister"
	L.runic_disciple = "Runic Disciple"
	L.coven_thornshaper = "Coven Thornshaper"
	L.thornguard = "Thornguard"
	L.matron_bryndle = "Matron Bryndle"
	L.devouring_maggot = "Devouring Maggot"
	L.pallid_gorger = "Pallid Gorger"
	L.banquet_steward = "Banquet Steward"
	L.crazed_marksman = "Crazed Marksman"
	L.maddened_survivalist = "Maddened Survivalist"
	L.faceless_maiden = "Faceless Maiden"
	L.marked_sister = "Marked Sister"
	L.matron_alma = "Matron Alma"
	L.heartsbane_soulcharmer = "Heartsbane Soulcharmer"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Heartsbane Runeweaver
		263943, -- Etch
		263905, -- Marking Cleave
		-- Bewitched Captain
		265368, -- Spirited Defense
		265372, -- Shadow Cleave
		-- Thistle Acolyte
		266036, -- Drain Essence
		-- Blight Toad
		265352, -- Toad Blight
		-- Dreadwing Raven
		265346, -- Pallid Glare
		-- Heartsbane Vinetwister
		263891, -- Grasping Thorns
		-- Runic Disciple
		264396, -- Spectral Talisman
		264390, -- Spellbind
		-- Coven Thornshaper
		264050, -- Infected Thorn
		{264038, "SAY"}, -- Uproot
		-- Thornguard
		264150, -- Shatter
		-- Matron Bryndle
		265759, -- Splinter Spike
		{265760, "TANK"}, -- Thorned Barrage
		265741, -- Drain Soul Essence
		-- Devouring Maggot
		278444, -- Infest
		-- Pallid Gorger
		271174, -- Retch
		-- Banquet Steward
		265407, -- Dinner Bell
		-- Crazed Marksman
		264456, -- Tracking Explosive
		-- Maddened Survivalist
		264525, -- Shrapnel Trap
		264520, -- Severing Serpent
		-- Faceless Maiden
		264407, -- Horrific Visage
		-- Marked Sister
		{264105, "SAY", "SAY_COUNTDOWN"}, -- Runic Mark
		-- Matron Alma
		265876, -- Ruinous Volley
		{265880, "SAY", "SAY_COUNTDOWN"}, -- Dread Mark
		265881, -- Decaying Touch
		-- Heartsbane Soulcharmer
		263959, -- Soul Volley
		263961, -- Warding Candles
	}, {
		[263943] = L.heartsbane_runeweaver,
		[265368] = L.bewitched_captain,
		[266036] = L.thistle_acolyte,
		[265352] = L.blight_toad,
		[265346] = L.dreadwing_raven,
		[263891] = L.heartsbane_vinetwister,
		[264396] = L.runic_disciple,
		[264050] = L.coven_thornshaper,
		[264150] = L.thornguard,
		[265759] = L.matron_bryndle,
		[278444] = L.devouring_maggot,
		[271174] = L.pallid_gorger,
		[265407] = L.banquet_steward,
		[264456] = L.crazed_marksman,
		[264525] = L.maddened_survivalist,
		[264407] = L.faceless_maiden,
		[264105] = L.marked_sister,
		[265876] = L.matron_alma,
		[263959] = L.heartsbane_soulcharmer,
	}
end

function mod:OnBossEnable()
	-- Heartsbane Runeweaver
	self:Log("SPELL_CAST_SUCCESS", "Etch", 263943)
	self:Log("SPELL_CAST_START", "MarkingCleave", 263905)

	-- Bewitched Captain
	self:Log("SPELL_CAST_START", "SpiritedDefense", 265368)
	self:Log("SPELL_CAST_START", "ShadowCleave", 265372)

	-- Thistle Acolyte
	self:Log("SPELL_CAST_START", "DrainEssence", 266036)

	-- Blight Toad
	self:Log("SPELL_CAST_START", "ToadBlight", 265352)

	-- Dreadwing Raven
	self:Log("SPELL_CAST_START", "PallidGlare", 265346)

	-- Heartsbane Vinetwister
	self:Log("SPELL_CAST_START", "GraspingThorns", 263891)
	self:Log("SPELL_AURA_APPLIED", "GraspingThornsApplied", 263891)
	self:Log("SPELL_AURA_REMOVED", "GraspingThornsRemoved", 263891)

	-- Runic Disciple
	self:Log("SPELL_CAST_START", "SpectralTalisman", 264396)
	self:Log("SPELL_CAST_START", "Spellbind", 264390)

	-- Coven Thornshaper
	self:Log("SPELL_CAST_START", "InfectedThorn", 264050)
	self:Log("SPELL_CAST_START", "Uproot", 264038)

	-- Thornguard
	self:Log("SPELL_CAST_START", "Shatter", 264150)

	-- Matron Bryndle
	self:Log("SPELL_CAST_SUCCESS", "SplinterSpike", 265759)
	self:Log("SPELL_CAST_START", "ThornedBarrage", 265760)
	self:Log("SPELL_CAST_START", "DrainSoulEssence", 265741)

	-- Devouring Maggot
	self:Log("SPELL_CAST_START", "Infest", 278444)

	-- Pallid Gorger
	self:Log("SPELL_CAST_START", "Retch", 271174)

	-- Banquet Steward
	self:Log("SPELL_CAST_START", "DinnerBell", 265407)

	-- Crazed Marksman
	self:Log("SPELL_CAST_START", "TrackingExplosive", 264456)

	-- Maddened Survivalist
	self:Log("SPELL_CAST_START", "ShrapnelTrap", 264525)
	self:Log("SPELL_CAST_START", "SeveringSerpent", 264520)

	-- Faceless Maiden
	self:Log("SPELL_CAST_START", "HorrificVisage", 264407)

	-- Marked Sister
	self:Log("SPELL_AURA_APPLIED", "RunicMarkApplied", 264105)
	self:Log("SPELL_AURA_REMOVED", "RunicMarkRemoved", 264105)

	-- Matron Alma
	self:Log("SPELL_CAST_START", "RuinousVolley", 265876)
	self:Log("SPELL_AURA_APPLIED", "DreadMarkApplied", 265880)
	self:Log("SPELL_AURA_REMOVED", "DreadMarkRemoved", 265880)
	self:Log("SPELL_CAST_START", "DecayingTouch", 265881)

	-- Heartsbane Soulcharmer
	self:Log("SPELL_CAST_START", "SoulVolley", 263959)
	self:Log("SPELL_CAST_START", "WardingCandles", 263961)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Heartsbane Runeweaver

function mod:Etch(args)
	if self:Me(args.destGUID) or self:Healer() then
		self:TargetMessage(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

function mod:MarkingCleave(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

-- Bewitched Captain

function mod:SpiritedDefense(args)
	self:Message(args.spellId, "cyan", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

do
	local prev = 0
	function mod:ShadowCleave(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Thistle Acolyte

function mod:DrainEssence(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Blight Toad

do
	local prev = 0
	function mod:ToadBlight(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Dreadwing Raven

function mod:PallidGlare(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
end

-- Heartsbane Vinetwister

function mod:GraspingThorns(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))

	local _, interruptReady = self:Interrupter()
	if interruptReady then
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:GraspingThornsApplied(args)
	if self:Dispeller("magic") then
		self:TargetMessage(args.spellId, "red", args.destName)
		self:PlaySound(args.spellId, "warning", nil, args.destName)
		self:TargetBar(args.spellId, 4, args.destName)
	end
end

function mod:GraspingThornsRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

-- Runic Disciple

function mod:SpectralTalisman(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

function mod:Spellbind(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

-- Coven Thornshaper

do
	local prev = 0
	function mod:InfectedThorn(args)
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
			return
		end
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(264038, "orange", name) -- Uproot
		self:PlaySound(264038, "alarm", nil, name) -- Uproot
		if self:Me(guid) then
			self:Say(264038, nil, nil, "Uproot") -- Uproot
		end
	end

	function mod:Uproot(args)
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
			return
		end
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
	end
end

-- Thornguard

do
	local prev = 0
	function mod:Shatter(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Matron Bryndle

function mod:SplinterSpike(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "warning")
end

function mod:ThornedBarrage(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
end

function mod:DrainSoulEssence(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

-- Devouring Maggot

do
	local prev = 0
	function mod:Infest(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "warning")
		end
	end
end

-- Pallid Gorger

do
	local prev = 0
	function mod:Retch(args)
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
			return
		end
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Banquet Steward

do
	local prev = 0
	function mod:DinnerBell(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Crazed Marksman

function mod:TrackingExplosive(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

-- Maddened Survivalist

do
	local prev = 0
	function mod:ShrapnelTrap(args)
		-- these NPCs can be mind-controlled by Priests and this ability can be cast,
		-- but don't suppress alerts as the traps still only harm players.
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

do
	local prev = 0
	function mod:SeveringSerpent(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end
end

-- Faceless Maiden

do
	local prev = 0
	function mod:HorrificVisage(args)
		if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
			return
		end
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "warning")
		end
	end
end

-- Marked Sister

function mod:RunicMarkApplied(args)
	self:TargetMessage(args.spellId, "orange", args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Runic Mark")
		self:SayCountdown(args.spellId, 6)
	end
end

function mod:RunicMarkRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
end

-- Matron Alma

function mod:RuinousVolley(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

function mod:DreadMarkApplied(args)
	self:TargetMessage(args.spellId, "orange", args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Dread Mark")
		self:SayCountdown(args.spellId, 6)
	end
end

function mod:DreadMarkRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
end

function mod:DecayingTouch(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

-- Heartsbane Soulcharmer

function mod:SoulVolley(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

function mod:WardingCandles(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
end
