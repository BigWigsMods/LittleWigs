
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Infested Crawg", 1841, 2131)
if not mod then return end
mod:RegisterEnableMob(131817)
mod.engageId = 2118

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
	self:CDBar(260793, 8) -- Indigestion
	self:CDBar(260292, 21) -- Charge
	if not self:Normal() then
		self:CDBar(260333, 45) -- Tantrum
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Charge(args)
	self:Message2(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert", "watchstep")
	self:CDBar(args.spellId, 20)
end

function mod:Indigestion(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "warning", "mobsoon")
	self:CDBar(args.spellId, 42)
end

function mod:Tantrum(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "long", "mobsoon")
	self:CDBar(args.spellId, 45)
end
