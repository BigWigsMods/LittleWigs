if not IsTestBuild() then return end

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Tussle Tonks", 2097, 2336)
if not mod then return end
mod:RegisterEnableMob(144244, 145185) -- The Platinum Pummeler, Gnomercy 4.U.
mod.engageId = 2257

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- The Platinum Pummeler
		299869, -- Platinum Plating
		285020, -- Whirling Edge
		285351, -- Lay Mine
		-- Gnomercy 4.U.
		{285153, "SAY", "FLASH"}, -- Foe Flipper
		285388, -- Vent Jets
		283565, -- Maximum Thrust
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_REMOVED", "PlatinumPlatingRemoved", 299869)
	self:Log("SPELL_AURA_REMOVED_DOSE", "PlatinumPlatingRemoved", 299869)
	self:Log("SPELL_CAST_START", "WhirlingEdge", 285020)
	self:Log("SPELL_CAST_SUCCESS", "LayMine", 285351)
	self:Log("SPELL_CAST_SUCCESS", "FoeFlipper", 285153)
	self:Log("SPELL_CAST_SUCCESS", "VentJets", 285388)
	self:Log("SPELL_CAST_START", "MaximumThrust", 283565)
end

function mod:OnEngage()

end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:PlatinumPlatingRemoved(args)
	self:StackMessage(args.spellId, args.destName, args.amount, "green")
	self:PlaySound(args.spellId, "long")
end

function mod:WhirlingEdge(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
end

function mod:LayMine(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "info")
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage2(285153, "yellow", name)
		self:PlaySound(285153, "alert", nil, name)
		if self:Me(guid) then
			self:Say(285153)
			self:Flash(285153)
		end
	end

	function mod:FoeFlipper(args)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
	end
end

function mod:VentJets(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CastBar(args.spellId, 10)
end

function mod:MaximumThrust(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
end
