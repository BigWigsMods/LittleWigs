
-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Baron Silverlaine", 764, 97)
if not mod then return end
mod:RegisterEnableMob(3887)
mod.engageId = 1070

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		93857, --Summon Worgen Spirit
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "WorgenSpirit", 93857)
end

--[[function mod:VerifyEnable()
	if GetInstanceDifficulty() == 2 then return true end
end]]

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:WorgenSpirit(args)
	self:Message(args.spellId, "Important")
end
