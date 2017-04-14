
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Raest", nil, nil, 1684)
if not mod then return end
mod:RegisterEnableMob(116409, 116410) -- Raest Magespear, Karam Magespear
mod.otherMenu = 1021 -- Broken Shore

--------------------------------------------------------------------------------
-- Locals
--

local phase = 1
local handGUID = ""

----------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.name = "Raest Magespear"

	L.handFromBeyond = "Hand from Beyond"
	L.handFromBeyond_icon = 229022 -- Grasping Hand

	L.killed = "%s killed"

	L.warmup_text = "Karam Magespear Active"
	L.warmup_trigger = "You were a fool to follow me, brother. The Twisting Nether feeds my strength. I have become more powerful than you could ever imagine!"
	L.warmup_trigger2 = "Kill this interloper, brother!"
end
mod.displayName = L.name

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		202081, -- Fixate
		235308, -- Purgatory
		"handFromBeyond",
		{235578, "FLASH"}, -- Grasp from Beyond
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "Warmup")
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")

	self:Log("SPELL_CAST_START", "Purgatory", 235308)
	self:Log("SPELL_AURA_REMOVED", "PurgatoryRemoved", 235308)
	self:Log("SPELL_CAST_START", "GraspFromBeyond", 235578)
	self:Log("SPELL_INTERRUPT", "Interrupts", "*")
	self:Death("HandFromBeyondDeath", 118698)

	self:Death("Win", 116409)
end

function mod:OnEngage()
	phase = 1
	handGUID = ""
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Warmup(_, msg)
	if msg == L.warmup_trigger then
		self:Bar("warmup", 45.7, L.warmup_text, 202081)
	elseif msg == L.warmup_trigger2 then
		self:Bar("warmup", 7.7, L.warmup_text, 202081)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(unit, spellName, _, _, spellId)
	if spellId == 202081 then -- Fixate
		self:Message(spellId, "Important", "Long", spellName .. " - " .. CL.stage:format(phase))
		if phase == 2 then
			self:Bar("handFromBeyond", 9, L.handFromBeyond, L.handFromBeyond_icon) -- Grasp from Beyond
		end
	end
end

function mod:Purgatory(args)
	self:Message(args.spellId, "Positive", "Info")
	phase = phase + 1
	self:CastBar(args.spellId, 38.3)
end

function mod:PurgatoryRemoved(args)
	self:Message(args.spellId, "Positive", "Info", CL.over:format(args.spellName))
	self:StopBar(CL.cast:format(args.spellName))
end

function mod:GraspFromBeyond(args)
	self:Message(args.spellId, "Urgent", "Alert")
	self:CastBar(args.spellId, 10)
	self:Bar(args.spellId, 15)
	if handGUID ~= args.sourceGUID then
		handGUID = args.sourceGUID
		self:Bar("handFromBeyond", 28, L.handFromBeyond, L.handFromBeyond_icon)
	end
	self:Flash(args.spellId)
end

function mod:Interrupts(args)
	if args.extraSpellId == 235578 then -- Grasp from Beyond
		self:Message(args.extraSpellId, "Personal", nil, CL.interrupted:format(args.extraSpellName))
		self:StopBar(CL.cast:format(args.extraSpellName))
	end
end

function mod:HandFromBeyondDeath(args)
	self:Message("handFromBeyond", "Neutral", nil, L.killed:format(L.handFromBeyond), false)
	self:StopBar(CL.cast:format(self:SpellName(235578)))  -- Grasp from Beyond
	self:StopBar(235578)  -- Grasp from Beyond
end
