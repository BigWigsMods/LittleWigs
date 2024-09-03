--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Underrot Trash", 1841)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	133685, -- Befouled Spirit
	131492, -- Devout Blood Priest
	130909, -- Fetid Maggot
	131436, -- Chosen Blood Matron
	133870, -- Diseased Lasher
	133835, -- Feral Bloodswarmer
	133852, -- Living Rot
	134284, -- Fallen Deathspeaker
	138187, -- Grotesque Horror
	133912, -- Bloodsworn Defiler
	138281 -- Faceless Corruptor
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.spirit = "Befouled Spirit"
	L.priest = "Devout Blood Priest"
	L.maggot = "Fetid Maggot"
	L.matron = "Chosen Blood Matron"
	L.fanatical_headhunter = "Fanatical Headhunter"
	L.lasher = "Diseased Lasher"
	L.bloodswarmer = "Feral Bloodswarmer"
	L.rot = "Living Rot"
	L.deathspeaker = "Fallen Deathspeaker"
	L.grotesque_horror = "Grotesque Horror"
	L.defiler = "Bloodsworn Defiler"
	L.corruptor = "Faceless Corruptor"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Befouled Spirit
		{265568, "SAY"}, -- Dark Omen
		278755, -- Harrowing Despair
		-- Devout Blood Priest
		265089, -- Dark Reconstitution
		265091, -- Gift of G'huun
		-- Fetid Maggot
		265540, -- Rotten Bile
		-- Chosen Blood Matron
		{265016, "ME_ONLY", "SAY"}, -- Blood Harvest
		265019, -- Savage Cleave
		265081, -- Warcry
		-- Fanatical Headhunter
		{265377, "DISPEL"}, -- Hooked Snare
		-- Diseased Lasher
		278961, -- Decaying Mind
		-- Feral Bloodswarmer
		{266107, "NAMEPLATE"}, -- Thirst For Blood
		266106, -- Sonic Screech
		-- Living Rot
		265668, -- Wave of Decay
		-- Fallen Deathspeaker
		272183, -- Raise Dead
		266209, -- Wicked Frenzy
		266265, -- Wicked Embrace
		-- Grotesque Horror
		413044, -- Dark Echoes
		-- Bloodsworn Defiler
		265487, -- Shadow Bolt Volley
		265433, -- Withering Curse
		265523, -- Summon Spirit Drain Totem
		-- Faceless Corruptor
		272592, -- Abyssal Reach
		272609, -- Maddening Gaze
	}, {
		[265568] = L.spirit,
		[265089] = L.priest,
		[265540] = L.maggot,
		[265016] = L.matron,
		[265377] = L.fanatical_headhunter,
		[278961] = L.lasher,
		[266107] = L.bloodswarmer,
		[265668] = L.rot,
		[272183] = L.deathspeaker,
		[413044] = L.grotesque_horror,
		[265487] = L.defiler,
		[272592] = L.corruptor,
	}, {
		[266107] = CL.fixate,
	}
end

