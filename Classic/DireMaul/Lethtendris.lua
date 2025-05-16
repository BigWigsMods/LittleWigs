--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Lethtendris", 429, 404)
if not mod then return end
mod:RegisterEnableMob(
	14327, -- Lethtendris
	14349 -- Pimgib
)
mod:SetEncounterID(345)
--mod:SetRespawnTime(0) resets, doesn't respawn

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.pimgib = "Pimgib"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Lethtendris
		17228, -- Shadow Bolt Volley
		{13338, "DISPEL"}, -- Curse of Thorns
		{16247, "DISPEL"}, -- Curse of Tongues
		11962, -- Immolate
		{22710, "DISPEL"}, -- Enlarge
		-- Pimgib
		15744, -- Blast Wave
		{22713, "DISPEL"}, -- Flame Buffet
	}, {
		[17228] = self.displayName, -- Lethtendris
		[15744] = L.pimgib,
	}
end

function mod:OnBossEnable()
	-- Lethtendris
	self:Log("SPELL_CAST_START", "ShadowBoltVolley", 17228)
	if self:Retail() then
		-- Curse of Thorns is instant cast on Retail
		self:Log("SPELL_AURA_APPLIED", "CurseOfThornsApplied", 450864)
	else -- Classic
		self:Log("SPELL_CAST_START", "CurseOfThorns", 13338)
		self:Log("SPELL_AURA_APPLIED", "CurseOfThornsApplied", 13338)
	end
	self:Log("SPELL_AURA_APPLIED", "CurseOfTonguesApplied", 16247)
	self:Log("SPELL_CAST_START", "Immolate", 11962)
	self:Log("SPELL_CAST_SUCCESS", "Enlarge", 22710)
	self:Log("SPELL_AURA_APPLIED", "EnlargeApplied", 22710)

	-- Pimgib
	self:Log("SPELL_CAST_START", "BlastWave", 15744)
	self:Log("SPELL_CAST_SUCCESS", "FlameBuffet", 22713)
	self:Log("SPELL_AURA_APPLIED_DOSE", "FlameBuffetApplied", 22713)
	self:Death("PimgibDeath", 14349)

	if self:Classic() and not self:Vanilla() then -- no encounter events in Cataclysm Classic
		self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
		self:Death("Win", 14327)
	end
end

function mod:OnEngage()
	self:CDBar(11962, 3.1) -- Immolate
	if self:Dispeller("magic", nil, 22713) then
		self:CDBar(22713, 7.2) -- Flame Buffet
	end
	self:CDBar(15744, 9.7) -- Blast Wave
	if self:Dispeller("magic", true, 22710) then
		self:CDBar(22710, 17.7) -- Enlarge
	end
	self:CDBar(17228, 18.1) -- Shadow Bolt Volley
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Lethtendris

function mod:ShadowBoltVolley(args)
	if self:MobId(args.sourceGUID) == 14327 then -- Lethtendris
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:CDBar(args.spellId, 17.0)
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:CurseOfThorns(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:CurseOfThornsApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("curse", nil, 13338) then
		self:TargetMessage(13338, "yellow", args.destName)
		self:PlaySound(13338, "alert", nil, args.destName)
	end
end

function mod:CurseOfTonguesApplied(args)
	if (self:Me(args.destGUID) or self:Dispeller("curse", nil, args.spellId)) and self:MobId(args.sourceGUID) == 14327 then -- Lethtendris
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

function mod:Immolate(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 14.5)
	self:PlaySound(args.spellId, "alert")
end

function mod:Enlarge(args)
	if self:Dispeller("magic", true, args.spellId) then
		self:CDBar(args.spellId, 32.8)
	end
end

function mod:EnlargeApplied(args)
	if self:Dispeller("magic", true, args.spellId) and not self:Friendly(args.destFlags) then
		self:Message(args.spellId, "yellow", CL.on:format(args.spellName, args.destName))
		self:PlaySound(args.spellId, "alert")
	end
end

-- Pimgib

function mod:BlastWave(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 18.2)
	self:PlaySound(args.spellId, "alert")
end

function mod:FlameBuffet(args)
	if self:Dispeller("magic", nil, args.spellId) then
		self:CDBar(args.spellId, 6.1)
	end
end

function mod:FlameBuffetApplied(args)
	if args.amount % 2 == 0 and self:Dispeller("magic", nil, args.spellId) then
		self:StackMessage(args.spellId, "orange", args.destName, args.amount, 4)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

function mod:PimgibDeath()
	self:StopBar(15744) -- Blast Wave
	self:StopBar(22713) -- Flame Buffet
end
