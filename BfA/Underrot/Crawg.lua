
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Infested Crawg", 1841, 2131)
if not mod then return end
mod:RegisterEnableMob(131817)
mod.engageId = 2118
mod.respawnTime = 25

--------------------------------------------------------------------------------
-- Locals
--

local randomCast = true
local tantrumCount = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.random_cast = "Charge or Indigestion"
	L.random_cast_desc = "The first cast after each Tantrum is random."
	L.random_cast_icon = "inv_misc_questionmark"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"random_cast",
		260292, -- Charge
		260793, -- Indigestion
		260333, -- Tantrum
	}, {
		["random_cast"] = "general",
		[260333] = "heroic",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Charge", 260292)
	self:Log("SPELL_CAST_START", "Indigestion", 260793)

	-- Heroic+
	self:Log("SPELL_CAST_SUCCESS", "Tantrum", 260333)
end

function mod:OnEngage()
	randomCast = true
	tantrumCount = 0
	self:CDBar("random_cast", 8, L.random_cast, "inv_misc_questionmark") -- Charge
	if not self:Normal() then
		self:CDBar(260333, 45) -- Tantrum estimate, updated after the first Charge or Indigestion
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Charge(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert", "watchstep")
	if randomCast then
		randomCast = false
		self:Bar(args.spellId, 23)
		self:Bar(260793, 11) -- Indigestion
		self:Bar(260333, tantrumCount == 0 and 37.6 or 34) -- Tantrum
	end
end

function mod:Indigestion(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning", "mobsoon")
	if randomCast then
		randomCast = false
		if tantrumCount == 0 then -- He'll do two charges if he hasn't tantrumed yet
			self:Bar(260292, 12, CL.count:format(self:SpellName(260292), 1)) -- Charge
			self:Bar(260292, 32, CL.count:format(self:SpellName(260292), 2)) -- Charge
			self:Bar(260333, 43.6) -- Tantrum
		else
			self:Bar(260292, 12) -- Charge
			self:Bar(260333, 26.7) -- Tantrum
		end
	end
end

function mod:Tantrum(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "long", "mobsoon")
	self:CDBar(args.spellId, 45) -- Estimate, updated after the next Charge or Indigestion
	self:Bar("random_cast", 18, L.random_cast, "inv_misc_questionmark") -- Charge
	randomCast = true
	tantrumCount = tantrumCount + 1
end