function mod:OnBossEnable()
	-- Befouled Spirit
	self:Log("SPELL_CAST_START", "DarkOmen", 265568)
	self:Log("SPELL_AURA_APPLIED", "DarkOmenApplied", 265568)
	self:Log("SPELL_CAST_START", "HarrowingDespair", 278755)

	-- Devout Blood Priest
	self:Log("SPELL_CAST_START", "DarkReconstitution", 265089)
	self:Log("SPELL_CAST_START", "GiftOfGhuun", 265091)
	self:Log("SPELL_AURA_APPLIED", "GiftOfGhuunApplied", 265091)

	-- Fetid Maggot
	self:Log("SPELL_CAST_START", "RottenBile", 265540)

	-- Chosen Blood Matron
	self:Log("SPELL_CAST_SUCCESS", "BloodHarvest", 265016)
	self:Log("SPELL_CAST_START", "SavageCleave", 265019)
	self:Log("SPELL_CAST_START", "Warcry", 265081)

	-- Fanatical Headhunter
	self:Log("SPELL_AURA_APPLIED", "HookedSnareApplied", 265377)

	-- Diseased Lasher
	self:Log("SPELL_CAST_START", "DecayingMind", 278961)
	self:Log("SPELL_AURA_APPLIED", "DecayingMindApplied", 278961)
	self:Log("SPELL_AURA_REMOVED", "DecayingMindRemoved", 278961)

	-- Feral Bloodswarmer
	self:Log("SPELL_AURA_APPLIED", "ThirstForBloodApplied", 266107)
	self:Log("SPELL_AURA_REMOVED", "ThirstForBloodRemoved", 266107)
	self:Log("SPELL_CAST_START", "SonicScreech", 266106)

	-- Living Rot
	self:Log("SPELL_AURA_APPLIED", "WaveOfDecayDamage", 278789)
	self:Log("SPELL_PERIODIC_DAMAGE", "WaveOfDecayDamage", 278789)
	self:Log("SPELL_PERIODIC_MISSED", "WaveOfDecayDamage", 278789)

	-- Fallen Deathspeaker
	self:Log("SPELL_CAST_START", "RaiseDead", 272183)
	self:Log("SPELL_CAST_START", "WickedFrenzy", 266209)
	self:Log("SPELL_AURA_APPLIED", "WickedFrenzyApplied", 266209)
	self:Log("SPELL_AURA_APPLIED", "WickedEmbraceApplied", 266265)
	self:Log("SPELL_AURA_REMOVED", "WickedEmbraceRemoved", 266265)

	-- Grotesque Horror
	self:Log("SPELL_CAST_START", "DarkEchoes", 413044)

	-- Bloodsworn Defiler
	self:Log("SPELL_CAST_START", "ShadowBoltVolley", 265487)
	self:Log("SPELL_CAST_START", "WitheringCurse", 265433)
	self:Log("SPELL_CAST_START", "SummonSpiritDrainTotem", 265523)

	-- Faceless Corruptor
	self:Log("SPELL_CAST_START", "AbyssalReach", 272592)
	self:Log("SPELL_CAST_START", "MaddeningGaze", 272609)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Befouled Spirit

function mod:DarkOmen(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "alert")
	-- seems not to have a CD
end

function mod:DarkOmenApplied(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId)
		self:PlaySound(args.spellId, "alarm")
		self:Say(args.spellId, nil, nil, "Dark Omen")
	end
end

