
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Shrine of the Storm Trash", 1864)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	134139, -- Shrine Templar
	136186, -- Tidesage Spiritualist
	139800, -- Galecaller Apprentice
	136214, -- Windspeaker Heldis
	139799, -- Ironhull Apprentice
	134150, -- Runecarver Sorn
	136249, -- Guardian Elemental
	134417, -- Deepsea Ritualist
	134514, -- Abyssal Cultist
	134418  -- Drowned Depthbringer
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.templar = "Shrine Templar"
	L.spiritualist = "Tidesage Spiritualist"
	L.galecaller_apprentice = "Galecaller Apprentice"
	L.windspeaker = "Windspeaker Heldis"
	L.ironhull_apprentice = "Ironhull Apprentice"
	L.runecarver = "Runecarver Sorn"
	L.guardian_elemental = "Guardian Elemental"
	L.ritualist = "Deepsea Ritualist"
	L.cultist = "Abyssal Cultist"
	L.depthbringer = "Drowned Depthbringer"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Shrine Templar
		276268, -- Heaving Blow
		267977, -- Tidal Surge
		267981, -- Protective Aura
		-- Tidesage Spiritualist
		268050, -- Anchor of Binding
		276266, -- Spirit's Swiftness
		268030, -- Mending Rapids
		-- Galecaller Apprentice
		274437, -- Tempest
		-- Windspeaker Heldis
		268177, -- Windblast
		268187, -- Gale Winds
		268184, -- Minor Swiftness Ward
		-- Ironhull Apprentice
		{274631, "TANK"}, -- Lesser Blessing of Ironsides
		{274633, "TANK"}, -- Sundering Blow
		276292, -- Whirling Slam
		-- Runecarver Sorn
		268211, -- Minor Reinforcing Ward
		268214, -- Carve Flesh
		-- Guardian Elemental
		268239, -- Shipbreaker Storm
		268233, -- Electrifying Shock
		-- Deepsea Ritualist
		268309, -- Unending Darkness
		{276297, "SAY_COUNTDOWN"} -- Void Seed
		-- Abyssal Cultist
		268391, -- Mental Assault
		268375, -- Detect Thoughts
		-- Drowned Depthbringer
		268322, -- Touch of the Drowned
	}, {
		[276268] = L.templar,
		[268050] = L.spiritualist,
		[274437] = L.galecaller_apprentice,
		[268177] = L.windspeaker,
		[274631] = L.ironhull_apprentice,
		[268211] = L.runecarver,
		[268239] = L.guardian_elemental,
		[268309] = L.ritualist,
		[268391] = L.cultist,
		[268322] = L.depthbringer,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")
	
	self:Log("SPELL_CAST_START", "HeavingBlow", 276268)
	self:Log("SPELL_CAST_START", "TidalSurge", 267977)
	self:Log("SPELL_CAST_START", "ProtectiveAura", 267981)
	self:Log("SPELL_CAST_SUCCESS", "AnchorOfBinding", 268050)
	self:Log("SPELL_AURA_APPLIED", "SpiritsSwiftness", 276266)
	self:Log("SPELL_CAST_START", "MendingRapids", 268030)
	self:Log("SPELL_CAST_START", "Tempest", 274437)
	self:Log("SPELL_CAST_START", "Windblast", 268177)
	self:Log("SPELL_CAST_START", "GaleWinds", 268187)
	self:Log("SPELL_CAST_START", "MinorSwiftnessWard", 268184)
	self:Log("SPELL_CAST_START", "LesserBlessingOfIronsides", 274631)
	self:Log("SPELL_AURA_APPLIED", "SunderingBlow", 274633)
	self:Log("SPELL_AURA_APPLIED_DOSE", "SunderingBlow", 274633)
	self:Log("SPELL_CAST_START", "WhirlingSlam", 276292)
	self:Log("SPELL_CAST_START", "MinorReinforcingWard", 268211)
	self:Log("SPELL_CAST_START", "CarveFlesh", 268214)
	self:Log("SPELL_CAST_START", "ShipbreakerStorm", 268239)
	self:Log("SPELL_AURA_APPLIED", "ElectrifyingShock", 268233)
	self:Log("SPELL_CAST_START", "UnendingDarkness", 268309)
	self:Log("SPELL_AURA_APPLIED", "VoidSeedApplied", 276297)
	self:Log("SPELL_AURA_REMOVED", "VoidSeedRemoved", 276297)
	self:Log("SPELL_CAST_START", "MentalAssault", 268391)
	self:Log("SPELL_CAST_START", "DetectThoughts", 268375)
	self:Log("SPELL_CAST_START", "TouchOfTheDrowned", 268322)
	self:Log("SPELL_AURA_APPLIED", "TouchOfTheDrownedApplied", 268322)
	
	self:Death("WindspeakerDeath", 136214)
	self:Death("RunecarverDeath", 134150)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:HeavingBlow(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:TidalSurge(args)
	self:Message2(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end

function mod:ProtectiveAura(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:AnchorOfBinding(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:SpiritsSwiftness(args)
	self:Message2(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
end

function mod:MendingRapids(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:Tempest(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:Windblast(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:GaleWinds(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 22)
end

function mod:WindspeakerDeath(args)
	self:StopBar(268187)
end

function mod:MinorSwiftnessWard(args)
	self:Message2(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
end

function mod:LesserBlessingOfIronsides(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:SunderingBlow(args)
	if self:Me(args.destGUID) then
		self:StackMessage(args.spellId, args.destName, args.amount, "purple")
		self:PlaySound(args.spellId, "info")	
	end
end

function mod:WhirlingSlam(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:MinorReinforcingWard(args)
	self:Message2(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
end

do
	local prev = 0
	function mod:CarveFlesh(args)
		self:Bar(args.spellId, args.time - prev > 16 and 11 or 18)
		prev = args.time
		self:TargetMessage(args.spellId, args.destName, "orange")
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:RunecarverDeath(args)
	self:StopBar(268214)
end

function mod:ShipbreakerStorm(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 13)
end

function mod:ElectrifyingShock(args)
	self:TargetMessage(args.spellId, args.destName, "yellow")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 15)
end

function mod:UnendingDarkness(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:VoidSeedApplied(args)
	if self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, args.destName, "blue")
		self:PlaySound(args.spellId, "alarm")
		self:TargetBar(args.spellId, 12, args.destName)
		self:SayCountdown(args.spellId, 12)
	end
end

function mod:VoidSeedRemoved(args)
	if self:Me(args.destGUID) then
		self:Message2(args.spellId, "blue", CL.removed:format(args.destName))
		self:PlaySound(args.spellId, "info")
		self:StopBar(args.spellId)
		self:StopSayCountdown(args.spellId)
	end
end

function mod:MentalAssault(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:DetectThoughts(args)
	self:Message2(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
end

function mod:TouchOfTheDrowned(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:TouchOfTheDrownedApplied(args)
	self:TargetMessage(args.spellId, args.destName, "yellow")
	self:PlaySound(args.spellId, "info")
end
