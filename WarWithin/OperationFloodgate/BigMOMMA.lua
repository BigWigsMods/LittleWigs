--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Big M.O.M.M.A.", 2773, 2648)
if not mod then return end
mod:RegisterEnableMob(226398) -- Big M.O.M.M.A.
mod:SetEncounterID(3020)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{460156, "CASTBAR"}, -- Jumpstart
		473287, -- Excessive Electrification
		471585, -- Mobilize Mechadrones
		{473351, "TANK_HEALER"}, -- Electrocrush
		{473220, "SAY"}, -- Sonic Boom
		469981, -- Kill-o-Block Barrier
		-- Darkfuse Mechadrone
		1214780, -- Maximum Distortion (Mythic)
		472452, -- Doom Storm
	}, {
		[1214780] = -30316, -- Darkfuse Mechadrone
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Jumpstart", 460156)
	self:Log("SPELL_AURA_APPLIED", "JumpstartApplied", 460156)
	self:Log("SPELL_PERIODIC_DAMAGE", "ExcessiveElectrificationDamage", 473287)
	self:Log("SPELL_PERIODIC_MISSED", "ExcessiveElectrificationDamage", 473287)
	self:Log("SPELL_CAST_START", "MobilizeMechadrones", 471585)
	self:Log("SPELL_CAST_START", "Electrocrush", 473351)
	self:Log("SPELL_CAST_START", "SonicBoom", 473220)
	self:Log("SPELL_CAST_START", "KillOBlockBarrier", 469981)

	-- Darkfuse Mechadrone
	--self:Log("SPELL_SUMMON", "MobilizeMechadronesSummon", 471595)
	self:Log("SPELL_CAST_START", "MaximumDistortion", 1214780) -- Mythic only
	self:Log("SPELL_CAST_START", "DoomStorm", 472452)
	--self:Death("DarkfuseMechadroneDeath", 228424)
end

function mod:OnEngage()
	self:SetStage(1)
	self:CDBar(473351, 5.7) -- Electrocrush
	self:CDBar(473220, 15.4) -- Sonic Boom
	self:CDBar(469981, 55.7) -- Kill-o-Block Barrier
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Jumpstart(args)
	-- this is cast when all 4 adds are killed
	self:StopBar(473351) -- Electrocrush
	self:StopBar(473220) -- Sonic Boom
	self:StopBar(469981) -- Kill-o-Block Barrier
	self:SetStage(2)
	self:Message(args.spellId, "green", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "info")
end

function mod:JumpstartApplied(args)
	self:Message(args.spellId, "green", CL.onboss:format(args.spellName))
	self:CastBar(args.spellId, 12)
	self:PlaySound(args.spellId, "long")
end

do
	local prev = 0
	function mod:ExcessiveElectrificationDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 1.5 then
			prev = args.time
			self:PersonalMessage(args.spellId, "underyou")
			self:PlaySound(args.spellId, "underyou")
		end
	end
end

function mod:MobilizeMechadrones(args)
	self:SetStage(1)
	self:Message(args.spellId, "cyan")
	self:CDBar(473351, 9.2) -- Electrocrush
	self:CDBar(473220, 18.9) -- Sonic Boom
	self:CDBar(469981, 58.9) -- Kill-o-Block Barrier
	self:PlaySound(args.spellId, "info")
end

function mod:Electrocrush(args)
	self:Message(args.spellId, "purple")
	self:CDBar(args.spellId, 20.6)
	self:PlaySound(args.spellId, "alert")
end

do
	local function printTarget(self, name, guid)
		self:TargetMessage(473220, "yellow", name)
		if self:Me(guid) then
			self:Say(473220, nil, nil, "Sonic Boom")
			self:PlaySound(473220, "warning")
		else
			self:PlaySound(473220, "alarm", nil, name)
		end
	end

	function mod:SonicBoom(args)
		self:GetUnitTarget(printTarget, 0.2, args.sourceGUID)
		self:CDBar(args.spellId, 21.7)
	end
end

function mod:KillOBlockBarrier(args)
	self:StopBar(args.spellId) -- just one cast per Stage 1
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
end

-- Darkfuse Mechadrone

--function mod:MobilizeMechadronesSummon(args)
	--self:Nameplate(472452, 8.5, args.destGUID) -- Doom Storm
	--self:Nameplate(1214780, 20.6, args.destGUID) -- Maximum Distortion
--end

function mod:MaximumDistortion(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	--self:Nameplate(args.spellId, 37.7, args.sourceGUID)
	self:PlaySound(args.spellId, "warning")
end

function mod:DoomStorm(args)
	self:Message(args.spellId, "orange")
	--self:Nameplate(args.spellId, 3.7, args.sourceGUID)
	self:PlaySound(args.spellId, "alarm")
end

--function mod:DarkfuseMechadroneDeath(args)
	--self:ClearNameplate(args.destGUID)
--end
