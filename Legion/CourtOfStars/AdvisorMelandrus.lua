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
	self:Log("SPELL_CAST_START", "PiercingGale", 209628)
	self:Log("SPELL_CAST_START", "SlicingMaelstrom", 209676)
end

function mod:OnEngage()
	bladeSurgeCount = 1
	slicingMaelstromCount = 1
	self:CDBar(209628, 10.8) -- Piercing Gale
	self:CDBar(224333, 8.4) -- Enveloping Winds
	self:CDBar(209602, 5.2, CL.count:format(self:SpellName(209602), bladeSurgeCount)) -- Blade Surge
	self:CDBar(209676, 22.8, CL.count:format(self:SpellName(209676), slicingMaelstromCount)) -- Slicing Maelstrom
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
	local text = CL.count:format(args.spellName, bladeSurgeCount)
	self:Message(args.spellId, "red", text)
	self:PlaySound(args.spellId, "info")
	self:StopBar(text)
	bladeSurgeCount = bladeSurgeCount + 1
	self:CDBar(args.spellId, 12.1, CL.count:format(args.spellName, bladeSurgeCount))
end

function mod:EnvelopingWinds(args)
	self:Message(224333, "yellow")
	self:PlaySound(224333, "alert")
	if slicingMaelstromCount == 1 then
		-- enveloping winds casts before the first slicing maelstrom show the "true" cooldown
		self:CDBar(224333, 8.5)
	else
		-- 95% of the time after the first slicing maelstrom it's 9.7 and 14.6 alternating
		-- due to delays from other abilities. but rarely it'll be 9.7 twice in a row.
		self:CDBar(224333, 9.7)
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
	local text = CL.count:format(args.spellName, slicingMaelstromCount)
	self:Message(args.spellId, "yellow", text)
	self:PlaySound(args.spellId, "warning")
	self:StopBar(text)
	slicingMaelstromCount = slicingMaelstromCount + 1
	self:CDBar(args.spellId, 24.3, CL.count:format(args.spellName, slicingMaelstromCount))
	-- fix up timers
	self:CDBar(209628, {12.1, 24.3}) -- Piercing Gale
end
