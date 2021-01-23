
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Commander Tharbek", 1358, 1228)
if not mod then return end
mod:RegisterEnableMob(79912, 80098) -- Commander Tharbek, Ironbarb Skyreaver
mod.engageId = 1759
mod.respawnTime = 26

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.iron_reaver = "{161989} ({100})" -- Iron Reaver (Charge)
	L.iron_reaver_desc = 161989
	L.iron_reaver_icon = 161989
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		161833, -- Noxious Spit
		162090, -- Imbued Iron Axe
		"iron_reaver",
		161882, -- Incinerating Breath
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_TARGETABLE_CHANGED", nil, "boss1", "boss2")

	self:Log("SPELL_AURA_APPLIED", "NoxiousSpit", 161833)
	self:Log("SPELL_CAST_SUCCESS", "ImbuedIronAxe", 162090)

	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "IronReaver", "boss1", "boss2")
	self:Death("DragonDies", 80098)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_TARGETABLE_CHANGED(_, unit)
	if self:MobId(self:UnitGUID(unit)) == 79912 and UnitCanAttack("player", unit) then
		self:MessageOld("stages", "cyan", "info", self.displayName, "ability_warrior_endlessrage")
	end
end

function mod:NoxiousSpit(args)
	if self:Me(args.destGUID) then
		self:MessageOld(args.spellId, "blue", "alarm", CL.underyou:format(args.spellName))
	end
end

function mod:ImbuedIronAxe(args)
	self:TargetMessageOld(args.spellId, args.destName, "yellow", "alert")
end

function mod:IronReaver(_, _, _, spellId)
	if spellId == 161989 then -- Iron Reaver
		self:MessageOld("iron_reaver", "red", nil, self:SpellName(100), spellId) -- 100 = "Charge"
		self:CDBar("iron_reaver", 19, self:SpellName(100), spellId) -- 19.4-22.7s
	elseif spellId == 161882 then -- Incinerating Breath
		self:MessageOld(spellId, "orange", "long", CL.incoming:format(self:SpellName(spellId)))
		self:CDBar(spellId, 20)
	end
end

function mod:DragonDies()
	self:StopBar(161882) -- Incinerating Breath
end
