--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Gekkan", 994, 690)
if not mod then return end
mod:RegisterEnableMob(
	61243, -- Gekkan,
	61337, -- Glintrok Ironhide
	61338, -- Glintrok Skulker
	61339, -- Glintrok Oracle
	61340 -- Glintrok Hexxer
)
-- mod.engageId = 2129 -- does not fire ENCOUNTER_END
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
	L.heal = -5923
	L.heal_desc = -5923
	L.heal_icon = 118940
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		118988, -- Reckless Inspiration
		118963, -- Shank
		{"heal", "CASTBAR"},
		{118903, "DISPEL"}, -- Hex of Lethargy
	}, {
		["stages"] = CL.general,
		[118963] = -5920,
		["heal"] = -5922,
		[118903] = -5924,
	}, {
		["heal"] = mod:SpellName(33144), -- Cleansing Flame (Heal)
		[118903] = mod:SpellName(66054), -- Hex of Lethargy (Hex)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "RecklessInspiration", 118988)
	self:Log("SPELL_CAST_START", "Shank", 118963)
	self:Log("SPELL_AURA_APPLIED", "ShankApplied", 118963)
	self:Log("SPELL_AURA_APPLIED", "HexOfLethargy", 118903)
	self:Log("SPELL_AURA_APPLIED_DOSE", "HexOfLethargy", 118903)
	self:Log("SPELL_AURA_REMOVED", "HexOfLethargyRemoved", 118903)
	self:Log("SPELL_CAST_START", "Heal", 118940)
	self:Log("SPELL_INTERRUPT", "HealStop", "*")

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Death("Deaths", 61243, 61337, 61338, 61339, 61340)
end

function mod:OnEngage()
	deaths = 0

	self:UnregisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT") -- Reset fires after Gekkan dies, even if the encounter hasn't ended
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:RecklessInspiration(args)
	self:TargetMessageOld(args.spellId, args.destName, "red", "alarm")
end

function mod:Shank(args)
	if self:MobId(args.sourceGUID) ~= 61338 then return end -- Don't announce casts done by trash mobs

	local unit = self:UnitTokenFromGUID(args.sourceGUID)
	if unit and self:Tanking(unit) then
		self:MessageOld(args.spellId, "purple", "warning", CL.casting:format(args.spellName))
	end
end

function mod:ShankApplied(args)
	if self:MobId(args.sourceGUID) ~= 61338 then return end -- Don't announce casts done by trash mobs

	self:TargetMessageOld(args.spellId, args.destName, "yellow")
	self:TargetBar(args.spellId, 5, args.destName)
end

function mod:HexOfLethargy(args)
	if self:MobId(args.sourceGUID) ~= 61340 then return end -- Don't announce casts done by trash mobs

	if self:Me(args.destGUID) or self:Dispeller("magic", nil, args.spellId) then
		self:TargetMessageOld(args.spellId, args.destName, "red")
		self:TargetBar(args.spellId, 20, args.destName, 66054, args.spellId) -- Hex
	end
end

function mod:HexOfLethargyRemoved(args)
	if self:MobId(args.sourceGUID) ~= 61340 then return end

	self:StopBar(66054, args.destName) -- Hex
end

function mod:Heal(args)
	if self:MobId(args.sourceGUID) ~= 61339 then return end -- Don't announce casts done by trash mobs

	local heal = self:SpellName(33144)
	self:MessageOld("heal", "orange", "alert", CL.other:format(args.sourceName, heal), args.spellId)
	self:CastBar("heal", 4, heal, args.spellId)
end

function mod:HealStop(args)
	if args.extraSpellId == 118940 and self:MobId(args.destGUID) == 61339 then
		local heal = self:SpellName(33144)
		self:StopBar(CL.cast:format(heal))
	end
end

function mod:Deaths(args)
	deaths = deaths + 1
	if deaths == 5 then
		self:Win()
	else
		self:MessageOld("stages", "green", "info", CL.mob_killed:format(args.destName, deaths, 5), false)
	end
end
