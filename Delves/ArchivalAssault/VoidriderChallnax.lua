--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Voidrider Challnax", 2803)
if not mod then return end
mod:RegisterEnableMob(
	244382, -- Voidripper
	244320 -- Voidrider Challnax
)
mod:SetEncounterID(3330)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.voidripper = "Voidripper"
	L.voidrider_challnax = "Voidrider Challnax"
	L.stages_icon = "inv_112_etherealwraps_basic_original"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.voidrider_challnax
end

function mod:GetOptions()
	return {
		"stages",
		-- Voidripper
		1238892, -- Null Breath
		1238909, -- Umbral Devastation
		-- Voidrider Challnax
		1239134, -- Cosmic Tranquilization
		1238919, -- Void Empowerment
		1238930, -- Impale
	}, {
		[1238892] = L.voidripper,
		[1239134] = L.voidrider_challnax,
	}
end

function mod:OnBossEnable()
	-- Voidripper
	self:Log("SPELL_CAST_START", "NullBreath", 1238892)
	self:Log("SPELL_CAST_START", "UmbralDevastation", 1238909)
	self:Death("VoidripperDeath", 244382)

	-- Voidrider Challnax
	self:RegisterUnitEvent("UNIT_TARGETABLE_CHANGED", nil, "boss2")
	self:Log("SPELL_CAST_START", "CosmicTranquilization", 1239134)
	self:Log("SPELL_CAST_START", "VoidEmpowerment", 1238919)
	self:Log("SPELL_CAST_START", "Impale", 1238930)
	self:Death("VoidriderChallnaxDeath", 244320)
end

function mod:OnEngage()
	self:SetStage(1)
	self:CDBar(1238892, 10.5) -- Null Breath
	self:CDBar(1238909, 20.2) -- Umbral Devastation
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Voidripper

function mod:NullBreath(args)
	self:Message(args.spellId, "red")
	self:CDBar(args.spellId, 14.5)
	self:PlaySound(args.spellId, "alarm")
end

function mod:UmbralDevastation(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 18.2)
	self:PlaySound(args.spellId, "info")
end

function mod:VoidripperDeath()
	self:StopBar(1238892) -- Null Breath
	self:StopBar(1238909) -- Umbral Devastation
	-- Void Empowerment is cast on Voidripper by Voidrider Challnax
	self:StopBar(1238919) -- Void Empowerment
end

-- Voidrider Challnax

function mod:UNIT_TARGETABLE_CHANGED(event, unit)
	if UnitCanAttack("player", unit) and self:MobId(self:UnitGUID(unit)) == 244320 then -- Voidrider Challnax
		self:UnregisterUnitEvent(event, unit)
		self:SetStage(2)
		self:Message("stages", "cyan", CL.other:format(CL.stage:format(2), L.voidrider_challnax), L.stages_icon)
		self:CDBar(1239134, 3.6) -- Cosmic Tranquilization
		self:CDBar(1238919, 6.0) -- Void Empowerment
		self:CDBar(1238930, 7.2) -- Impale
		self:PlaySound("stages", "long")
	end
end

function mod:CosmicTranquilization(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 15.8)
	self:PlaySound(args.spellId, "alert")
end

function mod:VoidEmpowerment(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 20.2)
	self:PlaySound(args.spellId, "alert")
end

function mod:Impale(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 12.2)
	self:PlaySound(args.spellId, "info")
end

function mod:VoidriderChallnaxDeath()
	self:StopBar(1239134) -- Cosmic Tranquilization
	self:StopBar(1238919) -- Void Empowerment
	self:StopBar(1238930) -- Impale
end
