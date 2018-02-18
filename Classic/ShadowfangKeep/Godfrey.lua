
-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Lord Godfrey", 33, 100)
if not mod then return end
mod:RegisterEnableMob(46964)
mod.engageId = 1072

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		93675, -- Mortal Wound
		93707, -- Summon Bloodthirsty Ghouls
		93520, -- Pistol Barrage
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "MortalWound", 93675)
	self:Log("SPELL_AURA_APPLIED", "BloodthirstyGhouls", 93707)
	self:Log("SPELL_CAST_START", "PistolBarrage", 93520)
end

--[[function mod:VerifyEnable()
	if GetInstanceDifficulty() == 2 then return true end
end]]

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:MortalWound(args)
	self:TargetMessage(args.spellId, args.destName, "Attention")
end

function mod:BloodthirstyGhouls(args)
	self:Message(args.spellId, "Attention", "Info")
end

function mod:PistolBarrage(args)
	self:Message(args.spellId, "Important", "Alert")
	self:Bar(args.spellId, 30)
end
