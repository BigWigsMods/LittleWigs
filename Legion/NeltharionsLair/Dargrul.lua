--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Dargrul", 1458, 1687)
if not mod then return end
mod:RegisterEnableMob(91007)
mod:SetEncounterID(1793)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local moltenCrashNext = false

--------------------------------------------------------------------------------
-- Initialization
--

local moltenCharskinMarker = mod:AddMarkerOption(true, "npc", 8, -12596, 8) -- Molten Charskin
function mod:GetOptions()
	return {
		200700, -- Landslide
		{200732, "TANK_HEALER"}, -- Molten Crash
		200637, -- Magma Sculptor
		{200404, "CASTBAR", "CASTBAR_COUNTDOWN"}, -- Magma Wave
		200551, -- Crystal Spikes
		216407, -- Lava Geyser
		-- Molten Charskin
		{200154, "SAY", "ME_ONLY_EMPHASIZE"}, -- Burning Hatred
		200672, -- Crystal Cracked
		moltenCharskinMarker,
	}, {
		[200154] = -12596, -- Molten Charskin
	}, {
		[200637] = CL.big_add, -- Magma Sculptor (Big Add)
		[200154] = CL.fixate, -- Burning Hatred (Fixate)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "MoltenCrash", 200732)
	self:Log("SPELL_CAST_START", "Landslide", 200700)
	self:Log("SPELL_CAST_START", "MagmaSculptor", 200637)
	self:Log("SPELL_CAST_START", "MagmaWavePreCast", 200418)
	self:Log("SPELL_CAST_START", "MagmaWave", 200404)
	self:Log("SPELL_CAST_START", "CrystalSpikes", 200551)
	self:Log("SPELL_AURA_APPLIED", "LavaGeyserDamage", 216407)
	self:Log("SPELL_PERIODIC_DAMAGE", "LavaGeyserDamage", 216407)
	self:Log("SPELL_AURA_APPLIED", "BurningHatred", 200154)
	self:Log("SPELL_AURA_APPLIED", "CrystalCracked", 200672)
	self:Log("SPELL_SUMMON", "MagmaSculptorSummon", 200637)
end

function mod:OnEngage()
	moltenCrashNext = false
	self:CDBar(200551, 5.1) -- Crystal Spikes
	self:CDBar(200637, 9.7, CL.big_add) -- Magma Sculptor
	self:CDBar(200700, 15.8) -- Landslide
	self:CDBar(200732, 18.9) -- Molten Crash
	-- cast at 100 energy, 60s energy gain + .8s delay
	self:CDBar(200404, 60.8) -- Magma Wave
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Landslide(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 17.0) -- pull:15.9, 17.0, 17.0, 23.1, 19.4, 17.0
	-- Molten Crash is always 3.2s after Landslide, but if another ability
	-- is cast instead then the Molten Crash will be skipped
	moltenCrashNext = true
	self:CDBar(200732, {3.2, 17.0}) -- Molten Crash
end

function mod:MoltenCrash(args)
	moltenCrashNext = false
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 17.0) -- pull:19.1, 17.0, 17.0, 23.1, 19.4
	-- soonest other abilties can be after this is 2.87s
	if self:BarTimeLeft(200551) < 2.87 then -- Crystal Spikes
		self:CDBar(200551, {2.87, 21.8})
	end
	if self:BarTimeLeft(CL.big_add) < 2.87 then -- Magma Sculptor
		self:CDBar(200637, {2.87, 71.6}, CL.big_add)
	end
end

function mod:MagmaSculptor(args)
	self:Message(args.spellId, "yellow", CL.incoming:format(CL.big_add))
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 71.6, CL.big_add)
end

function mod:MagmaWavePreCast(args)
	self:Message(200404, "red") -- Magma Wave
	self:PlaySound(200404, "long") -- Magma Wave
	self:CastBar(200404, 2.5)
	-- cast at 100 energy, 59.5s energy gain + 2.5s cast
	self:CDBar(200404, 62.0) -- Magma Wave
end

function mod:MagmaWave(args)
	-- soonest other abilties can be after this is 6.2s, but only correct once the cast
	-- actually starts because RARELY Dargrul will skip the Magma Wave cast after emoting
	if self:BarTimeLeft(200551) < 6.2 then -- Crystal Spikes
		self:CDBar(200551, {6.2, 21.8})
	end
	if self:BarTimeLeft(200700) < 6.2 then -- Landslide
		self:CDBar(200700, {6.2, 17.0}) -- Landslide
		self:CDBar(200732, {9.4, 17.0}) -- Molten Crash
	end
end

function mod:CrystalSpikes(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 21.8) -- pull:21.9, 21.8, 24.3, 21.8, 21.8
	if moltenCrashNext then
		moltenCrashNext = false
		-- boss cast Crystal Spikes intead of Molten Crash, restart Molten Crash bar as it will be skipped
		self:CDBar(200732, 17.0) -- Molten Crash
	elseif self:BarTimeLeft(200700) < 2.42 then -- Landslide
		-- soonest Landslide (+Molten Crash) can be after this is 2.42s
		self:CDBar(200700, {2.42, 17.0}) -- Landslide
		self:CDBar(200732, {5.62, 17.0}) -- Molten Crash
	end
end

do
	local prev = 0
	function mod:LavaGeyserDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:PersonalMessage(args.spellId, "underyou")
				self:PlaySound(args.spellId, "underyou")
			end
		end
	end
end

-- Molten Charskin

function mod:BurningHatred(args)
	if self:MobId(args.sourceGUID) == 101476 then -- Molten Charskin
		self:TargetMessage(args.spellId, "red", args.destName, CL.fixate)
		if self:Me(args.destGUID) then
			self:Say(args.spellId, CL.fixate, nil, "Fixate")
			self:PlaySound(args.spellId, "warning", nil, args.destName)
		else
			self:PlaySound(args.spellId, "alert", nil, args.destName)
		end
	end
end

do
	local prev = 0
	function mod:CrystalCracked(args)
		-- sometimes this applies twice in the same tick, throttle to prevent duplicate alerts
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "green")
			self:PlaySound(args.spellId, "info")
		end
	end
end

do
	local moltenCharskinGUID = nil

	function mod:MagmaSculptorSummon(args)
		if self:GetOption(moltenCharskinMarker) then
			moltenCharskinGUID = args.destGUID
			self:RegisterTargetEvents("MarkMoltenCharskin")
		end
	end

	function mod:MarkMoltenCharskin(_, unit, guid)
		if moltenCharskinGUID == guid then
			moltenCharskinGUID = nil
			self:CustomIcon(moltenCharskinMarker, unit, 8)
			self:UnregisterTargetEvents()
		end
	end
end
