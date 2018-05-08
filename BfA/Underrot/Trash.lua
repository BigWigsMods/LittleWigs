if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

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
	133870, -- Venomous Lasher
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
	L.spirit = "Befouled Spirit"
	L.priest = "Devout Blood Priest"
	L.maggot = "Fetid Maggot"
	L.matron = "Chosen Blood Matron"
	L.lasher = "Venomous Lasher"
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
		-- Fetid Maggot
		265540, -- Rotten Bile
		-- Chosen Blood Matron
		265019, -- Savage Cleave
		265081, -- Warcry
		-- Venomous Lasher
		265687, -- Noxious Poison
		266105, -- Rampant Growth
		-- Feral Bloodswarmer
		266107, -- Thirst For Blood
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
		[265081] = L.matron,
		[265687] = L.lasher,
		[266107] = L.bloodswarmer,
		[265668] = L.rot,
		[272183] = L.deathspeaker,
		[265487] = L.defiler,
		[272592] = L.corruptor,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")

	self:Log("SPELL_CAST_START", "DarkOmen", 265568)
	self:Log("SPELL_AURA_APPLIED", "DarkOmenApplied", 265568)
	self:Log("SPELL_CAST_START", "DarkReconstitution", 265089)
	self:Log("SPELL_CAST_START", "RottenBile", 265540)
	self:Log("SPELL_AURA_APPLIED", "SavageCleaveApplied", 265019)
	self:Log("SPELL_CAST_START", "Warcry", 265081)
	self:Log("SPELL_CAST_SUCCESS", "RampantGrowth", 266105)
	self:Log("SPELL_AURA_APPLIED", "ThirstForBloodApplied", 266107)
	self:Log("SPELL_CAST_START", "WaveofDecay", 265668)
	self:Log("SPELL_CAST_START", "RaiseDead", 272183)
	self:Log("SPELL_CAST_START", "WickedFrenzy", 266209)
	self:Log("SPELL_CAST_START", "ShadowBoltVolley", 265487)
	self:Log("SPELL_CAST_START", "WitheringCurse", 265433)
	self:Log("SPELL_CAST_START", "SummonSpiritDrainTotem", 265523)
	self:Log("SPELL_CAST_START", "AbyssalReach", 272592)
	self:Log("SPELL_CAST_START", "MaddeningGaze", 272609)


	self:Log("SPELL_AURA_APPLIED", "GroundDamage", 265687) -- Noxious Poison
	self:Log("SPELL_PERIODIC_DAMAGE", "GroundDamage", 265687)
	self:Log("SPELL_PERIODIC_MISSED", "GroundDamage", 265687)

end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DarkOmen(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "alert")
end

function mod:DarkOmenApplied(args)
	if self:Me(args.destGUID) then
		self:TargetMessage2(args.spellId, "blue", args.destName)
		self:PlaySound(args.spellId, "alarm")
		self:Say(args.spellId)
	end
end

function mod:DarkReconstitution(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "warning")
end

function mod:RottenBile(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
end

function mod:Warcry(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
end

function mod:RampantGrowth(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "warning")
end

function mod:SavageCleaveApplied(args)
	if self:Me(args.destGUID) then
		self:TargetMessage2(args.spellId, "blue", args.destName)
		self:PlaySound(args.spellId, "info")
	end
end

function mod:ThirstForBloodApplied(args)
	if self:Me(args.destGUID) then
		self:TargetMessage2(args.spellId, "blue", args.destName)
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:WaveofDecay(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

function mod:RaiseDead(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

function mod:WickedFrenzy(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
end

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

do
	local prev = 0
	function mod:AbyssalReach(args)
		local t = GetTime()
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
		local t = GetTime()
		if t-prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

do
	local prev = 0
	function mod:GroundDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 1.5 then
				prev = t
				self:Message(args.spellId, "blue", nil, CL.underyou:format(args.spellName))
				self:PlaySound(args.spellId, "alarm", "gtfo")
			end
		end
	end
end
