
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Shrine of the Storm Trash", 1822)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	134139, -- Shrine Templar
	136186, -- Tidesage Spiritualist
	139800, -- Galecaller Apprentice
	136214, -- Windspeaker Heldis
	139799, -- Ironhull Apprentice
	134150  -- Runecarver Sorn
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.templar = "Shrine Templar"
	L.spiritualist = "Tidesage Spiritualist"
	L.galecallerApprentice = "Galecaller Apprentice"
	L.windspeaker = "Windspeaker Heldis"
	L.ironhullApprentice = "Ironhull Apprentice"
	L.runecarver = "Runecarver Sorn"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Shrine Templar
		276268, -- Heaving Blow
		267977, -- Tidal Surge
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
		{274631,"TANK"}, -- Lesser Blessing of Ironsides
		{274633,"TANK"}, -- Sundering Blow
		276292, -- Whirling Slam
		-- Runecarver Sorn
		268211, -- Minor Reinforcing Ward
	}, {
		[276268] = L.templar,
		[268050] = L.spiritualist,
		[274437] = L.galecallerApprentice,
		[268177] = L.windspeaker,
		[274631] = L.ironhullApprentice,
		[268211] = L.runecarver,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")
	
	self:Log("SPELL_CAST_START", "HeavingBlow", 276268)
	self:Log("SPELL_CAST_START", "TidalSurge", 267977)
	self:Log("SPELL_CAST_SUCCESS", "AnchorOfBinding", 268050)
	self:Log("SPELL_AURA_APPLIED", "SpiritsSwiftness", 276266)
	self:Log("SPELL_CAST_START", "MendingRapids", 268030)
	self:Log("SPELL_CAST_START", "Tempest", 274437)
	self:Log("SPELL_CAST_START", "Windblast", 268177)
	self:Log("SPELL_CAST_START", "GaleWinds", 268187)
	self:Log("SPELL_CAST_START", "MinorSwiftnessWard", 268187)
	self:Log("SPELL_CAST_START", "LesserBlessingOfIronsides", 274631)
	self:Log("SPELL_AURA_APPLIED", "SunderingBlow", 274633)
	self:Log("SPELL_AURA_APPLIED_DOSE", "SunderingBlow", 274633)
	self:Log("SPELL_CAST_START", "WhirlingSlam", 276292)
	self:Log("SPELL_CAST_START", "MinorReinforcingWard", 268211)
	
	self:Death("WindspeakerDeath", 136214)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:HeavingBlow(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:TidalSurge(args)
	self:Message2(args.spellId, "yellow")
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
