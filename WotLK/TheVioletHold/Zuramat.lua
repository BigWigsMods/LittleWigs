--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Zuramat the Obliterator", 608, 631)
if not mod then return end
mod:RegisterEnableMob(
	29314, -- Zuramat the Obliterator
	32230 -- Void Lord (replacement boss)
)
-- mod.engageId = 0 -- no IEEU and ENCOUNTER_* events
-- mod.respawnTime = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.short_name = "Zuramat"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		54361, -- Void Shift
		54524, -- Shroud of Darkness
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "VoidShift", 54361, 59743) -- Normal, Heroic
	self:Log("SPELL_CAST_START", "ShroudOfDarkness", 54524, 59745) -- Normal, Heroic
	self:Log("SPELL_AURA_APPLIED", "ShroudOfDarknessApplied", 54524, 59745)
	self:Log("SPELL_AURA_REMOVED", "ShroudOfDarknessRemoved", 54524, 59745)

	self:Death("Win", 29314, 32230)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:VoidShift(args)
	self:TargetMessage(54361, "yellow", args.destName)
	self:PlaySound(54361, "long", nil, args.destName)
	self:Bar(54361, 15.8)
end

function mod:ShroudOfDarkness(args)
	self:Message(54524, "orange", CL.casting:format(args.spellName))
	self:PlaySound(54524, "alert")
end

function mod:ShroudOfDarknessApplied(args)
	if self:Player(args.destFlags) then return end

	self:Message(54524, "red", CL.onboss:format(args.spellName))
	self:PlaySound(54524, self:Dispeller("magic", true) and "warning" or "alarm")
	self:Bar(54524, 5, CL.onboss:format(args.spellName))
end

function mod:ShroudOfDarknessRemoved(args)
	if self:Player(args.destFlags) then return end

	self:StopBar(CL.onboss:format(args.spellName))
	self:Message(54524, "green", CL.removed_from:format(args.spellName, L.short_name))
	self:PlaySound(54524, "info")
end
