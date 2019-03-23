
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Infested Crawg", 1841, 2131)
if not mod then return end
mod:RegisterEnableMob(131817)
mod.engageId = 2118

--------------------------------------------------------------------------------
-- Locals
--

local firstCast = true

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.random_cast = "Random Cast"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		260292, -- Charge
		260793, -- Indigestion
		260333, -- Tantrum
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Charge", 260292)
	self:Log("SPELL_CAST_START", "Indigestion", 260793)

	-- Heroic+
	self:Log("SPELL_CAST_SUCCESS", "Tantrum", 260333)
end

function mod:OnEngage()
	firstCast = true
	self:CDBar(260292, 8, L.random_cast) -- Charge
	if not self:Normal() then
		self:Bar(260333, 45) -- Tantrum
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Charge(args)
	self:Message2(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert", "watchstep")
	if firstCast then
		firstCast = false
		self:Bar(args.spellId, 23)
		self:Bar(260793, 11) -- Indigestion
	end
end

function mod:Indigestion(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "warning", "mobsoon")
	if firstCast then
		firstCast = false
		self:Bar(260292, 12, CL.count:format(self:SpellName(260292), 1)) -- Charge
		self:Bar(260292, 32, CL.count:format(self:SpellName(260292), 2)) -- Charge
	end
end

function mod:Tantrum(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "long", "mobsoon")
	self:CDBar(args.spellId, 45)
	self:Bar(260292, 18, L.random_cast) -- Charge
	firstCast = true
end
