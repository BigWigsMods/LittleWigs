-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Zanzil", 793, 184)
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
		96316, -- Zanzil's (Blue) Resurrection Elixir
		96338, -- Zanzil's Graveyard Gas
		{96342, "ICON", "FLASH"}, -- Pursuit
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ZanziliFire", 96914)
	self:Log("SPELL_AURA_APPLIED", "BlueResurrectionElixir", 96316)
	self:Log("SPELL_AURA_APPLIED", "GraveyardGasCast", 96338)
	self:Log("SPELL_AURA_REMOVED", "GraveyardGasCastOver", 96338)
	self:Log("SPELL_CAST_START", "PursuitCastStart", 96342)
	self:Log("SPELL_CAST_SUCCESS", "PursuitCastSuccess", 96342)
	self:Log("SPELL_AURA_REMOVED", "PursuitRemoved", 96306) -- this is applied to the mob, there are no SPELL_AURA_* events for the debuff his target gets
	self:Death("AddDied", 52054)

	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:Death("Win", 52053)
end

function mod:OnEngage()
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:ZanziliFire(args)
	-- if self:MobId(args.sourceGUID) ~= 52053 then return end -- DKs could steal this ability
	self:Message(args.spellId, "Attention", "Info")
end

function mod:BlueResurrectionElixir(args)
	self:Message(args.spellId, "Attention", "Alert")
end

function mod:GraveyardGasCast(args)
	self:Message(args.spellId, "Attention", "Alert", CL.casting:format(args.spellName))
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
			self:Flash(96342)
		end
		self:TargetMessage(96342, player, "Important", "Alert")
		self:PrimaryIcon(96342, player)
	end

	function mod:PursuitCastStart(args)
		scheduled = self:ScheduleTimer("GetUnitTarget", 0.1, printTarget, 0.4, args.sourceGUID) -- the add recasts this the same moment he dies, I don't have a better idea
	end

	function mod:PursuitCastSuccess(args)
		if not targetFound then
			self:TargetMessage(96342, args.destName, "Important", "Alert")
			self:PrimaryIcon(96342, args.destName)
		else
			targetFound = nil
		end
	end

	function mod:PursuitRemoved()
		self:PrimaryIcon(96342)
	end

	function mod:AddDied()
		if scheduled then
			self:CancelTimer(scheduled)
		end
	end
end
