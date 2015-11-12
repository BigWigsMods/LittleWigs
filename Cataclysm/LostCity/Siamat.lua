
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Siamat", 747, 122)
if not mod then return end
mod:RegisterEnableMob(44819)

local adds = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.engage_trigger = "Winds of the south, rise and come to your master's aid!"
	L.servant = "Summon Servant"
	L.servant_desc = "Warn when a Servant of Siamat is summoned."
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"servant",
		"stages",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_SUMMON", "Servant", 84553)
	self:Yell("Engage", L["engage_trigger"])

	self:Death("Win", 44819)
end

function mod:OnEngage()
	adds = 0
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Servant(args)
	adds = adds + 1
	if adds == 3 then
		self:Message("stages", "Neutral", nil, CL.soon:format(CL.phase:format(2)), false)
		adds = 0
	end
	self:Message("servant", "Important", "Alert", CL.add_spawned, args.spellId)
end

