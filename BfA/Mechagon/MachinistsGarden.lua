if not IsTestBuild() then return end

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Machinist's Garden", 2097, 2348)
if not mod then return end
mod:RegisterEnableMob(144248) -- Head Machinist Sparkflux
mod.engageId = 2259

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		294855, -- Blossom Blast
		285437, -- "Hidden" Flame Cannon
		{285460, "DISPEL"}, -- Discom-BOMB-ulator
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "BlossomBlast", 294855)
	self:Log("SPELL_CAST_SUCCESS", "HiddenFlameCannon", 285437)
	self:Log("SPELL_CAST_SUCCESS", "Discombombulator", 285460)
	self:Log("SPELL_AURA_APPLIED", "DiscombombulatorApplied", 285460)
end

function mod:OnEngage()

end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:BlossomBlast(args)
	if self:Healer() or self:Me(args.destGUID) then
		self:TargetMessage2(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

function mod:HiddenFlameCannon(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:Discombombulator(args)
	self:Message2(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
end

do
	local playerList = mod:NewTargetList()
	function mod:DiscombombulatorApplied(args)
		if self:Dispeller("magic", nil, args.spellId) then
			self:TargetsMessage(args.spellId, "orange", playerList)
			self:PlaySound(args.spellId, "alert", nil, playerList)
		end
	end
end
