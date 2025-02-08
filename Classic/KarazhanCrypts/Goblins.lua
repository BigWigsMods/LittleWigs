--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Goblins", 2875)
if not mod then return end
mod:RegisterEnableMob(
	238420, -- Weeshald Rustboot
	238417, -- Beengis
	238416, -- Geenkle
	238418, -- Jank
	238419 -- Gold Rustboot
)
mod:SetEncounterID(3169) -- Opera of Malediction
--mod:SetRespawnTime(30)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.goblins = "Goblins"
	--L.weeshald_rustboot = "Weeshald Rustboot"
	--L.beengis = "Beengis"
	L.geenkle = "Geenkle"
	L.jank = "Jank"
	L.gold_rustboot = "Gold Rustboot"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.goblins
end

function mod:GetOptions()
	return {
		-- Geenkle
		{16170, "DISPEL"}, -- Bloodlust
		-- Jank
		{744, "DISPEL"}, -- Poison
		-- Gold Rustboot
		27758, -- War Stomp
	}, {
		[16170] = L.geenkle,
		[744] = L.jank,
		[27758] = L.gold_rustboot,
	}
end

function mod:OnBossEnable()
	-- Geenkle
	self:Log("SPELL_CAST_SUCCESS", "Bloodlust", 16170)
	self:Log("SPELL_AURA_APPLIED", "BloodlustApplied", 16170)
	self:Death("GeenkleDeath", 238416)

	-- Jank
	self:Log("SPELL_CAST_SUCCESS", "Poison", 744)
	self:Log("SPELL_AURA_APPLIED", "PoisonApplied", 744)
	self:Death("JankDeath", 238418)

	-- Gold Rustboot
	self:Log("SPELL_CAST_SUCCESS", "WarStomp", 27758)
	self:Death("GoldRustbootDeath", 238419)
end

function mod:OnEngage()
	self:CDBar(744, 7.0) -- Poison
	self:CDBar(27758, 8.2) -- War Stomp
	self:CDBar(16170, 11.2) -- Bloodlust
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Geenkle

function mod:Bloodlust(args)
	self:CDBar(args.spellId, 13.3)
end

function mod:BloodlustApplied(args)
	if self:Me(args.destGUID) or (self:Dispeller("magic", true, args.spellId) and not self:Player(args.destFlags)) then
		self:Message(args.spellId, "red", CL.on:format(args.spellName, args.destName))
		self:PlaySound(args.spellId, "info")
	end
end

function mod:GeenkleDeath()
	self:StopBar(16170) -- Bloodlust
end

-- Jank

function mod:Poison(args)
	-- also cast by trash
	if self:MobId(args.sourceGUID) == 238418 then -- Jank
		self:CDBar(args.spellId, 32.0)
	end
end

function mod:PoisonApplied(args)
	-- also cast by trash
	if self:MobId(args.sourceGUID) == 238418 then -- Jank
		if self:Me(args.destGUID) or (self:Dispeller("poison", nil, args.spellId) and self:Player(args.destFlags)) then
			self:TargetMessage(args.spellId, "red", args.destName)
			self:PlaySound(args.spellId, "alert", nil, args.destName)
		end
	end
end

function mod:JankDeath()
	self:StopBar(744) -- Poison
end

-- Gold Rustboot

function mod:WarStomp(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 11.3)
	self:PlaySound(args.spellId, "alert")
end

function mod:GoldRustbootDeath()
	self:StopBar(27758) -- War Stomp
end
