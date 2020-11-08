
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Yalnu", 1279, 1210)
if not mod then return end
mod:RegisterEnableMob(83846)
mod.engageId = 1756
--mod.respawnTime = 0 -- wiping teleports you out, then you can retry immediately

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		169613, -- Genesis
		169179, -- Colossal Blow
		169251, -- Entanglement
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Genesis", 169613)
	self:Log("SPELL_CAST_START", "ColossalBlow", 169179)
	self:Log("SPELL_CAST_SUCCESS", "Entanglement", 169251)
end

function mod:OnEngage()
	self:CDBar(169613, 26) -- Genesis
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Genesis(args)
	self:MessageOld(args.spellId, "yellow", "long")
	self:Bar(args.spellId, 17, CL.cast:format(args.spellName))
	self:Bar(args.spellId, 60)
end

function mod:ColossalBlow(args)
	self:MessageOld(args.spellId, "orange", "warning")
end

function mod:Entanglement(args)
	self:MessageOld(args.spellId, "green", "info")
end
