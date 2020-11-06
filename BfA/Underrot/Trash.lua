
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
	133912, -- Bloodsworn Defiler
	138281 -- Faceless Corruptor
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.custom_on_fixate_plates = "Thirst For Blood icon on Enemy Nameplate"
	L.custom_on_fixate_plates_desc = "Show an icon on the target nameplate that is fixating on you.\nRequires the use of Enemy Nameplates. This feature is currently only supported by KuiNameplates."
	L.custom_on_fixate_plates_icon = 266107

	L.spirit = "Befouled Spirit"
	L.priest = "Devout Blood Priest"
	L.maggot = "Fetid Maggot"
	L.matron = "Chosen Blood Matron"
	L.lasher = "Diseased Lasher"
	L.bloodswarmer = "Feral Bloodswarmer"
	L.rot = "Living Rot"
	L.deathspeaker = "Fallen Deathspeaker"
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
		-- Devout Blood Priest
		265089, -- Dark Reconstitution
		265091, -- Gift of G'huun
		-- Fetid Maggot
		265540, -- Rotten Bile
		-- Chosen Blood Matron
		265019, -- Savage Cleave
		265081, -- Warcry
		-- Diseased Lasher
		278961, -- Decaying Mind
		-- Feral Bloodswarmer
		266107, -- Thirst For Blood
		"custom_on_fixate_plates",
		266106, -- Sonic Screech
		-- Living Rot
		265668, -- Wave of Decay
		-- Fallen Deathspeaker
		272183, -- Raise Dead
		266209, -- Wicked Frenzy
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
		[265019] = L.matron,
		[278961] = L.lasher,
		[266107] = L.bloodswarmer,
		[265668] = L.rot,
		[272183] = L.deathspeaker,
		[265487] = L.defiler,
		[272592] = L.corruptor,
	}
end

function mod:OnBossEnable()
	-- Befouled Spirit
	self:Log("SPELL_CAST_START", "DarkOmen", 265568)
	self:Log("SPELL_AURA_APPLIED", "DarkOmenApplied", 265568)
	-- Devout Blood Priest
	self:Log("SPELL_CAST_START", "DarkReconstitution", 265089)
	self:Log("SPELL_CAST_START", "GiftOfGhuun", 265091)
	self:Log("SPELL_AURA_APPLIED", "GiftOfGhuunApplied", 265091)
	-- Fetid Maggot
	self:Log("SPELL_CAST_START", "RottenBile", 265540)
	-- Chosen Blood Matron
	self:Log("SPELL_CAST_SUCCESS", "BloodHarvest", 265016) -- charge that Matron does right before casting Savage Cleave
	self:Log("SPELL_CAST_START", "SavageCleave", 265019)
	self:Log("SPELL_AURA_APPLIED", "SavageCleaveApplied", 265019)
	self:Log("SPELL_CAST_START", "Warcry", 265081)
	-- Diseased Lasher
	self:Log("SPELL_CAST_START", "DecayingMind", 278961)
	self:Log("SPELL_AURA_APPLIED", "DecayingMindApplied", 278961)
	self:Log("SPELL_AURA_REMOVED", "DecayingMindRemoved", 278961)
	-- Feral Bloodswarmer
	self:Log("SPELL_AURA_APPLIED", "ThirstForBloodApplied", 266107)
	self:Log("SPELL_AURA_REMOVED", "ThirstForBloodRemoved", 266107)
	self:Log("SPELL_CAST_START", "SonicScreech", 266106)
	-- Fallen Deathspeaker
	self:Log("SPELL_CAST_START", "RaiseDead", 272183)
	self:Log("SPELL_CAST_START", "WickedFrenzy", 266209)
	self:Log("SPELL_AURA_APPLIED", "WickedFrenzyApplied", 266209)
	self:Log("SPELL_AURA_REMOVED", "WickedFrenzyRemoved", 266209)
	self:Log("SPELL_DISPEL", "WickedFrenzySoothed", "*")
	-- Bloodsworn Defiler
	self:Log("SPELL_CAST_START", "ShadowBoltVolley", 265487)
	self:Log("SPELL_CAST_START", "WitheringCurse", 265433)
	self:Log("SPELL_CAST_START", "SummonSpiritDrainTotem", 265523)
	-- Faceless Corruptor
	self:Log("SPELL_CAST_START", "AbyssalReach", 272592)
	self:Log("SPELL_CAST_START", "MaddeningGaze", 272609)
	-- Living Rot
	self:Log("SPELL_AURA_APPLIED", "WaveOfDecayDamage", 278789)
	self:Log("SPELL_PERIODIC_DAMAGE", "WaveOfDecayDamage", 278789)
	self:Log("SPELL_PERIODIC_MISSED", "WaveOfDecayDamage", 278789)

	if self:GetOption("custom_on_fixate_plates") then
		self:ShowPlates()
	end
