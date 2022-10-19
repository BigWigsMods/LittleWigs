if not IsTestBuild() then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Kokia Blazehoof", 2521, 2485)
if not mod then return end
mod:RegisterEnableMob(189232) -- Kokia Blazehoof
mod:SetEncounterID(2606)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		372863, -- Ritual of Blazebinding
		372107, -- Molten Boulder
		{372858, "TANK_HEALER"}, -- Searing Blows
		373087, -- Burnout
		373017, -- Roaring Blaze
	}, {
		[373087] = -24945, -- Blazebound Firestorm
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "RitualOfBlazebinding", 372863)
	self:Log("SPELL_CAST_START", "MoltenBoulder", 372107)
	self:Log("SPELL_CAST_START", "SearingBlows", 372858)
	self:Log("SPELL_CAST_START", "Burnout", 373087)
	self:Log("SPELL_CAST_START", "RoaringBlaze", 373017)
end

function mod:OnEngage()
	self:Bar(372863, 7.6) -- Ritual of Blazebinding
	self:Bar(372107, 14.5) -- Molten Boulder
	self:Bar(372858, 21.6) -- Searing Blows
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:RitualOfBlazebinding(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "long")
	self:Bar(args.spellId, 33.6)
end

function mod:MoltenBoulder(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 17)
end

function mod:SearingBlows(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 32.9)
end

function mod:Burnout(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

function mod:RoaringBlaze(args)
	self:Message(args.spellId, "red")
	if self:Interrupter() then
		self:PlaySound(args.spellId, "warning")
	end
end
