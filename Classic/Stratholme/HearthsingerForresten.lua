--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Hearthsinger Forresten", 329, 443)
if not mod then return end
mod:RegisterEnableMob(10558) -- Hearthsinger Forresten
mod:SetEncounterID(473)
--mod:SetRespawnTime(0) resets, doesn't respawn

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{16798, "DISPEL"}, -- Enchanting Lullaby
		16244, -- Demoralizing Shout
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "EnchantingLullaby", 16798)
	self:Log("SPELL_AURA_APPLIED", "EnchantingLullabyApplied", 16798)
	self:Log("SPELL_CAST_SUCCESS", "DemoralizingShout", 16244)
	if self:Heroic() then -- no encounter events in Timewalking
		self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
		self:Death("Win", 10558)
	end
end

function mod:OnEngage()
	self:CDBar(16244, 8.0) -- Demoralizing Shout
	if not self:Solo() then
		self:CDBar(16798, 9.5) -- Enchanting Lullaby
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:EnchantingLullaby(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 11.1)
	self:PlaySound(args.spellId, "alert")
end

function mod:EnchantingLullabyApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("magic", nil, args.spellId) then
		self:TargetMessage(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
	end
end

function mod:DemoralizingShout(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 11.0)
	self:PlaySound(args.spellId, "alert")
end
