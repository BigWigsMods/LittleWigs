
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Hylbrande", 2441, 2448)
if not mod then return end
mod:RegisterEnableMob(175663) -- Hylbrande
mod.engageId = 2426
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		346971, -- [DNT] Summon Vault Defender
		{346116, "TANK"}, -- Shearing Swings
		347094, -- Titanic Crash
		346957, -- Purged by Fire
		346766, -- Sanitizing Cycle
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Log("SPELL_CAST_SUCCESS", "ShearingSwings", 346116)
	self:Log("SPELL_CAST_START", "TitanicCrash", 347094)
	self:Log("SPELL_CAST_START", "PurgedByFire", 346957)
	self:Log("SPELL_CAST_START", "SanitizingCycle", 346766)
end

function mod:OnEngage()

end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 346971 then -- [DNT] Summon Vault Defender
		self:Message(spellId, "yellow", CL.add_spawned)
		self:PlaySound(spellId, "info")
	end
end

function mod:ShearingSwings(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
end

function mod:TitanicCrash(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:PurgedByFire(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end

function mod:SanitizingCycle(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "long")
end
