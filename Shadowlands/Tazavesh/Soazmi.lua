--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("So'azmi", 2441, 2451)
if not mod then return end
mod:RegisterEnableMob(175806) -- So'azmi
mod:SetEncounterID(2437)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local divideCount = 0
local shuriCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		357188, -- Double Technique
		347610, -- Shuri
		347249, -- Divide
		347623, -- Quickblade
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "DoubleTechnique", 357188)
	self:Log("SPELL_CAST_SUCCESS", "Shuri", 347610)
	self:Log("SPELL_CAST_START", "Divide", 347249, 347414)
	self:Log("SPELL_CAST_START", "Quickblade", 347623)
end

function mod:OnEngage()
	divideCount = 0
	shuriCount = 0
	self:Bar(347623, 8.2) -- Quickblade
	self:Bar(347610, 19.4) -- Shuri
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- called from trash module
function mod:Warmup()
	self:Bar("warmup", 23.1, CL.active, "achievement_dungeon_brokerdungeon")
end

do
	local prev = 0

	function mod:DoubleTechnique(args)
		local count = args.time - prev > 10 and 1 or 2
		self:Message(args.spellId, "orange", CL.count:format(args.spellName, count))
		self:PlaySound(args.spellId, "alert")
		prev = args.time
	end
end

function mod:Shuri(args)
	shuriCount = shuriCount + 1
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	if divideCount == 2 then
		self:CDBar(args.spellId, shuriCount % 3 == 0 and 31.5 or 15.8)
	end
end

function mod:Divide()
	divideCount = divideCount + 1
	self:Message(347249, "yellow")
	self:PlaySound(347249, "info")
	if divideCount == 2 then
		shuriCount = 0
		self:Bar(347610, 27.9) -- Shuri
	end
end

function mod:Quickblade(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 15.5)
end
