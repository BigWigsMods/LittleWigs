
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Kruul", nil, nil, 1698)
if not mod then return end
mod:RegisterEnableMob(117933, 117198)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.name = "Kruul"
end
mod.displayName = L.name

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
	234423, -- Drain Life
	234422, -- Aura of Decay
	233473, -- Holy Ward
	234428, -- Summon Tormenting Eye
	235110, -- Nether Aberration
	235112, -- Smoldering Infernal Summon
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Log("SPELL_CAST_START", "DrainLife", 234423)
	self:Log("SPELL_CAST_START", "HolyWard", 233473)
	self:Log("SPELL_AURA_APPLIED_DOSE", "AuraOfDecay", 234422)
end

function mod:OnEngage()
	self:Message(234423, "Neutral", nil, "Kruul Engaged")
end

--------------------------------------------------------------------------------
-- Event Handlers
--
function mod:UNIT_SPELLCAST_SUCCEEDED(unit, spellName, _, _, spellId)
	if spellId == 234428 then -- Summon Tormenting Eye
		self:Message(spellId, "Attention", "Info")
		self:CDBar(spellId, 18)
	elseif spellId == 235110 then -- Nether Aberration
		self:Message(spellId, "Attention", "Info", CL.incoming:format(spellName))
		self:CDBar(spellId, 35)
	elseif spellId == 235112 then -- Smoldering Infernal Summon
		self:Message(spellId, "Attention", "Info", CL.incoming:format(spellName))
		self:CDBar(spellId, 50)
	end
end

function mod:DrainLife(args)
	self:Message(args.spellId, "Urgent", "Alert", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 23)
end

function mod:HolyWard(args)
	self:Message(args.spellId, "Positive", "Long", CL.casting:format(args.spellName))
	self:CastBar(args.spellId, 8)
	self:CDBar(args.spellId, 35)
end

function mod:AuraOfDecay(args)
	local amount = args.amount or 1
	self:StackMessage(args.spellId, args.destName, amount, "Personal", "Alarm")
end