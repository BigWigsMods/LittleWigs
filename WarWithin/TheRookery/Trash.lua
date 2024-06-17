if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Rookery Trash", 2648)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	209801, -- Quartermaster Koratite
	212786, -- Cursed Stormrider
	207199, -- Cursed Rooktender
	207186, -- Unruly Stormrook
	214419, -- Corrupted Rookguard
	214439, -- Corrupted Oracle
	214421, -- Corrupted Thunderer
	219066, -- Inflicted Civilian
	212793, -- Void Ascendant
	212739 -- Radiating Voidstone
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.quartermaster_koratite = "Quartermaster Koratite"
	L.cursed_stormrider = "Cursed Stormrider"
	L.cursed_rooktender = "Cursed Rooktender"
	L.unruly_stormrook = "Unruly Stormrook"
	L.corrupted_rookguard = "Corrupted Rookguard"
	L.corrupted_oracle = "Corrupted Oracle"
	L.corrupted_thunderer = "Corrupted Thunderer"
	L.inflicted_civilian = "Inflicted Civilian"
	L.void_ascendant = "Void Ascendant"
	L.radiating_voidstone = "Radiating Voidstone"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Quartermaster Koratite
		426893, -- Bounding Void
		450628, -- Entropy Shield
		-- Cursed Stormrider
		427323, -- Charged Bombardment
		-- TODO Localized Storm?
		-- Cursed Rooktender
		427260, -- Enrage Rook
		-- Unruly Stormrook
		430013, -- Thunderstrike
		-- Corrupted Rookguard
		423979, -- Implosion
		-- Corrupted Oracle
		430754, -- Void Shell
		430179, -- Seeping Corruption
		-- Corrupted Thunderer
		430812, -- Attracting Shadows
		-- Inflicted Civilian
		443854, -- Instability
		-- Void Ascendant
		432959, -- Void Volley
		-- Radiating Voidstone
		432781, -- Embrace the Void
	}, {
		[426893] = L.quartermaster_koratite,
		[427323] = L.cursed_stormrider,
		[427260] = L.cursed_rooktender,
		[430013] = L.unruly_stormrook,
		[423979] = L.corrupted_rookguard,
		[430754] = L.corrupted_oracle,
		[430812] = L.corrupted_thunderer,
		[443854] = L.inflicted_civilian,
		[432959] = L.void_ascendant,
		[432781] = L.radiating_voidstone,
	}
end

function mod:OnBossEnable()
	-- Quartermaster Koratite
	self:Log("SPELL_CAST_START", "BoundingVoid", 426893)
	self:Log("SPELL_CAST_START", "EntropyShield", 450628)
	self:Death("QuartermasterKoratiteDeath", 209801)

	-- Cursed Stormrider
	self:Log("SPELL_CAST_START", "ChargedBombardment", 427323)

	-- Cursed Rooktender
	self:Log("SPELL_CAST_START", "EnrageRook", 427260)

	-- Unruly Stormrook
	self:Log("SPELL_CAST_START", "Thunderstrike", 430013)

	-- Corrupted Rookguard
	self:Log("SPELL_CAST_START", "Implosion", 423979)

	-- Corrupted Oracle
	self:Log("SPELL_CAST_START", "VoidShell", 430754)
	self:Log("SPELL_AURA_APPLIED", "SeepingCorruptionApplied", 430179)

	-- Corrupted Thunderer
	self:Log("SPELL_CAST_START", "AttractingShadows", 430812)

	-- Inflicted Civilian
	self:Log("SPELL_CAST_SUCCESS", "Instability", 443854)

	-- Void Ascendant
	self:Log("SPELL_CAST_START", "VoidVolley", 432959)

	-- Radiating Voidstone
	self:Log("SPELL_CAST_START", "EmbraceTheVoid", 432781)
	self:Log("SPELL_AURA_REMOVED", "EmbraceTheVoidRemoved", 432781)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Quartermaster Koratite

do
	local timer

	function mod:BoundingVoid(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		self:PlaySound(args.spellId, "alarm")
		self:CDBar(args.spellId, 12.1)
		timer = self:ScheduleTimer("QuartermasterKoratiteDeath", 30)
	end

	function mod:EntropyShield(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "cyan")
		self:PlaySound(args.spellId, "info")
		self:CDBar(args.spellId, 26.7)
		timer = self:ScheduleTimer("QuartermasterKoratiteDeath", 30)
	end

	function mod:QuartermasterKoratiteDeath(args)
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(426893) -- Bounding Void
		self:StopBar(450628) -- Entropy Shield
	end
end

-- Cursed Stormrider

function mod:ChargedBombardment(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
end

-- Cursed Rooktender

function mod:EnrageRook(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Unruly Stormrook

function mod:Thunderstrike(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Corrupted Rookguard

function mod:Implosion(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Corrupted Oracle

function mod:VoidShell(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
end

function mod:SeepingCorruptionApplied(args)
	self:TargetMessage(args.spellId, "orange", args.destName)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
end

-- Corrupted Rookguard

function mod:AttractingShadows(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
end

-- Inflicted Civilian

do
	local prev = 0
	function mod:Instability(args)
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Void Ascendant

function mod:VoidVolley(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

-- Radiating Voidstone

do
	local prev = 0
	function mod:EmbraceTheVoid(args)
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

do
	local prev = 0
	function mod:EmbraceTheVoidRemoved(args)
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "green", CL.removed:format(args.spellName))
			self:PlaySound(args.spellId, "info")
		end
	end
end
