--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Vanessa VanCleef", 36, 95)
if not mod then return end
mod:RegisterEnableMob(
	49564, -- A Note From Vanessa
	49541 -- Vanessa VanCleef
)
mod:SetEncounterID(1081)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local powderExplosionNext = nil

--------------------------------------------------------------------------------
-- Initialization
--

local autotalk = mod:AddAutoTalkOption(true, "boss")
function mod:GetOptions()
	return {
		autotalk,
		-- Vanessa VanCleef
		92614, -- Deflection
		95542, -- Vengeance of VanCleef
		-2063, -- Fiery Blaze
		-2065, -- Powder Explosion
		-- Defias Blood Wizard
		90932, -- Ragezone
	}, {
		[92614] = self.displayName, -- Vanessa VanCleef
		[90932] = -2075, -- Defias Blood Wizard
	}
end

function mod:OnBossEnable()
	-- Autotalk
	self:RegisterEvent("GOSSIP_SHOW")

	-- Vanessa VanCleef
	self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1")
	self:Log("SPELL_AURA_APPLIED", "Deflection", 92614)
	self:Log("SPELL_AURA_APPLIED", "VengeanceOfVanCleef", 95542)
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE") -- Fiery Blaze
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1") -- Powder Explosion

	-- Defias Blood Wizard
	self:Log("SPELL_CAST_START", "Ragezone", 90932)
end

function mod:OnEngage()
	powderExplosionNext = nil
	self:CDBar(92614, 10.9) -- Deflection
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Autotalk

function mod:GOSSIP_SHOW()
	if self:GetOption(autotalk) then
		if self:GetGossipID(39764) then
			-- 39764:Continue reading... <Note: This will alert Vanessa to your presence!>
			self:SelectGossipID(39764)
		end
	end
end

-- Vanessa VanCleef

function mod:UNIT_HEALTH(event, unit)
	if self:MobId(self:UnitGUID(unit)) == 49541 then -- Vanessa VanCleef
		-- Vanessa stops casting Deflection below 25% HP
		if self:GetHealth(unit) < 25 then
			self:StopBar(92614) -- Deflection
			self:UnregisterUnitEvent(event, unit)
		end
	end
end

function mod:Deflection(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 10, CL.onboss:format(args.spellName))
	self:CDBar(args.spellId, 41.1)
end

function mod:VengeanceOfVanCleef(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE()
	if not self:IsEngaged() or powderExplosionNext then
		-- ignore the emotes during the pre-boss event, and ignore the emote
		-- when the boss casts Powder Explosion.
		return
	end
	self:Message(-2063, "red") -- Fiery Blaze
	self:PlaySound(-2063, "warning")
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 96280 then -- Vanessa Cosmetic Bomb State
		powderExplosionNext = true
		self:StopBar(92614) -- Deflection
		self:Message(-2065, "orange", CL.percent:format(1, self:SpellName(-2065))) -- Powder Explosion
		self:PlaySound(-2065, "alarm")
	end
end

-- Defias Blood Wizard

function mod:Ragezone(args)
	self:Message(args.spellId, "green")
	self:PlaySound(args.spellId, "info")
end
