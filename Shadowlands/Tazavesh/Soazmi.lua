local isElevenDotTwo = BigWigsLoader.isNext -- XXX remove in 11.2
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

local shuriCount = 1
local firstDoubleTechnique = 0

--------------------------------------------------------------------------------
-- Initialization
--

if isElevenDotTwo then -- XXX remove check in 11.2
	function mod:GetOptions()
		return {
			"warmup",
			1245579, -- Shuri
			1245634, -- Divide
			1245669, -- Double Technique
			1248209, -- Phase Slash
		}
	end
else
	function mod:GetOptions()
		return {
			"warmup",
			357188, -- Double Technique
			347610, -- Shuri
			347249, -- Divide
			347623, -- Quickblade
		}
	end
end

function mod:OnBossEnable()
	if isElevenDotTwo then -- XXX remove check in 11.2
		self:Log("SPELL_CAST_START", "Shuri", 1245579)
		self:Log("SPELL_CAST_START", "Divide", 1245634)
		self:Log("SPELL_CAST_START", "DoubleTechnique", 1245669)
		self:Log("SPELL_INTERRUPT", "DoubleTechniqueInterrupt", 1245669)
		self:Log("SPELL_CAST_SUCCESS", "DoubleTechniqueSuccess", 1245669)
		self:Log("SPELL_CAST_START", "PhaseSlash", 1248209)
	else -- XXX remove block in 11.2
		self:Log("SPELL_CAST_START", "DoubleTechnique", 357188)
		self:Log("SPELL_CAST_START", "Shuri", 347610)
		self:Log("SPELL_CAST_START", "DivideOld", 347249, 347414)
		self:Log("SPELL_CAST_START", "Quickblade", 347623)
	end
end

function mod:OnEngage()
	shuriCount = 1
	self:StopBar(CL.active)
	self:SetStage(1)
	-- energy gain for Double Technique starts on pull, but it won't be cast until after the first Divide
	firstDoubleTechnique = GetTime() + 49.4
	if isElevenDotTwo then -- XXX remove check in 11.2
		self:CDBar(1248209, 8.2) -- Phase Slash
		self:CDBar(1245579, 12.2) -- Shuri
	else -- XXX remove block in 11.2
		self:CDBar(347623, 8.2) -- Quickblade
		self:CDBar(347610, 19.4) -- Shuri
	end
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
	shuriCount = shuriCount + 1
	if isElevenDotTwo then -- XXX remove check in 11.2
		if self:GetStage() == 1 then -- Stage 1
			self:CDBar(args.spellId, 20.6)
		else -- Stage 2 and 3
			if shuriCount % 2 == 0 then
				self:CDBar(args.spellId, 20.6)
			else
				self:CDBar(args.spellId, 43.6)
			end
		end
	else -- XXX remove block in 11.2
		if self:GetStage() == 3 then
			self:CDBar(args.spellId, shuriCount % 3 == 0 and 31.5 or 15.8)
		else
			self:CDBar(args.spellId, 15.8)
		end
	end
	self:PlaySound(args.spellId, "warning")
end

function mod:Divide(args)
	self:SetStage(self:GetStage() + 1)
	if self:GetStage() == 2 then
		shuriCount = 1 -- resets counter
		self:Message(args.spellId, "cyan", CL.percent:format(70, args.spellName))
		-- Double Technique is cast at 100 energy, but energy gain starts on pull
		local timeUntilDoubleTechnique = firstDoubleTechnique - GetTime()
		if timeUntilDoubleTechnique > 2.4 then
			self:CDBar(1245669, timeUntilDoubleTechnique) -- Double Technique
		else
			self:CDBar(1245669, 2.4) -- Double Technique
		end
		self:CDBar(1245579, 26.7) -- Shuri
	else -- 3
		self:Message(args.spellId, "cyan", CL.percent:format(40, args.spellName))
	end
	self:PlaySound(args.spellId, "info")
end

function mod:DivideOld() -- XXX remove in 11.2
	self:SetStage(self:GetStage() + 1)
	self:Message(347249, "cyan")
	if self:GetStage() == 3 then
		shuriCount = 0
		self:CDBar(347610, 27.9) -- Shuri
	end
	self:PlaySound(347249, "info")
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
			self:CDBar(args.spellId, 48.1)
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

function mod:Quickblade(args) -- XXX remove in 11.2
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 15.5)
	self:PlaySound(args.spellId, "alarm")
end
