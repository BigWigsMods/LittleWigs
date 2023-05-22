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
local castingScreech = false

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		{40184, "FLASH", "CASTBAR"}, -- Paralyzing Screech
		40303, -- Spell Bomb
		-5252, -- Cyclone of Feathers
		-5253, -- Brood of Anzu
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ParalyzingScreech", 40184)
	self:Log("SPELL_CAST_SUCCESS", "ParalyzingScreechStop", 40184)
	self:Log("SPELL_AURA_APPLIED", "SpellBomb", 40303)
	self:Log("SPELL_AURA_APPLIED", "CycloneOfFeathers", 40321)

	if self:Classic() then
		self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
		self:RegisterEvent("UNIT_HEALTH")
	else
		self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
		self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1")
	end
	self:Death("AddDied", 23132)
end

function mod:OnEngage()
	nextBroodWarning = 80 -- 75% and 35%
	addsAlive = 0
	castingScreech = false
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:ParalyzingScreech(args)
	castingScreech = true
	self:MessageOld(args.spellId, "red", "warning", CL.casting:format(args.spellName))
	self:CastBar(args.spellId, 5)
	self:Flash(args.spellId)
end

function mod:ParalyzingScreechStop(args)
	castingScreech = false
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
	if addsAlive == 0 and not castingScreech then -- he doesn't unbanish himself if you kill the last add when he's casting Paralyzing Screech
		self:StopBar(CL.onboss:format(self:SpellName(42354))) -- Banish Self
	end
end

do
	local prev
	function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, castId, spellId)
		if spellId == 42354 and castId ~= prev then -- Banish Self
			prev = castId
			addsAlive = addsAlive + 7
			self:Bar(-5253, 45, CL.onboss:format(self:SpellName(spellId)), spellId)
			self:MessageOld(-5253, "orange", nil, CL.incoming:format(self:SpellName(-5253))) -- Brood of Anzu
		end
	end
end

function mod:UNIT_HEALTH(event, unit)
	if self:MobId(self:UnitGUID(unit)) == 23035 then
		local hp = self:GetHealth(unit)
		if hp < nextBroodWarning then
			self:MessageOld(-5253, "orange", nil, CL.soon:format(self:SpellName(42354)), 42354) -- Banish Self
			nextBroodWarning = nextBroodWarning - 40

			if nextBroodWarning < 15 then
				if self:Classic() then
					self:UnregisterEvent(event)
				else
					self:UnregisterUnitEvent(event, unit)
				end
			end
		end
	end
end
