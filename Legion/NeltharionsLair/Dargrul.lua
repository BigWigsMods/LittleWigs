--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Dargrul", 1458, 1687)
if not mod then return end
mod:RegisterEnableMob(91007)
mod:SetEncounterID(1793)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		200700, -- Landslide
		{200732, "TANK_HEALER"}, -- Molten Crash
		200637, -- Magma Sculptor
		200404, -- Magma Wave
		200551, -- Crystal Spikes
		216407, -- Lava Geyser
		-- Molten Charskin
		200154, -- Burning Hatred
		200672, -- Crystal Cracked
	}, {
		[200154] = -12596, -- Molten Charskin
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "MoltenCrash", 200732)
	self:Log("SPELL_CAST_START", "Landslide", 200700)
	self:Log("SPELL_CAST_START", "MagmaSculptor", 200637)
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1") -- for Magma Wave
	self:Log("SPELL_CAST_START", "MagmaWave", 200404)
	self:Log("SPELL_CAST_START", "CrystalSpikes", 200551)
	self:Log("SPELL_AURA_APPLIED", "LavaGeyserDamage", 216407)
	self:Log("SPELL_PERIODIC_DAMAGE", "LavaGeyserDamage", 216407)
	self:Log("SPELL_AURA_APPLIED", "BurningHatred", 200154)
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE") -- for Crystal Cracked
end

function mod:OnEngage()
	self:CDBar(200551, 5.1) -- Crystal Spikes
	self:Bar(200637, 9.7) -- Magma Sculptor
	self:Bar(200700, 15.8) -- Landslide
	self:Bar(200732, 19) -- Molten Crash
	-- cast at 100 energy, 60s energy gain + .8s delay
	self:Bar(200404, 60.8) -- Magma Wave
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Landslide(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	-- TODO pattern? pull:15.8, 17.1, 19.5, 21.8, 16.9, 17.0, 25.5, 17.0, 17.0, 26.7, 19.4, 21.8, 21.8
	--               pull:15.8, 17.1, 19.4, 21.9, 17.0, 17.1, 25.6, 17.1, 17.0, 25.6, 19.5, 21.9, 18.3, 17.1, 17.1, 20.7, 17.1, 17.1, 17.0, 24.4, 17.1, 18.3, 18.3, 18.3, 17.1, 25.6, 17.1, 17.0, 26.8, 19.5, 21.9
	self:CDBar(args.spellId, 17.0) -- pull:15.9, 17.0, 17.0, 23.1, 19.4, 17.0
	-- Molten Crash is always 3.2s after Landslide
	self:Bar(200732, {3.2, 17.0}) -- Molten Crash
end

function mod:MoltenCrash(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	-- TODO pattern? pull:19.0, 17.0, 19.5, 21.8, 34.0, 25.4, 17.0, 17.0, 26.7, 19.4, 21.8, 21.9
	--               pull:19.0, 17.1, 19.4, 21.9, 34.1, 25.5, 17.1, 17.0, 25.6, 19.5, 21.9, 35.4, 17.1, 20.7, 17.1, 34.1, 24.4, 17.0, 18.3, 36.6, 17.1, 25.5, 17.1, 17.0, 26.8, 19.5
	self:CDBar(args.spellId, 17.0) -- pull:19.1, 17.0, 17.0, 23.1, 19.4
end

function mod:MagmaSculptor(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 71.6)
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	-- faster than combat log event for Magma Wave (200404)
	if spellId == 201661 or spellId == 201663 then -- Dargrul Ability Callout 02, Dargrul Ability Callout 03
		self:Message(200404, "red") -- Magma Wave
		self:PlaySound(200404, "long") -- Magma Wave
		-- cast at 100 energy, 60s energy gain + .6s delay
		self:CDBar(200404, 60.6) -- Magma Wave
		self:CastBar(200404, 7) -- Magma Wave
	end
end

function mod:MagmaWave(args)
	-- correct the castbar started above
	self:CastBar(200404, {6, 7})
	-- soonest Crystal Spikes can be after this is 6.2s, but only correct once the cast
	-- actually starts because RARELY Dargrul will skip the Magma Wave cast after emoting
	local crystalSpikesTimeLeft = self:BarTimeLeft(200551)
	if crystalSpikesTimeLeft < 6.2 then
		self:Bar(200551, {6.2, 21.8})
	end
end

function mod:CrystalSpikes(args)
	-- TODO targeted?
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 21.8) -- pull:21.9, 21.8, 24.3, 21.8, 21.8
	-- soonest Landslide (+Molten Crash) can be after this is 2.43s
	local landslideTimeLeft = self:BarTimeLeft(200700)
	if landslideTimeLeft < 2.43 then
		self:Bar(200700, {2.43, 17.0}) -- Landslide
		self:Bar(200732, {5.63, 17.0}) -- Molten Crash
	end
end

do
	local prev = 0
	function mod:LavaGeyserDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:PersonalMessage(args.spellId, "underyou")
				self:PlaySound(args.spellId, "underyou")
			end
		end
	end
end

-- Molten Charskin

function mod:BurningHatred(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "warning")
	else
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg)
	if msg:find("200672", nil, true) then -- Crystal Cracked
		self:Message(200672, "green")
		self:PlaySound(200672, "info")
		self:Bar(200672, 10)
	end
end
