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
		282801, -- Platinum Plating
		285020, -- Whirling Edge
		285344, -- Lay Mine
		-- Gnomercy 4.U.
		{285152, "SAY", "FLASH"}, -- Foe Flipper
		285388, -- Vent Jets
		{283422, "SAY", "FLASH"}, -- Maximum Thrust
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_REMOVED", "PlatinumPlatingRemoved", 282801)
	self:Log("SPELL_AURA_REMOVED_DOSE", "PlatinumPlatingRemoved", 282801)
	self:Log("SPELL_CAST_START", "WhirlingEdge", 285020)
	self:Log("SPELL_CAST_SUCCESS", "LayMine", 285344)
	self:Log("SPELL_CAST_SUCCESS", "FoeFlipper", 285152)
	self:Log("SPELL_CAST_START", "VentJets", 285388)
	self:Log("SPELL_CAST_SUCCESS", "VentJetsSuccess", 285388)
	self:Log("SPELL_CAST_START", "MaximumThrust", 283422)
end

function mod:OnEngage()
	self:Bar(285020, 8.2) -- Whirling Edge
	self:Bar(285388, 22) -- Vent Jets
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	-- If the event fires more than once, args.amount is the same for both events
	local prev = 0
	function mod:PlatinumPlatingRemoved(args)
		local t = args.time
		if t-prev > 0.1 then
			prev = t
			self:StackMessage(args.spellId, args.destName, args.amount, "green")
			self:PlaySound(args.spellId, "long")
		end
	end
end

function mod:WhirlingEdge(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 32.8)
end

function mod:LayMine(args)
	self:Message2(args.spellId, "orange")
	self:PlaySound(args.spellId, "info")
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage2(285152, "yellow", name)
		self:PlaySound(285152, "alert", nil, name)
		if self:Me(guid) then
			self:Say(285152)
			self:Flash(285152)
		end
	end

	function mod:FoeFlipper(args)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
	end
end

function mod:VentJets(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 43.7)
end

function mod:VentJetsSuccess(args)
	self:CastBar(args.spellId, 10)
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage2(283422, "yellow", name)
		self:PlaySound(283422, "alert", nil, name)
		if self:Me(guid) then
			self:Say(283422)
			self:Flash(283422)
		end
	end

	function mod:MaximumThrust(args)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
		self:Bar(args.spellId, 43.7)
	end
end
