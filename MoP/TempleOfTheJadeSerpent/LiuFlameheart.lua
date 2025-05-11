--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Liu Flameheart", 960, 658)
if not mod then return end
mod:RegisterEnableMob(
	56732, -- Liu Flameheart
	56762 -- Yu'lon
)
mod:SetEncounterID(1416)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Initialization
--

if mod:Retail() then -- Dragonflight+
	function mod:GetOptions()
		return {
			"stages",
			-- Stage 1: Serpent Dance
			106823, -- Serpent Strike
			106856, -- Serpent Kick
			-- Stage 2: Jade Serpent Dance
			106841, -- Jade Serpent Strike
			106864, -- Jade Serpent Kick
			118540, -- Jade Serpent Wave
			-- Stage 3: The Jade Serpent
			396907, -- Jade Fire Breath
			107045, -- Jade Fire
		}, {
			[106823] = CL.other:format(CL.stage:format(1), self:SpellName(-5501)), -- Stage 1: Serpent Dance
			[106841] = CL.other:format(CL.stage:format(2), self:SpellName(-5505)), -- Stage 2: Jade Serpent Dance
			[396907] = CL.other:format(CL.stage:format(3), self:SpellName(-5509)), -- Stage 3: The Jade Serpent
		}
	end
else -- Classic Mists through Shadowlands
	function mod:GetOptions()
		return {
			"stages",
			-- Stage 1: Serpent Dance
			106823, -- Serpent Strike
			-- Stage 2: Jade Serpent Dance
			106841, -- Jade Serpent Strike
			118540, -- Jade Serpent Wave
			-- Stage 3: The Jade Serpent
			107045, -- Jade Fire
		}, {
			[106823] = CL.other:format(CL.stage:format(1), self:SpellName(-5501)), -- Stage 1: Serpent Dance
			[106841] = CL.other:format(CL.stage:format(2), self:SpellName(-5505)), -- Stage 2: Jade Serpent Dance
			[107045] = CL.other:format(CL.stage:format(3), self:SpellName(-5509)), -- Stage 3: The Jade Serpent
		}
	end
end

function mod:OnBossEnable()
	-- Stages
	self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1")
	self:Log("SPELL_CAST_SUCCESS", "JadeEssence", 106797)
	if self:Retail() then -- Dragonflight+
		self:Log("SPELL_CAST_SUCCESS", "EncounterEvent", 181089) -- Summon Jade Serpent
	else -- Classic Mists through Shadowlands
		self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "UNIT_SPELLCAST_SUCCEEDED_CLASSIC", "boss1") -- Summon Jade Serpent
	end

	-- Stage 1: Serpent Dance
	if self:Retail() then -- Dragonflight+
		self:Log("SPELL_CAST_START", "SerpentStrike", 106823)
	end
	self:Log("SPELL_CAST_SUCCESS", "SerpentStrikeSuccess", 106823)
	self:Log("SPELL_AURA_APPLIED", "SerpentStrikeApplied", 106823)
	if self:Retail() then -- Dragonflight+
		self:Log("SPELL_CAST_START", "SerpentKick", 106856)
	end

	-- Stage 2: Jade Serpent Dance
	if self:Retail() then -- Dragonflight+
		self:Log("SPELL_CAST_START", "JadeSerpentStrike", 106841)
	end
	self:Log("SPELL_CAST_SUCCESS", "JadeSerpentStrikeSuccess", 106841)
	self:Log("SPELL_AURA_APPLIED", "JadeSerpentStrikeApplied", 106841)
	if self:Retail() then -- Dragonflight+
		self:Log("SPELL_CAST_START", "JadeSerpentKick", 106864)
	end
	self:Log("SPELL_PERIODIC_DAMAGE", "JadeSerpentWaveDamage", 118540)
	self:Log("SPELL_PERIODIC_MISSED", "JadeSerpentWaveDamage", 118540)

	-- Stage 3: The Jade Serpent
	if self:Retail() then -- Dragonflight+
		self:Log("SPELL_CAST_START", "JadeFireBreath", 396907)
		self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss2") -- Jade Fire
	else -- Classic Mists through Shadowlands
		self:Log("SPELL_CAST_SUCCESS", "JadeFire", 107045)
	end
	self:Log("SPELL_AURA_APPLIED", "JadeFireDamage", 107110)
	self:Log("SPELL_DAMAGE", "JadeFireDamage", 107110)
	self:Log("SPELL_MISSED", "JadeFireDamage", 107110)
end

function mod:OnEngage()
	self:SetStage(1)
	if self:Retail() then -- Dragonflight+
		if self:Tank() then
			self:CDBar(106823, 8.3) -- Serpent Strike
		elseif self:Dispeller("magic") then
			self:CDBar(106823, 9.8) -- Serpent Strike
		end
		self:CDBar(106856, 10.8) -- Serpent Kick
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Stages

