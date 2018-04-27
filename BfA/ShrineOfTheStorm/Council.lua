if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Tidesage Coucil", 1864, 2154)
if not mod then return end
mod:RegisterEnableMob(134058, 134063) -- Galecaller Faye, Brother Ironhull
mod.engageId = 2131

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		267891, -- Swiftness Ward
		267830, -- Blessing of the Tempest
		267818, -- Slicing Blast
		267905, -- Reinforcing Ward
		{267901, "TANK"}, -- Blessing of Ironsides
		{267899, "TANK"}, -- Hindering Cleave
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "SwiftnessWard", 267891)
	self:Log("SPELL_AURA_APPLIED", "SwiftnessWardApplied", 267888)
	self:Log("SPELL_CAST_SUCCESS", "BlessingoftheTempest", 267830)
	self:Log("SPELL_CAST_START", "SlicingBlast", 267818)
	self:Log("SPELL_CAST_START", "ReinforcingWard", 267905)
	self:Log("SPELL_CAST_START", "BlessingofIronsides", 267901)
	self:Log("SPELL_CAST_START", "HinderingCleave", 267899)
end

function mod:OnEngage()
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SwiftnessWard(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "long")
end

function mod:SwiftnessWardApplied(args)
	if self:Me(args.destGUID) then
		self:Message(267891, "green")
		self:PlaySound(267891, "info")
	end
end

function mod:BlessingoftheTempest(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "warning")
	self:CastBar(args.spellId, 11)
end

function mod:SlicingBlast(args)
	self:Message(args.spellId, "yellow")
	if self:Interrupter(args.sourceGUID) then
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:ReinforcingWard(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "long")
end

function mod:BlessingofIronsides(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	self:CastBar(args.spellId, 8)
end

function mod:HinderingCleave(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
end
