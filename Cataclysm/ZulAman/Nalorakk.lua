-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Nalorakk", 568, 187)
if not mod then return end
mod:RegisterEnableMob(23576)

-------------------------------------------------------------------------------
--  Localization

local L = mod:GetLocale()
if L then
	L.forms = "Forms"
	L.forms_desc = "Warn for form changes."
	L.troll_message = "Troll Form"
	L.troll_trigger = "Make way for da Nalorakk!"
	L.bear_trigger = "You call on da beast"
end

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		"forms",
		42398, -- Deafening Roar
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "Forms")

	self:Log("SPELL_AURA_APPLIED", "DeafeningRoar", 42398)
	-- self:Log("UNIT_SPELLCAST_SUCCEEDED", "Bear", 42377) -- FIXME: there's already a check using Yells, wouldn't this create duplicate messages? Maybe there's a USCS event for the troll form as well?

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Death("Win", 23576)
end

function mod:OnEngage()
	self:Bar("forms", 30, self:SpellName(7090), 42594) -- 7090 = Bear Form; 42594 = Shape of the Bear
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Forms(_, msg)
	if msg == L.bear_trigger then
		self:Message("forms", "Important", nil, self:SpellName(7090), 42594)  -- 7090 = Bear Form; 42594 = Shape of the Bear
		self:Bar("forms", 30, L.troll_message, 89259)
	elseif msg == L.troll_trigger then
		self:Message("forms", "Important", nil, L.troll_message, 89259)
		self:Bar("forms", 30, self:SpellName(7090), 42594) -- 7090 = Bear Form; 42594 = Shape of the Bear
	end
end

do
	local prev = 0
	function mod:DeafeningRoar(args)
		local t = GetTime()
		if t - prev > 4 then
			self:Message(args.spellId, "Attention", "Info")
		end
		prev = t
	end
end
