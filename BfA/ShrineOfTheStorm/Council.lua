
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
		267818, -- Slicing Blast
		267905, -- Reinforcing Ward
		{267899, "TANK"}, -- Hindering Cleave
		{267901, "TANK"}, -- Blessing of Ironsides
	}, {
		[267891] = -17970, -- Galecaller Faye
		[267905] = -18154, -- Brother Ironhull
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "SwiftnessWard", 267891)
	self:Log("SPELL_AURA_APPLIED", "SwiftnessWardApplied", 267888)
	self:Log("SPELL_CAST_START", "SlicingBlast", 267818)
	self:Log("SPELL_CAST_START", "ReinforcingWard", 267905)
	self:Log("SPELL_CAST_START", "BlessingofIronsides", 267901)
	self:Log("SPELL_AURA_APPLIED", "BlessingofIronsidesApplied", 267901)
	self:Log("SPELL_CAST_START", "HinderingCleave", 267899)
end

function mod:OnEngage()
	self:Bar(267899, 6) -- Hindering Cleave
	self:Bar(267891, 14.5) -- Swiftness Ward
	self:Bar(267905, 30) -- Reinforcing Ward
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SwiftnessWard(args)
	self:Message2(args.spellId, "cyan")
	self:PlaySound(args.spellId, "long")
	self:Bar(args.spellId, 31.5)
end

function mod:SwiftnessWardApplied(args)
	if self:Me(args.destGUID) then
		self:Message2(267891, "green")
		self:PlaySound(267891, "info")
	end
end

function mod:SlicingBlast(args)
	self:Message2(args.spellId, "yellow")
	if self:Interrupter(args.sourceGUID) then
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:ReinforcingWard(args)
	self:Message2(args.spellId, "cyan")
	self:PlaySound(args.spellId, "long")
	self:Bar(args.spellId, 30)
end

function mod:BlessingofIronsides(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	self:Bar(args.spellId, 33)
end

function mod:BlessingofIronsidesApplied(args)
	self:TargetBar(args.spellId, 8, args.destName)
end

function mod:HinderingCleave(args)
	self:Message2(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 17)
end
