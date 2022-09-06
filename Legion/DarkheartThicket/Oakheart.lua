
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Oakheart", 1466, 1655)
if not mod then return end
mod:RegisterEnableMob(103344)
mod.engageId = 1837

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{204646, "SAY", "ICON"}, -- Crushing Grip
		204574, -- Strangling Roots
		204667, -- Nightmare Breath
		204666, -- Shattered Earth
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "CrushingGrip", 204646)
	self:Log("SPELL_CAST_SUCCESS", "CrushingGripEnd", 204646)
	self:Log("SPELL_CAST_START", "StranglingRoots", 204574)
	self:Log("SPELL_CAST_START", "NightmareBreath", 204667)
	self:Log("SPELL_CAST_START", "ShatteredEarth", 204666)
end

function mod:OnEngage()
	self:CDBar(204646, 28) -- Crushing Grip
	self:CDBar(204574, 12) -- Strangling Roots
	self:CDBar(204667, 18) -- Nightmare Breath
	self:CDBar(204666, 7.3) -- Shattered Earth
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local function printTarget(self, player, guid)
		self:TargetMessageOld(204646, player, "orange", "alert", nil, nil, true)
		self:PrimaryIcon(204646, player)
		if self:Me(guid) then
			self:Say(204646)
		end
	end
	function mod:CrushingGrip(args)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
		self:CDBar(args.spellId, 28) -- hc pull:28.0, 27.9, 34.0 / m pull:30.1, 32.8, 34.0
	end
	function mod:CrushingGripEnd(args)
		self:PrimaryIcon(args.spellId)
	end
end

function mod:StranglingRoots(args)
	self:MessageOld(args.spellId, "yellow")
	self:CDBar(args.spellId, 23) -- hc pull:12.5, 24.3, 26.7, 23.1 / m pull:14.6, 24.3, 32.8, 33.6
end

function mod:NightmareBreath(args)
	self:MessageOld(args.spellId, "red", "info")
	self:CDBar(args.spellId, 26) -- hc pull:18.6, 26.7, 32.8 / m pull:19.5, 32.8, 26.7, 33.5
end

function mod:ShatteredEarth(args)
	self:MessageOld(args.spellId, "red", "alarm")
	self:CDBar(args.spellId, 51) -- m pull: 7.3, 50.9, 51.1
end
