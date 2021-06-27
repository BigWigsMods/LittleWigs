
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Hylbrande", 2441, 2448)
if not mod then return end
mod:RegisterEnableMob(175663) -- Hylbrande
mod:SetEncounterID(2426)
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
	self:Log("SPELL_AURA_REMOVED", "SanitizingCycleRemoved", 346766)
end

function mod:OnEngage()
	self:Bar(346116, 8.1) -- Shearing Swings
	self:Bar(346957, 10.5) -- Purged by Fire
	self:Bar(347094, 15.4) -- Titanic Crash
	self:Bar(346971, 19, CL.adds) -- [DNT] Summon Vault Defender
	self:Bar(346766, 38.8) -- Sanitizing Cycle
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 346971 then -- [DNT] Summon Vault Defender
		self:Message(spellId, "yellow", CL.add_spawned)
		self:PlaySound(spellId, "info")
		if self:BarTimeLeft(346766) > 29.1 then -- Sanitizing Cycle
			self:Bar(spellId, 29.1, CL.adds)
		end
	end
end

function mod:ShearingSwings(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	if self:BarTimeLeft(346766) > 10.9 then -- Sanitizing Cycle
		self:CDBar(args.spellId, 10.9)
	end
end

function mod:TitanicCrash(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	if self:BarTimeLeft(346766) > 23.1 then -- Sanitizing Cycle
		self:Bar(args.spellId, 23.1)
	end
end

function mod:PurgedByFire(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	if self:BarTimeLeft(346766) > 17 then -- Sanitizing Cycle
		self:Bar(args.spellId, 17)
	end
end

function mod:SanitizingCycle(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "long")
	self:StopBar(args.spellId)
	self:StopBar(346116) -- Shearing Swings
	self:StopBar(346957) -- Purged by Fire
	self:StopBar(CL.adds) -- [DNT] Summon Vault Defender
	self:StopBar(347094) -- Titanic Crash
end

function mod:SanitizingCycleRemoved(args)
	self:Message(args.spellId, "cyan", CL.over:format(args.spellName))
	self:PlaySound(args.spellId, "long")
	self:Bar(args.spellId, 70)
	self:Bar(346116, 16.6) -- Shearing Swings
	self:Bar(346957, 19.2) -- Purged by Fire
	self:Bar(346971, 20.3, CL.adds) -- [DNT] Summon Vault Defender
	self:Bar(347094, 22.8) -- Titanic Crash
end
