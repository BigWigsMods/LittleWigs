if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Heartsbane Triad", 1862, 2125)
if not mod then return end
mod:RegisterEnableMob(135360, 135358, 135359) -- Sister Briar, Sister Malady, Sister Solena
mod.engageId = 2113

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		--260697, -- Bramble Bolt
		260741, -- Jagged Nettles
		--260696, -- Ruinous Bolt
		{260703, "SAY"}, -- Unstable Runic Mark
		--260698, -- Soul Bolt
		260907, -- Soul Manipulation
		260773, -- Dire Ritual
	}
end

function mod:OnBossEnable() -- XXX See if announcing their base spell is too spammy or not
	--self:Log("SPELL_CAST_START", "BrambleBolt", 260773)
	self:Log("SPELL_CAST_SUCCESS", "JaggedNettles", 260741)
	--self:Log("SPELL_CAST_START", "RuinousBolt", 260773)
	self:Log("SPELL_AURA_APPLIED", "UnstableRunicMark", 260703)
	--self:Log("SPELL_CAST_START", "SoulBolt", 260773)
	self:Log("SPELL_AURA_APPLIED", "SoulManipulation", 260907)
	self:Log("SPELL_CAST_START", "DireRitual", 260773)
end

function mod:OnEngage()
end

--------------------------------------------------------------------------------
-- Event Handlers
--

--function mod:BrambleBolt(args)
--	self:Message(args.spellId, "yellow", "Alert")
--end

function mod:JaggedNettles(args)
	self:Message(args.spellId, "orange", "Alarm")
end

--function mod:RuinousBolt(args)
--	self:Message(args.spellId, "yellow", "Alert")
--end

function mod:UnstableRunicMark(args)
	self:TargetMessage(args.spellId, args.destName, "orange", "Alarm", nil, nil, self:Dispeller("curse"))
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
		self:Flash(args.spellId)
	end
end

--function mod:SoulBolt(args)
--	self:Message(args.spellId, "yellow", "Alert")
--end

function mod:SoulManipulation(args)
	self:TargetMessage(args.spellId, args.destName, "orange", "Alarm", nil, nil, true)
end

function mod:DireRitual(args)
	self:Message(args.spellId, "red", "Warning")
end
