--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Commander Tharbek", 1358, 1228)
if not mod then return end
mod:RegisterEnableMob(79912, 80098) -- Commander Tharbek, Ironbarb Skyreaver
mod:SetEncounterID(1759)
mod:SetRespawnTime(26)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		161833, -- Noxious Spit
		162090, -- Imbued Iron Axe
		161989, -- Iron Reaver
		161882, -- Incinerating Breath
	}, nil, {
		[161989] = CL.charge, -- Iron Reaver (Charge)
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_TARGETABLE_CHANGED", nil, "boss1", "boss2")
	self:Log("SPELL_AURA_APPLIED", "NoxiousSpit", 161833)
	self:Log("SPELL_CAST_SUCCESS", "ImbuedIronAxe", 162090)
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1", "boss2")
	self:Death("IronbarbSkyreaverDeath", 80098) -- Ironbarb Skyreaver
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_TARGETABLE_CHANGED(_, unit)
	if self:MobId(self:UnitGUID(unit)) == 79912 and UnitCanAttack("player", unit) then
		self:Message("stages", "cyan", self.displayName, "ability_warrior_endlessrage")
		self:PlaySound("stages", "info")
	end
end

function mod:NoxiousSpit(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId, "underyou")
		self:PlaySound(args.spellId, "underyou")
	end
end

function mod:ImbuedIronAxe(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 161989 then -- Iron Reaver
		self:Message(spellId, "red", CL.charge)
		self:CDBar(spellId, 19, CL.charge) -- 19.4-22.7s
	elseif spellId == 161882 then -- Incinerating Breath
		self:Message(spellId, "orange", CL.incoming:format(self:SpellName(spellId)))
		self:CDBar(spellId, 20)
		self:PlaySound(spellId, "long")
	end
end

function mod:IronbarbSkyreaverDeath()
	self:StopBar(161882) -- Incinerating Breath
end
