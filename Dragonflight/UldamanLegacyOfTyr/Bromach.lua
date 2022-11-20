--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Bromach", 2451, 2487)
if not mod then return end
mod:RegisterEnableMob(184018) -- Bromach
mod:SetEncounterID(2556)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Bromach
		369605, -- Call of the Deep
		369700, -- Quaking Totem
		369754, -- Bloodlust
		369703, -- Thundering Slam
		-- Stonevault Geomancer
		369675, -- Chain Lightning
		-- Quaking Totem
		369660, -- Tremor
	}, {
		[369605] = self.displayName,
		[369675] = -24988, -- Stonevault Geomancer
		[369660] = 369700, -- Quaking Totem
	}
end

function mod:OnBossEnable()
	-- Bromach
	self:Log("SPELL_CAST_SUCCESS", "CallOfTheDeep", 369605)
	self:Log("SPELL_CAST_START", "QuakingTotem", 382303)
	self:Log("SPELL_CAST_START", "Bloodlust", 369754)
	self:Log("SPELL_CAST_SUCCESS", "BloodlustSuccess", 369754)
	self:Log("SPELL_CAST_START", "ThunderingSlam", 369703)

	-- Stonevault Geomancer
	self:Log("SPELL_CAST_START", "ChainLightning", 369675)

	-- Quaking Totem
	self:Log("SPELL_CAST_SUCCESS", "Tremor", 369660)
end

function mod:OnEngage()
	self:CDBar(369605, 5.9) -- Call of the Deep
	self:Bar(369700, 20.6) -- Quaking Totem
	self:Bar(369703, 12.3) -- Thundering Slam
	self:Bar(369754, 27.9) -- Bloodlust
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Bromach

function mod:CallOfTheDeep(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 27.9)
end

function mod:QuakingTotem(args)
	self:Message(369700, "yellow")
	self:PlaySound(369700, "alert")
	self:Bar(369700, 40)
end

function mod:Bloodlust(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 30.3)
end

function mod:BloodlustSuccess(args)
	self:Bar(args.spellId, 20, CL.onboss:format(args.spellName))
end

function mod:ThunderingSlam(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 11.6)
end

-- Stonevault Geomancer

function mod:ChainLightning(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
end

-- Quaking Totem

function mod:Tremor(args)
	self:Message(args.spellId, "green", CL.onboss:format(args.spellName))
	self:PlaySound(args.spellId, "info")
	self:Bar(args.spellId, 10, CL.onboss:format(args.spellName))
end
