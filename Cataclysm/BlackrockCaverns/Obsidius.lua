-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Ascendant Lord Obsidius", 645, 109)
if not mod then return end
mod:RegisterEnableMob(39705)

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		76188, -- Twilight Corruption
		{76200, "ICON"}, -- Transformation
		76189, -- Crepuscular Veil
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "TwilightCorruption", 76188)
	self:Log("SPELL_AURA_REMOVED", "TwilightCorruptionRemoved", 76188)
	self:Log("SPELL_AURA_APPLIED", "Change", 76200)
	self:Log("SPELL_AURA_APPLIED", "CrepuscularVeil", 76189)

	self:Death("Win", 39705)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:TwilightCorruption(args)
	self:TargetMessage(args.spellId, args.destName, "Important", "Alarm")
	self:TargetBar(args.spellId, 12, args.destName)
end

function mod:TwilightCorruptionRemoved(args)
	self:StopBar(args.spellId, args.destName)
end

do
	local prev = 0
	function mod:Change(args)
		local t = GetTime()
		if (t - prev) > 2 then
			self:Message(args.spellId, "Urgent")
		end
		self:PrimaryIcon(args.spellId, mod.displayName)
		prev = t
	end
end

function mod:CrepuscularVeil(args)
	if self:Tank(args.destName) then
		self:TargetMessage(args.spellId, args.destName, "Attention")
		self:TargetBar(args.spellId, 4, args.destName)
	end
end

