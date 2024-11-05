if not BigWigsLoader.isVanilla and not BigWigsLoader.isRetail then return end -- not an encounter in Cataclysm
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Postmaster Malown", 329, 2633)
if not mod then return end
mod:RegisterEnableMob(11143) -- Postmaster Malown
mod:SetEncounterID(mod:Retail() and 1885 or 2798)
--mod:SetRespawnTime(0) resets, doesn't respawn

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		6253, -- Backhand
		{12741, "DISPEL"}, -- Curse of Weakness
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Backhand", 6253)
	self:Log("SPELL_CAST_SUCCESS", "CurseOfWeakness", 12741)
	self:Log("SPELL_AURA_APPLIED", "CurseOfWeaknessApplied", 12741)
	if self:Heroic() then -- no encounter events in Timewalking
		self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
		self:Death("Win", 11143)
	end
end

function mod:OnEngage()
	self:CDBar(6253, 9.7) -- Backhand
	self:CDBar(12741, 10.6) -- Curse of Weakness
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Backhand(args)
	self:Message(args.spellId, "purple")
	self:CDBar(args.spellId, 7.3)
	self:PlaySound(args.spellId, "alert")
end

function mod:CurseOfWeakness(args)
	self:CDBar(args.spellId, 14.6)
end

function mod:CurseOfWeaknessApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("curse", nil, args.spellId) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end
