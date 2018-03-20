
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Gekkan", 994, 690)
if not mod then return end
-- Gekkan, Glintrok Ironhide, Glintrok Skulker, Glintrok Oracle, Glintrok Hexxer
mod:RegisterEnableMob(61243, 61337, 61338, 61339, 61340)
mod.engageId = 2129
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Locals
--

local deaths = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.heal = "{-5923} ({33144})" -- Cleansing Flame (Heal)
	L.heal_desc = -5923
	L.heal_icon = 118940
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		118963, -- Shank
		"heal",
		118903, -- Hex of Lethargy
		"stages"
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Shank", 118963)
	self:Log("SPELL_AURA_APPLIED", "HexOfLethargy", 118903)
	self:Log("SPELL_AURA_APPLIED_DOSE", "HexOfLethargy", 118903)
	self:Log("SPELL_AURA_REMOVED", "HexOfLethargyRemoved", 118903)
	self:Log("SPELL_CAST_START", "Heal", 118940)
	self:Log("SPELL_INTERRUPT", "HealStop", "*")

	self:Death("Deaths", 61243, 61337, 61338, 61339, 61340)
end

function mod:OnEngage()
	deaths = 0
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Shank(args)
	self:TargetMessage(args.spellId, args.destName, "Attention")
	self:TargetBar(args.spellId, 5, args.destName)
end

function mod:HexOfLethargy(args)
	self:TargetMessage(args.spellId, args.destName, "Important")
	self:TargetBar(args.spellId, 20, args.destName, 66054, args.spellId) -- Hex
end

function mod:HexOfLethargyRemoved(args)
	self:StopBar(66054, args.destName) -- Hex
end

function mod:Heal(args)
	local heal = self:SpellName(33144)
	self:Message("heal", "Urgent", "Alert", CL.other:format(args.sourceName, heal), args.spellId)
	self:CastBar("heal", 4, heal, args.spellId)
end

function mod:HealStop(args)
	if args.extraSpellId == 118940 then
		local heal = self:SpellName(33144)
		self:StopBar(CL.cast:format(heal))
	end
end

function mod:Deaths(args)
	deaths = deaths + 1
	if deaths < 5 then
		self:Message("stages", "Positive", "Info", CL.mob_killed:format(args.destName, deaths, 5), false)
	end
end

