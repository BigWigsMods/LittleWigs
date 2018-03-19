
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Gug'rokk", 1175, 889)
if not mod then return end
mod:RegisterEnableMob(74790)
--BOSS_KILL#1654#Gug'rokk

--------------------------------------------------------------------------------
-- Locals
--

local blastCount = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then

end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		150776, -- Magma Eruption
		150755, -- Unstable Slag
		150677, -- Molten Blast
		150678, -- Molten Core
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_CAST_START", "MagmaEruption", 150776)
	self:Log("SPELL_CAST_START", "UnstableSlag", 150755)
	self:Log("SPELL_CAST_START", "MoltenBlast", 150677)
	self:Log("SPELL_AURA_APPLIED", "MoltenCore", 150678)
	self:Log("SPELL_AURA_APPLIED_DOSE", "MoltenCore", 150678)

	self:Death("Win", 74790)
end

function mod:OnEngage()
	blastCount = 0
	self:CDBar(150755, 20) -- Summon Unstable Slag
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:MagmaEruption(args)
	self:Message(args.spellId, "Urgent", "Info")
	self:CDBar(args.spellId, 20) -- 20-21
end

function mod:UnstableSlag(args)
	self:Message(args.spellId, "Important", "Warning")
	self:CDBar(args.spellId, 21)
end

function mod:MoltenBlast(args)
	blastCount = blastCount + 1
	self:Message(args.spellId, "Attention", "Long", CL.count:format(args.spellName, blastCount))
end

function mod:MoltenCore(args)
	if self:MobId(args.destGUID) == 74790 then -- Filter spell steal
		self:StackMessage(args.spellId, args.destName, args.amount, "Attention")
	end
end
