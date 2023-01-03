--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ner'zhul", 1176, 1160)
if not mod then return end
mod:RegisterEnableMob(76407)
mod:SetEncounterID(1682)
mod:SetRespawnTime(33)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		154442, -- Malevolence
		154350, -- Omen of Death
		-9680, -- Ritual of Bones
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Malevolence", 154442)
	self:Log("SPELL_SUMMON", "OmenOfDeath", 154350)
	self:Log("SPELL_CAST_SUCCESS", "RitualOfBones", 154671)
end

function mod:OnEngage()
	self:CDBar(154442, 5.7) -- Malevolence
	self:CDBar(154350, 6.1) -- Omen of Death
	self:CDBar(-9680, 20.6) -- Ritual of Bones
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Malevolence(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 8.5)
end

function mod:OmenOfDeath(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 10.9)
end

function mod:RitualOfBones(args)
	self:Message(-9680, "orange")
	self:PlaySound(-9680, "warning")
	self:CDBar(-9680, 50.5)
	-- ritual of bones puts a CD on omen of death
	self:CDBar(154350, 25.4) -- Omen of Death
end
