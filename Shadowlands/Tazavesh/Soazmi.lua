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
		self:Log("SPELL_CAST_START", "PhaseSlash", 1248209)
	else -- XXX remove block in 11.2
		self:Log("SPELL_CAST_START", "DoubleTechnique", 357188)
		self:Log("SPELL_CAST_SUCCESS", "Shuri", 347610)
		self:Log("SPELL_CAST_START", "DivideOld", 347249, 347414)
		self:Log("SPELL_CAST_START", "Quickblade", 347623)
	end
end

function mod:OnEngage()
	shuriCount = 1
	self:SetStage(1)
	if isElevenDotTwo then -- XXX remove check in 11.2
		self:CDBar(1248209, 8.5) -- Phase Slash
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
		end
	end
	self:PlaySound(args.spellId, "warning")
end

function mod:Divide(args)
	self:SetStage(self:GetStage() + 1)
	if self:GetStage() == 2 then
		shuriCount = 1 -- resets counter
		self:Message(args.spellId, "cyan", CL.percent:format(70, args.spellName))
		if isElevenDotTwo then -- XXX remove check in 11.2
			self:CDBar(1245669, 2.4) -- Double Technique
			self:CDBar(1245579, 30.2) -- Shuri
		end
	else -- 3
		self:Message(args.spellId, "cyan", CL.percent:format(40, args.spellName))
		self:CDBar(1245579, 27.9) -- Shuri
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
	local prev = 0
	function mod:DoubleTechnique(args)
		local count = args.time - prev > 15 and 1 or 2
		prev = args.time
		self:Message(args.spellId, "red", CL.count_amount:format(CL.casting:format(args.spellName), count, 2))
		if isElevenDotTwo then -- XXX remove check in 11.2
			if count == 1 then
				self:CDBar(args.spellId, 64.1)
			end
		end
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:PhaseSlash(args)
	self:Message(args.spellId, "purple")
	self:CDBar(args.spellId, 16.1)
	self:PlaySound(args.spellId, "alert")
end

function mod:Quickblade(args) -- XXX remove in 11.2
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 15.5)
	self:PlaySound(args.spellId, "alarm")
end
