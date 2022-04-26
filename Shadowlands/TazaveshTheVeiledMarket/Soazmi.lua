
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("So'azmi", 2441, 2451)
if not mod then return end
mod:RegisterEnableMob(175806) -- So'azmi
mod:SetEncounterID(2437)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.warmup_trigger = "Excuse our intrusion, So'leah. I hope we caught you at an inconvenient time."
end

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
	self:RegisterEvent("CHAT_MSG_MONSTER_SAY", "Warmup")
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

function mod:Warmup(event, msg)
	if msg == L.warmup_trigger then
		self:UnregisterEvent(event)
		self:Bar("warmup", 24, CL.active, "achievement_dungeon_brokerdungeon")
	end
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

function mod:Divide(args)
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
