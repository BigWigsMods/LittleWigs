
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Tidesage Coucil", 1864, 2154)
if not mod then return end
mod:RegisterEnableMob(134058, 134063) -- Galecaller Faye, Brother Ironhull
mod.engageId = 2131
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		267891, -- Swiftness Ward
		267818, -- Slicing Blast
		267830, -- Blessing of the Tempest
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
	self:Log("SPELL_AURA_APPLIED", "BlessingoftheTempestApplied", 267830)
	self:Log("SPELL_AURA_REMOVED", "BlessingoftheTempestRemoved", 267830)
	self:Log("SPELL_INTERRUPT", "Interrupted", "*")

	self:Death("FayeDeath", 134058)
	self:Death("IronhullDeath", 134063)
end

function mod:OnEngage()
	self:Bar(267899, 8.5) -- Hindering Cleave
	self:Bar(267891, 17) -- Swiftness Ward
	self:Bar(267905, 30) -- Reinforcing Ward
	self:Bar(267901, 6.1) -- Blessing of Ironsides
	self:Bar(267830, 26.7) -- Blessing of the Tempest
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SwiftnessWard(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "long")
	self:Bar(args.spellId, 31.5)
end

function mod:SwiftnessWardApplied(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(267891)
		self:PlaySound(267891, "info")
	end
end

function mod:SlicingBlast(args)
	self:Message(args.spellId, "orange")
	if self:Interrupter() then
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:ReinforcingWard(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "long")
	self:Bar(args.spellId, 32)
end

function mod:BlessingofIronsides(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	self:Bar(args.spellId, 33)
end

function mod:BlessingofIronsidesApplied(args)
	self:TargetBar(args.spellId, 8, args.destName)
end

do
	local blessingActive = false

	function mod:BlessingoftheTempestApplied(args)
		blessingActive = true
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "info")
		self:TargetBar(args.spellId, 11, args.destName)
		self:CDBar(args.spellId, 20)
	end

	function mod:BlessingoftheTempestRemoved(args)
		blessingActive = false
	end

	function mod:Interrupted(args)
		if blessingActive and self:MobId(args.destGUID) == 134058 then -- Galecaller Faye
			local unit = self:UnitTokenFromGUID(args.destGUID)
			if unit and self:UnitWithinRange(unit, 10) then -- Tempest spawns close to the boss, so warnings aren't needed for ranged
				self:Message(267830, "yellow", self:SpellName(274437), 274437) -- Tempest
				self:PlaySound(267830, "info")
			end
		end
	end
end

function mod:HinderingCleave(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 17)
end

function mod:FayeDeath(args)
	self:StopBar(267830) -- Blessing of the Tempest
	self:StopBar(267891) -- Swiftness Ward
end

function mod:IronhullDeath(args)
	self:StopBar(267899) -- Hindering Cleave
	self:StopBar(267905) -- Reinforcing Ward
	self:StopBar(267901) -- Blessing of Ironsides
end