function mod:UNIT_HEALTH(event, unit)
	if self:MobId(self:UnitGUID(unit)) == 56732 then -- Liu Flameheart
		local hp = self:GetHealth(unit)
		if hp < 35 and hp > 30 then
			self:UnregisterUnitEvent(event, unit)
			self:Message("stages", "cyan", CL.soon:format(CL.stage:format(3)), false)
			self:PlaySound("stages", "info")
		elseif hp < 75 and hp > 70 then
			self:UnregisterUnitEvent(event, unit)
			self:Message("stages", "cyan", CL.soon:format(CL.stage:format(2)), false)
			self:PlaySound("stages", "info")
		end
	end
end

function mod:JadeEssence(args)
	if self:Retail() then -- Dragonflight+
		self:StopBar(106823) -- Serpent Strike
		self:StopBar(106856) -- Serpent Kick
	end
	self:SetStage(2)
	self:Message("stages", "cyan", CL.percent:format(70, CL.stage:format(2)), args.spellId)
	if self:Retail() then -- Dragonflight+
		if self:Tank() then
			self:CDBar(106841, 5.0) -- Jade Serpent Strike
		elseif self:Healer() then
			self:CDBar(106841, 6.5) -- Jade Serpent Strike
		end
		self:CDBar(106864, 7.5) -- Jade Serpent Kick
	end
	self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1")
	self:PlaySound("stages", "long")
end

function mod:EncounterEvent(args) -- Retail only
	-- this is fired once before transitioning to stage 2, then again before transitioning to stage 3.
	-- we're only looking for the stage 2 -> 3 transition here.
	if self:GetStage() == 2 then
		self:StopBar(106841) -- Jade Serpent Strike
		self:StopBar(106864) -- Jade Serpent Kick
		self:SetStage(3)
		self:Message("stages", "cyan", CL.percent:format(30, CL.stage:format(3)), 396907)
		self:CDBar(396907, 6.5) -- Jade Fire Breath
		self:CDBar(107045, 11.3) -- Jade Fire
		self:PlaySound("stages", "long")
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED_CLASSIC(event, unit, _, spellId) -- Classic only
	if spellId == 106895 then -- Summon Jade Serpent
		self:UnregisterUnitEvent(event, unit)
		self:SetStage(3)
		self:Message("stages", "cyan", CL.percent:format(30, CL.stage:format(3)), false)
		self:PlaySound("stages", "long")
	end
end

-- Stage 1: Serpent Dance

function mod:SerpentStrike(args) -- Retail only
	if self:Tank() then
		self:Message(args.spellId, "purple")
		self:CDBar(args.spellId, 15.8)
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:SerpentStrikeSuccess(args)
	if self:Retail() and (not self:Tank() and self:Dispeller("magic")) then
		self:CDBar(args.spellId, 15.8)
	end
	if self:Classic() and not self:Dispeller("magic") then
		self:Message(args.spellId, "purple")
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:SerpentStrikeApplied(args)
	if self:Dispeller("magic") then
		self:TargetMessage(args.spellId, "purple", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

function mod:SerpentKick(args) -- Retail only
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 15.8)
	self:PlaySound(args.spellId, "alarm")
end

-- Stage 2: Jade Serpent Dance

function mod:JadeSerpentStrike(args) -- Retail only
	if self:Tank() then
		self:Message(args.spellId, "purple")
		self:CDBar(args.spellId, 15.8)
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:JadeSerpentStrikeSuccess(args)
	if self:Retail() and self:Healer() then
		self:CDBar(args.spellId, 15.8)
	end
	if self:Classic() and not self:Healer() then
		self:Message(args.spellId, "purple")
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:JadeSerpentStrikeApplied(args)
	if self:Healer() then
		self:TargetMessage(args.spellId, "purple", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

function mod:JadeSerpentKick(args) -- Retail only
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 15.8)
	self:PlaySound(args.spellId, "alarm")
end

do
	local prev = 0
	function mod:JadeSerpentWaveDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 1.5 then
			prev = args.time
			self:PersonalMessage(args.spellId, "underyou")
			self:PlaySound(args.spellId, "underyou")
		end
	end
end

-- Stage 3: The Jade Serpent

function mod:JadeFireBreath(args) -- Retail only
	self:Message(args.spellId, "purple")
	self:CDBar(args.spellId, 10.9)
	self:PlaySound(args.spellId, "alarm")
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId) -- Retail only
	if spellId == 107045 then -- Jade Fire
		self:Message(spellId, "orange")
		self:CDBar(spellId, 12.1)
		self:PlaySound(spellId, "alarm")
	end
end

function mod:JadeFire(args) -- Classic only
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

do
	local prev = 0
	function mod:JadeFireDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 1.5 then
			prev = args.time
			self:PersonalMessage(107045, "underyou")
			self:PlaySound(107045, "underyou")
		end
	end
end
