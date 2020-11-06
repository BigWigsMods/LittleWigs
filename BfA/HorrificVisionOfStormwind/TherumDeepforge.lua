
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Therum Deepforge", 2213)
if not mod then return end
mod:RegisterEnableMob(156577)
mod:SetAllowWin(true)
mod.engageId = 2374

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.therum_deepforge = "Therum Deepforge"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		309671, -- Empowered Forge Breath
	}
end

function mod:OnRegister()
	L.displayName = L.therum_deepforge
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "EmpoweredForgeBreath", 309671)
end

function mod:OnEngage()
	self:Bar(309671, 8.5) -- Empowered Forge Breath
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:EmpoweredForgeBreath(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 14.6)
end
