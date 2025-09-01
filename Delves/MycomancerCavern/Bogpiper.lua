--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Bogpiper", 2679)
if not mod then return end
mod:RegisterEnableMob(
	220314, -- Bogpiper
	247446 -- Bogpiper (Ethereal Routing Station)
)
mod:SetEncounterID(2960)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.bogpiper = "Bogpiper"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.bogpiper
	self:SetSpellRename(454213, CL.charge) -- Muck Charge (Charge)
end

function mod:GetOptions()
	return {
		454213, -- Muck Charge
		470582, -- Swamp Bolt
		453897, -- Sporesong
		427710, -- Sporesplosion
	},nil,{
		[454213] = CL.charge, -- Muck Charge (Charge)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "MuckCharge", 454213)
	self:Log("SPELL_CAST_START", "SwampBolt", 470582)
	self:Log("SPELL_CAST_START", "Sporesong", 453897)

	-- Sporbit
	self:Log("SPELL_CAST_START", "Sporesplosion", 427710)

	-- Ethereal Routing Station
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1", "boss2", "boss3") -- Teleported
end

function mod:OnEngage()
	self:CDBar(454213, 5.7, CL.charge) -- Muck Charge
	self:CDBar(470582, 10.5) -- Swamp Bolt
	self:CDBar(453897, 15.0) -- Sporesong
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, unit, _, spellId)
	if spellId == 1243416 and self:MobId(self:UnitGUID(unit)) == 247446 then -- Teleported
		-- check mobId because Ethereal Routing Station can have up to 3 bosses engaged at once
		self:Win()
	end
end

function mod:MuckCharge(args)
	self:Message(args.spellId, "red", CL.charge)
	self:CDBar(args.spellId, 25.0, CL.charge)
	self:PlaySound(args.spellId, "alarm")
end

function mod:SwampBolt(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 26.7)
	self:PlaySound(args.spellId, "alert")
end

function mod:Sporesong(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 27.9)
	self:PlaySound(args.spellId, "long")
end

-- Sporbit

do
	local prev = 0
	function mod:Sporesplosion(args)
		if args.time - prev > 2.5 then
			prev = args.time
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end
