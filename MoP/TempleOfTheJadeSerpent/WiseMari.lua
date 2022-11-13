--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Wise Mari", 960, 672)
if not mod then return end
mod:RegisterEnableMob(56448) -- Wise Mari
mod:SetEncounterID(1418)
mod:SetRespawnTime(20)

--------------------------------------------------------------------------------
-- Locals
--

local addDeaths = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Normal / Heroic
		"stages",
		-6327, -- Call Water
		106653, -- Sha Residue
		115167, -- Corrupted Waters
	}, {
		["stages"] = CL.normal.." / "..CL.heroic
	}
end

function mod:OnBossEnable()

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
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Normal / Heroic

function mod:BubbleBurst(args)
	local text = CL.stage:format(2)
	self:DelayedMessage("stages", 4, "green", text, false, "info")
	self:Bar("stages", 4, text, args.spellId)
end

function mod:CallWater(args)
	self:DelayedMessage(-6327, 3, "red", CL.count:format(CL.add_spawned, addDeaths + 1), args.spellId, "alarm")
	self:Bar(-6327, 3, CL.next_add, args.spellId)
end

function mod:AddDeath()
	addDeaths = addDeaths + 1
	self:Message(-6327, "green", nil, CL.add_killed:format(addDeaths, 4), 106526)
	self:PlaySound(-6327, "info")
end

do
	local prev = 0
	function mod:GroundEffectDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t - prev > 1.5 then
				prev = t
				self:PersonalMessage(args.spellId, "underyou")
				self:PlaySound(args.spellId, "underyou")
			end
		end
	end
end
