--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Wise Mari", 960, 672)
if not mod then return end
mod:RegisterEnableMob(56448) -- Wise Mari
mod:SetEncounterID(1418)
mod:SetRespawnTime(25)

--------------------------------------------------------------------------------
-- Locals
--

local addDeaths = 0
local corruptedVortexCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Mythic+
		{397785, "CASTBAR"}, -- Wash Away
		{397797, "SAY", "SAY_COUNTDOWN"}, -- Corrupted Vortex
		397793, -- Corrupted Geyser
		-- Normal / Heroic
		"stages",
		-6327, -- Call Water
		106653, -- Sha Residue
		115167, -- Corrupted Waters
	}, {
		[397785] = CL.mythic,
		["stages"] = CL.normal.." / "..CL.heroic,
	}
end

function mod:OnBossEnable()
	-- Mythic+
	self:Log("SPELL_CAST_START", "WashAway", 397783)
	self:Log("SPELL_CAST_SUCCESS", "WashAwayChannelStart", 397783)
	self:Log("SPELL_AURA_APPLIED", "CorruptedVortexApplied", 397797)
	self:Log("SPELL_PERIODIC_DAMAGE", "CorruptedVortexDamage", 397799)
	self:Log("SPELL_PERIODIC_MISSED", "CorruptedVortexDamage", 397799)

	-- Normal / Heroic
	self:Log("SPELL_CAST_START", "BubbleBurst", 106612)
	self:Log("SPELL_CAST_START", "CallWater", 106526)
	self:Death("AddDeath", 56511)
	self:Log("SPELL_PERIODIC_DAMAGE", "GroundEffectDamage", 106653) -- Sha Residue
	self:Log("SPELL_PERIODIC_MISSED", "GroundEffectDamage", 106653)
	self:Log("SPELL_DAMAGE", "GroundEffectDamage", 115167) -- Corrupted Waters
	self:Log("SPELL_MISSED", "GroundEffectDamage", 115167)
end

function mod:OnEngage()
	addDeaths = 0
	corruptedVortexCount = 0
	if self:Mythic() then
		self:CDBar(397785, 21) -- Wash Away
		self:CDBar(397797, 8.5) -- Corrupted Vortex
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Mythic+

function mod:WashAway(args)
	self:Message(397785, "red", CL.casting:format(args.spellName))
	self:PlaySound(397785, "warning")
	self:CastBar(397785, 3)
	self:CDBar(397785, 41.3)
	-- either wash away or the second corrupted vortex can occur first,
	-- but the pattern is wash away, vortex, vortex, repeat
	corruptedVortexCount = 0
	self:Bar(397793, 3.4, CL.count:format(self:SpellName(397793), 1)) -- Corrupted Geyser (1)
	self:Bar(397793, 8.4, CL.count:format(self:SpellName(397793), 2)) -- Corrupted Geyser (2)
	self:Bar(397793, 13.4, CL.count:format(self:SpellName(397793), 3)) -- Corrupted Geyser (3)
end

function mod:WashAwayChannelStart(args)
	self:CastBar(397785, 12)
end

function mod:CorruptedVortexApplied(args)
	corruptedVortexCount = corruptedVortexCount + 1
	self:CDBar(args.spellId, corruptedVortexCount % 2 == 0 and 28.2 or 13)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "alarm")
		self:Say(args.spellId, nil, nil, "Corrupted Vortex")
		self:SayCountdown(args.spellId, 6)
	else
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
	self:Bar(397793, 3.4) -- Corrupted Geyser
end

function mod:CorruptedVortexDamage(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(397797, "underyou")
		self:PlaySound(397797, "underyou")
	end
end

-- Normal / Heroic

function mod:BubbleBurst(args)
	local text = CL.stage:format(2)
	self:DelayedMessage("stages", 4, "green", text, false, "info")
	self:Bar("stages", 4, text, args.spellId)
end

function mod:CallWater(args)
	self:DelayedMessage(-6327, 3, "red", CL.count:format(CL.add_spawned, addDeaths + 1), -6327, "alarm")
	self:Bar(-6327, 3, CL.next_add)
end

function mod:AddDeath()
	addDeaths = addDeaths + 1
	self:Message(-6327, "green", CL.add_killed:format(addDeaths, 4))
	self:PlaySound(-6327, "info")
end

do
	local prev = 0
	function mod:GroundEffectDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 1.5 then
				prev = t
				self:PersonalMessage(args.spellId, "underyou")
				self:PlaySound(args.spellId, "underyou", nil, args.destName)
			end
		end
	end
end
