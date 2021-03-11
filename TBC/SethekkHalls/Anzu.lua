-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Anzu", 556, 542)
if not mod then return end
mod:RegisterEnableMob(23035)
mod.engageId = 1904
-- mod.respawnTime = 0 -- resets, doesn't respawn

-------------------------------------------------------------------------------
--  Locals
--

local nextBroodWarning = 80
local addsAlive = 0

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		{40184, "FLASH"}, -- Paralyzing Screech
		40303, -- Spell Bomb
		-5252, -- Cyclone of Feathers
		-5253, -- Brood of Anzu
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ParalyzingScreech", 40184)
	self:Log("SPELL_AURA_APPLIED", "SpellBomb", 40303)
	self:Log("SPELL_AURA_APPLIED", "CycloneOfFeathers", 40321)

	self:RegisterUnitEvent("UNIT_HEALTH", nil,  "boss1")
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Death("AddDied", 23132)
end

function mod:OnEngage()
	nextBroodWarning = 80 -- 75% and 35%
	addsAlive = 0
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:ParalyzingScreech(args)
	self:MessageOld(args.spellId, "red", "warning", CL.casting:format(args.spellName))
	self:CastBar(args.spellId, 5)
	self:Flash(args.spellId)
end

function mod:SpellBomb(args)
	self:TargetMessageOld(args.spellId, args.destName, "yellow", "alarm", nil, nil, self:Dispeller("curse"))
	self:TargetBar(args.spellId, 8, args.destName)
end

function mod:CycloneOfFeathers(args)
	self:TargetMessageOld(-5252, args.destName, "yellow", "alert")
	self:TargetBar(-5252, 6, args.destName)
end

function mod:AddDied()
	addsAlive = addsAlive - 1
	self:MessageOld(-5253, "green", nil, CL.add_remaining:format(addsAlive))
	if addsAlive == 0 and not UnitCastingInfo("boss1") then -- he doesn't unbanish himself if you kill the last add when he's casting Paralyzing Screech
		self:StopBar(CL.onboss:format(self:SpellName(42354))) -- Banish Self
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 42354 then -- Banish Self
		self:Bar(-5253, 45, CL.onboss:format(self:SpellName(spellId)), spellId)
		self:MessageOld(-5253, "orange", nil, CL.incoming:format(self:SpellName(-5253))) -- Brood of Anzu
		addsAlive = addsAlive + 7
	end
end

function mod:UNIT_HEALTH(event, unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < nextBroodWarning then
		self:MessageOld(-5253, "orange", nil, CL.soon:format(self:SpellName(42354)), 42354) -- Banish Self
		nextBroodWarning = nextBroodWarning - 40

		if nextBroodWarning < 15 then
			self:UnregisterUnitEvent(event, unit)
		end
	end
end
