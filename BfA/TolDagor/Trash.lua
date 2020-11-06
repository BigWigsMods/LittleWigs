
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Tol Dagor Trash", 1771)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	127482, -- Sewer Vicejaw
	130025, -- Irontide Thug
	130026, -- Bilge Rat Seaspeaker
	127488, -- Ashvane Flamecaster
	127486, -- Ashvane Officer
	130027, -- Ashvane Marine
	136665, -- Ashvane Spotter
	130028 -- Ashvane Priest
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.vicejaw = "Sewer Vicejaw"
	L.thug = "Irontide Thug"
	L.seaspeaker = "Bilge Rat Seaspeaker"
	L.flamecaster = "Ashvane Flamecaster"
	L.officer = "Ashvane Officer"
	L.marine = "Ashvane Marine"
	L.priest = "Ashvane Priest"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Sewer Vicejaw
		258079, -- Massive Chomp
		-- Irontide Thug
		258128, -- Debilitating Shout
		-- Bilge Rat Seaspeaker
		258153, -- Watery Dome
		-- Ashvane Flamecaster
		258634, -- Fuselighter
		-- Ashvane Officer
		258313, -- Handcuff
		-- Ashvane Marine & Ashvane Spotter
		258864, -- Suppression Fire
		-- Ashvane Priest
		258917, -- Righteous Flames
		258935, -- Inner Flames
	}, {
		[258079] = L.vicejaw,
		[258128] = L.thug,
		[258153] = L.seaspeaker,
		[258634] = L.flamecaster,
		[258313] = L.officer,
		[258864] = L.marine,
		[258917] = L.priest,
	}
end

function mod:OnBossEnable()
	-- Sewer Vicejaw
	self:Log("SPELL_AURA_APPLIED", "MassiveChomp", 258079)
	self:Log("SPELL_AURA_APPLIED_DOSE", "MassiveChomp", 258079)
	-- Irontide Thug
	self:Log("SPELL_CAST_START", "DebilitatingShout", 258128)
	-- Bilge Rat Seaspeaker
	self:Log("SPELL_CAST_START", "WateryDome", 258153)
	-- Ashvane Flamecaster
	self:Log("SPELL_CAST_START", "Fuselighter", 258634)
	-- Ashvane Officer
	self:Log("SPELL_CAST_START", "Handcuff", 258313)
	-- Ashvane Marine & Ashvane Spotter
	self:Log("SPELL_CAST_START", "SuppressionFire", 258864)
	-- Ashvane Priest
	self:Log("SPELL_CAST_START", "RighteousFlames", 258917)
	self:Log("SPELL_CAST_START", "InnerFlames", 258935)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Sewer Vicejaw
function mod:MassiveChomp(args)
	if self:Me(args.destGUID) then
		local amount = args.amount or 1
		if amount % 2 == 0 then
			self:StackMessage(args.spellId, args.destName, args.amount, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Irontide Thug
function mod:DebilitatingShout(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

-- Bilge Rat Seaspeaker
do
	local prev = 0
	function mod:WateryDome(args)
		local t = args.time
		if t-prev > 1.5 then
			prev = t
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

-- Ashvane Flamecaster
do
	local prev = 0
	function mod:Fuselighter(args)
		local t = args.time
		if t-prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Ashvane Officer
do
	local prev = 0
	function mod:Handcuff(args)
		local t = args.time
		if t-prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "warning")
		end
	end
end

-- Ashvane Marine & Ashvane Spotter
do
	local prev = 0
	function mod:SuppressionFire(args)
		local t = args.time
		if t-prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "long")
		end
	end
end

-- Ashvane Priest
do
	local prev = 0
	function mod:RighteousFlames(args)
		local t = args.time
		if t-prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

do
	local prev = 0
	function mod:InnerFlames(args)
		local t = args.time
		if t-prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "warning")
		end
	end
end