end

function mod:OnBossDisable()
	if self:GetOption("custom_on_fixate_plates") then
		self:HidePlates()
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Befouled Spirit
function mod:DarkOmen(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "alert")
end

function mod:DarkOmenApplied(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId)
		self:PlaySound(args.spellId, "alarm")
		self:Say(args.spellId)
	end
end

-- Devout Blood Priest
function mod:DarkReconstitution(args)
	self:Message(args.spellId, "orange")
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
end

-- Chosen Blood Matron
do
	local lastChargeTarget = nil
	function mod:BloodHarvest(args)
		lastChargeTarget = args.destName
	end

	function mod:SavageCleave(args)
		if IsItemInRange(33278, lastChargeTarget) then -- 11 yards
			self:Message(args.spellId, "red", CL.near:format(args.spellName))
			self:PlaySound(args.spellId, "warning")
		else
			self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
		end
	end
end

function mod:SavageCleaveApplied(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId)
		self:PlaySound(args.spellId, "info")
	end
end

function mod:Warcry(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
end

-- Diseased Lasher
function mod:DecayingMind(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:DecayingMindApplied(args)
	if self:Me(args.destGUID) or self:Healer() or self:Dispeller("disease") then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "info", nil, args.destName)
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
			if t-prev > 1.5 then
				prev = t
				self:PersonalMessage(args.spellId)
				self:PlaySound(args.spellId, "alarm")
			end
			if self:GetOption("custom_on_fixate_plates") then
				self:AddPlateIcon(args.spellId, args.sourceGUID)
			end
		end
	end
end

function mod:ThirstForBloodRemoved(args)
	if self:Me(args.destGUID) and self:GetOption("custom_on_fixate_plates") then
		self:RemovePlateIcon(args.spellId, args.sourceGUID)
	end
end

function mod:SonicScreech(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

-- Fallen Deathspeaker
function mod:RaiseDead(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

function mod:WickedFrenzy(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
end

function mod:WickedFrenzyApplied(args)
	local isTank = self:Tank()
	if isTank or self:Dispeller("enrage", true) then
		self:TargetMessage(args.spellId, "red", args.destName)
		self:PlaySound(args.spellId, isTank and "alarm" or "alert")
		if isTank then
			self:TargetBar(args.spellId, 8, args.destName)
		end
	end
end

function mod:WickedFrenzyRemoved(args)
	if self:Tank() then
		self:StopBar(args.spellId, args.destName)
	end
end

function mod:WickedFrenzySoothed(args)
	if args.extraSpellId == 266209 and self:Tank() then
		self:Message(266209, "green", CL.removed:format(args.extraSpellName))
		self:PlaySound(266209, "info")
	end
end

-- Bloodsworn Defiler
function mod:ShadowBoltVolley(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
end

function mod:WitheringCurse(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:SummonSpiritDrainTotem(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
end

-- Faceless Corruptor
do
	local prev = 0
	function mod:AbyssalReach(args)
		local t = args.time
		if t-prev > 1.5 then
			prev = t
			self:Message(args.spellId, "cyan")
			self:PlaySound(args.spellId, "long")
		end
	end
end

do
	local prev = 0
	function mod:MaddeningGaze(args)
		local t = args.time
		if t-prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

do
	local prev = 0
	function mod:WaveOfDecayDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t-prev > 1.5 then
				prev = t
				self:PersonalMessage(265668, "underyou")
				self:PlaySound(265668, "alarm", "gtfo")
			end
		end
	end
end
