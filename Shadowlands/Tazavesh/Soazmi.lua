--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("So'azmi", 2441, 2451)
if not mod then return end
mod:RegisterEnableMob(175806) -- So'azmi
mod:SetEncounterID(2437)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local firstDoubleTechnique = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		1245579, -- Shuri
		1245634, -- Divide
		1245669, -- Double Technique
		1248209, -- Phase Slash
		-- Hard Mode
		1245752, -- Triple Technique
	}, {
		[1245752] = CL.hard,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Shuri", 1245579)
	self:Log("SPELL_CAST_START", "Divide", 1245634)
	self:Log("SPELL_CAST_START", "DoubleTechnique", 1245669)
	self:Log("SPELL_INTERRUPT", "DoubleTechniqueInterrupt", 1245669)
	self:Log("SPELL_CAST_SUCCESS", "DoubleTechniqueSuccess", 1245669)
	self:Log("SPELL_CAST_START", "PhaseSlash", 1248209)

	-- Hard Mode
	self:Log("SPELL_CAST_START", "TripleTechnique", 1245752)
	self:Log("SPELL_INTERRUPT", "TripleTechniqueInterrupt", 1245752)
	self:Log("SPELL_CAST_SUCCESS", "TripleTechniqueSuccess", 1245752)
end

function mod:OnEngage()
	self:StopBar(CL.active)
	self:SetStage(1)
	-- energy gain for Double Technique starts on pull, but it won't be cast until after the first Divide
	firstDoubleTechnique = GetTime() + 49.4
	self:CDBar(1248209, 8.2) -- Phase Slash
	self:CDBar(1245579, 12.2) -- Shuri
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- called from trash module
function mod:Warmup()
	self:Bar("warmup", 23.1, CL.active, "achievement_dungeon_brokerdungeon")
end

function mod:Shuri(args)
	self:Message(args.spellId, "yellow")
	-- often delayed by Double Technique / Triple Technique
	self:CDBar(args.spellId, 20.6)
	self:PlaySound(args.spellId, "warning")
end

function mod:Divide(args)
	-- in 11.2 non-keystone Mythic Tazavesh is always hard mode, may need to revisit this after TWW Season 3
	if self:Mythic() and not self:MythicPlus() then -- Hard Mode
		-- Divide is cast on pull in Hard Mode
		self:SetStage(3)
		self:Message(args.spellId, "cyan")
		self:CDBar(1245752, 49.4) -- Triple Technique
	else -- Mythic+ and Heroic
		self:SetStage(self:GetStage() + 1)
		if self:GetStage() == 2 then
			self:Message(args.spellId, "cyan", CL.percent:format(70, args.spellName))
			-- Double Technique is cast at 100 energy, but energy gain starts on pull
			local timeUntilDoubleTechnique = firstDoubleTechnique - GetTime()
			if timeUntilDoubleTechnique > 2.4 then
				self:CDBar(1245669, timeUntilDoubleTechnique) -- Double Technique
			else
				self:CDBar(1245669, 2.4) -- Double Technique
			end
		else -- 3
			self:Message(args.spellId, "cyan", CL.percent:format(40, args.spellName))
		end
	end
	self:PlaySound(args.spellId, "info")
end

do
	local count = 1
	local prev = 0
	function mod:DoubleTechnique(args)
		-- cast at 100 energy, energy resets to 0 and gain is paused while casting Double Technique
		count = args.time - prev > 20 and 1 or 2
		prev = args.time
		self:StopBar(args.spellId)
		self:Message(args.spellId, "red", CL.count_amount:format(CL.casting:format(args.spellName), count, 2))
		self:PlaySound(args.spellId, "alert")
	end

	function mod:DoubleTechniqueInterrupt(args)
		if count == 2 then
			-- energy gain resumes, 48s energy gain + delay
			self:CDBar(1245669, 48.1)
		end
	end

	function mod:DoubleTechniqueSuccess(args)
		-- energy gain resumes, 48s energy gain + delay
		self:CDBar(args.spellId, 48.1)
	end
end

function mod:PhaseSlash(args)
	self:Message(args.spellId, "purple")
	self:CDBar(args.spellId, 15.8)
	self:PlaySound(args.spellId, "alert")
end

-- Hard Mode

do
	local count = 1
	local prev = 0
	function mod:TripleTechnique(args)
		-- cast at 100 energy, energy resets to 0 and gain is paused while casting Triple Technique
		count = args.time - prev > 20 and 1 or count + 1
		prev = args.time
		self:StopBar(args.spellId)
		self:Message(args.spellId, "red", CL.count_amount:format(CL.casting:format(args.spellName), count, 3))
		self:PlaySound(args.spellId, "alert")
	end

	function mod:TripleTechniqueInterrupt(args)
		if count == 3 then
			-- energy gain resumes, 48s energy gain + delay
			self:CDBar(1245752, 48.1)
		end
	end

	function mod:TripleTechniqueSuccess(args)
		-- energy gain resumes, 48s energy gain + delay
		self:CDBar(args.spellId, 48.1)
	end
end
