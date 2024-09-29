-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Zanzil", 859, 184)
if not mod then return end
mod:RegisterEnableMob(52053)
--mod.engageId = 1181 -- no boss frames, also he consistently fires ENCOUNTER_END when his Graveyard Gas ends, without despawning
--mod.respawnTime = 30

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		96914, -- Zanzili Fire
		{96316, "ICON", "FLASH"}, -- Zanzil's (Blue) Resurrection Elixir
		{96338, "CASTBAR"}, -- Zanzil's Graveyard Gas
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ZanziliFire", 96914)

	self:Log("SPELL_AURA_APPLIED", "BlueResurrectionElixir", 96316)
	self:Log("SPELL_CAST_START", "PursuitCastStart", 96342)
	self:Log("SPELL_CAST_SUCCESS", "PursuitCastSuccess", 96342)
	self:Log("SPELL_AURA_REMOVED", "PursuitRemoved", 96306) -- this is applied to the mob, there are no SPELL_AURA_* events for the debuff his target gets
	self:Death("AddDied", 52054)

	self:Log("SPELL_AURA_APPLIED", "GraveyardGasCast", 96338)
	self:Log("SPELL_AURA_REMOVED", "GraveyardGasCastOver", 96338)

	self:CheckForEngage()
	self:Death("Win", 52053)
end

function mod:OnEngage()
	self:CheckForWipe()
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:ZanziliFire(args)
	self:MessageOld(args.spellId, "yellow", "info", CL.casting:format(args.spellName))
end

function mod:BlueResurrectionElixir(args)
	self:MessageOld(args.spellId, "yellow", "alert")
end

function mod:GraveyardGasCast(args)
	self:MessageOld(args.spellId, "yellow", "alert", CL.casting:format(args.spellName))
	self:CastBar(args.spellId, 7)
end

function mod:GraveyardGasCastOver(args)
	self:Bar(args.spellId, 12) -- duration
end

do
	local targetFound, scheduled = nil, nil

	local function printTarget(self, player, guid)
		targetFound = true
		if self:Me(guid) then
			self:Flash(96316, 96342)
		end
		self:TargetMessageOld(96316, player, "red", "alert", 96342)
		self:PrimaryIcon(96316, player)
	end

	function mod:PursuitCastStart(args)
		scheduled = self:ScheduleTimer("GetUnitTarget", 0.1, printTarget, 0.4, args.sourceGUID) -- the add recasts this the same moment he dies, I don't have a better idea
	end

	function mod:PursuitCastSuccess(args)
		if not targetFound then
			if self:Me(args.destGUID) then
				self:Flash(96316, args.spellId)
			end
			self:TargetMessageOld(96316, args.destName, "red", "alert", args.spellId)
			self:PrimaryIcon(96316, args.destName)
		else
			targetFound = nil
		end
	end

	function mod:PursuitRemoved()
		self:PrimaryIcon(96316)
	end

	function mod:AddDied()
		if scheduled then
			self:CancelTimer(scheduled)
		end
	end
end
