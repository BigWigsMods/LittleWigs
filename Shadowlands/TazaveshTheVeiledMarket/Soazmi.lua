
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("So'azmi", 2441, 2451)
if not mod then return end
mod:RegisterEnableMob(175806) -- So'azmi
mod:SetEncounterID(2437)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		357188, -- Double Technique
		347610, -- Shuri
		347249, -- Divide
		347623, -- Quickblade
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "DoubleTechnique", 357188)
	self:Log("SPELL_CAST_SUCCESS", "Shuri", 347610)
	self:Log("SPELL_CAST_START", "Divide", 347249)
	self:Log("SPELL_CAST_START", "Quickblade", 347623)
end

function mod:OnEngage()
	self:Bar(347623, 8.2) -- Quickblade
	self:Bar(347610, 20) -- Shuri
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prev = 0

	function mod:DoubleTechnique(args)
		local count = args.time - prev > 10 and 1 or 2
		self:Message(args.spellId, "orange", CL.count:format(args.spellName, count))
		self:PlaySound(args.spellId, "alert")
		prev = args.time
	end
end

function mod:Shuri(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
end

function mod:Divide(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
end

function mod:Quickblade(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 15.5)
end
