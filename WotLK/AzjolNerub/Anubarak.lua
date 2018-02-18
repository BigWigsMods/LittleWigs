-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Anub'arakAN", 533, 587) -- AN (AnzolNerub) is intentional to prevent conflict with Anub'arak from The Coliseum
if not mod then return end
mod.displayName = "Anub'arak"
--mod.otherMenu = "Dragonblight"
mod:RegisterEnableMob(29120)

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		53472, -- Pound
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Pound", 53472, 59433)
	self:Death("Win", 29120)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Pound(args)
	self:CastBar(53472, 3.2)
	self:Message(53472, "Attention", nil, CL.casting:format(args.spellName))
end
