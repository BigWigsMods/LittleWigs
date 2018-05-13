if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Waycrest Manor Trash", 1862)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	131586, -- Banquet Steward
	137830, -- Pallid Gorger
	131849, -- Crazed Marksman
	131677, -- Heartsbane Runeweaver
	131850, -- Maddened Survivalist
	135329, -- Matron Bryndle
	131666, -- Coven Thornshaper
	131858, -- Thornguard
	135052, -- Blight Toad
	135049, -- Dreadwing Raven
	131812, -- Heartsbane Soulcharmer
	131587, -- Bewitched Captain
	131685, -- Runic Disciple
	131818, -- Marked Sister
	135365 -- Matron Alma
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.steward = "Banquet Steward"
	L.gorger = "Pallid Gorger"
	L.marksman = "Crazed Marksman"
	L.runeweaver = "Heartsbane Runeweaver"
	L.survivalist = "Maddened Survivalist"
	L.bryndle = "Matron Bryndle"
	L.thornshaper = "Coven Thornshaper"
	L.thornguard = "Thornguard"
	L.toad = "Blight Toad"
	L.raven = "Dreadwing Raven"
	L.soulcharmer = "Heartsbane Soulcharmer"
	L.captain = "Bewitched Captain"
	L.disciple = "Runic Disciple"
	L.sister = "Marked Sister"
	L.alma = "Matron Alma"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Banquet Steward
		265407, -- Dinner Bell
		-- Pallid Gorger
		271174, -- Retch
		-- Crazed Marksman
		264456, -- Tracking Explosive
		-- Heartsbane Runeweaver
		263943, -- Etch
		263905, -- Marking Cleave
		-- Maddened Survivalist
		264525, -- Shrapnel Trap
		264520, -- Severing Serpent
		-- Matron Bryndle
		265759, -- Splinter Spike
		265760, -- Thorned Barrage
		265741, -- Drain Soul Essence
		-- Coven Thornshaper
		264050, -- Infected Thorn
		264038, -- Uproot
		-- Thornguard
		264556, -- Tearing Strike
		264150, -- Shatter
		-- Blight Toad
		265352, -- Toad Blight
		-- Dreadwing Raven
		265346, -- Pallid Glare
		-- Heartsbane Soulcharmer
		263959, -- Soul Volley
		263961, -- Warding Candles
		-- Bewitched Captain
		265368, -- Spirited Defense
		-- Runic Disciple
		264396, -- Spectral Talisman
		264390, -- Spellbind
		-- Marked Sister
		{264105, "SAY"}, -- Runic Mark
		-- Matron Alma
		265876, -- Ruinous Volley
		{265880, "SAY"}, -- Dread Mark
		265881, -- Decaying Touch
	}, {
		[265407] = L.steward,
		[271174] = L.gorger,
		[264456] = L.marksman,
		[263943] = L.runeweaver,
		[264525] = L.survivalist,
		[265759] = L.bryndle,
		[264050] = L.thornshaper,
		[264556] = L.thornguard,
		[265352] = L.toad,
		[265346] = L.raven,
		[263959] = L.soulcharmer,
		[265368] = L.captain,
		[264396] = L.disciple,
		[264105] = L.sister,
		[265876] = L.alma,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")

	-- Banquet Steward
	self:Log("SPELL_CAST_START", "DinnerBell", 265407)
	-- Pallid Gorger
	self:Log("SPELL_CAST_START", "Retch", 271174)
	-- Crazed Marksman
	self:Log("SPELL_CAST_START", "TrackingExplosive", 264456)
	-- Heartsbane Runeweaver
	self:Log("SPELL_CAST_SUCCESS", "Etch", 263943)
	self:Log("SPELL_CAST_START", "MarkingCleave", 263905)
	-- Maddened Survivalist
	self:Log("SPELL_CAST_START", "ShrapnelTrap", 264525)
	self:Log("SPELL_CAST_START", "SeveringSerpent", 264520)
	-- Matron Bryndle
	self:Log("SPELL_CAST_SUCCESS", "SplinterSpike", 265759)
	self:Log("SPELL_CAST_START", "ThornedBarrage", 265760)
	self:Log("SPELL_CAST_START", "DrainSoulEssence", 265741)
	-- Coven Thornshaper
	self:Log("SPELL_CAST_START", "InfectedThorn", 264050)
	self:Log("SPELL_CAST_START", "Uproot", 264038)
	-- Thornguard
	self:Log("SPELL_AURA_APPLIED", "TearingStrike", 264556)
	self:Log("SPELL_CAST_START", "Shatter", 264150)
	-- Blight Toad
	self:Log("SPELL_CAST_START", "ToadBlight", 265352)
	-- Dreadwing Raven
	self:Log("SPELL_CAST_START", "PallidGlare", 265346)
	-- Heartsbane Soulcharmer
	self:Log("SPELL_CAST_START", "SoulVolley", 263959)
	self:Log("SPELL_CAST_START", "WardingCandles", 263961)
	-- Bewitched Captain
	self:Log("SPELL_CAST_START", "SpiritedDefense", 265368)
	-- Runic Disciple
	self:Log("SPELL_CAST_START", "SpectralTalisman", 264396)
	self:Log("SPELL_CAST_START", "Spellbind", 264390)
	-- Marked Sister
	self:Log("SPELL_CAST_START", "RunicMark", 264105)
	self:Log("SPELL_AURA_APPLIED", "RunicMarkApplied", 264105)
	self:Log("SPELL_AURA_REMOVED", "RunicMarkRemoved", 264105)
	-- Matron Alma
	self:Log("SPELL_CAST_START", "RuinousVolley", 265876)
	self:Log("SPELL_AURA_APPLIED", "DreadMarkApplied", 265880)
	self:Log("SPELL_AURA_REMOVED", "DreadMarkRemoved", 265880)
	self:Log("SPELL_CAST_START", "DecayingTouch", 265881)

end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Banquet Steward
function mod:DinnerBell(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "warning")
end

-- Pallid Gorger
function mod:Retch(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

-- Crazed Marksman
function mod:TrackingExplosive(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

-- Heartsbane Runeweaver
function mod:Etch(args)
	self:TargetMessage2(args.spellId, "orange", args.destName)
	if self:Me(args.destGUID) or self:Healer() then
		self:PlaySound(args.spellId, "warning")
	end
end

function mod:MarkingCleave(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

-- Maddened Survivalist
function mod:ShrapnelTrap(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:SeveringSerpent(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

-- Matron Bryndle
function mod:SplinterSpike(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "warning")
end

function mod:ThornedBarrage(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:DrainSoulEssence(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

-- Coven Thornshaper
function mod:InfectedThorn(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

function mod:Uproot(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Thornguard
do
	local prev = 0
	function mod:TearingStrike(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 1.5 then
				prev = t
				self:TargetMessage2(args.spellId, "blue", args.destName)
				self:PlaySound(args.spellId, "alarm")
			end
		end
	end
end

do
	local prev = 0
	function mod:Shatter(args)
		local t = GetTime()
		if t-prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

-- Blight Toad
do
	local prev = 0
	function mod:ToadBlight(args)
		local t = GetTime()
		if t-prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

-- Dreadwing Raven
function mod:PallidGlare(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Heartsbane Soulcharmer
function mod:SoulVolley(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
end

function mod:WardingCandles(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

-- Bewitched Captain
function mod:SpiritedDefense(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "alert")
end

-- Runic Disciple
function mod:SpectralTalisman(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

function mod:Spellbind(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
end

-- Marked Sister
function mod:RunicMark(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

function mod:RunicMarkApplied(args)
	self:TargetMessage2(args.spellId, "orange", args.destName)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "warning")
		self:Say(args.spellId)
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
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
end

function mod:DreadMarkApplied(args)
	self:TargetMessage2(args.spellId, "orange", args.destName)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "alarm")
		self:Say(args.spellId)
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
