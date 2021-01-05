--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Erekem", 608, 626)
if not mod then return end
mod:RegisterEnableMob(
	29315, -- Erekem
	32226 -- Arakkoa Windwalker (replacement boss)
)
-- mod.engageId = 0 -- no IEEU and ENCOUNTER_* events
-- mod.respawnTime = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{54479, "DISPEL"}, -- Earth Shield
		54481, -- Chain Heal
		54516, -- Bloodlust
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "EarthShield", 54479, 59471) -- Normal, Heroic
	self:Log("SPELL_CAST_START", "ChainHeal", 54481, 59473) -- Normal, Heroic
	self:Log("SPELL_CAST_SUCCESS", "Bloodlust", 54516)

	self:Death("Win", 29315, 32226)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:EarthShield(args)
	if bit.band(args.destFlags, 0x400) ~= 0 then return end -- COMBATLOG_OBJECT_TYPE_PLAYER

	if self:Dispeller("magic", true, 54479) then
		self:Message(54479, "yellow", CL.onboss:format(args.spellName))
		self:PlaySound(54479, "alert")
	end
end

function mod:ChainHeal(args)
	self:CDBar(54481, 10.9)
	self:Message(54481, "orange", CL.casting:format(args.spellName))
	if self:Interrupter() then
		self:PlaySound(54481, "warning")
	end
end

function mod:Bloodlust(args)
	self:Message(args.spellId, "red", CL.onboss:format(args.spellName))
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 32.8)
end
