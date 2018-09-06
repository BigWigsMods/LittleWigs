
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ring of Booty", 1754, 2094)
if not mod then return end
mod:RegisterEnableMob(126969) -- Trothak
mod.engageId = 2095

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	-- Our champion that sleeps with the fishes... literally! The Freehold Fanatic... the Master of the Jagged Jawbone Jab... the Powerful Pugilist Predator... Trothak the Shark Puncher!
	L.warmup_trigger = "sleeps with the fishes..."
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		256405, -- Sharknado
		256358, -- Shark Toss
		256489, -- Rearm
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_SAY", "Warmup")

	self:Log("SPELL_CAST_START", "Sharknado", 256405)
	self:Log("SPELL_CAST_SUCCESS", "SharkToss", 256358)
	self:Log("SPELL_CAST_START", "Rearm", 256489)
end

function mod:OnEngage()
	self:CDBar(256358, 17) -- Shark Toss
	self:CDBar(256405, 23) -- Sharknado
	self:CDBar(256489, 46) -- Rearm
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Warmup(event, msg)
	if msg:find(L.warmup_trigger, nil, true) then
		self:UnregisterEvent(event)
		self:Bar("warmup", 17.4, CL.active, "achievement_dungeon_freehold")
	end
end

function mod:Sharknado(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning", "runout")
	self:Bar(args.spellId, 40)
end

function mod:SharkToss(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert", "watchstep")
	self:CDBar(args.spellId, 29)
end

function mod:Rearm(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
	self:Bar(args.spellId, 40)
end
