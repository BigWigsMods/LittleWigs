--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Kaigy Maryla", 2875)
if not mod then return end
mod:RegisterEnableMob(238233) -- Kaigy Maryla
mod:SetEncounterID(3170) -- Apprentice
--mod:SetRespawnTime(30)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.kaigy_maryla = "Kaigy Maryla"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.kaigy_maryla
end

function mod:GetOptions()
	return {
		{1222942, "DISPEL"}, -- Flame Shock
		1222943, -- Incendiary Boulder
		1220410, -- Dragon's Breath
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "FlameShock", 1222942)
	self:Log("SPELL_AURA_APPLIED", "FlameShockApplied", 1222942)
	self:Log("SPELL_CAST_START", "IncendiaryBoulder", 1222943)
	self:Log("SPELL_CAST_SUCCESS", "DragonsBreath", 1220410)
end

function mod:OnEngage()
	self:CDBar(1222942, 3.2) -- Flame Shock
	self:CDBar(1222943, 11.3) -- Incendiary Boulder
	self:CDBar(1220410, 11.3) -- Dragon's Breath
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:FlameShock(args)
	self:CDBar(args.spellId, 22.7)
end

function mod:FlameShockApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("magic", nil, args.spellId) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end

function mod:IncendiaryBoulder(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 17.8)
	self:PlaySound(args.spellId, "alarm")
end

function mod:DragonsBreath(args)
	self:TargetMessage(args.spellId, "purple", args.destName)
	self:CDBar(args.spellId, 15.3)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
end
