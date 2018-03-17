-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Rom'ogg Bonecrusher", 645, 105)
if not mod then return end
mod:RegisterEnableMob(39665)

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		75543, -- The Skullcracker
		75272, -- Quake
		75539, -- Chains of Woe
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Skullcracker", 75543)
	self:Log("SPELL_CAST_START", "Quake", 75272)
	self:Log("SPELL_CAST_START", "ChainsOfWoe", 75539)
	self:Death("Win", 39665)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Skullcracker(args)
	local time = self:Heroic() and 8 or 12 -- 8sec on heroic, 12 on normal
	self:CastBar(args.spellId, time)
	self:Message(args.spellId, "Urgent", nil, CL.casting:format(args.spellName))
end

function mod:Quake(args)
	--self:CDBar(args.spellId, 19) --innacurate?
	self:Message(args.spellId, "Attention", nil, CL.casting:format(spellName))
end

function mod:ChainsOfWoe(args)
	self:Message(args.spellId, "Important", "Alert", CL.casting:format(spellName))
end

