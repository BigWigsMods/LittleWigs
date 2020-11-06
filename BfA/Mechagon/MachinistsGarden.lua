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
		294853, -- Activate Plant
		294855, -- Blossom Blast
		285440, -- "Hidden" Flame Cannon
		{285454, "DISPEL"}, -- Discom-BOMB-ulator
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")

	self:Log("SPELL_CAST_SUCCESS", "BlossomBlast", 294855)
	self:Log("SPELL_CAST_SUCCESS", "HiddenFlameCannon", 285440)
	self:Log("SPELL_CAST_SUCCESS", "Discombombulator", 285454)
	self:Log("SPELL_AURA_APPLIED", "DiscombombulatorApplied", 285460)
end

function mod:OnEngage()
	self:Bar(294853, 6.1) -- Activate Plant
	self:Bar(285454, 8.5) -- Discom-BOMB-ulator
	self:Bar(285440, 14.1) -- "Hidden" Flame Cannon
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 294853 then -- Activate Plant
		self:Message(spellId, "orange")
		self:PlaySound(spellId, "long")
		self:Bar(spellId, 45)
	end
end

function mod:BlossomBlast(args)
	if self:Healer() or self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

function mod:HiddenFlameCannon(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CastBar(args.spellId, 12.5)
	self:Bar(args.spellId, 47.3)
end

function mod:Discombombulator(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
	self:Bar(args.spellId, 18.2)
end

do
	local playerList = mod:NewTargetList()
	function mod:DiscombombulatorApplied(args)
		if self:Dispeller("magic", nil, 285454) then
			self:TargetsMessage(285454, "orange", playerList)
			self:PlaySound(285454, "alert", nil, playerList)
		end
	end
end
