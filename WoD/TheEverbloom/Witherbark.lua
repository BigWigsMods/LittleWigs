
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Witherbark", 1279, 1214)
if not mod then return end
mod:RegisterEnableMob(81522)
mod.engageId = 1746
mod.respawnTime = 20

--------------------------------------------------------------------------------
-- Locals
--

local energy = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.energyStatus = "A Globule reached Witherbark: %d%% energy"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		164294, -- Unchecked Growth
		164275, -- Brittle Bark
		{164357, "TANK"}, -- Parched Gasp
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "UncheckedGrowth", 164294)
	self:Log("SPELL_AURA_APPLIED", "BrittleBark", 164275)
	self:Log("SPELL_AURA_REMOVED", "BrittleBarkOver", 164275)
	self:Log("SPELL_CAST_SUCCESS", "Energize", 164438)
	self:Log("SPELL_CAST_START", "ParchedGasp", 164357)

	self:Log("SPELL_CAST_SUCCESS", "UncheckedGrowthSpawned", 181113) -- Encounter Spawn
end

function mod:OnEngage()
	energy = 0
	self:CDBar(164357, 7) -- Parched Gasp
	self:Bar(164275, 30) -- Brittle Bark
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UncheckedGrowth(args)
	if self:Me(args.destGUID) then
		self:MessageOld(args.spellId, "blue", "alarm", CL.you:format(args.spellName))
	end
end

function mod:BrittleBark(args)
	energy = 0
	self:MessageOld(args.spellId, "yellow", "info", ("%s - %s"):format(args.spellName, CL.incoming:format(self:SpellName(-10100)))) -- 10100 = Aqueous Globules
	self:StopBar(164357) -- Parched Gasp
end

function mod:BrittleBarkOver(args)
	self:MessageOld(args.spellId, "yellow", "info", CL.over:format(args.spellName))
	self:Bar(args.spellId, 30)
	self:CDBar(164357, 4) -- Parched Gasp
end

function mod:Energize()
	if self.isEngaged then -- This happens when killing the trash, we only want it during the encounter.
		energy = energy + 25
		if energy < 101 then
			self:MessageOld(164275, "cyan", nil, L.energyStatus:format(energy), "spell_lightning_lightningbolt01")
		end
	end
end

function mod:ParchedGasp(args)
	self:MessageOld(args.spellId, "red")
	self:CDBar(args.spellId, 11) -- 10-13s
end

function mod:UncheckedGrowthSpawned()
	self:MessageOld(164294, "orange", nil, CL.add_spawned)
end