function mod:HarrowingDespair(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	if self:Interrupter() then
		self:PlaySound(args.spellId, "warning")
	end
	--self:Nameplate(args.spellId, 32.8, args.sourceGUID)
end

-- Devout Blood Priest

function mod:DarkReconstitution(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

function mod:GiftOfGhuun(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:GiftOfGhuunApplied(args)
	if self:MobId(args.sourceGUID) ~= 131492 then return end -- filter out Spellsteal
	self:Message(args.spellId, "red", CL.other:format(args.spellName, args.destName))
	if self:Dispeller("magic", true) then
		self:PlaySound(args.spellId, "alarm")
	end
end

-- Fetid Maggot

function mod:RottenBile(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
	--self:Nameplate(args.spellId, 10.1, args.sourceGUID)
end

-- Chosen Blood Matron

function mod:BloodHarvest(args)
	self:TargetMessage(args.spellId, "orange", args.destName)
	self:PlaySound(args.spellId, "info", nil, args.destName)
	if self:Me(args.destGUID) then
		-- :Say here, because if Blood Harvest hits its target a
		-- Savage Cleave will be immediately cast in their direction.
		self:Say(args.spellId, nil, nil, "Blood Harvest")
	end
	--self:Nameplate(args.spellId, 12.1, args.sourceGUID)
end

function mod:SavageCleave(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	--self:Nameplate(args.spellId, 12.3, args.sourceGUID)
end

function mod:Warcry(args)
	if self:Tank() or self:Healer() or self:Dispeller("enrage", true) then
		self:Message(args.spellId, "red")
		self:PlaySound(args.spellId, "long")
		--self:Nameplate(args.spellId, 25.5, args.sourceGUID)
	end
end

-- Fanatical Headhunter

function mod:HookedSnareApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("movement", nil, args.spellId) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

-- Diseased Lasher

function mod:DecayingMind(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	--self:Nameplate(args.spellId, 27.1, args.sourceGUID)
end

function mod:DecayingMindApplied(args)
	if self:Me(args.destGUID) or self:Healer() or self:Dispeller("disease") then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "warning", nil, args.destName)
		self:TargetBar(args.spellId, 30, args.destName)
	end
end

function mod:DecayingMindRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

-- Feral Bloodswarmer

do
	local prev = 0
	function mod:ThirstForBloodApplied(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if not self:Tank() and t - prev > 1.5 then
				prev = t
				self:PersonalMessage(args.spellId, nil, CL.fixate)
				self:PlaySound(args.spellId, "alarm")
			end
			self:Nameplate(args.spellId, 15, args.sourceGUID, CL.fixate)
		end
		-- if this is uncommented, move to SPELL_CAST_SUCCESS
		--self:Nameplate(args.spellId, 31.6, args.sourceGUID)
	end
end

function mod:ThirstForBloodRemoved(args)
	if self:Me(args.destGUID) then
		self:StopNameplate(args.spellId, args.sourceGUID, CL.fixate)
	end
end

function mod:SonicScreech(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
	--self:Nameplate(args.spellId, 25.5, args.sourceGUID)
end

-- Living Rot

do
	local prev = 0
	function mod:WaveOfDecayDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:PersonalMessage(265668, "underyou")
				self:PlaySound(265668, "underyou", "gtfo")
			end
		end
	end
end

-- Fallen Deathspeaker

function mod:RaiseDead(args)
	-- only cast in non-Mythic
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

function mod:WickedFrenzy(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by DKs
		return
	end
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	--self:Nameplate(args.spellId, 25.5, args.sourceGUID)
end

do
	local prev = 0
	function mod:WickedFrenzyApplied(args)
		if not self:Friendly(args.destFlags) and (self:Tank() or self:Dispeller("enrage", true)) then
			local t = args.time
			-- throttle, as this applies on all nearby enemies
			if t - prev > 1 then
				prev = t
				self:TargetMessage(args.spellId, "red", args.destName)
				self:PlaySound(args.spellId, "alarm")
			end
		end
	end
end


function mod:WickedEmbraceApplied(args)
	if self:Me(args.destGUID) or self:Healer() or self:Dispeller("magic") then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "info", nil, args.destName)
		self:TargetBar(args.spellId, 12, args.destName)
	end
end

function mod:WickedEmbraceRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

-- Grotesque Horror

function mod:DarkEchoes(args)
	if self:Friendly(args.sourceFlags) then -- these NPCs can be mind-controlled by Priests
		return
	end
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
	--self:Nameplate(args.spellId, 20.6, args.sourceGUID)
end

-- Bloodsworn Defiler

function mod:ShadowBoltVolley(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	--self:Nameplate(args.spellId, 29.1, args.sourceGUID)
end

function mod:WitheringCurse(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	--self:Nameplate(args.spellId, 25.5, args.sourceGUID)
end

function mod:SummonSpiritDrainTotem(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
	--self:Nameplate(args.spellId, 35.2, args.sourceGUID)
end

-- Faceless Corruptor

do
	local prev = 0
	function mod:AbyssalReach(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "cyan")
			self:PlaySound(args.spellId, "long")
		end
		--self:Nameplate(args.spellId, 16.2, args.sourceGUID)
	end
end

do
	local prev = 0
	function mod:MaddeningGaze(args)
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
		--self:Nameplate(args.spellId, 15.8, args.sourceGUID)
	end
end
