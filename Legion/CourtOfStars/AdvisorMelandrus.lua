--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Advisor Melandrus", 1571, 1720)
if not mod then return end
mod:RegisterEnableMob(104218) -- Advisor Melandrus
mod:SetEncounterID(1870)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.warmup_trigger = "Yet another failure, Melandrus. Consider this your chance to correct it. Dispose of these outsiders. I must return to the Nighthold."
end

--------------------------------------------------------------------------------
-- Locals
--

local bladeSurgeCount = 0
local slicingMaelstromCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		209602, -- Blade Surge
		224333, -- Enveloping Winds
		209628, -- Piercing Gale
		209676, -- Slicing Maelstrom
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_SAY", "Warmup")
	self:Log("SPELL_CAST_START", "BladeSurge", 209602)
	self:Log("SPELL_CAST_SUCCESS", "EnvelopingWinds", 224327)
	self:Log("SPELL_AURA_APPLIED", "EnvelopingWindsApplied", 224333)
	self:Log("SPELL_CAST_START", "PiercingGale", 209628)
	self:Log("SPELL_CAST_START", "SlicingMaelstrom", 209676)
end

function mod:OnEngage()
	bladeSurgeCount = 0
	slicingMaelstromCount = 0
	self:CDBar(209628, 10.8) -- Piercing Gale
	self:CDBar(224333, 8.4) -- Enveloping Winds
	self:CDBar(209602, 5.2, CL.count:format(self:SpellName(209602), 1)) -- Blade Surge (1)
	self:CDBar(209676, 22.8, CL.count:format(self:SpellName(209676), 1)) -- Slicing Maelstrom (1)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Warmup(event, msg)
	if msg == L.warmup_trigger then
		self:UnregisterEvent(event)
		self:Bar("warmup", 11, CL.active, "inv_helm_mask_fittedalpha_b_01_nightborne_01")
	end
end

function mod:BladeSurge(args)
	bladeSurgeCount = bladeSurgeCount + 1
	local bladeSurgeMessage = CL.count:format(args.spellName, bladeSurgeCount)
	self:Message(args.spellId, "red", bladeSurgeMessage)
	self:PlaySound(args.spellId, "info")
	self:StopBar(bladeSurgeMessage)
	self:CDBar(args.spellId, 12.1, CL.count:format(args.spellName, bladeSurgeCount + 1))
end

function mod:EnvelopingWinds(args)
	self:Message(224333, "yellow")
	self:PlaySound(224333, "alert")
	if slicingMaelstromCount == 1 then
		-- Enveloping Winds casts before the first Slicing Maelstrom show the "true" cooldown
		self:CDBar(224333, 8.5)
	else
		-- 95% of the time after the first Slicing Maelstrom it's 9.7 and 14.6 alternating
		-- due to delays from other abilities. but rarely it'll be 9.7 twice in a row.
		self:CDBar(224333, 9.7)
	end
end

function mod:EnvelopingWindsApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("magic") then
		self:TargetMessage(args.spellId, "red", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

function mod:PiercingGale(args)
	if self:MobId(args.sourceGUID) == 104218 then -- Advisor Melandrus
		self:Message(args.spellId, "orange")
		self:PlaySound(args.spellId, "alarm")
		self:CDBar(args.spellId, 24.3)
	end
end

function mod:SlicingMaelstrom(args)
	slicingMaelstromCount = slicingMaelstromCount + 1
	local slicingMaelstromMessage = CL.count:format(args.spellName, slicingMaelstromCount)
	self:Message(args.spellId, "yellow", slicingMaelstromMessage)
	self:PlaySound(args.spellId, "warning")
	self:StopBar(slicingMaelstromMessage)
	self:CDBar(args.spellId, 24.3, CL.count:format(args.spellName, slicingMaelstromCount + 1))
	-- fix up timers
	self:CDBar(209628, {12.1, 24.3}) -- Piercing Gale
end
