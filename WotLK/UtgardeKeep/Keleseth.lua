-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Prince Keleseth", 574, 638)
if not mod then return end
--mod.otherMenu = "Howling Fjord"
mod:RegisterEnableMob(23953)
mod.engageId = 2026

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		48400, -- Ice Tomb
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "IceTomb", 48400)
	self:Log("SPELL_AURA_REMOVED", "IceTombRemoved", 48400)
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:IceTomb(player, spellId, _, _, spellName)
	self:Message(48400, spellName..": "..player, "Urgent", spellId)
	self:Bar(48400, player..": "..spellName, 20, spellId)
end

function mod:IceTombRemoved(player, _, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, player..": "..spellName)
end
