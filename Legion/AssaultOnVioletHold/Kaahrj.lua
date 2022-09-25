
--------------------------------------------------------------------------------
-- TODO List:
-- - Used an old log (16-09-01), timers might have changed
-- - Might be missing Important spells

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Kaahrj", 1544, 1686)
if not mod then return end
mod:RegisterEnableMob(101950)
mod.engageId = 1846

--------------------------------------------------------------------------------
-- Locals
--


--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		201148, -- Doom
		201146, -- Hysteria
		201153, -- Eternal Darkness
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Doom", 201148)
	self:Log("SPELL_AURA_APPLIED", "Hysteria", 201146)
	self:Log("SPELL_CAST_START", "EternalDarkness", 201153)
end

function mod:OnEngage()
	self:Bar(201148, 7) -- Doom
	self:Bar(201146, 15) -- Hysteria
	self:Bar(201153, 15) -- Eternal Darkness
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Doom(args)
	self:MessageOld(args.spellId, "yellow", "info")
	self:CDBar(args.spellId, 11)
end

function mod:Hysteria(args)
	self:TargetMessageOld(args.spellId, args.destName, "orange", "alarm", nil, nil, self:Dispeller("magic"))
	self:CDBar(args.spellId, 20)
end

function mod:EternalDarkness(args)
	self:MessageOld(args.spellId, "red", "long", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 40)
end
