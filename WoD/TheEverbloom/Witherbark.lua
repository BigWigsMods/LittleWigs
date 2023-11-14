--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Witherbark", 1279, 1214)
if not mod then return end
mod:RegisterEnableMob(81522) -- Witherbark
mod:SetEncounterID(1746)
mod:SetRespawnTime(30)
mod:SetStage(1)

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
		164275, -- Brittle Bark
		164438, -- Energize
		164357, -- Parched Gasp
		{164294, "ME_ONLY"}, -- Unchecked Growth
		{-10098, "OFF"}, -- Unchecked Growth (Add Spawned)
	}, nil, {
		[-10098] = CL.add_spawned,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "BrittleBark", 164275)
	self:Log("SPELL_AURA_REMOVED", "BrittleBarkOver", 164275)
	self:Log("SPELL_ENERGIZE", "Energize", 164438)
	self:Log("SPELL_CAST_START", "ParchedGasp", 164357)
	self:Log("SPELL_AURA_APPLIED", "UncheckedGrowthApplied", 164302)
	self:Log("SPELL_PERIODIC_DAMAGE", "UncheckedGrowthDamage", 164294)
	self:Log("SPELL_PERIODIC_MISSED", "UncheckedGrowthDamage", 164294)
	self:Log("SPELL_CAST_SUCCESS", "UncheckedGrowthSummon", 164556)
end

function mod:OnEngage()
	self:SetStage(1)
	self:CDBar(164294, 5.8) -- Unchecked Growth
	self:CDBar(164357, 9.7) -- Parched Gasp
	-- cast at 0 energy, 39s energy loss + delay
	self:CDBar(164275, 39.2) -- Brittle Bark
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local energy = 0

	function mod:BrittleBark(args)
		self:SetStage(2)
		energy = 0
		self:Message(args.spellId, "cyan", CL.other:format(args.spellName, CL.incoming:format(self:SpellName(-10100)))) -- 10100 = Aqueous Globules
		self:PlaySound(args.spellId, "long")
		self:StopBar(args.spellId)
		self:StopBar(164357) -- Parched Gasp
		if self:Normal() then
			self:StopBar(164294) -- Unchecked Growth
		end
	end

	function mod:BrittleBarkOver(args)
		self:SetStage(1)
		self:Message(args.spellId, "cyan", CL.over:format(args.spellName))
		self:PlaySound(args.spellId, "long")
		-- cast at 0 energy, 39s energy loss + delay
		self:Bar(args.spellId, 39.3)
		self:CDBar(164357, 3.6) -- Parched Gasp
	end

	function mod:Energize(args)
		if self:IsEngaged() then -- This happens when killing the trash, we only want it during the encounter.
			energy = energy + args.extraSpellId -- args.extraSpellId is the energy gained from SPELL_ENERGIZE
			if energy < 100 then
				self:Message(args.spellId, "cyan", L.energyStatus:format(energy))
				self:PlaySound(args.spellId, "info")
			end
		end
	end
end

function mod:ParchedGasp(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 17.0)
end

function mod:UncheckedGrowthApplied(args)
	self:TargetMessage(164294, "yellow", args.destName)
	self:PlaySound(164294, "alert", nil, args.destName)
	self:CDBar(164294, 12.1)
end

do
	local prev = 0
	function mod:UncheckedGrowthDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 1.5 then
				prev = t
				self:PersonalMessage(args.spellId, "underyou")
				self:PlaySound(args.spellId, "underyou", nil, args.destName)
			end
		end
	end
end

function mod:UncheckedGrowthSummon()
	self:Message(-10098, "orange", CL.add_spawned, false)
	self:PlaySound(-10098, "info")
end
