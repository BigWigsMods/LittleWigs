if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Fangs of the Queen", 2669, 2595)
if not mod then return end
mod:RegisterEnableMob(
	216648, -- Nx
	216649 -- Vx
)
mod:SetEncounterID(2908)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local shadeSlashRemaining = 2
local rimeDaggerRemaining = 2

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Stages
		439522, -- Synergic Step
		-- Stage One: Nx, the Shrouded Fang
		439621, -- Shade Slash (Nx)
		439692, -- Duskbringer (Nx)
		{440238, "DISPEL"}, -- Ice Sickles (Vx)
		-- Stage Two: Vx, the Frosted Fang
		440468, -- Rime Dagger (Vx)
		{441298, "SAY"}, -- Freezing Blood (Vx)
		458741, -- Frozen Solid (Vx)
		{441286, "SAY"}, -- Dark Paranoia (Nx) (Mythic)
	}, {
		[439621] = -29960, -- Stage One: Nx, the Shrouded Fang
		[440468] = -29961, -- Stage Two: Vx, the Frosted Fang
	}, {
		[441286] = CL.mythic, -- Dark Paranoia (Mythic)
	}
end

function mod:OnBossEnable()
	-- Stages
	self:Log("SPELL_CAST_SUCCESS", "SynergicStep", 439522)

	-- Stage One: Nx, the Shrouded Fang
	self:Log("SPELL_CAST_START", "ShadeSlash", 439621)
	self:RegisterUnitEvent("UNIT_SPELLCAST_START", nil, "boss1", "boss2") -- Duskbringer (doesn't log)
	--self:Log("SPELL_CAST_START", "IceSickles", 440218) TODO this doesn't log consistently?
	self:Log("SPELL_AURA_APPLIED", "IceSicklesApplied", 440238)
	-- TODO what about Shadow Shunpo 440419?

	-- Stage Two: Vx, the Frosted Fang
	self:Log("SPELL_CAST_START", "RimeDagger", 440468)
	self:Log("SPELL_AURA_APPLIED", "FreezingBloodApplied", 441298)
	self:Log("SPELL_AURA_APPLIED", "FrozenSolidApplied", 458741)
	self:Log("SPELL_AURA_APPLIED", "DarkParanoiaApplied", 441286)
end

function mod:OnEngage()
	shadeSlashRemaining = 2
	rimeDaggerRemaining = 2
	self:SetStage(1)
	self:CDBar(439621, 4.1) -- Shade Slash
	self:CDBar(439692, 17.0) -- Duskbringer
	self:CDBar(440238, 23.0) -- Ice Sickles
	self:CDBar(439522, 28.6) -- Synergic Step
	self:CDBar(440468, 47.6) -- Rime Dagger
	--if self:Mythic() then
		--TODO self:CDBar(441286, 40) -- Dark Paranoia
	--end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Stages

do
	local prev = 0
	function mod:SynergicStep(args)
		-- this cast is spammed many times over ~5 seconds, we just care about when the sequence starts
		local t = args.time
		if t - prev > 10 then
			prev = t
			self:Message(439522, "cyan")
			self:PlaySound(439522, "info")
			if self:GetStage() == 1 then -- entering stage 2
				rimeDaggerRemaining = 2
				self:SetStage(2)
			else -- entering stage 1
				shadeSlashRemaining = 2
				self:SetStage(1)
			end
			self:CDBar(439522, 42.4)
		end
	end
end

-- Stage One: Nx, the Shrouded Fang

function mod:ShadeSlash(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	shadeSlashRemaining = shadeSlashRemaining - 1
	if shadeSlashRemaining > 0 then
		self:CDBar(args.spellId, 7.0)
	else
		self:CDBar(args.spellId, 78.0)
	end
end

function mod:UNIT_SPELLCAST_START(_, _, _, spellId)
	if spellId == 439692 then -- Duskbringer
		self:Message(spellId, "orange")
		self:PlaySound(spellId, "alarm")
		self:CDBar(spellId, 85.1)
	end
end

do
	local playerList = {}
	local prev = 0
	function mod:IceSicklesApplied(args)
		-- TODO this should be able to be dispelled by movement dispelling effects but it's bugged
		if self:Me(args.destGUID) or self:Dispeller("magic", nil, args.spellId) then
			local t = args.time
			-- there is no reliable cast event for this anymore, so reset the player list using a throttle
			if t - prev > 1 then
				prev = t
				playerList = {}
			end
			self:PlaySound(args.spellId, "alert", nil, playerList)
			self:TargetsMessage(args.spellId, "yellow", playerList, 3)
		end
		self:CDBar(args.spellId, 85.1)
	end
end

-- Stage Two: Vx, the Frosted Fang

function mod:RimeDagger(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alarm")
	rimeDaggerRemaining = rimeDaggerRemaining - 1
	if rimeDaggerRemaining > 0 then
		self:CDBar(args.spellId, 12.0)
	else
		self:CDBar(args.spellId, 73.0)
	end
end

function mod:FreezingBloodApplied(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "info", nil, args.destName)
	if self:Me(args.destGUID) then
		self:Yell(args.spellId, nil, nil, "Freezing Blood")
	end
end

function mod:FrozenSolidApplied(args)
	-- this only happens if Rime Dagger is cast again without the tank removing Freezing Blood
	self:TargetMessage(args.spellId, "purple", args.destName)
	self:PlaySound(args.spellId, "warning", nil, args.destName)
end

function mod:DarkParanoiaApplied(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Dark Paranoia")
	end
	self:CDBar(args.spellId, 85.1) -- TODO guessed
end
