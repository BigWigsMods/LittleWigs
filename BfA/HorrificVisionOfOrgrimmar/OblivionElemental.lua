--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Oblivion Elemental", 2212)
if not mod then return end
mod:RegisterEnableMob(
	153244, -- Oblivion Elemental
	234040 -- Oblivion Elemental (Revisited)
)
mod:SetEncounterID({2372, 3088}) -- BFA, Revisited
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Locals
--

local hopelessnessCount = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.oblivion_elemental = "Oblivion Elemental"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		297574, -- Hopelessness
	}
end

function mod:OnRegister()
	self.displayName = L.oblivion_elemental
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Hopelessness", 297574)
	self:Log("SPELL_AURA_APPLIED", "HopelessnessApplied", 297574)
	self:Log("SPELL_AURA_REMOVED", "HopelessnessRemoved", 297574)
end

function mod:OnEngage()
	hopelessnessCount = 1
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Hopelessness(args)
	if hopelessnessCount == 1 then
		self:Message(args.spellId, "yellow", CL.percent:format(80, CL.casting:format(args.spellName)))
	else
		self:Message(args.spellId, "yellow", CL.percent:format(40, CL.casting:format(args.spellName)))
	end
	hopelessnessCount = hopelessnessCount + 1
end

function mod:HopelessnessApplied(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId)
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:HopelessnessRemoved(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "green", CL.removed:format(args.spellName))
		self:PlaySound(args.spellId, "info")
	end
end
