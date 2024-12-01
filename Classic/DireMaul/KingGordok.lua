--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("King Gordok", 429, 417)
if not mod then return end
mod:RegisterEnableMob(11501) -- King Gordok
mod:SetEncounterID(368)
--mod:SetRespawnTime(0) resets, doesn't respawn

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		22886, -- Berserker Charge
		{15572, "TANK"}, -- Sunder Armor
		{16856, "TANK_HEALER"}, -- Mortal Strike
		16727, -- War Stomp
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "BerserkerCharge", 22886)
	self:Log("SPELL_CAST_SUCCESS", "SunderArmor", 15572)
	self:Log("SPELL_CAST_SUCCESS", "MortalStrike", 16856)
	self:Log("SPELL_CAST_SUCCESS", "WarStomp", 16727)
end

function mod:OnEngage()
	self:CDBar(22886, 9.4) -- Berserker Charge
	self:CDBar(15572, 17.9) -- Sunder Armor
	self:CDBar(16856, 19.1) -- Mortal Strike
	self:CDBar(16727, 28.8) -- War Stomp
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:BerserkerCharge(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:CDBar(args.spellId, 18.2)
	self:PlaySound(args.spellId, "info", nil, args.destName)
end

function mod:SunderArmor(args)
	if self:MobId(args.sourceGUID) == 11501 then -- King Gordok
		self:Message(args.spellId, "purple")
		self:CDBar(args.spellId, 6.1)
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:MortalStrike(args)
	self:Message(args.spellId, "purple")
	self:CDBar(args.spellId, 8.5)
	self:PlaySound(args.spellId, "alarm")
end

function mod:WarStomp(args)
	if self:MobId(args.sourceGUID) == 11501 then -- King Gordok
		self:Message(args.spellId, "red")
		self:CDBar(args.spellId, 26.7)
		self:PlaySound(args.spellId, "alarm")
	end
end
