if not IsTestBuild() then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Warlord Sargha", 2519, 2501)
if not mod then return end
mod:RegisterEnableMob(189901) -- Warlord Sargha
mod:SetEncounterID(2611)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		376780, -- Magma Shield
		377204, -- The Dragon's Kiln
		377477, -- Burning Ember
		377522, -- Burning Pursuit
	}, {
		[376780] = self.displayName, -- Warlord Sargha
		[377522] = -25270, -- Raging Ember
	}, {
		[377522] = CL.fixate, -- Burning Pursuit (Fixate)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "MagmaShieldApplied", 376780)
	self:Log("SPELL_AURA_REMOVED", "MagmaShieldRemoved", 376780)
	self:Log("SPELL_CAST_START", "TheDragonsKiln", 377204)
	self:Log("SPELL_CAST_START", "BurningEmber", 377473)
	self:Log("SPELL_AURA_APPLIED", "BurningPursuit", 377522)
end

function mod:OnEngage()
	self:CDBar(377204, 11.1) -- The Dragon's Kiln
	self:CDBar(377477, 21.5) -- Burning Ember
	self:CDBar(376780, 38.6) -- Magma Shield
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local magmaShieldStart = 0

	function mod:MagmaShieldApplied(args)
		magmaShieldStart = args.time
		self:Message(args.spellId, "orange")
		self:PlaySound(args.spellId, "long")
		-- TODO bar
	end

	function mod:MagmaShieldRemoved(args)
		local duration = args.time - magmaShieldStart
		self:Message(args.spellId, "green", CL.removed_after:format(args.spellName, duration))
		self:PlaySound(args.spellId, "info")
	end
end

function mod:TheDragonsKiln(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 21.8)
end

function mod:BurningEmber(args)
	self:Message(377477, "yellow")
	self:PlaySound(377477, "alert")
	self:CDBar(377477, 45)
end

function mod:BurningPursuit(args)
	if self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, "blue", args.destName, CL.fixate)
		self:PlaySound(args.spellId, "warning")
	end
end
